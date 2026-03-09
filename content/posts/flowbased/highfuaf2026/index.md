---
title: 'Flowbased: an update on export restrictions of France'
date: 2026-03-09
description: 'Last year my post about new constraints restricting the French export to Core got a lot of attention. This post checks whether the described situation has changed since then.'
plotly: true
---
Last year I [wrote about](https://boerman.dev/posts/flowbased/highfuaf2025/) fluctuations in the market and the effects on grid constraints. In summary due to increased exports from France to Italy North, the french TSO RTE introduced new Flowbased constraints. These then limit the French export possibilities towards the Core region. These limits folow from forecasted flows from France to Italy North, the so called _Fuaf_.

We are now a year further and the question is, is this still true? Please note I will not repeat all concept explanations in this post, for more details on this please consult the original post!

## Repeating key indicators

It is currently beginning of March so to make the comparison fair I chose to compare the first two months of 2025 with the first two months of 2026.  
In figure 1 below the average Fuaf is plotted per TSO for all presolved constraints, comparing the two selected periods.

{{<plotly json="fig_presolved_fuaf.json" height="500px" caption="Figure 1: Average Forecasted Commercial Exchanges Outside Core, presolved domain only" >}}

Here we can see that the Fuaf flows are on average still one of the highest for RTE among all TSO's. Futhermore it has actually  increased compared to 2025 period. This then again actively limits the market as well. In figure 2 some selected TSO's are plotted on active constraints statistics. 

{{<plotly json="fig_moved_ac.json" height="500px" caption="Figure 2: Change in FB Core Active Constraint statistics for some TSOs" >}}

Here we can see that RTE active constraints not only have lower capacity for exchanges within Core (RAM) but are also active in even higher share of time units then before.

We can then again zoom in on the specific constraints. This time we zoom in a bit further and check the active contraints of RTE in table 1.

<figure class="left" style="width:100%">

| CNE Name   |   AVG RAM 2025 |   AVG Fuaf 2025 |   AVG Shadow Price 2025 [EUR/MWh] |   % MTU 2025 |   AVG RAM 2026 |   AVG Fuaf 2026 |  AVG Shadow Price 2026 [EUR/MWh] |   % MTU 2026 |
|:-----------------------------------|-----------:|------------:|--------------------:|-------------:|-----------:|------------:|--------------------:|-------------:|
| L 400kV N0 1 CREYS-ST-VULBAS-OUEST |        21.4587 |         53.0783 |             182.902 |         4.8  |        20.1154 |         58.7492 |            318.364  |        16.97 |
| L 400kV N0 2 CREYS-ST-VULBAS-OUEST |        22.1413 |         52.0127 |             200.974 |        21.4  |        20.4978 |         57.3162 |            311.421  |        49.24 |
| Ensdorf - Vigy VIGY2 S             |        22.6446 |         33.0614 |             104.495 |         6.92 |        23.119  |         36.6248 |            195.759  |         5.72 |
| Ensdorf - Vigy VIGY1 N             |       ---      |        ---      |             ---     |       ---    |        21.0586 |         37.4786 |            107.446  |         0.37 |
| Avelgem - Avelin 380.80            |       ---      |        ---      |             ---     |       ---    |        79.11   |        -15.454  |             24.8799 |         0.05 |

<figcaption class="center">Table 1: Statistics for all CNE's in active constraints for RTE in selected time periods. Data in % of Fmax unless otherwise noted.</figcaption>
</figure>

Here again the picture is very similar to last time. Both circuits of Creys-st-vulbas are dominant in this overview, having large Fuaf's and high share of MTU's. These are the two circuits that are relatively close to the French-Italian border and the same ones that were comming up in the analysis of the previous post of the presolved constraints. In the appendix this exact analysis is repeating which shows this as well.

## Checking French Core Export

On top of repeating last times analyis there is some extra things we can check this time as well.

## 15 min MTU
One change between the two selected periods is that 15min MTU went live. This means that active constraints are based on 15min resolution. However capacity calculation stayed in hourly resolution. This means that the presolved domains are still in hourly resolution. So for a fair comparison no adaptation is needed.  
To make the comparison fair for active constraints between 2025 and 2026 the share of MTU's is shown as percentage of all possible MTU's in that period. In 2026 this total number of MTU's is 4 times as much as 2025.

## Appendix
To check if the high Fuaf still results in low capacities for Core we can also look at the average RAM in the presolved domain. This is plotted in figure 3. This shows that RTE RAM is virtually unchanged compared between the time periods and thus still quite low
{{<plotly json="fig_presolved_ram.json" height="500px" caption="Figure 3: Average RAM per TSO, presolved domain only" >}}

Below in table 2 a repittion of the exact same analysis as last time on the presolved constraints of RTE is shown. From there you can see the picture is very much the same as last time as well.
<figure class="left" style="width:100%;text-transform: none !important;">

| CNE name                         |   AVG RAM 2025 |   AVG Fuaf 2025 |   AVG coun 2025 [#] |   AVG RAM 2026 |   AVG Fuaf 2026 |   count 2026 [#] |
|:-----------------------------------------|-----------:|------------:|-------------:|-----------:|------------:|-------------:|
| L 400kV N0 1 CREYS-ST-VULBAS-OUEST       |      23.46 |       50.08 |          449 |      20.62 |       57.39 |          569 |
| L 400kV N0 2 CREYS-ST-VULBAS-OUEST       |      26.42 |       46.22 |         1016 |      21.94 |       54.5  |         1059 |
| L 400kV N0 1 FRASNE - GENISSIAT          |     ---    |      ---    |          --- |      34.44 |       36.02 |            7 |
| Ensdorf - Vigy VIGY1 N                   |      22.09 |       33.82 |           12 |      33.48 |       33.26 |           76 |
| Ensdorf - Vigy VIGY2 S                   |      26.18 |       29.67 |          387 |      30.94 |       30.68 |          465 |
| L 400kV N0 1 MUHLBACH-SIERENTZ           |     ---    |      ---    |          --- |      28.94 |       24.72 |            1 |
| Avelgem - Avelin 380.80                  |      83.19 |        3.5  |          589 |      85.68 |       -3.03 |          831 |
| L 400kV N0 1 AVELIN-MASTAING             |      47.31 |        4.34 |          338 |      43.79 |       -4.03 |           27 |
| L 400kV N0 1 FAUX-FRESNAY-MERY-SUR-SEINE |      38.5  |       -2.57 |          157 |      38.1  |       -4.67 |           95 |
| L 400kV N0 1 AVELIN-GAVRELLE             |     ---    |      ---    |          --- |      61.23 |       -9.36 |           45 |
| L 400kV N0 2 AVELIN - MASTAING           |      80.88 |      -28.94 |           40 |     ---    |      ---    |          --- |

<figcaption class="center">Table 2: Statistics for all presolved CNE's  for RTE in selected time periods Data in % of Fmax unless otherwise noted. </figcaption>
</figure>


