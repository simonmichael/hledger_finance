# hledger finance repo

In this repo we keep a ledger and reports of the hledger project's finances, for clarity and dogfooding.\
See also the hledger.org [Finance](https://hledger.org/FINANCE.html) page.
(If you're looking for the main hledger code repo, see <https://github.com/simonmichael/hledger>.)

In this directory:

- `Justfile`          - maintenance and reporting scripts. Run `just` to see help.
- `hledger.conf`      - local hledger config
- `main.journal`      - top-level journal file
- `accounts.journal`  - account declarations
- `oc.csv`            - all hledger open collective transactions, exported as CSV
- `oc.csv.rules`      - hledger CSV rules for converting the above to..
- `oc.journal`        - journal file generated from oc.csv
- `other.journal`     - other transactions, manually recorded
- `README.md`         - this readme. Hand-maintained content plus hledger-generated reports.

Reports update process:

- View [latest Open Collective transactions](https://opencollective.com/hledger/transactions?kind=CONTRIBUTION%2CEXPENSE%2CHOST_FEE%2CPAYMENT_PROCESSOR_FEE%2CPAYMENT_PROCESSOR_COVER)
- Check parameters 1
  - all should be set to All
- Click Download CSV
- Check parameters 2
  - Date range should be sufficient to leave no gap
  - Timezone should be what rules require: Local (consider switching to UTC for greater stability)
  - Start date / End date should be sufficient to leave no gap (Why both these and Date range ? Try ignoring these)
  - Exported Fields should be Platform Default
  - Separate transactions compatibility should be ENABLED
- Click Export CSV
- Wait for and check for a successful complete download by browser. Warning this is deceptive.
- Manually close the Export CSV dialog
- In finance dir, `just update` (gather csv, regenerate journal and reports)
- Deal with any snafu (missing python deps..)
- Review diffs in magit, investigate/resolve any problems
- Review reports in VSC markdown preview, check that these match:
  - Assets report > latest asset balance 
  - https://opencollective.com/hledger#category-BUDGET > TODAY'S BALANCE
- Commit
- `git push` to update https://github.com/simonmichael/hledger_finance

## Reports

<!-- REPORTS: (don't edit below) -->

## Revenues & Expenses This Year


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">revenues:donations</td><td class="account">expenses:fees</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2025-01</th><td align="right" class="amount">141.00</td><td align="right" class="amount">-24.08</td><td style="border-left:double black" align="right" class="amount coltotal"><b>116.92</b></td></tr><tr><th style="border-right:double black">2025-02</th><td align="right" class="amount">37.00</td><td align="right" class="amount">-7.79</td><td style="border-left:double black" align="right" class="amount coltotal"><b>29.21</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th><td align="right" class="amount rowtotal">178.00</td><td align="right" class="amount rowtotal">-31.87</td><td style="border-left:double black" align="right" class="amount coltotal"><b>146.13</b></td></tr><tr><th style="border-right:double black" class="rowaverage">average</th><td align="right" class="amount rowaverage">89.00</td><td align="right" class="amount rowaverage">-15.94</td><td style="border-left:double black" align="right" class="amount colaverage"><b>73.06</b></td></tr></table>


## Revenues & Expenses by Year


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">revenues:donations</td><td class="account">expenses:bounties</td><td class="account">expenses:fees</td><td class="account">expenses:misc</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td>USD</td><td>USD</td><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">120.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-19.08</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">225.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-34.93</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>190.07</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">105.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-23.33</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>81.67</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1254.38</td><td align="right" class="amount">0</td><td align="right" class="amount">-189.81</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1064.57</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4721.00</td><td align="right" class="amount">-760.01</td><td align="right" class="amount">-708.34</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>3252.65</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">3744.00</td><td align="right" class="amount">-400.00</td><td align="right" class="amount">-592.10</td><td align="right" class="amount">-578.12</td><td style="border-left:double black" align="right" class="amount coltotal"><b>2173.78</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">1868.00</td><td align="right" class="amount">-862.00</td><td align="right" class="amount">-303.93</td><td align="right" class="amount">-100.00</td><td style="border-left:double black" align="right" class="amount coltotal"><b>602.07</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">1277.00</td><td align="right" class="amount">-1198.14</td><td align="right" class="amount">-171.89</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>-93.03</b></td></tr><tr><th style="border-right:double black">2025</th><td align="right" class="amount">178.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-31.87</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>146.13</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th><td align="right" class="amount rowtotal">13492.38</td><td align="right" class="amount rowtotal">-3220.15</td><td align="right" class="amount rowtotal">-2075.28</td><td align="right" class="amount rowtotal">-678.12</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7518.83</b></td></tr></table>


## Assets & Liabilities By Year


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">assets:opencollective</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">100.92</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">290.99</td><td style="border-left:double black" align="right" class="amount coltotal"><b>290.99</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">372.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>372.66</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1437.23</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1437.23</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4689.88</td><td style="border-left:double black" align="right" class="amount coltotal"><b>4689.88</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">6863.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>6863.66</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">7465.73</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7465.73</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">7372.70</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7372.70</b></td></tr><tr><th style="border-right:double black">2025</th><td align="right" class="amount">7518.83</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7518.83</b></td></tr></table>

