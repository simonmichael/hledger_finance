SED=gsed
DELCSS=$(SED) -E -z 's/<style>[^>]+><link[^>]+>/\n<br>\n/g'
HLEDGER=hledger -f oc.journal

# avoid -t as it currently doesn't indent in HTML
REPORT1=$(HLEDGER) bs --drop 1 --layout=bare -E -p 'quarterly from 1/1 to tomorrow'
REPORT2=$(HLEDGER) is --drop 1 --layout=bare -S -p 'quarterly from 1/1 to tomorrow' #--alias '/(revenues:donations).*/=\1'
REPORT3=$(HLEDGER) bs --drop 1 --layout=bare -E -p 'yearly to tomorrow'
REPORT4=$(HLEDGER) is --drop 1 --layout=bare -TS -p 'yearly to tomorrow' #--alias '/(revenues:donations).*/=\1'
# REPORT3=$(HLEDGER) cf -YET -e tomorrow

PLOT1=$(HLEDGER) plot -- bal --depth=1 ^assets   --historical  --terminal --rcParams '{"figure.figsize":[8,3]}' --no-today -q --title "hledger assets"
PLOT2=$(HLEDGER) plot -- bal --depth=1 ^expenses --monthly --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly expenses"
PLOT3=$(HLEDGER) plot -- bal --depth=1 ^revenues --monthly --invert  --terminal --rcParams '{"figure.figsize":[8,3]}' --drawstyle 'steps-mid' --no-today -q --title "hledger monthly revenues"

default: report plots

# Move a downloaded CSV file here (the download from
# https://opencollective.com/hledger/transactions?kind=CONTRIBUTION%2CEXPENSE%2CHOST_FEE > Download CSV > Download (V2)).
oc.csv: ~/Downloads/transactions.txt
	mv $< $@

.INTERMEDIATE: ~/Downloads/transactions.txt

# 1. regenerate journal from CSV
# 2. add new account declarations (preserving old ones)
# 3. run journal checks
oc.journal journal: oc.csv oc.csv.rules
	((printf "include oc.accounts\n\n"; hledger -f $< print -x) >new.journal && mv new.journal oc.journal) || (rm -f new.journal; false)
	((cat oc.accounts; hledger -f oc.journal accounts --undeclared --directives) | sort > oc.accounts.new && mv oc.accounts.new oc.accounts) || (rm -f oc.accounts.new; false)
	@make check

CHECKS=accounts commodities balancednoautoconversion ordereddates
check:
	@printf "checking journal.. "
	@$(HLEDGER) check $(CHECKS) && echo all ok: $(CHECKS)

# show reports on stdout
report: oc.journal Makefile
	$(REPORT1) --pretty; echo
	$(REPORT2) --pretty; echo
	$(REPORT3) --pretty; echo
	$(REPORT4) --pretty; echo

# show plots on stdout
plots: oc.journal Makefile
	echo;$(PLOT1); echo
	echo;$(PLOT2); echo
	echo;$(PLOT3); echo

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

