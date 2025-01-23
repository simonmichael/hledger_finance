# hledger finance repo

Here we track the hledger project's finances,
for clarity, dogfooding, and as a real-world example of FOSS project accounting with hledger.
(shortcut: https://finance.hledger.org)

See also the FINANCE section on the hledger website, eg
[Sponsor hledger](https://hledger.org/sponsor.html),
[Regression bounty](https://hledger.org/REGRESSIONS.html) and 
[FINANCE notes](https://hledger.org/FINANCE.html).

In this directory:

- `Justfile`          - maintenance and reporting scripts. `just` to see help.
- `hledger.conf`      - local hledger config
- `main.journal`      - top-level journal file
- `accounts.journal`  - account declarations
- `oc.*`              - hledger open collective CSV, conversion rules, journal
- `other.journal`     - other transactions, manually recorded

The rest of this README is reports, intended to be somewhat readable on Github.
These are regenerated semi-automatically, and may improve as data and scripts are cleaned up.
<!-- We get most new transactions on the 23rd and 24th of the month and for a few days around start of month. -->
Update process:

- View [latest Open Collective transactions](https://opencollective.com/hledger/transactions?kind=CONTRIBUTION%2CEXPENSE%2CHOST_FEE%2CPAYMENT_PROCESSOR_FEE%2CPAYMENT_PROCESSOR_COVER)
- Check all parameters are set to All
- Click Download CSV
- Turn on Separate transactions compatibility
- Check other parameters, defaults should be ok
- Click Export CSV, wait for dowload to complete
- Ensure that it downloaded, then close the Export CSV dialog
- In finance dir, `just update` (gather csv, regenerate journal and reports)
- Deal with any snafu (missing python deps..)
- Review diffs, investigate/resolve any problems
- Check that the latest asset balance matches https://opencollective.com/hledger#category-BUDGET > TODAY'S BALANCE
- Commit
- `git push` to update https://github.com/simonmichael/hledger_finance

## Reports

<!-- REPORTS: (don't edit below) -->

## Yearly Assets & Liabilities


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">assets:opencollective</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">100.92</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">290.99</td><td style="border-left:double black" align="right" class="amount coltotal"><b>290.99</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">372.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>372.66</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1437.23</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1437.23</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4689.88</td><td style="border-left:double black" align="right" class="amount coltotal"><b>4689.88</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">6863.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>6863.66</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">7465.73</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7465.73</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">7372.70</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7372.70</b></td></tr><tr><th style="border-right:double black">2025</th><td align="right" class="amount">7488.38</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7488.38</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th></tr></table>


## Yearly Revenues & Expenses


<table><tr><th style="border-right:double black" class="account">account</th><td class="account">revenues:donations</td><td class="account">expenses:bounties</td><td class="account">expenses:fees</td><td class="account">expenses:misc</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td>USD</td><td>USD</td><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">120.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-19.08</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">225.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-34.93</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>190.07</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">105.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-23.33</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>81.67</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1254.38</td><td align="right" class="amount">0</td><td align="right" class="amount">-189.81</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1064.57</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4721.00</td><td align="right" class="amount">-760.01</td><td align="right" class="amount">-708.34</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>3252.65</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">3744.00</td><td align="right" class="amount">-400.00</td><td align="right" class="amount">-592.10</td><td align="right" class="amount">-578.12</td><td style="border-left:double black" align="right" class="amount coltotal"><b>2173.78</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">1868.00</td><td align="right" class="amount">-862.00</td><td align="right" class="amount">-303.93</td><td align="right" class="amount">-100.00</td><td style="border-left:double black" align="right" class="amount coltotal"><b>602.07</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">1277.00</td><td align="right" class="amount">-1198.14</td><td align="right" class="amount">-171.89</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>-93.03</b></td></tr><tr><th style="border-right:double black">2025</th><td align="right" class="amount">139.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-23.32</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>115.68</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th><td align="right" class="amount rowtotal">13453.38</td><td align="right" class="amount rowtotal">-3220.15</td><td align="right" class="amount rowtotal">-2066.73</td><td align="right" class="amount rowtotal">-678.12</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7488.38</b></td></tr></table>


## This Year's Revenues & Expenses


<table><tr><th colspan="3" style="text-align:left"><h2>Income Statement 2025-01-01..2025-01-23</h2></th></tr>

<table><tr><th></th><th>Commodity</th><th>2025-01-01..2025-01-23</th></tr><tr><td colspan="3" class="account"><b>Revenues</b></td></tr><tr><td class="account">donations</td><td>USD</td><td align="right" class="amount">139.00</td></tr><tr><td class="account">  Guest</td><td>USD</td><td align="right" class="amount">52.00</td></tr><tr><td class="account">  incognito</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  Joyful Systems</td><td>USD</td><td align="right" class="amount">10.00</td></tr><tr><td class="account">  October Swimmer</td><td>USD</td><td align="right" class="amount">10.00</td></tr><tr><td class="account">  Jack Todaro</td><td>USD</td><td align="right" class="amount">5.00</td></tr><tr><td class="account">  Brandon Barker</td><td>USD</td><td align="right" class="amount">2.00</td></tr><tr><td class="account">  Frank</td><td>USD</td><td align="right" class="amount">2.00</td></tr><tr><td class="account">  James Blachly</td><td>USD</td><td align="right" class="amount">2.00</td></tr><tr><td class="account">  Ken Ewing</td><td>USD</td><td align="right" class="amount">2.00</td></tr><tr><td class="account">  Rishi Hyanki</td><td>USD</td><td align="right" class="amount">2.00</td></tr><tr><td class="account">  Samim Pezeshki</td><td>USD</td><td align="right" class="amount">2.00</td></tr><tr><td style="border-top:double black" class="account"><b>Total:</b></td><td style="border-top:double black"><b>USD</b></td><td style="border-top:double black" align="right" class="amount coltotal"><b>139.00</b></td></tr><tr><td colspan="3"> </td></tr><tr><td colspan="3" class="account"><b>Expenses</b></td></tr><tr><td class="account">fees</td><td>USD</td><td align="right" class="amount">23.32</td></tr><tr><td class="account">  Open Source Collective</td><td>USD</td><td align="right" class="amount">13.90</td></tr><tr><td class="account">  STRIPE</td><td>USD</td><td align="right" class="amount">6.00</td></tr><tr><td class="account">  PAYPAL</td><td>USD</td><td align="right" class="amount">3.42</td></tr><tr><td style="border-top:double black" class="account"><b>Total:</b></td><td style="border-top:double black"><b>USD</b></td><td style="border-top:double black" align="right" class="amount coltotal"><b>23.32</b></td></tr><tr><td colspan="3"> </td></tr><tr><td style="border-top:double black" class="account"><b>Net:</b></td><td style="border-top:double black"><b>USD</b></td><td style="border-top:double black" align="right" class="amount coltotal"><b>115.68</b></td></tr></table></table>

## Yearly Net Income
```
2017	       101 
2018	       190 +
2019	        82 
2020	      1065 +++++++
2021	      3253 +++++++++++++++++++++
2022	      2174 ++++++++++++++
2023	       602 ++++
2024	       -93 
2025	       116 
```

## Yearly Net Assets
```
2017	       101 
2018	       291 +
2019	       373 ++
2020	      1437 +++++++++
2021	      4690 +++++++++++++++++++++++++++++++
2022	      6864 +++++++++++++++++++++++++++++++++++++++++++++
2023	      7466 +++++++++++++++++++++++++++++++++++++++++++++++++
2024	      7373 +++++++++++++++++++++++++++++++++++++++++++++++++
2025	      7488 +++++++++++++++++++++++++++++++++++++++++++++++++
```

## Assets Over Time
```
                                               hledger assets


                                        bal --depth=1 ^assets --historical
        ⢰⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢒⣒⣒⣒⣒⣒⣒⣒⡒⠒⠒⠒⠒⠒⠒⠒⢲
  8000  ⢸ ⠠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤                                                                  ⣀⡀ ⣀⣠⠴⠒⠳⠤⠤⠏⠉⠉⠉⠉⠉   ⠱⢤⢤⡤    ⢸
        ⢸             assets                                                    ⢀⣄⣀⠤⠶⠖⠉⠁⠉⠉⠁                       ⢸
        ⢸                                                                   ⡀ ⣠⠞⠉⠈                                ⢸
  6000  ⢸                                                                 ⢀⡖⠳⠋⠁                                   ⢸
        ⢸                                                               ⢀⡖⠉                                       ⢸
        ⢸                                                             ⣠⠶⠋                                         ⢸
  4000  ⢸                                                          ⣀⣤⠞⠁                                           ⢸
[USD]   ⢸                                                        ⣀⠞⠁                                              ⢸
        ⢸                                                     ⢀⣠⠖⠁                                                ⢸
  2000  ⢸                                                  ⢀⣠⠖⠉                                                   ⢸
        ⢸                                            ⣀⣠⠤⠖⠒⠋⠉                                                      ⢸
        ⢸    ⢀⣀⣀⣀⣀⣀⣠⣤⣤⣤⣤⣤⡤⠤⠤⠤⠤⠤⠤⠤⠤⠶⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠓⠋⠉⠉⠁                                                            ⢸
      0 ⠘⠂⠒⠒⠲⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠖⠒⠒⠒⠒⠘


        2017        2018        2019        2020        2021        2022        2023        2024        2025
```

## Revenues Over Time
```
                                        hledger monthly revenues


                                      bal --depth=1 ^revenues --monthly
       ⢰⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢒⣒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢲
       ⢸                                                              ⢸⢸  ⢰⢲               ⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤            ⢸
       ⢸                                                            ⢠⢦⢸⢸⢰⢲⢸⢸                           revenues   ⢸
       ⢸                                                        ⢠⠤⠤⠴⠋⠘⠚⠘⠚⢸⢸⠸⢤                                     ⢸
  400  ⢺                                                        ⢸        ⢸⢸ ⢸ ⢠⢤                 ⡤⡄               ⢸
       ⢸                                                    ⢠⢤⢠⢄⢸        ⠸⠼ ⠸⠤⠼⢸                 ⡇⡇               ⢸
       ⢸                                                    ⢸⢸⢸⢸⢸              ⢸                 ⡇⡇               ⢸
       ⢸                                                   ⢰⠚⢸⢸⠸⡼              ⠸⣄                ⡇⡇      ⡤⡄       ⢸
[USD]  ⢼                                                   ⢸ ⢼⢸                 ⢸   ⠠⣿⠄          ⡇⡇      ⡇⡇       ⢸
       ⢸                                            ⢀⡀     ⣸ ⢸⣸                 ⠘⠒⠒⠛⠒⠹⠤⠤⠤⠴⠉⠶⠋⡇  ⡏⠁⣇      ⡇⣇⡀ ⣀    ⢸
       ⢸                                           ⡔⠋⠙⠒⠒⠒⠚⠉⠁  ⠁                              ⠉⠉⠉⠁ ⠈⡇     ⡇ ⣇⡀⡇    ⢸
       ⢸                           ⡖⡆              ⡇                                               ⣇⣀⣀⣀⣀⣀⡇  ⣇⡇    ⢸
       ⣸    ⠠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠖⠒⠒⠒⠒⠦⠤⠤⠤⠇⠧⠤⣄⣤⡤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠇                                                              ⢸
    0  ⠘⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠘


       2017        2018        2019         2020        2021        2022        2023        2024         2025
```

## Expenses Over Time
```
                                        hledger monthly expenses


                                      bal --depth=1 ^expenses --monthly
       ⢰⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⣒⡒⠒⠒⠒⠒⠒⠒⢲
  600  ⢹ ⠠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤                                                       ⢀⣄                             ⡇⡏      ⢸
       ⢸             expenses                                              ⢸⢸                             ⡇⡇      ⢸
       ⢸                                                                   ⢸⢸                             ⡇⡇      ⢸
       ⢸                                                                   ⢸⢸                             ⡇⡇      ⢸
  400  ⢹                                                           ⢰⢲      ⢸⢸                             ⡇⡇      ⢸
       ⢸                                                           ⢸⢸      ⢸⢸                 ⠶⡄         ⡠⠇⡇      ⢸
       ⢸                                                           ⢸⢸ ⢰⢹   ⢸⢸                 ⡇⡇         ⡇ ⡇      ⢸
[USD]  ⣸                                                          ⢠⠼⢸ ⢸⢸   ⢸⢸   ⢠⣲     ⢀⣒⡀   ⢀⡇⡇         ⡇ ⡇      ⢸
  200  ⢸                                                          ⢸ ⢸⢠⠼⢸⢠⢶ ⢸⢸   ⢸⢸      ⣿     ⡇⡇⡖⡄       ⡇ ⡇      ⢸
       ⢸                                                          ⢸ ⢸⢸ ⢸⢸⢸ ⢸⠈⢹  ⢸⢸ ⢠⠒⡆⢠⡖⠉⢲⡄   ⡇⠓⠃⣇⡀ ⡤⡄   ⡇ ⠧⡄     ⢸
       ⢸                                                    ⢀⣄⢀⣀⢠⠤⠼ ⠘⠚ ⠘⠞⢸⣰⠋ ⠸⠤⢤⣘⢸ ⠸ ⣇⠸⡇ ⢸⠇   ⡇   ⡇ ⡇⡇   ⡇  ⠧⡄    ⢸
       ⣸    ⣠⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣠⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⡤⣤⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣠⣀⣀⡴⠒⠒⠒⠒⠒⠒⠒⠚⠁⠘⠚⠈⠉               ⠉⠈⠒⠋⠁⠈⠛⠁ ⠈⠙⠒⠛⠒⠃   ⠓⠦⠇⠧⠤⠤⠤⠇   ⠙    ⢸
    0  ⠘⠒⠒⠒⠂⠶⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠶⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠘


       2017        2018         2019        2020        2021        2022        2023        2024         2025
```
