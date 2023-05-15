SED=gsed
RG=rg -IN --sort=path
HLEDGER=hledger -f oc.journal
DELCSS=$(SED) -E -z 's/<style>[^>]+><link[^>]+>/\n<br>\n/g'

# main reports
# avoid -t as it currently doesn't indent in HTML
REPORT1=./hlfi bs
REPORT2=./hlfi is
REPORT3=./hlfi bs -Y -b2017
REPORT4=./hlfi is -T -Y -b2017

# main bar charts
BAR1=echo "Quarterly net worth:"; ./hlfi b-a
BAR2=echo "Quarterly revenues:"; ./hlfi b-r
BAR3=echo "Quarterly expenses:"; ./hlfi b-x

# main line charts
LINE1=./hlfi l-a
LINE2=./hlfi l-r
LINE3=./hlfi l-x

help: # list make targets
	@printf "hledger project finance makefile. See also ./hlfi\nTargets:\n"
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

# This preserves the existing content of oc.accounts, may need to clean that manually from time to time.
oc.accounts: oc.journal  # declare any new accounts found in the journal
	((cat oc.accounts; hledger -f oc.journal accounts --undeclared --directives) | sort > oc.accounts.new && mv oc.accounts.new oc.accounts) || (rm -f oc.accounts.new; false)

CHECKS=accounts commodities balancednoautoconversion ordereddates
check:  # check the journal for problems
	@printf "checking journal.. "
	@$(HLEDGER) check $(CHECKS) && echo "all ok ✅"

journal: oc.journal oc.accounts check Makefile  # make oc.journal + oc.accounts + check

reports: journal Makefile  # show main reports in terminal
	@$(REPORT1); echo
	@$(REPORT2); echo
	@$(REPORT3); echo
	@$(REPORT4); echo

bar-charts: journal Makefile  # show main charts in terminal with hledger-bar
	@$(BAR1); echo
	@$(BAR2); echo
	@$(BAR3); echo

line-charts: journal Makefile  # show main charts in terminal with hledger-plot
	@$(LINE1); echo
	@$(LINE2); echo
	@$(LINE3); echo

README.md: journal Makefile  # update reports and (if hledger-plot is installed) charts in README.md
	$(SED) '/<!-- REPORTS: -->/q' README.md >.README.md
	$(REPORT1) -O html >>.README.md
	$(REPORT2) -O html >>.README.md
	$(REPORT3) -O html >>.README.md
	$(REPORT4) -O html >>.README.md
	-(printf "\n\n\`\`\`\n" && $(BAR1) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(BAR2) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(BAR3) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(LINE1) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(LINE2) && printf "\n\`\`\`\n";) >>.README.md
	-(printf "\n\n\`\`\`\n" && $(LINE3) && printf "\n\`\`\`\n";) >>.README.md
	$(DELCSS) <.README.md >README.md
	rm -f .README.md

update:  # make journal + README.md and commit both
	@make README.md
	git commit -m "update csv"      -- oc.csv          || echo "csv has not changed"
	git commit -m "update journal"  -- oc.journal      || echo "journal has not changed"
	git commit -m "update accounts" -- oc.accounts     || echo "accounts have not changed"
	git commit -m "update readme reports" -- README.md || echo "readme reports have not changed"

