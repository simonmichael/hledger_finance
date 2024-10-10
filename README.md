The hledger project's public finances.
Here we track our OpenCollective funds for greater insight,
and perhaps add additional entries to manage project finances.
This is also serves as a real-world example, collaborative accounting
practice, and dogfooding. See also: https://hledger.org/finance

This repo is separate from the main hledger repo,
but typically checked out as `finance/` within the latter's working copy.

In this directory:

- `Makefile` - maintenance scripts, eg for updating the journal and readme. `make` to see help.
- `hlfi`     - financial report scripts. `./hlfi` to see help.
- `oc.*`     - CSV, rules, journals for our Open Collective transactions

## Reports

The rest of this README is reports, which attempt to be somewhat readable on Github.
These are regenerated semi-automatically, and may improve as data and rules are cleaned up.

<!--
Process:

1. Manually download the latest oc.csv, monthly or so.
  (We get most new transactions on the 23rd and 24th of the month and for a few days around start of month.)
  View latest OC transactions (https://opencollective.com/hledger/transactions)
  ensure all KINDs selected:   https://opencollective.com/hledger/transactions?kind=CONTRIBUTION%2CEXPENSE%2CHOST_FEE%2CPAYMENT_PROCESSOR_FEE%2CPAYMENT_PROCESSOR_COVER
  click Download CSV
	click Export CSV
2. `make update` to gather the csv, regenerate and check journal, update reports, and commit
3. Review commits, investigate/resolve any hledger version-related changes
4. Check latest calculated OC balance against the one reported on the website
  (hledger -f oc.journal bs, https://opencollective.com/hledger#category-BUDGET > TODAY'S BALANCE)
5. Push to https://github.com/simonmichael/hledger_finance

TODO: add non-OC transactions: bounty donations..
-->
<!-- REPORTS: (don't edit below) -->
## Yearly Assets & Liabilities
<link rel="stylesheet" href="hledger.css">

<table><tr><th style="border-right:double black" class="account">account</th><td class="account">assets:opencollective</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">100.92</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">290.99</td><td style="border-left:double black" align="right" class="amount coltotal"><b>290.99</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">372.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>372.66</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1437.23</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1437.23</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4689.88</td><td style="border-left:double black" align="right" class="amount coltotal"><b>4689.88</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">6863.66</td><td style="border-left:double black" align="right" class="amount coltotal"><b>6863.66</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">7465.73</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7465.73</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">7907.51</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7907.51</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th></tr></table>

## Yearly Revenues & Expenses
<link rel="stylesheet" href="hledger.css">

<table><tr><th style="border-right:double black" class="account">account</th><td class="account">revenues:donations</td><td class="account">expenses:bounties</td><td class="account">expenses:fees</td><td class="account">expenses:misc</td><td style="border-left:double black" class="account"><b>Total:</b></td></tr><tr><th style="border-right:double black">commodity</th><td>USD</td><td>USD</td><td>USD</td><td>USD</td><td style="border-left:double black"><b>USD</b></td></tr><tr><th style="border-right:double black">2017</th><td align="right" class="amount">120.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-19.08</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>100.92</b></td></tr><tr><th style="border-right:double black">2018</th><td align="right" class="amount">225.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-34.93</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>190.07</b></td></tr><tr><th style="border-right:double black">2019</th><td align="right" class="amount">105.00</td><td align="right" class="amount">0</td><td align="right" class="amount">-23.33</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>81.67</b></td></tr><tr><th style="border-right:double black">2020</th><td align="right" class="amount">1254.38</td><td align="right" class="amount">0</td><td align="right" class="amount">-189.81</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>1064.57</b></td></tr><tr><th style="border-right:double black">2021</th><td align="right" class="amount">4721.00</td><td align="right" class="amount">-760.01</td><td align="right" class="amount">-708.34</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>3252.65</b></td></tr><tr><th style="border-right:double black">2022</th><td align="right" class="amount">3744.00</td><td align="right" class="amount">-400.00</td><td align="right" class="amount">-592.10</td><td align="right" class="amount">-578.12</td><td style="border-left:double black" align="right" class="amount coltotal"><b>2173.78</b></td></tr><tr><th style="border-right:double black">2023</th><td align="right" class="amount">1868.00</td><td align="right" class="amount">-862.00</td><td align="right" class="amount">-303.93</td><td align="right" class="amount">-100.00</td><td style="border-left:double black" align="right" class="amount coltotal"><b>602.07</b></td></tr><tr><th style="border-right:double black">2024</th><td align="right" class="amount">1091.00</td><td align="right" class="amount">-499.77</td><td align="right" class="amount">-149.45</td><td align="right" class="amount">0</td><td style="border-left:double black" align="right" class="amount coltotal"><b>441.78</b></td></tr><tr><th style="border-right:double black" class="rowtotal">total</th><td align="right" class="amount rowtotal">13128.38</td><td align="right" class="amount rowtotal">-2521.78</td><td align="right" class="amount rowtotal">-2020.97</td><td align="right" class="amount rowtotal">-678.12</td><td style="border-left:double black" align="right" class="amount coltotal"><b>7907.51</b></td></tr></table>

## This Year's Revenues & Expenses


<table><tr><th colspan="3" style="text-align:left"><h2>Income Statement 2024-01-01..2024-10-09</h2></th></tr><tr><th></th><th>Commodity</th><th style="text-align:right">2024-01-01..2024-10-09</th></tr><tr><td colspan="3">&nbsp;</td></tr><tr><th colspan="3" style="text-align:left" class="account">Revenues</th></tr><tr><td class="account">donations</td><td>USD</td><td align="right" class="amount">1091.00</td></tr><tr><td class="account">  october-swimmer</td><td>USD</td><td align="right" class="amount">280.00</td></tr><tr><td class="account">  joyfulsystems</td><td>USD</td><td align="right" class="amount">150.00</td></tr><tr><td class="account">  Bas van Dijk</td><td>USD</td><td align="right" class="amount">100.00</td></tr><tr><td class="account">  marc11</td><td>USD</td><td align="right" class="amount">100.00</td></tr><tr><td class="account">  usaAmch</td><td>USD</td><td align="right" class="amount">100.00</td></tr><tr><td class="account">  akanshaG42</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  incognito-6a1e7e79</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  jack-todaro</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  markokocic</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  brandonbarker</td><td>USD</td><td align="right" class="amount">20.00</td></tr><tr><td class="account">  guest-4c0726ae</td><td>USD</td><td align="right" class="amount">20.00</td></tr><tr><td class="account">  james-blachly</td><td>USD</td><td align="right" class="amount">20.00</td></tr><tr><td class="account">  ken-ewing</td><td>USD</td><td align="right" class="amount">20.00</td></tr><tr><td class="account">  rhyanki</td><td>USD</td><td align="right" class="amount">20.00</td></tr><tr><td class="account">  samim-pezeshki</td><td>USD</td><td align="right" class="amount">20.00</td></tr><tr><td class="account">  guest-d120c27f</td><td>USD</td><td align="right" class="amount">18.00</td></tr><tr><td class="account">  richard-kelly</td><td>USD</td><td align="right" class="amount">18.00</td></tr><tr><td class="account">  guest-0084c183</td><td>USD</td><td align="right" class="amount">5.00</td></tr><tr><td style="border-top:double black" class="account"><b>Total:</b></td><td style="border-top:double black"><b>USD</b></td><td style="border-top:double black" align="right" class="amount coltotal"><b>1091.00</b></td></tr><tr><td colspan="3">&nbsp;</td></tr><tr><th colspan="3" style="text-align:left" class="account">Expenses</th></tr><tr><td class="account">bounties</td><td>USD</td><td align="right" class="amount">499.77</td></tr><tr><td class="account">  Bas van Dijk</td><td>USD</td><td align="right" class="amount">100.00</td></tr><tr><td class="account">  usaAmch</td><td>USD</td><td align="right" class="amount">100.00</td></tr><tr><td class="account">  akanshaG42</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  markokocic</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  pranesh-prakash</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  simon</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  william-pierce</td><td>USD</td><td align="right" class="amount">50.00</td></tr><tr><td class="account">  ivan-popovych</td><td>USD</td><td align="right" class="amount">49.77</td></tr><tr><td class="account">fees</td><td>USD</td><td align="right" class="amount">149.45</td></tr><tr><td class="account">  Open Source Collective</td><td>USD</td><td align="right" class="amount">77.94</td></tr><tr><td class="account">  Stripe</td><td>USD</td><td align="right" class="amount">50.85</td></tr><tr><td class="account">  PayPal</td><td>USD</td><td align="right" class="amount">17.75</td></tr><tr><td class="account">  Other Payment Processor</td><td>USD</td><td align="right" class="amount">2.91</td></tr><tr><td style="border-top:double black" class="account"><b>Total:</b></td><td style="border-top:double black"><b>USD</b></td><td style="border-top:double black" align="right" class="amount coltotal"><b>649.22</b></td></tr><tr><td colspan="3">&nbsp;</td></tr><tr><td style="border-top:double black" class="account"><b>Net:</b></td><td style="border-top:double black"><b>USD</b></td><td style="border-top:double black" align="right" class="amount coltotal"><b>441.78</b></td></tr></table>

## Yearly Net Assets
```
2017	       101 
2018	       291 +
2019	       373 +
2020	      1437 +++++++
2021	      4690 +++++++++++++++++++++++
2022	      6864 ++++++++++++++++++++++++++++++++++
2023	      7466 +++++++++++++++++++++++++++++++++++++
2024	      7908 +++++++++++++++++++++++++++++++++++++++
```
## Yearly Net Income
```
2017	       101 ++
2018	       190 ++++
2019	        82 ++
2020	      1065 ++++++++++++++++++++++++++
2021	      3253 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
2022	      2174 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
2023	       602 +++++++++++++++
2024	       442 +++++++++++
```
## Assets Over Time
```
                                               hledger assets


                                        bal --depth=1 ^assets --historical
        ⢰⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢒⣒⣒⣒⣒⣒⣒⣒⣒⠒⠒⠒⠒⢲
  8000  ⢸ ⠠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤                                                                     ⣀  ⣀⡠⠴⠒⠳⠤⠤⠞⠉⠉⠉⠉⠉⠁  ⠈    ⢸
        ⢸             ...                                                          ⣠⣀⣠⠴⠶⠚⠉⠈⠉⠉⠁                    ⢸
        ⢸                                                                     ⢀ ⢀⡴⠋⠁⠁                             ⢸
  6000  ⢸                                                                    ⡴⠻⠞⠁                                 ⢸
        ⢸                                                                 ⢀⡴⠋                                     ⢸
        ⢸                                                               ⣠⡶⠋                                       ⢸
  4000  ⢸                                                            ⣀⣤⠞⠁                                         ⢸
[USD]   ⢸                                                          ⣠⠞⠁                                            ⢸
        ⢸                                                       ⢀⣠⠚⠁                                              ⢸
  2000  ⢸                                                    ⣀⡤⠚⠉                                                 ⢸
        ⢸                                             ⢀⣀⡠⠤⠒⠚⠉⠁                                                    ⢸
        ⢸    ⢀⣀⣀⣀⣀⣀⣠⣤⣤⣤⣤⣤⣤⠤⠤⠤⠤⠤⠤⠤⠤⠴⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠛⠚⠉⠉⠉                                                           ⢸
      0 ⠘⠂⠒⠒⠲⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠖⠘


        2017        2018         2019        2020         2021        2022         2023        2024         2025
```
## Revenues Over Time
```
                                        hledger monthly revenues


                                      bal --depth=1 ^revenues --monthly
       ⢰⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢒⣒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢲
       ⢸                                                                ⢸⢸  ⢰⢲                     ⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠄    ⢸
       ⢸                                                              ⢠⢦⢸⢸⢠⢲⢸⢸                                ... ⢸
       ⢸                                                          ⡤⠤⠤⠞⠋⠘⠚⠘⠚⢸⢸⠘⢦                                   ⢸
  400  ⢺                                                          ⡇        ⢸⢸ ⢸ ⢀⠤⡀                ⢠⢤             ⢸
       ⢸                                                      ⡤⡄⡤⡄⡇        ⠸⠼ ⠸⠤⠴ ⡇                ⢸⢸             ⢸
       ⢸                                                      ⡇⡇⡇⡇⡇               ⡇                ⢸⢸             ⢸
       ⢸                                                     ⡖⠃⡇⡇⢧⠇               ⣇⡀               ⢸⢸       ⡤⡄    ⢸
[USD]  ⢼                                                     ⡇ ⡇⡇                  ⡇   ⡎⡇          ⢸⢸⠄      ⡇⡇    ⢸
       ⢸                                              ⣀     ⢀⡇ ⣇⡇                  ⠓⠒⠚⠒⠃⠧⠤⠤⠤⠞⠹⠜⢹  ⢸⠉⢸⡀      ⡇⡇    ⢸
       ⢸                                            ⢰⠚⠈⠒⠒⠒⠒⠋⠉  ⠈                               ⠈⠉⠉⠉  ⢨⡇     ⡇⣇    ⢸
       ⢸                           ⢠⠖⡄              ⢸                                                ⠸⣃⣀⣀⣀⣀⣀⡇     ⢸
       ⣸    ⠠⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠴⠒⠒⠒⠒⠲⠤⠤⠤⠼ ⠧⠤⣄⣤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠼                                                             ⢸
    0  ⠘⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠆⠘


       2017         2018        2019         2020        2021         2022         2023        2024         2025
```
## Expenses Over Time
```
                                        hledger monthly expenses


                                      bal --depth=1 ^expenses --monthly
       ⢰⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢒⣒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⢲
       ⢸                                                                     ⢸⢸                    ⠤⠤⠤⠤⠤⠤⠤⠤⠤⠤⠄    ⢸
       ⢸                                                                     ⢸⢸                               ... ⢸
       ⢸                                                                     ⢸⢸                                   ⢸
  400  ⢺                                                             ⣠⣄      ⢸⢸                                   ⢸
       ⢸                                                             ⡇⢸      ⢸⢸                                   ⢸
       ⢸                                                             ⡇⢸ ⢀⣀   ⢸⢸                 ⢸⢹          ⡞⡆    ⢸
       ⢸                                                             ⡇⢸ ⢸⢸   ⢸⢸    ⣀            ⢸⢸          ⡇⡇    ⢸
[USD]  ⢼                                                            ⡖⠃⢸ ⢸⢸   ⢸⢸    ⡏⡇     ⡯⢵    ⢸⢸          ⡇⡇    ⢸
  200  ⢸                                                            ⡇ ⢸⢰⠚⢸⢰⢹ ⢸⢸⡀   ⡇⡇     ⡇⢸    ⢸⢸⢰⢳        ⡇⡇    ⢸
       ⢸                                                            ⡇ ⢸⢸ ⢸⢸⢸ ⢸ ⢹   ⡇⡇ ⡏⡇ ⡎⠁⠈⢳   ⢸⠈⠚⠸⢤  ⠤⡄   ⡇⡇    ⢸
       ⢸                                                      ⣠⡀⣀⡀⡴⠶⠃ ⠘⠚ ⠘⠚⠸⠼⠉ ⠘⠤⠶⣀⡇⡇ ⡇⢧⡀⡇  ⢸   ⢸   ⢸  ⡇⡇   ⡇⠣    ⢸
       ⣸    ⣠⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣄⣀⣀⣀⣀⣀⣀⣀⣀⣀⣠⠤⣤⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣄⣀⣠⠖⠒⠒⠒⠒⠒⠒⠒⠋ ⠓⠃⠈                ⠉ ⠙⠉⠁ ⠓⠃  ⠈⠓⠒⠓⠚   ⠘⠒⠤⠃⠧⠤⠤⠤⠇     ⢸
    0  ⠘⠒⠒⠒⠂⠶⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠖⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠰⠆⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠂⠶⠐⠒⠒⠒⠒⠒⠒⠒⠒⠒⠒⠲⠆⠘


       2017         2018        2019         2020        2021         2022         2023        2024         2025
```
