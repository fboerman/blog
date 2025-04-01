---
title: 'Flowbased: how the markets can fluctuate, 2025 Q1 vs 2024 Q1'
date: 2025-03-31
description: 'A look at Flowbased domain trends, specifically the rise of forecasted commercial exchanges outside Core in France,  by comparing the first quarter of 2024 and 2025'
plotly: true
scientific: true
---
## Summary
One of the (many) things that keeps my work interesting is that the system I work on is very dynamic. Today I want to highlight one such dynamic situation by comparing the first quarter of 2025 with the first quarter of 2024. Here we will see that the grid constraints that limit the market have shifted from one TSO to another due to changing grid situation. 
 
RTE (France) in particular shows up a lot more in list of constraints that have actively limited the market, so called active constraints. It also has a lot more forecasted flows from *outside* the [Core capacity calculation region](https://www.entsoe.eu/bites/ccr-core/about/), thus strongly limiting the capacity it can provide *inside* Core. The source of these flows are probably due to higher west-east export flows towards Italy and Switzerland. These increased flows then map onto newly added network elements in the Flowbased domain, located close to these countries.  
These are legitimate process steps to take, but show the impact of southern european flows on the **Core** region. The upcoming North Italy integration into the new **Central** capacity calculation Flowbased region will possibly help with better integrating and managing these flows.

## The Analyses
So lets take a look at the shifting market trends mentioned. Figure 1 below shows the statistics per TSO for the Flowbased active constraints. The x axis shows the share of hours in which a TSO had at least one, the y axis shows the average capacity released for within Core (RAM, as a % of maximum capacity of a constraint). The size is the average shadow price, which is a measure of how much it limited the welfare of the market. It is shown for all businessdays in the first quarter of 2025.  
If you are not familiar with each TSO, you can consult [this page of ENTSOE to check](https://www.entsoe.eu/about/inside-entsoe/members/).

{{<plotly json="fig_scatter_active_2025.json" height="400px" caption="Figure 1: FB Core Active Constraint statistics for 2025 Q1 (Check appendix A for 2024Q1)" >}}

What stands out here are the two TSOs with fairly low average capacities: TransnetBw and RTE.  
Active constraints are heavily dependant on grid situation and market direction. For some TSOs this statistic move wildly, while others are pretty stable. In figure 2 the change between figure 1 and the same statistics of one year before are shown for some TSOs. Here we can see that while TransnetBW barely moved, RTE and CEPS moved to much higher share of time and lower average capacities.

{{<plotly json="fig_moved_ac.json" height="400px" caption="Figure 2: Change in FB Core Active Constraint statistics for some TSOs" >}}

So what could explain such lower capacities? Partially this is due to various grid changes and changing market directions. We are looking at averages here, so which elements are active is hidden, more on this later. If the market moves in a fundamental different direction all the time, it will hit very different constraints with different properties. But for RTE there is something else going on as well: there is a very high increase of forecasted flows from *outside* Core, the so called $F_{uaf}$, which eats up the capacity available *inside* Core.  
To show this lets look at a breakdown of how the RAM is calculated. This is shown in figure 3. It looks a bit technical at first but will be explained below the figure. For more details and formulas underlying this please consult the [Core CCM](https://eepublicdownloads.entsoe.eu/clean-documents/nc-tasks/Core%20-%20ANNEX%20I_III.pdf).  
Presolved here means to mathematically filter only the constraints that are actually limiting the capacity domain.

{{<plotly json="fig_waterfall_ram_rte_2025.json" height="400px" caption="Figure 3: Breakdown of the components of RAM, each bar is average number over all presolved constraints for RTE in Q1 2025" >}}

From left to right the waterfall shows how the final RAM is build up. We start at the thermal capacity $F_{max}$ then we subtract an error margin of 10% (FRM). Next we subtract two flows that we cannot influence inside our region: flows that exist without any commercial exchange and are just there, $F_{0all}$, and forecasted commercial flows from outside of our region, $F_{uaf}$. Then we add up the virtual capacity coming from the 70% rule,  AMR and finally subtract individual validation adjustments for grid security, IVA. Then we arrive at our RAM!

Now from figure 3 we can see that the $F_{uaf}$ is relatively large. To put this in perspective figure 4 shows the average $F_{uaf}$ for all TSO's for both 2024 and 2025 Q1. Here we can see that it has shot up from 6.57% to 31.16% for RTE!

{{<plotly json="fig_presolved_fuaf.json" height="400px" caption="Figure 4: Average Forecasted Commercial Exchanges Outside Core, presolved domain only" >}}

So what can possibly cause this increase? That is a complicated question to answer with only public data. The forecast is based on forecasted net positions of other zones and mapped with non public PTDF (sensitivity) numbers to the constraints. This requires a more deep dive on TSO side in their data. It does however explain why the RAM has decreased for RTE and why thus their constraints show up more as limiting the market.  

Having said that, we can take some educated guesses if we zoom in further. In table 1 below, all network elements for RTE in the presolved domain are listed for the first quarter in both 2024 and 2025. This is presolved domain so bigger then only the active constraints.    
What is most interesting here, is that the elements with the highest average $F_{uaf}$ in 2025, didn't exist in 2024 in the domain! These are Creys-st-Vulbas-Ouest No 1 and 2. These  also have a high occurence count to begin with.  
A quick google search learns us that these are located close to the French Italian border, with Italy being outside of Core. These constraints were probably added after RTE needed to apply large capacity reductions through the validation phase (IVA) in [spring '24](https://www.jao.eu/sites/default/files/news_media/RTE%20-%20French%20eastern%20borders_situation%20update%20on%2020th%20June%202024.pdf), due to high west-east export flows. Adding network elements as constraints is the normal way to deal with such situations instead of applying mass IVA's. They do however show that such southern european flows can have a large impact on the Flowbased domain of the whole of Core. Integrating the Italy North bidding zone in the new Central CCR, currently being designed, will enable better management of these flows. They will then be inside the CCR (and thus the Flowbased domain) and can be more efficiently allocated into the RAM, instead of being reserved in the forecast called $F_{uaf}$.

This conclusion does not explain the (more modest) increase in $F_{uaf}$ on the Ensdorf - Vigy lines, which are on the north French - German border. However they have much lower occurences and are thus less to blame for the rising statistics that we looked at earlier.

<figure class="left" style="width:100%">

| Cne Name                                 |   avg RAM 2024 |   avg Fuaf 2024 |   count 2024 |   avg RAM 2025 |   avg Fuaf 2025 |   count 2025 |
|:-----------------------------------------|-----------:|------------:|-------------:|-----------:|------------:|-------------:|
| L 400kV N0 1 CREYS-ST-VULBAS-OUEST       |     ---    |      ---    |          --- |      21.21 |       58.97 |         1522 |
| L 400kV N0 2 CREYS-ST-VULBAS-OUEST       |     ---    |      ---    |          --- |      26.18 |       46.59 |         1059 |
| Ensdorf - Vigy VIGY1 N                   |      48.13 |       12.63 |         1329 |      22.09 |       33.82 |           12 |
| Ensdorf - Vigy VIGY2 S                   |      29.09 |       25.18 |           16 |      26.81 |       29    |          498 |
| L 400kV N0 1 AVELIN-MASTAING             |      38.79 |        9.42 |           94 |      49.58 |        6.65 |         1024 |
| Avelgem - Avelin 380.80                  |      78.53 |       -0.82 |          821 |      83.19 |        3.5  |          589 |
| Achene - Lonny 19                        |     ---    |      ---    |          --- |      90.26 |       -0.01 |          273 |
| L 400kV N0 1 FAUX-FRESNAY-MERY-SUR-SEINE |      33.06 |       -2.29 |          259 |      38.5  |       -2.57 |          157 |
| L 400kV N0 2 AVELIN - MASTAING           |      57.62 |       -0.71 |            2 |      80.07 |      -27.9  |           41 |
| L 400kV N0 1 AVELIN-GAVRELLE             |      64.49 |      -13.01 |           12 |     ---    |      ---    |          --- |


<figcaption class="center">Table 1: Statistics for all CNE's in presolved domain for RTE in first quarter of 2024 and 2025</figcaption>
</figure>

## Extra Background
This section provides some extra background and context for those interested.  
### Low RAM in context
We started with the observation of low RAM for the active constraints of RTE and TransnetBW. But when comparing in a broader context of presolved constraints  are they a really that much lower? The answer is yes, especially compared to the same quarter in 2024. In figure 5 below the average RAM of the presolved constraints are shown per TSO. RTE and TransnetBW are indeed the lowest and RTE shows a large drop compared to 2024 Q1.

{{<plotly json="fig_presolved_ram.json" height="400px" caption="Figure 5: Average RAM per TSO, presolved domain only" >}}

### 70% rule
Some people might be surprised by such low RAM and state that they thought it had to be minimum 70% (before any validation subtractions or action plans apply). This is a subtle but very important mistake in interpreting the legislation.  
The "70% rule" comes from the EU Clean Energy Package, which indeed stipulates that 70% of physical capacity has to be made available for *cross zonal trade*. The only exception to this is if a TSO can prove it will endanger operational security.  
*Margin Available Cross Zonal Trade* (MACZT) has two parts, and this is where the confusion comes in. The main equation is:
$$ RAM + F_{uaf} \ge 0.7 \cdot F_{max} $$
So this fits with the above story, high $F_{uaf}$ still satisfies the 70% rule, in fact it lowers the required minimum RAM!

## Appendix
Appendix A is the same as figure 1 but then for 2024 Q1.
{{<plotly json="fig_scatter_active_2024.json" height="400px" caption="Appendix A: FB Core Active Constraint statistics for 2024 Q1" >}}

Appendix B is the same figure 3 but then for 2024 Q1.
{{<plotly json="fig_waterfall_ram_rte_2024.json" height="400px" caption="Appendix B: Breakdown of the components of RAM, each bar is average number over all presolved constraints for RTE in Q1 2024" >}}

