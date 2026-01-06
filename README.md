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
- `oc.csv.rules`      - rules for converting the above (copy of examples/csv/other/opencollective/opencollective-legacy.rules, keep synced)
- `oc.journal`        - journal file generated from oc.csv
- `other.journal`     - other transactions, manually recorded
- `README.md`         - this readme. Hand-maintained content plus hledger-generated reports.

To regenerate the reports:

- `just oc-txns` (View Open Collective transactions with no filters, <https://opencollective.com/hledger/transactions?kind=ALL>)
  - Click Export CSV
  - Selected export set: Legacy Platform Default (Pre-2024)
  - Use field IDs as column headers instead of field names: on
  - Export taxes and payment processor fees as columns: on
  - Click Export CSV
  - Close the dialog
- `just update`, check git diffs
- `just reports oc-budget`, check latest balance agrees with OC's
- `just commit`
- `git push` to <https://github.com/simonmichael/hledger_finance>

## Reports

<!-- REPORTS: (don't edit below) -->

## Revenues & Expenses This Year


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">revenues:contributions</td><td class="account">expenses:fees</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2026-01</th><td align="right" class="amount">80.00</td><td align="right" class="amount">-13.71</td><td style="border-left:double black" align="right" class="amount coltotal"><b>66.29</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th><td align="right" class="amount rowtotal">80.00</td><td align="right" class="amount rowtotal">-13.71</td><td style="border-left:double black" align="right" class="amount coltotal"><b>66.29</b></td></tr><tr><th style="border-right:double black" class="rowaverage">average</th><td align="right" class="amount rowaverage">80.00</td><td align="right" class="amount rowaverage">-13.71</td><td style="border-left:double black" align="right" class="amount colaverage"><b>66.29</b></td></tr></table>


## Revenues & Expenses by Year


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">revenues:contributions</td><td class="account">expenses:disbursed</td><td class="account">expenses:fees</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td>USD</td><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">120.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-19.08</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">225.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-34.93</td><td style="border-left:double black" align="right" class="amount coltotal"><b>190.07</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">105.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-23.33</td><td style="border-left:double black" align="right" class="amount coltotal"><b>81.67</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1254.38</td><td align="right" class="amount">0</td><td align="right" class="amount">-189.81</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1064.57</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4721.00</td><td align="right" class="amount">-760.01</td><td align="right" class="amount">-708.34</td><td style="border-left:double black" align="right" class="amount coltotal"><b>3252.65</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">3744.00</td><td align="right" class="amount">-978.12</td><td align="right" class="amount">-592.10</td><td style="border-left:double black" align="right" class="amount coltotal"><b>2173.78</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">1868.00</td><td align="right" class="amount">-962.00</td><td align="right" class="amount">-303.93</td><td style="border-left:double black" align="right" class="amount coltotal"><b>602.07</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">1277.00</td><td align="right" class="amount">-1198.14</td><td align="right" class="amount">-171.89</td><td style="border-left:double black" align="right" class="amount coltotal"><b>-93.03</b></td></tr><tr><th style="border-right:double black">2025</th><td align="right" class="amount">1779.00</td><td align="right" class="amount">-1681.91</td><td align="right" class="amount">-298.08</td><td style="border-left:double black" align="right" class="amount coltotal"><b>-200.99</b></td></tr><tr><th style="border-right:double black">2026</th><td align="right" class="amount">80.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-13.71</td><td style="border-left:double black" align="right" class="amount coltotal"><b>66.29</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th><td align="right" class="amount rowtotal">15173.38</td><td align="right" class="amount rowtotal">-5580.18</td><td align="right" class="amount rowtotal">-2355.20</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7238.00</b></td></tr></table>


## Assets & Liabilities By Year


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">assets:opencollective</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">100.92</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">290.99</td><td style="border-left:double black" align="right" class="amount coltotal"><b>290.99</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">372.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>372.66</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1437.23</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1437.23</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4689.88</td><td style="border-left:double black" align="right" class="amount coltotal"><b>4689.88</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">6863.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>6863.66</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">7465.73</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7465.73</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">7372.70</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7372.70</b></td></tr><tr><th style="border-right:double black">2025</th><td align="right" class="amount">7171.71</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7171.71</b></td></tr><tr><th style="border-right:double black">2026</th><td align="right" class="amount">7238.00</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7238.00</b></td></tr></table>

