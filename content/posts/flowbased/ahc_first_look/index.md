---
title: 'Flowbased: AHC parallel run first quick look'
date: 2026-04-29
description: 'The Advanced Hybrid Coupling parallel run has finally launched, time to take a quick first look at the available data!'
plotly: true
---

After 2 cancelled days the Advanced Hybrid Coupling external parallel run finally started on business day 2026-04-17! I have been involved in the AHC project for a while now, so that was a pretty nice milestone!  The next step is the actual go-live, currently foreseen for businessday the 11th of June, so not far off!

In this post I wanted to take a quick look at the first couple of days of the parallel run, before I take some time off for family visits. This post highlights a couple of quick indicators to get a first feel of the results.  
You can find the AHC final domain data in my [SQL Datalake](https://ui.dl.amunanalytics.eu/catalog/flowbased_dayahead/final_domain_ahc_parrun/) as well!

This post assumes some basic familiarity with the flowbased methodology. For a good introduction to these you can check out my [tutorial post](https://boerman.dev/posts/flowbased/whatis/cnecs_and_activeconstraints/) or the excellent [entsoe page](https://www.entsoe.eu/bites/ccr-core/day-ahead/) on Core.  
All data in the plots runs from the first businessday of 2026-04-17 to the last one available when writing this post, 2026-04-30.

# What is AHC?
Advanced Hybrid Coupling, or AHC, is a method to better integrate non flowbased borders into a flowbased domain. The beauty of it, is that it logically extends the already existing concepts, instead of inventing fully new ones.  
In the current production setting the Standard Hybrid Coupling (SHC) is used. This means that for all non flowbased borders (so on the boundary of the CCR) a flow forecast is assumed, which induces flows on all CNECs, which is shown in the Fuaf parameter. This forecast is static and cannot be influenced by capacity calculation or the market coupling algorithm. It is thus a form of static capacity reservation and an inefficiency. How bad Fuaf flows can get can be seen on the French-Italian border, which I have writting about twice: [one](https://boerman.dev/posts/flowbased/highfuaf2025/) [two](https://boerman.dev/posts/flowbased/highfuaf2026/) 

 
Now in an AHC setting non flowbased borders can be modelled as a _virtual hub_. This hub then has PTDFs in the same way as normal hubs and thus denotes a new dimension in the flowbased domain. This has two major consequences.  
First the flows induced on these borders are no longer static forecasts, but depend on the export/import position of the virtual hub, _just like with any other hub_. This allows the earlier reserved capacity to move from the Fuaf (capacity outside CCR) to the RAM (capacity inside the CCR). Effectively you move the border inside your domain.  
Second this results in the market algorithm (Euphemia) to optimize this hub, and choose its import/export position, the same as with all other hubs. Any flow induced by such a choice will be subtracted from the RAM just like with normal hubs. Compared to the SHC situation this means the algorithm now has the freedom to optimize all these hubs and their effects. This instead of that any choice of, for example, a HVDC  border does not load or relieve capacity somewhere else in the flowbased domain. This results in a much more efficient, and closer to the physical grid, allocation.  
This all comes at the drawback of higher computational intensity. The addition of a new dimension in the flowbased domain increases the complexity exponentially. Luckily advancements in both the Core tooling and Euphemia has kept this manageble. 

In the Core AHC design  most virtual hubs are located on the HVDC borders to the Nordic area. The Netherlands, Germany and Poland have these on their northern borders. On top of that two AC borders are also moved into AHC. These are the Polish-Lithuanian border and the Romenian-Bulgarian border. The Italian borders were not taken in, due to these being integrated in the new Central CCR in the future. The Spanish border is very small and is currently not planned to be converted to AHC.

# Looking at Parallel Run
A good first indicator to look at during a parallel run is process stability. This had a bit of a false start, due to several IT issues the first 2 business days of the parallel run had to be cancelled. Since the 17th the process has run stable, except for the 24th. That day the process did not succeed and resulting in 24 hours of Default Flowbased Parameters (DFPs). These are the minimum capacities that are the fallback of flowbased Core Day Ahead. Besides these hiccups the process has run stable.

## Number of presolved CNECs
Let us now look at the number of presolved CNEC's. In figure 1 below the average number of presolved CNEC's (rounded to 2 decimals) is shown per day for the whole domain. Here it can be clearly seen that the number in the AHC parallel run (the right yellow bar) is quite a bit higher then the production number (the left dark blue bar). This is to be expected. When you have a higher dimension domain, you need more CNEC's to be able to construct the domain around all of those. Simple example of this is the prevalance of external constraints, these are the upper bounds of the virtual hub, usually corresponding to the maximum physical capacity of whatever border they represent.
{{<plotly json="fig_num_cnecs_core.json" height="400px" caption="Figure 1: Comparison Average Number of Presolved CNEC's for whole Core per Day" >}}

This indicator can also be splitted across all TSO's. In figure 2 below the same statistic is repeated but then indicated per TSO. Here you can indeed see, that the TSO's which are in hubs which have virtual hubs on their borders, are the most impacted. Next to that some hubs further away see a (small) increase in number of presolved CNEC's.

{{<plotly json="fig_num_cnecs_pertso.json" height="400px" caption="Figure 2: Comparison Average Number of Presolved CNEC's per TSO" >}}

## Comparing Max Possible Export
A third interesting indicator to look at is the difference in maximum possible export of a Core hub. This can be done by looking at the max NP indicator that is pubished on the publication tool. What is important here is to make a fair comparison. The max NP is always defined as the max of the **Core Net Position**, so excluding all other non-Core borders. In SHC (current production situation) this means that to be able to fairly compare, the NTC of the borders which will get a virtual hub needs to be added to this max NP of the attached Core hub in SHC. The result of this can then be compared to the max NP in the AHC setup.

After doing this the comparison can be made for all Core hubs. This is shown in figure 3 below. Here the left dark blue bar is the average max NP over all hours in the SHC setup (production) and the right yellow bar the same in the AHC parallel run data.  
In this figure it can be seen that the for the zones with a virtual hub the max export is a bit higher, even after NTC correction of the production value. This is only the average, if you zoom in the situation is a bit more nuanced. This can be seen in my [dashboard on data.boerman.dev](https://data.boerman.dev/d/6dd51641-9c0e-4eab-bd0b-dc458dc633ea/ahc-par-run-compare-min-max-np?orgId=1&from=now%2Fd-14d&to=now%2Fd%2B1d&timezone=browser&var-zone=NL).  

{{<plotly json="fig_max_np_comparison.json" height="400px" caption="Figure 3: Comparison Average Max Netposition" >}}

Figure 4 below shows the median delta for the hubs with at least one virtual hub attached. This shows that 3 out of 4 hubs have on average an increase in the theoretical maximum of expert in the flowbased domain.

The exception to this is the Romenian hub. On the RO-BG border the capacities decrease in AHC. This possibly means that in the SHC situation too much capacity was released from a pure capacity calculation perspective, and AHC shows a more grid aligned number. This requires futher deep diving for more clues.

{{<plotly json="fig_median_delta.json" height="400px" caption="Figure 4: Median Delta AHC-Prod Max Netposition for selected zones" >}}

Obviously an average like this does not show everything. For more information about the distribution of the delta, check the interactive boxplot in the appendix below!


# Disclaimers
There are some important disclaimers to these first graphs.  
First of all the dataset is not that large, 14 businessdays of which one resulted in a fallback. Trends visible now don't always hold over longer time.  
Second there is the issue of the external constraint(EC). This is the upper and lower boundaries of the virtual hubs. Usually this denotes the physical capacity of the connection that it models. However the exact ATC is not always available when creating these EC. Thus the EC is usually higher then the ATC actually used in market coupling. That means the max NP is an overshoot of what is actually possible. To make the comparison more fair, the max NP can be recalculated with a changed EC to put it in line with the actual ATC ex ante. This is the subject of a later post.

# Future Work
That is it for now. I am planning (subject to time availability haha) to write some follow ups with more data included and different indicators!

# Appendix
Below an interactive boxplot is shown for the delta betwoon AHC and production SHC. In this a positive number means the AHC value is higher then the production SHC value. On the left you can choose which zone to view in a dropdown.

{{<plotly json="fig_boxplot.json" height="500px" caption="Figure 5: Boxplot Delta AHC-Prod Max Netposition, select the Hub you want to see on the left side!" >}}

