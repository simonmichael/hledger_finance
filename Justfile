#rg := 'rg -IN --sort=path'

sed := 'gsed -E'
hledger := 'hledger -n'
hledgerc := 'hledger -f main.journal'
downloads := '/Users/simon/Downloads'
occsvsrc := downloads / 'hledger-transactions.csv'
csv := 'data/oc.csv'
checks := 'accounts commodities balanced ordereddates'
open := 'open'

# Make constants and recipe arguments available as environment variables.
# (But {{ VAR }} handles multi-word values better.)

set export := true

# By default, list this justfile's commands, optionally filtered by case-insensitive REGEX
@_help *REGEX:
    if [[ '{{ REGEX }}' =~ '' ]]; then just -ul; else just -ul --color=always | rg -i '{{ REGEX }}'; true; fi

alias h := _help

# Check this justfile for errors and non-standard format
@_chk:
    just --fmt --unstable --check

alias chk := _chk

# If this justfile is error free but in non-standard format, reformat it
@_fmt:
    just -q chk || just -q --fmt --unstable

alias fmt := _fmt

# maintenance

# Help download CSV, update and check journals, update readme reports
[group('maintenance')]
@update: oc-csv _journal _accounts _check _readme

# Review the cli reports and opencollective budget page
[group('maintenance')]
@review: oc-budget reports

# Commit all that's committable
[group('maintenance')]
@commit:
    -git commit -m "oc csv"   -- oc.csv
    -git commit -m "journals" -- *.journal
    -git commit -m "reports"  -- README.md

# Publish latest commits
[group('maintenance')]
@push:
    git push

# steps

# Regenerate OC journal from OC csv
[group('steps')]
@_journal:
    ($hledger -f $csv --rules oc.csv.rules print -x -c '1.00 USD' --round=soft >.oc.journal && mv .oc.journal oc.journal) \
    || (rm -f .oc.journal; false)

# Declare any new accounts found, preserving existing declaration order
[group('steps')]
@_accounts:
    ((cat accounts.journal; $hledgerc accounts --undeclared --directives) >.accounts.journal && mv .accounts.journal accounts.journal) \
    || (rm -f .accounts.journal; false)

# Check the journal for problems
[group('steps')]
@_check:
    printf "checking journal.. "
    $hledgerc check $checks && echo "all ok ✅"

# Update reports in README.md
[group('steps')]
@_readme:
    $sed '/<!-- REPORTS:/q' README.md >.README.md
    just ytdrx -Ohtml >>.README.md
    just yrx -Ohtml >>.README.md
    just yal -Ohtml >>.README.md
    #just b-rx >>.README.md
    #just b-al >>.README.md
    #just l-a >>.README.md
    #just l-r >>.README.md
    #just l-x >>.README.md
    $sed -z 's/<link[^>]+>(<link[^>]+>)?<style>[^>]+>/\n\n/g' <.README.md >README.md  # XXX remove HTML reports' CSS
    rm -f .README.md

# Preview the rendered readme
[group('steps')]
@_readme-preview:
    pandoc README.md -o .README.html && $open .README.html

# misc

# Open the opencollective budget page
[group('misc')]
@oc-budget:
    $open 'https://opencollective.com/hledger#category-BUDGET'

# Open the opencollective transactions page for downloading csv
[group('misc')]
@oc-csv:
    $open 'https://opencollective.com/hledger/transactions?kind=ALL'
    read -p 'After successful download, press enter: '
    if [[ -f $occsvsrc ]]; then mv $occsvsrc $csv; else echo "no new $occsvsrc found"; fi

# Open sm's liberapay ledger
[group('misc')]
@li-ledger:
    $open https://liberapay.com/simonmichael/ledger

# Open liberapay receiving page for sm
[group('misc')]
@li-rx-sm:
    $open https://liberapay.com/simonmichael/receiving

# Open liberapay receiving page for hledger
[group('misc')]
@li-rx-hledger:
    $open https://liberapay.com/hledger/receiving

# Download liberapay patrons as csv
[group('misc')]
@li-csv: _li-pub _li-active _li-all

# Download liberapay public active patrons
[group('misc')]
@_li-pub:
    wget -O data/liberapay-public-active-patrons-simonmichael-`date -I`.csv https://liberapay.com/simonmichael/patrons/public.csv

# Download liberapay active patrons
[group('misc')]
@_li-active:
    $open 'https://liberapay.com/simonmichael/patrons/export.csv?scope=active'
    read -p 'After successful download, press enter: '
    mv $downloads/liberapay-active-patrons-simonmichael-*.csv data

# Download liberapay patrons from last 10 years
[group('misc')]
@_li-all:
    $open 'https://liberapay.com/simonmichael/patrons/export.csv?scope=all'
    read -p 'After successful download, press enter: '
    mv $downloads/liberapay-patrons-simonmichael-*.csv data

# cli reports

# Show basic reports in terminal. Can pass through one argument.
[group('cli reports')]
reports *args: (ytdrx args) (yrx args) (yal args)

# This year's revenue and expenses
[group('cli reports')]
ytdrx *args:
    @printf "\n## Revenues & Expenses This Year\n"
    $hledgerc bal -b1/1 -M type:rx --invert -2 -MTAS --transpose {{ args }}
    @printf "\n"

# Yearly revenues & expenses
[group('cli reports')]
yrx *args:
    @printf "\n## Revenues & Expenses by Year\n"
    $hledgerc bal type:rx --invert -2 -YT --transpose {{ args }}
    @printf "\n"

# Yearly assets & liabilities
[group('cli reports')]
yal *args:
    @printf "\n## Assets & Liabilities By Year\n"
    $hledgerc bal type:al -2 -HYT --transpose {{ args }}
    @printf "\n"

# cli charts

# Show basic charts in terminal. Can pass through one argument.
[group('cli charts')]
charts *args: (barcharts args) (linecharts args)

# Show hledger-bar charts in terminal
[group('cli charts')]
barcharts *args: (b-rx args) (b-al args)

# Yearly net income bar chart
[group('cli charts')]
b-rx *args:
    @printf '\n## Net Income by Year\n```\n'
    $hledgerc bar -v 150 -Y type:rx --invert {{ args }}
    @printf '```\n'

# Yearly net assets bar chart
[group('cli charts')]
b-al *args:
    @printf '\n## Net Assets by Year\n```\n'
    $hledgerc bar -v 150 -Y type:al -H {{ args }}
    @printf '```\n'

# Show hledger-plot charts in terminal
[group('cli charts')]
linecharts *args: (l-a args) (l-r args) (l-x args)

# Assets line chart
[group('cli charts')]
l-a *args:
    @printf '\n## Assets Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^assets   --historical  --terminal --rcParams '{"figure.figsize":[8,3]}' --no-today -q --title "hledger assets" {{ args }} \
    | sed 's/⠀/ /g'  # partial workaround for https://github.com/gooofy/drawilleplot/issues/4
    @printf '```\n'

# Revenues line chart
[group('cli charts')]
l-r *args:
    @printf '\n## Revenues Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^revenues --monthly --invert  --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly revenues" {{ args }} \
    | sed 's/⠀/ /g'
    @printf '```\n'

# Expenses line chart
[group('cli charts')]
l-x *args:
    @printf '\n## Expenses Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^expenses --monthly --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly expenses" {{ args }} \
    | sed 's/⠀/ /g'
    @printf '```\n'
