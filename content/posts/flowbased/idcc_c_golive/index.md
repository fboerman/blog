---
title: 'Flowbased IDCC: parallel run of IDCC(c)'
date: 2025-06-24
description: 'On 2025-06-25 the new Core IDCC(c) calculation will go live. In this post I take a look at what this means and discuss the parallel run that was performed by TSOs'
plotly: true
scientific: true
---
On the 25th of June, the new Core IDCC(c) capacity calculation will go live. This is the third of a total of five planned Core capacity calculations in the intraday timeframe. For each of these updates, the capacities will be recalculated with updated forecasts and will take into account the trades up until the point of (re)calculation.  
In this post, I present an overview of the intraday process for the Core region. After that, I discuss the results of the parallel run of the new (c) calculation.  
These results of the parallel run show a "reflow" effect ocurring. The available capacities are redistributed around the current market clearing point. This effect opens isolated zones and borders, in exchange for a lower average positive capacity. 

# The process and its timings
The intraday market of SIDC is based on both auctions and continious trade. Currently, the capacity _allocation_ for both auction and continious trade are done in ATC, while the capacity _calculation_ is done in the flowbased methodology. 
 This is because the research and development on flowbased _allocation_ in intraday is still ongoing and it is thus currently not yet possible. In Day-ahead, allocation is already done in flowbased.  

