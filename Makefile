SED=gsed
RG=rg -IN --sort=path
HLEDGER=hledger

help: # list make targets
	@printf "hledger project finance makefile. This mainly manages data, for reports see ./hlfi\nTargets:\n"
	@$(RG) '^(\w[^:]*): [^#]*(# .*)|^# \*\* (.*)' -or '$$3 $$1|$$2' $(MAKEFILE_LIST) | column -t -s'|' || true
# (which have a single-# same-line comment)

help-%: # list make targets matching a pattern
	@make -s help | $(RG) -i "$*" || true

# Gather the latest download from Open Collective. See README.
oc.csv: ~/Downloads/hledger-transactions.csv   # gather any downloaded opencollective hledger CSV here
	-mv $@ $@.old || true
	mv $< $@

.INTERMEDIATE: ~/Downloads/hledger-transactions.csv

oc.journal: oc.csv oc.csv.rules  # regenerate journal from csv
	((printf "include oc.accounts\n\n"; $(HLEDGER) -f $< print -x -c '1.00 USD' --round=soft) >new.journal && mv new.journal oc.journal) || (rm -f new.journal; false)

# This preserves the existing content of oc.accounts, may need to clean that manually from time to time.
oc.accounts: oc.journal  # declare any new accounts found in the journal
	((cat oc.accounts; $(HLEDGER) -f oc.journal accounts --undeclared --directives) | sort > oc.accounts.new && mv oc.accounts.new oc.accounts) || (rm -f oc.accounts.new; false)

CHECKS=accounts commodities balanced ordereddates
check:  # check the journal for problems
	@printf "checking journal.. "
	@$(HLEDGER) -f oc.journal check $(CHECKS) && echo "all ok ✅"

journal: oc.journal oc.accounts check Makefile  # make oc.journal + oc.accounts + check

README.md: journal Makefile  # update reports and charts in README.md
	$(SED) '/<!-- REPORTS:/q' README.md >.README.md
	./hlfi reports -O html >>.README.md
	echo >>.README.md
	echo '```' >>.README.md
	./hlfi b-a >>.README.md
	echo '```' >>.README.md
	echo '```' >>.README.md
	./hlfi b-r >>.README.md
	echo '```' >>.README.md
	echo '```' >>.README.md
	./hlfi b-x >>.README.md
	echo '```' >>.README.md
	echo '```' >>.README.md
	./hlfi l-a >>.README.md
	echo '```' >>.README.md
	echo '```' >>.README.md
	./hlfi l-r >>.README.md
	echo '```' >>.README.md
	echo '```' >>.README.md
	./hlfi l-x >>.README.md
	echo '```' >>.README.md
	$(SED) -E -z 's/<style>[^>]+><link[^>]+>/\n<br>\n/g' <.README.md >README.md  # remove HTML reports' CSS
	rm -f .README.md

update:  # make journal + README.md and commit both
	@make README.md
	git commit -m "update csv"      -- oc.csv          || echo "csv has not changed"
	git commit -m "update journal"  -- oc.journal      || echo "journal has not changed"
	git commit -m "update accounts" -- oc.accounts     || echo "accounts have not changed"
	git commit -m "update readme reports" -- README.md || echo "readme reports have not changed"

