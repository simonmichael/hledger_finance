#rg := 'rg -IN --sort=path'
sed := 'gsed -E'
hledger := 'hledger -n'
hledgerc := 'hledger'
csvsrc := '~/Downloads/hledger-transaction.csv'
csv := 'oc.csv'
checks := 'accounts commodities balanced ordereddates'

set export := true
#set positional-arguments

# List this justfile's recipes, optionally filtered by REGEX.
@h *REGEX:
    if [[ '{{ REGEX }}' =~ '' ]]; then just -ul; else just -ul | rg -i '{{ REGEX }}'; true; fi

# Check this justfile for errors and non-standard format.
@chk:
    just --fmt --unstable --check

# If this justfile is error free but in non-standard format, reformat it.
@fmt:
    just -q chk || just -q --fmt --unstable

# Gather any downloaded open collective CSV here.
csv:
    if [[ -f $csvsrc ]]; then mv $csvsrc $csv; else echo "no new $csvsrc"; fi

# Regenerate OC journal from csv.
journal:
    ($hledger -f $csv print -x -c '1.00 USD' --round=soft >.oc.journal && mv .oc.journal oc.journal) || (rm -f .oc.journal; false)

# Declare any new accounts found in the journals (preserving existing declarations' order).
accounts:
    ((cat accounts.journal; $hledgerc accounts --undeclared --directives) >.accounts.journal && mv .accounts.journal accounts.journal) || (rm -f .accounts.journal; false)

# Check the journal for problems.
check:
    printf "checking journal.. "
    $hledgerc check $checks && echo "all ok ✅"

# Update reports in README.md. You should update csv journal accounts first.
readme:
    $sed '/<!-- REPORTS:/q' README.md >.README.md
    just yal -Ohtml >>.README.md
    just yrx -Ohtml >>.README.md
    just tyrx -Ohtml >>.README.md
    just b-rx >>.README.md
    just b-al >>.README.md
    just l-a >>.README.md
    just l-r >>.README.md
    just l-x >>.README.md
    $sed -z 's/<link[^>]+>(<link[^>]+>)?<style>[^>]+>/\n\n/g' <.README.md >README.md  # XXX remove HTML reports' CSS
    rm -f .README.md

# Show basic reports in terminal. Can pass through one argument.
reports *args: (yal args) (yrx args) (tyrx args)

# Yearly assets & liabilities
yal *args:
    printf "## Yearly Assets & Liabilities\n"
    $hledgerc bal type:al -2 -HYT --transpose --drop 0 "$args"
    printf "\n"

# Yearly revenues & expenses
yrx *args:
    printf "## Yearly Revenues & Expenses\n"
    $hledgerc bal type:rx --invert -2 -YT --transpose --drop 0 "$args"
    printf "\n"

# This year's revenue and expenses
tyrx *args:
    printf "## This Year's Revenues & Expenses\n"
    $hledgerc is -b1/1 -t -S "$args"
    printf "\n"

# Show hledger-bar charts in terminal
barcharts *args: (b-rx args) (b-al args)

# Yearly net income bar chart
b-rx *args:
    @printf '\n## Yearly Net Income\n```\n'
    hledger-bar -v 150 -Y type:rx --invert "$args"
    @printf '```\n'

# Yearly net assets bar chart
b-al *args:
    @printf '\n## Yearly Net Assets\n```\n'
    hledger-bar -v 150 -Y type:al -H "$args"
    @printf '```\n'

# Show hledger-plot charts in terminal
linecharts *args: (l-a args) (l-r args) (l-x args)

# XXX with partial workaround for https://github.com/gooofy/drawilleplot/issues/4
# Assets line chart
l-a *args:
    @printf '\n## Assets Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^assets   --historical  --terminal --rcParams '{"figure.figsize":[8,3]}' --no-today -q --title "hledger assets" "$args" \
    | sed 's/⠀/ /g'
    @printf '```\n'

# Revenues line chart
l-r *args:
    @printf '\n## Revenues Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^revenues --monthly --invert  --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly revenues" "$args" \
    | sed 's/⠀/ /g'
    @printf '```\n'

# Expenses line chart
l-x *args:
    @printf '\n## Expenses Over Time\n```\n'
    $hledgerc plot -- bal --depth=1 ^expenses --monthly --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly expenses" "$args" \
    | sed 's/⠀/ /g'
    @printf '```\n'

# Update all that's updateable.
update: csv journal accounts reports

# Commit all that's commitable.
# commit:
#     git commit -m "update oc csv"      -- oc.csv           || echo "oc csv has not changed"
#     git commit -m "update oc journal"  -- oc.journal       || echo "oc journal has not changed"
#     git commit -m "update other journal"  -- other.journal || echo "other journal has not changed"
#     git commit -m "update accounts" -- accounts.journal    || echo "accounts have not changed"
#     git commit -m "update reports" -- README.md            || echo "reports have not changed"
