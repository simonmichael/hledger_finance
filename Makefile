oc.journal: oc.csv oc.csv.rules
	(printf "include oc.accounts\n\n"; hledger -f $< print -x) >$@

report: oc.journal
	hledger -f oc.journal bs -Y
	@echo
	hledger -f oc.journal is -YTS -t
