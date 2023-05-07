SED=gsed
RG=rg -N --sort=path
HLEDGER=hledger -f oc.journal
DELCSS=$(SED) -E -z 's/<style>[^>]+><link[^>]+>/\n<br>\n/g'

# avoid -t as it currently doesn't indent in HTML
REPORT1=$(HLEDGER) bs --drop 1 --layout=bare -E -p 'quarterly from 1/1 to tomorrow'
REPORT2=$(HLEDGER) is --drop 1 --layout=bare -S -p 'quarterly from 1/1 to tomorrow' #--alias '/(revenues:donations).*/=\1'
REPORT3=$(HLEDGER) bs --drop 1 --layout=bare -E -p 'yearly to tomorrow'
REPORT4=$(HLEDGER) is --drop 1 --layout=bare -TS -p 'yearly to tomorrow' #--alias '/(revenues:donations).*/=\1'
# REPORT3=$(HLEDGER) cf -YET -e tomorrow

# generate charts with hledger-bar
BAR1=echo "Quarterly net worth:"; hledger-bar -v 200 -f oc.journal -Q type:al -H
BAR2=echo "Quarterly revenues:";  hledger-bar -v 40 -f oc.journal -Q type:r --invert
BAR3=echo "Quarterly expenses:";  hledger-bar -v 40 -f oc.journal -Q type:x --invert

# generate plots with hledger-plot # XXX and partial workaround for https://github.com/gooofy/drawilleplot/issues/4
PLOT1=$(HLEDGER) plot -- bal --depth=1 ^assets   --historical  --terminal --rcParams '{"figure.figsize":[8,3]}' --no-today -q --title "hledger assets" | $(SED) 's/⠀/ /g'
PLOT2=$(HLEDGER) plot -- bal --depth=1 ^revenues --monthly --invert  --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly revenues" | $(SED) 's/⠀/ /g'
PLOT3=$(HLEDGER) plot -- bal --depth=1 ^expenses --monthly --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly expenses" | $(SED) 's/⠀/ /g'

help: # list make targets
	@$(RG) '^(\w[^:]*): [^#]*(# .*)|^# \*\* (.*)' -or '$$3 $$1|$$2' $(MAKEFILE_LIST) | column -t -s'|' || true
# (which have a single-# same-line comment)

help-%: # list make targets matching a pattern
	@make -s help | $(RG) -i "$*" || true

# gather the download from https://opencollective.com/hledger/transactions?kind=CONTRIBUTION%2CEXPENSE%2CHOST_FEE > Download CSV
oc.csv: ~/Downloads/hledger-transactions.csv   # gather any downloaded opencollective hledger CSV here
	-mv $@ $@.old || true
	mv $< $@

.INTERMEDIATE: ~/Downloads/hledger-transactions.csv

oc.journal: oc.csv oc.csv.rules  # regenerate journal from csv
	((printf "include oc.accounts\n\n"; hledger -f $< print -x) >new.journal && mv new.journal oc.journal) || (rm -f new.journal; false)

# This always starts with the existing oc.accounts, may need to clean that manually from time to time.
oc.accounts: oc.journal  # declare any new accounts found in the journal
	((cat oc.accounts; hledger -f oc.journal accounts --undeclared --directives) | sort > oc.accounts.new && mv oc.accounts.new oc.accounts) || (rm -f oc.accounts.new; false)

CHECKS=accounts commodities balancednoautoconversion ordereddates
check:  # check the journal for problems
	@printf "checking journal.. "
	@$(HLEDGER) check $(CHECKS) && echo "all ok ✅"

journal: oc.journal oc.accounts check Makefile  # make oc.journal + oc.accounts + check

reports: journal Makefile  # show reports in terminal
	$(REPORT1) --pretty; echo
	$(REPORT2) --pretty; echo
	$(REPORT3) --pretty; echo
	$(REPORT4) --pretty; echo

charts: journal Makefile  # show charts in terminal with hledger-bar
	@$(BAR1); echo
	@$(BAR2); echo
	@$(BAR3); echo

charts2: journal Makefile  # show charts in terminal with hledger-plot
	@$(PLOT1); echo
	@$(PLOT2); echo
	@$(PLOT3); echo

README.md: journal Makefile  # update reports and (if hledger-plot is installed) charts in README.md
	$(SED) '/<!-- REPORTS: -->/q' README.md >.README.md
	$(REPORT1) -O html >>.README.md
	$(REPORT2) -O html >>.README.md
	$(REPORT3) -O html >>.README.md
	$(REPORT4) -O html >>.README.md
	-(printf "\n\n\`\`\`\n" && $(BAR1) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(BAR2) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(BAR3) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(PLOT1) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(PLOT2) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(PLOT3) && printf "\n\`\`\`\n";) >>.README.md
	$(DELCSS) <.README.md >README.md
	rm -f .README.md

update:  # make journal + README.md and commit both
	@make README.md
	git commit -m "update csv"      -- oc.csv          || echo "csv has not changed"
	git commit -m "update journal"  -- oc.journal      || echo "journal has not changed"
	git commit -m "update accounts" -- oc.accounts     || echo "accounts have not changed"
	git commit -m "update readme reports" -- README.md || echo "readme reports have not changed"

# update plain text reports in readme
# README.md: hf.journal Makefile
# 	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
# 	printf '\n```\n' >>.$@
# 	$(REPORT1) --pretty >>.$@
# 	printf '```\n\n```\n' >>.$@
# 	$(REPORT2) --pretty >>.$@
# 	printf '```\n\n' >>.$@
# 	mv .$@ $@

