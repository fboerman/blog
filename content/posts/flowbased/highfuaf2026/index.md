---
title: 'Flowbased: an update on export restrictions of France'
date: 2026-03-11
description: 'Last year my post about new constraints restricting the French export to Core got a lot of attention. This post checks whether the described situation has changed since then.'
plotly: true
---
Last year I [wrote about](https://boerman.dev/posts/flowbased/highfuaf2025/) fluctuations in the market and the effects on grid constraints. In summary due to increased exports from France to Italy North, the French TSO RTE introduced new Flowbased constraints. These then limit the French export possibilities towards the Core region. These limits follow from forecasted flows from France to Italy North, the so called _Fuaf_.

We are now a year further and the question is, is this still true? Please note I will not repeat all concept explanations in this post, for more details on this please consult the original post!

## Repeating key indicators

It is currently beginning of March so to make the comparison fair I chose to compare the first two months of 2025 with the first two months of 2026.  
In figure 1 below the average Fuaf is plotted per TSO for all presolved constraints, comparing the two selected periods.

{{<plotly json="fig_presolved_fuaf.json" height="500px" caption="Figure 1: Average Forecasted Commercial Exchanges Outside Core, presolved domain only" >}}

Here we can see that the average Fuaf flows are still one of the highest for RTE among all TSO's. Furthermore it has actually  increased compared to 2025 period. This then again actively limits the market as well.

Now lets move on to active constraints. In figure 2 some selected TSO's are plotted on active constraints statistics. 

{{<plotly json="fig_moved_ac.json" height="500px" caption="Figure 2: Change in FB Core Active Constraint statistics for some TSOs" >}}

Here we can see that RTE active constraints not only have lower capacity for exchanges within Core, but are also active in even higher share of time units then before.

We can then again zoom in on the specific constraints. This time we zoom in a bit further and check the active constraints of RTE in table 1, instead of the full presolved domain.

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

Here again the picture is very similar to last time. Both circuits of Creys-st-vulbas are dominant in this overview, having large Fuaf's and high share of MTU's. These are the two circuits that are relatively close to the French-Italian border and the same ones that were coming up in the analysis of the previous post of the presolved constraints. In addition to this it can also be seen that the shadow prices are quite a lot higher in 2026 as well. So in terms of welfare the effect has been even stronger. 

In the appendix the exact analysis of last time on presolved domain is repeating which shows this as well.

## Zooming in on French Exports

On top of repeating last times analysis there are some extra indicators we can check this time as well. First we can check the evolution of the theoretical maximum export in the Core Domain for France. This is shown in figure 3 below.

{{<plotly json="fig_minmax_rte.json" height="400px" caption="Figure 3: Evolution of average theoretical max Export for FR in Core" >}}

Here we can see a clear downward trend over the years. In fact in 2026 the situation again is a bit lower then in the same months in 2025. Again this follows directly from the situation describe above. Higher Fuaf means lower RAM, lower RAM means lower capacity especially for France.

As a last indicator we can also check the market performance of France. In terms of market direction France has been an exporting powerhouse for a while now. This also means it will actually use this maximum export and be constrained by it. We can visualize this by calculating  the French Core Net Position as a share of the theoretical maximum of the French NP in Core. In other words a simple NP\_Core/NP\_max division over all exporting MTU's.  
Please note that using 100% of this theoretical maximum is very rare. In order to achieve a very high utilization, all other Net Positions in Core would need to be optimized for this single one. That is almost never the economic optimum. In practice everything above 50% is already quite high, especially averaged over a longer period. 

In figure 4 below the average export utilization over the first 2 months of 2026 is shown for all Core zones. On the secondary y-axis the share of exporting time units is plotted as well.

{{<plotly json="fig_exports_stats.json" height="500px" caption="Figure 4: Export statistics for all zones in Core in first two months of 2026." >}}

Here we can see that in this time period France was exporting most of the time (almost 85%) and that its average utilization of the export space is quite high, almost 60%. This is much higher then all other zones in both metrics.

## Conclusion
So in conclusion it can be seen that the previous post is still very relevant. Not a whole lot has changed. The Fuaf on dominant French constraints is still very high, at 33% on average. French CNEC's are still very dominant with French CNECs active over 70% of the time in the measured time period. This can again be traced back to the same constraints as last time.  
It can also be observed that the market algorithm indeed uses a lot of the available export space, an indication that such lower capacity domain can have an important influence on the market outcome. This can also be seen in the average shadow price on the French active constraints, which is consistently high.
 

## Note about 15 min MTU switch
One change between the two selected periods is that SDAC switched from 1h to 15min MTU. This means that active constraints are based on 15min resolution as well. However capacity calculation stayed in hourly resolution. This means that the presolved domains are still in hourly resolution. So for a fair comparison no adaptation is needed.  
To make the comparison fair for active constraints between 2025 and 2026 the share of MTU's is shown as percentage of all possible MTU's in that period. In 2026 this total number of MTU's is 4 times as much as 2025.

## Appendix
To check if the high Fuaf still results in low capacities for Core we can also look at the average RAM in the presolved domain. This is plotted in figure 5. This shows that RTE RAM is virtually unchanged compared between the time periods and thus still quite low
{{<plotly json="fig_presolved_ram.json" height="500px" caption="Figure 5: Average RAM per TSO, presolved domain only" >}}

Below in table 2 a repetition of the exact same analysis as last time on the presolved constraints of RTE is shown. From there you can see the picture is very much the same as last time as well.
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

In order to better show that France is a clear outlier in the statistics of figure 4, the same data can be shown as a scatter plot. This is done in figure 6 below.

{{<plotly json="fig_scatter_export_stats.json" height="500px" caption="Figure 6: Repetition of figure 4 but in scatter form" >}}

Here it can be seen clearly that France is in the top right corner, further away from the others on both metrics.