{{< details title="ATC vs Flowbased" >}}
Currently the capacity calculation in the Core region is done with the flowbased methodology. This methodology describes a way to express the possible range of a netposition of a zone, taking into account the netposition of all other zones. By being able to express it with such details more capacity can be released compared to the old way of ATC (Available Transfer Capacity). In ATC you have one value per border direction, independent of all other borders and zones. More information on this methdology can be found on the ENTSOE website [here](https://www.entsoe.eu/bites/ccr-core/day-ahead/).
{{< /details >}}

After every flowbased _calculation_, an ATC _extraction_ is done. This allows the capacities from the flowbased domain to be distributed equally over all borders. The resulting capacity (ATC) is then released to the market to be used. More information on this algorithm can be found in article 20 of [the IDCC methodology](https://www.acer.europa.eu/sites/default/files/documents/Individual%20Decisions_annex/ACER_Decision_03-2024_Core_ID_CCM_A2-3-Annex_III.pdf).  
The process design calls for 5 intraday calculations, labeled (a) to (e). For (b) to (e) there will be a full flowbased calculation done based on new gridmodels and other updated inputs, as well as trade up until then. After this an ATC extraction is performed on the new flowbased domain and the resulting ATC released to the market.  
 
IDCC(a) is a little different. This is the calculation performed directly after day-ahead market clearing, which is not a new calculation. Instead, IDCC(a) simply extracts the leftovers from the day-ahead calculation after the  the day-ahead auction.  
In this new methodology, three of the IDCC calculations will be directly tied to the Intraday Auctions (IDA): (a) to IDA1, (b) to IDA2 and (d) to IDA3.  This means that the capacity released by these three calculcations will first **exclusively** be released to the auction. Then, the **leftovers** from these auctions will be released to the continious trade market. The results of (c) and (e) will instead be directly released to continous trade. Please note that the IDA design calls for pausing the continious trade market while the IDA's are running.   
The exact process calculation steps are out of scope of this post but you can find more information on this on the [ENTSOE website](https://www.entsoe.eu/bites/ccr-core/intraday/).  
As of writing this post, only (a) and (b) are operational and (c) will become operational on 25th of June 2025. IDCC(d) and (e) are in development and more information about its release planning will be published soon.

Figure 1 below shows an infographic for the process timings of the IDCC calculations (a)-(c) and the IDA's 1-3. Here, you can see that the first two IDCC calculations, as well as the first 2 IDA's are actually performed on the day previous to the delivery day. IDCC(c) and IDA3 are the first ones that are done on the delivery day itself. As a consequence, they do not cover all 24 hours. IDCC(c) only updates the capacities for delivery hour 06:00 onwards and IDA3 auctions hour 12:00 onwards. 

<a href="core_idcc_timings.svg">
{{< figure src="core_idcc_timings.svg" caption="Figure 1:  Core IDCC Timings (Click for a larger zoomable version)" >}}
</a>

# The parallel run
Since businessday 2024-12-17, the Core TSO's have been running a parallel run for IDCC(c). The implication here is that the new process is running as if it is live. However, the final result is not actually send to the market. The results from this parallel run are only published on the [publication tool](https://parallelrun-publicationtool.jao.eu/coreID/IDCCC_intradayAtc). 
Since the start of the parallel run, approximately 14% of the hours calculated triggered some form of fallback (i.e. process failure). However none of these occured in the last month running up to the go live of the 25th of June.

In order to properly assess the effect of the IDCC(c) calculation we want to compare the ATC's shortly before and after IDCC(c). Simply comparing with IDCC(b) results would include trade in between (b) and (c). By calculating the ATC just _before_ IDCC(c) and compare it with the output _after_ (c) this effected is removed. This then results in the formula:

$$ \delta = ATC_{c} - (NTC_{b} - AAC_{c})  $$

In which the $ATC$ is the Available Transfer Capacity, the $NTC$ the Net Transfer Capacity (so capacity without any trade) and the $AAC$ the Already Allocated Capacity (so the already executed trade) at the denoted calculation moments.  
To analyse the results of the parallel run, three indicators will be discussed next. In these indicators the discussed delta is used to be able to give a fair comparison.
 
## Frequency of zero or negative capacities
For the first indicator we  compare the _frequency_ of hours with zero or negative capacities per border. In figure 2, the change in this frequency is shown for all Core borders over the whole parallel run. The x-axis should be read as "ZoneFrom-ZoneTo". For a larger version of figure 2 <a href="/flowbased/idcc_c_golive/fig_kpi2.html">click here</a>

{{< plotly json="fig_kpi2.json" height="500px" caption="Figure 2: Delta (after - before) IDCC(c) Frequency of Zero and Negative ID ATCs" >}}

Here we can see that on almost all borders the frequency of negative capacities _decreases_ substantionally, with many borders approaching 20 percentage points. This is a very positive result, as it means more borders are open for intraday trade for more periods of time due to the recalculation of (c).

{{< details title="How can negative capacities occur?" >}}
For those not familiar with ATC extractions, negative capacities can seem strange. The reason negative capacities  occur is that when a flowbased (re)calculation is being done the gridmodels and forecasts used as inputs are updated. It is possible that based on these, it is found that there was too much capacity released by the earlier calculation. If this "over" capacity is then already used by the market in the meantime, you end up with negative capacities instead.
{{< /details >}}


## Frequency of isolated Core bidding zones
Secondly, we can compare the _frequency_ of isolated Core bidding zones. In figure 3, the change in this frequency is shown for all Core zones in either import or export direction or both. For a larger version of figure 3 <a href="/flowbased/idcc_c_golive/fig_kpi3.html">click here</a>. Please note that isolation is defined using Core borders **only**.

{{< plotly json="fig_kpi3.json" height="500px" caption="Figure 3: Delta (after - before) IDCC(c) Frequency of isolated Core Bidding Zones" >}}

{{< details title="What is bidding zone isolation" >}}
Bidding zone isolation is defined as the hours in which for a certain zone all **Core** borders of the **selected zone** have zero or negative capacities. This can be defined for only import or export direction or both at the same time.
{{< /details >}}

From figure 3, we can see that the isolation for multiple directions _decreases_ for most zones. This is a very positive result, as it  means that zones which couldn't cross border trade within Core in some hours may actually start trading on at least one Core border after the recalculation.

For a daily updated overview of bidding zone isolation and more you can also visit one of my other projects: [https://idcc.coreflowbased.eu/](https://idcc.coreflowbased.eu/).

## Size of mean positive ATC
The third and last indicator we can look at is the mean positive ATC. This indicator filters out all positive  hours per border and averages them. This means that the hours identified in the first indicator are not selected here. This average per border is shown in figure 4 below. For a larger version of figure 4 <a href="/flowbased/idcc_c_golive/fig_kpi4.html">click here</a>

{{< plotly json="fig_kpi4.json" height="500px" caption="Figure 4: Delta (after - before) IDCC(c) Mean Positive ID ATCs" >}}

Here we can see that the mean positive ATC _decreases_ for most borders (with a few exceptions). This is not what we would want, as we generally want higher capacities. This is actually a trade off with the improvements from the first two indicators, which I will explain next.

## The reflow effect
In summary, we can see that for the 3 indicators looked at, negative ATC and isolation of bidding zones decreases, but so does the mean positive ATC! This may be explained by two effects.  
One effect is that when the ATC of an hour is increased above zero, it is more likely it will not be super high above zero, which will likely drag down the average. More importantly however is the second effect, that the first 2 vs the last indicator are a trade off against eachother.  
It is important to understand that recalculations do not create new capacity out of thin air. There is no rule that capacity needs to be reserved for a later timeframe. Every single calculation, wether it is day-ahead or intraday, aims to **maximize the resulting capacities** given the physical constraints of the grid. When a recalculation is done, the ATC extraction aims to fairly distribute the available capacity equally over all borders.  
This means that if a border had a very high ATC available but a different border is negative **before** the calculation, the extraction algorithm will redistribute the available capacity fairly among them (if the capacity still exists after updating all inputsrecalculating the domain). If a border sees a lot of trade, resulting in low left over ATC, the same thing will occur. This effect can be seen as a "reflow" of available capacities across all borders, resulting in the indicators we are seeing: less negative ATC and isolations but also lower mean positive capacity.


# What is next
After the go live of IDCC(c), TSO's will work on developing and bringing live the remaining planned flowbased calculations of (d) and (e). It is exptected that for the hours they calculate (12:00 onwards for (d) and 18:00 onwards for (e)) the same reflow effect will occur as is happening in (c). For these, a paralell run will be held by the TSO's as well, hopefully proving the same positive results.

