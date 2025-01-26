#rg := 'rg -IN --sort=path'

sed := 'gsed -E'
hledger := 'hledger -n'
hledgerc := 'hledger'
csvsrc := '/Users/simon/Downloads/hledger-transactions.csv'
csv := 'oc.csv'
checks := 'accounts commodities balanced ordereddates'

set export := true

# List this justfile's recipes, optionally filtered by REGEX.
@_help *REGEX:
    if [[ '{{ REGEX }}' =~ '' ]]; then just -ul; else just -ul --color=always | rg -i '{{ REGEX }}'; true; fi

# Check this justfile for errors and non-standard format.
@_chk:
    just --fmt --unstable --check

# If this justfile is error free but in non-standard format, reformat it.
@_fmt:
    just -q chk || just -q --fmt --unstable

alias h := _help
alias chk := _chk
alias fmt := _fmt

# Gather any downloaded open collective CSV here.
[group('maintenance')]
csv:
    if [[ -f $csvsrc ]]; then mv $csvsrc $csv; else echo "no new $csvsrc"; fi

# Regenerate OC journal from csv.
[group('maintenance')]
journal:
    ($hledger -f $csv print -x -c '1.00 USD' --round=soft >.oc.journal && mv .oc.journal oc.journal) \
    || (rm -f .oc.journal; false)

# Declare any new accounts found in the journals (preserving existing declarations' order).
[group('maintenance')]
accounts:
    ((cat accounts.journal; $hledgerc accounts --undeclared --directives) >.accounts.journal && mv .accounts.journal accounts.journal) \
    || (rm -f .accounts.journal; false)

# Check the journal for problems.
[group('maintenance')]
check:
    printf "checking journal.. "
    $hledgerc check $checks && echo "all ok ✅"

# Update reports in README.md. You should update csv journal accounts first.
[group('maintenance')]
readme:
    $sed '/<!-- REPORTS:/q' README.md >.README.md
    just tyrx -Ohtml >>.README.md
    just yrx -Ohtml >>.README.md
    just yal -Ohtml >>.README.md
    #just b-rx >>.README.md
    #just b-al >>.README.md
    #just l-a >>.README.md
    #just l-r >>.README.md
    #just l-x >>.README.md
    $sed -z 's/<link[^>]+>(<link[^>]+>)?<style>[^>]+>/\n\n/g' <.README.md >README.md  # XXX remove HTML reports' CSS
    rm -f .README.md

# csv journal accounts check readme
[group('maintenance')]
update: csv journal accounts check readme

# Commit all that's commitable.
# [group('maintenance')]
# commit:
#     git commit -m "update oc csv"      -- oc.csv           || echo "oc csv has not changed"
#     git commit -m "update oc journal"  -- oc.journal       || echo "oc journal has not changed"
#     git commit -m "update other journal"  -- other.journal || echo "other journal has not changed"
#     git commit -m "update accounts" -- accounts.journal    || echo "accounts have not changed"
#     git commit -m "update reports" -- README.md            || echo "reports have not changed"

# Show basic reports in terminal. Can pass through one argument.
[group('reports')]
reports *args: (yal args) (yrx args) (tyrx args)

# This year's revenue and expenses
[group('reports')]
tyrx *args:
    printf "\n## Year To Date\n"
    $hledgerc is -b1/1 -t --drop 1 -S "$args"
    printf "\n"

# Yearly revenues & expenses
[group('reports')]
yrx *args:
    printf "\n## Revenues & Expenses by Year\n"
    $hledgerc bal type:rx --invert -2 -YT --transpose "$args"
    printf "\n"

# Yearly assets & liabilities
[group('reports')]
yal *args:
    printf "\n## Assets & Liabilities By Year\n"
    $hledgerc bal type:al -2 -HYT --transpose "$args"
    printf "\n"

# Show charts in terminal
[group('reports')]
charts *args: (barcharts args) (linecharts args)

# Show hledger-bar charts in terminal
[group('reports')]
barcharts *args: (b-rx args) (b-al args)

# Yearly net income bar chart
[group('reports')]
b-rx *args:
    @printf '\n## Net Income by Year\n```\n'
    hledger-bar -v 150 -Y type:rx --invert "$args"
    @printf '```\n'

# Yearly net assets bar chart
[group('reports')]
b-al *args:
    @printf '\n## Net Assets by Year\n```\n'
    hledger-bar -v 150 -Y type:al -H "$args"
    @printf '```\n'

# Show hledger-plot charts in terminal
[group('reports')]
linecharts *args: (l-a args) (l-r args) (l-x args)

# Assets line chart
[group('reports')]
l-a *args:
    @printf '\n## Assets Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^assets   --historical  --terminal --rcParams '{"figure.figsize":[8,3]}' --no-today -q --title "hledger assets" "$args" \
    | sed 's/⠀/ /g'  # partial workaround for https://github.com/gooofy/drawilleplot/issues/4
    @printf '```\n'

# Revenues line chart
[group('reports')]
l-r *args:
    @printf '\n## Revenues Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^revenues --monthly --invert  --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly revenues" "$args" \
    | sed 's/⠀/ /g'
    @printf '```\n'

# Expenses line chart
[group('reports')]
l-x *args:
    @printf '\n## Expenses Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^expenses --monthly --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly expenses" "$args" \
    | sed 's/⠀/ /g'
    @printf '```\n'
