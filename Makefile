SED=gsed
DELCSS=$(SED) -E -z 's/<style>[^>]+><link href="hledger.css" rel="stylesheet">/\n<br>\n/g'
HLEDGER=hledger -f oc.journal

REPORT1=$(HLEDGER) bs -YE -e tomorrow
REPORT2=$(HLEDGER) is -YETS -e tomorrow -t
# REPORT3=$(HLEDGER) cf -YET -e tomorrow

default: report

# Move a downloaded CSV file here.
# This is the download from https://opencollective.com/hledger/transactions -> Download CSV button
oc.csv: ~/Downloads/hledger-oc.csv
	mv $< $@

.INTERMEDIATE: ~/Downloads/hledger-oc.csv

# regenerate journal from CSV
oc.journal journal: oc.csv oc.csv.rules
	(printf "include oc.accounts\n\n"; hledger -f $< print -x) >oc.journal
	@make check

check:
	$(HLEDGER) check -s ordereddates && echo ok

# show reports on stdout
report: oc.journal Makefile
	$(REPORT1) --pretty; echo
	$(REPORT2) --pretty; echo

# update html reports in readme
README.md readme: oc.journal Makefile
	$(SED) '/<!-- REPORTS: -->/q' README.md >.README.md
	$(REPORT1) -O html >>.README.md
	$(REPORT2) -O html >>.README.md
	echo >>.README.md
	$(DELCSS) <.README.md >README.md
	rm -f .README.md

# update journal, readme, and commit both
update:
	@make README.md
	git commit -m "update csv"     -- oc.csv     || echo "csv has not changed"
	git commit -m "update journal" -- oc.journal || echo "journal has not changed"
	git commit -m "update reports" -- README.md@ || echo "reports have not changed"

# update plain text reports in readme
# README.md: hf.journal Makefile
# 	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
# 	printf '\n```\n' >>.$@
# 	$(REPORT1) --pretty >>.$@
# 	printf '```\n\n```\n' >>.$@
# 	$(REPORT2) --pretty >>.$@
# 	printf '```\n\n' >>.$@
# 	mv .$@ $@

