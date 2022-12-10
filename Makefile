SED=gsed
DELCSS=$(SED) -E -z 's/<style>[^>]+><link[^>]+>/\n<br>\n/g'
HLEDGER=hledger -f oc.journal

# avoid -t as it currently doesn't indent in HTML
REPORT1=$(HLEDGER) bs --drop 1 -E -p 'quarterly from 1/1 to tomorrow'
REPORT2=$(HLEDGER) is --drop 1 -S -p 'quarterly from 1/1 to tomorrow' #--alias '/(revenues:donations).*/=\1'
REPORT3=$(HLEDGER) bs --drop 1 -E -p 'yearly to tomorrow'
REPORT4=$(HLEDGER) is --drop 1 -TS -p 'yearly to tomorrow' #--alias '/(revenues:donations).*/=\1'
# REPORT3=$(HLEDGER) cf -YET -e tomorrow

default: report

# Move a downloaded CSV file here (the download from
# https://opencollective.com/hledger/transactions?kind=CONTRIBUTION%2CEXPENSE%2CHOST_FEE > Download CSV > Download (V2)).
oc.csv: ~/Downloads/transactions.txt
	mv $< $@

.INTERMEDIATE: ~/Downloads/transactions.txt

# regenerate journal from CSV
oc.journal journal: oc.csv oc.csv.rules
	((printf "include oc.accounts\n\n"; hledger -f $< print -x) >new.journal && mv new.journal oc.journal) || (rm -f new.journal; false)
	@make check

check:
	@printf "checking journal.. "
	@$(HLEDGER) check commodities balancednoautoconversion ordereddates && echo ok

# show reports on stdout
report: oc.journal Makefile
	$(REPORT1) --pretty; echo
	$(REPORT2) --pretty; echo
	$(REPORT3) --pretty; echo
	$(REPORT4) --pretty; echo

# update html reports in readme
README.md readme: oc.journal Makefile
	$(SED) '/<!-- REPORTS: -->/q' README.md >.README.md
	$(REPORT1) -O html >>.README.md
	$(REPORT2) -O html >>.README.md
	$(REPORT3) -O html >>.README.md
	$(REPORT4) -O html >>.README.md
	echo >>.README.md
	$(DELCSS) <.README.md >README.md
	rm -f .README.md

# update journal, readme, and commit both
update:
	@make README.md
	git commit -m "update csv"     -- oc.csv     || echo "csv has not changed"
	git commit -m "update journal" -- oc.journal || echo "journal has not changed"
	git commit -m "update reports" -- README.md  || echo "reports have not changed"

# update plain text reports in readme
# README.md: hf.journal Makefile
# 	$(SED) '/<!-- REPORTS -->/q' $@ >.$@
# 	printf '\n```\n' >>.$@
# 	$(REPORT1) --pretty >>.$@
# 	printf '```\n\n```\n' >>.$@
# 	$(REPORT2) --pretty >>.$@
# 	printf '```\n\n' >>.$@
# 	mv .$@ $@

