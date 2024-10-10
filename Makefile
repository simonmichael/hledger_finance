SED=gsed
RG=rg -IN --sort=path

# hlfi uses ./hledger.conf, but this Makefile currently does not, so -n needed.
HLEDGER=hledger -n

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
	($(HLEDGER) -f $< print -x -c '1.00 USD' --round=soft >new.journal && mv new.journal oc.journal) || (rm -f new.journal; false)

# This preserves the existing content (and display order); may need to clean up manually from time to time.
accounts.journal: main.journal oc.journal other.journal # declare any new accounts found in the journals
	((cat $@; $(HLEDGER) -f main.journal accounts --undeclared --directives) > $@.new && mv $@.new $@) || (rm -f $@.new; false)

CHECKS=accounts commodities balanced ordereddates
check:  # check the journal for problems
	@printf "checking journal.. "
	@$(HLEDGER) -f main.journal check $(CHECKS) && echo "all ok ✅"

journal: oc.journal accounts.journal check Makefile  # make oc.journal + accounts.journal + check

README.md readme reports: journal Makefile  # update reports and charts in README.md
	$(SED) '/<!-- REPORTS:/q' README.md >.README.md
	./hlfi reports -O html >>.README.md
	echo >>.README.md
	echo '## Yearly Net Assets' >>.README.md
	echo '```' >>.README.md
	./hlfi b-al >>.README.md
	echo '```' >>.README.md
	echo '## Yearly Net Income' >>.README.md
	echo '```' >>.README.md
	./hlfi b-rx >>.README.md
	echo '```' >>.README.md
	echo '## Assets Over Time' >>.README.md
	echo '```' >>.README.md
	./hlfi l-a >>.README.md
	echo '```' >>.README.md
	echo '## Revenues Over Time' >>.README.md
	echo '```' >>.README.md
	./hlfi l-r >>.README.md
	echo '```' >>.README.md
	echo '## Expenses Over Time' >>.README.md
	echo '```' >>.README.md
	./hlfi l-x >>.README.md
	echo '```' >>.README.md
	$(SED) -E -z 's/<link[^>]+><style>[^>]+>/\n\n/g' <.README.md >README.md  # remove HTML reports' CSS
	rm -f .README.md

update:  # make journal + README.md and commit both
	@make README.md
	git commit -m "update oc csv"      -- oc.csv           || echo "oc csv has not changed"
	git commit -m "update oc journal"  -- oc.journal       || echo "oc journal has not changed"
	git commit -m "update other journal"  -- other.journal || echo "other journal has not changed"
	git commit -m "update accounts" -- accounts.journal    || echo "accounts have not changed"
	git commit -m "update reports" -- README.md            || echo "reports have not changed"

