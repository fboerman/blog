---
title: "Flowbased: update 2 about the the Nordic Flowbased parallel run results"
date: 2023-10-16
draft: false
description: "The Nordic Flowbased go-live has unfortunately been postponed. However the parallel run is still going strong, so time for an updated look on the results!"
plotly: true
---

Recently it [was announced](https://nordic-rcc.net/go-live-of-nordic-flow-based-capacity-calculation-delayed/) that the Nordic Flowbased go-live was delayed due to some IT issues. While this is obviously a pitty to hear, other more positive things have happened as well.  
The evaluation report [was published](https://nordic-rcc.net/wp-content/uploads/2023/06/Parallel-run-report_final_public.pdf) for NRAs. It was judged and [found sufficient by the NRAs](https://www.nordicenergyregulators.org/2023/07/nra-communication-regarding-the-tsos-june-2023-epr-report/), although with some extra remarks.  
A very interesting summary of issues found and lessons learned [was published](https://nordic-rcc.net/wp-content/uploads/2023/06/Operational-learning-points.pdf) alongside the report. In there a point by point analysis is done for specific issues that were encountered during the parallel run, a very interesting read for experts!

I want to highlight one important one, the modelling between SE2 and SE3. The price spread on that border was puzzling high when compared to the NTC historical results last time I wrote about it. This was apparently partly due to a modelling mistake and was presented on march 27th in the stakeholder meeting, [which slides can be found online](https://nordic-rcc.net/wp-content/uploads/2023/03/5.-Result-elaboration-DA.pdf).  
In figure 1 below the slide explaining this from that meeting is shown.

{{<figure src="modelling_SE2_SE3.png" caption="Figure 1: slide 8 stakeholder meeting 2023-03-27 showing the modelling issues on SE-SE3 border" >}}

In summary this modelling mistake made less capacity on the SE2-SE3 border available in Flowbased compared to the historical situation of NTC. This was rectified starting in week 9 (2023-02-27) which should decrease the price spread on this border in the parallel run.

## Some remarks on the data
Just like last time lets look at the simulated market results. As a recap, these are simulated with historical orders but with the new flowbased domain from the parallel run. From these simulations the prices and net positions are then published.  
I have choosen the starting point of the data set for this point to be 2023-02-27 as the SE2-SE3 mistake was then fixed. This still leaves a quite big set with both winter and summer days. There are 5039 hours between 2023-02-27 and the last simulated day in the external parallel run, which at time of writing is 2023-09-24.  
The simulation results can be downloaded from [Nordic RCC](https://nordic-rcc.net/flow-based/simulation-results/) and also contains 5093 hours so all hours have been simulated.

## Market Simulation Results: Prices
So lets look at the main indicators, starting with prices.  
Lets begin with the simplest visualization: the average shift in prices per bidding zone. Negative means a lower price in the simulation compared to the historical result, positive the other way round. This is shown in a map form in figure 2 below. 
{{< plotly json="fig_mean_price_diff.json" height="700px" caption="Figure 2: Average difference between simulated prices and production prices  between 2023-02-27 and 2023-09-24,over all hours. Negative number means a lower price on average in the simulations. All in EUR/MWh (figure is interactive)">}}

Now while the absolute prices are interested to show who goes up and down, its good to see those prices in context. So in figure 3 below the same data is shown, but this time as percentage of the mean price per zone.
{{< plotly json="fig_mean_price_diff_pct.json" height="700px" caption="Figure 3: Average difference between simulated prices and production prices  between 2023-02-27 and 2023-09-24, over all hours, as a percentage of the mean price of the zone. (figure is interactive)">}}
Here you can see that an impact of 5 euros on SE2 is relatively much more then the 4 euro impact on NO2.  
From both figures it can be seen that the price in Sweden has mainly moved up, while the price in South Norway and Denmark has dropped. Especially within Norway there is a sharp divide. In general it seems that northen zones have increased prices while southern ones have dropping prices.  
Why is that the case?

## Market Simulation Results: Net Positions
Now lets take a look at a different key indicator: the net positions. A net position is the summed import/export over all borders of a zone, in which conventionally negative NP means import and positive number means export.  
In figure 4 below the average change in hourly NP for each zone is plotted on the map, as percentage of the mean of historical NP.
{{< plotly json="fig_np_diffs_pct.json" height="700px" caption="Figure 4: Average difference between simulated Net Position and production Net Position between 2023-02-27 and 2023-09-24 over all hours, as a percentage of the mean NP of the zone. Negative number means shift into import direction. (figure is interactive)">}}

Here we can see a coupling between the price shifts in figure 3 and the NP shifts in figure 4. Cheaper zones import more and more expensive zones are exporting more.  
This coupling between prices and netto position shifts makes sense in that flowbased has made it possible to shift more power from a historical cheap zone (thus increasing the prices and the export) to a historical more expensive zone (thus decreasing prices and increasing import). This is one of the core goals of improved capacity calculation: decreasing of price spreads. In effect the prices "move" towards eachother. These two figures thus show that Flowbased is doing what it is designed for!

Now there are some extreme percentages on there, 200% for Finland and 100% for south of Norway. Why are these so extreme? In table 1 the data underlying this map is shown.
<figure class="left" style="width:100%">

| Zone | NP simulation - historical | mean NP historical | difference in % |
|-----:|---------------------------:|-------------------:|----------------:|
|  FI  | 97.69                      | -49.19             | 198.61          |
|  NO1 | 14.67                      | -544.50            | 2.69            |
|  NO2 | -1605.06                   | 1539.74            | -104.24         |
|  NO3 | 184.29                     | -332.19            | 55.48           |
|  NO4 | 156.56                     | 890.78             | 17.58           |
|  NO5 | -223.13                    | 1373.13            | -16.25          |
|  DK1 | -2.59                      | 456.14             | -0.57           |
|  DK2 | 2.84                       | -376.82            | 0.75            |
|  SE1 | 284.52                     | 1329.79            | 21.40           |
|  SE2 | 183.04                     | 3387.44            | 5.40            |
|  SE3 | 95.37                      | -485.42            | 19.65           |
|  SE4 | -1.02                      | -1250.66           | -0.08           |

<figcaption class="center">Table 1: Change in Net Position per zone tabulated</figcaption>
</figure>
Here we can see that for the extreme zones such as FI and NO2 the NP has a large difference while the zone had historically a small net position. So Finland for example became 100MW more exporting, while at first it was importing on average 50MW. This results in a large relative number and is to be expected with such flips.


## Price Spreads
Now lets come back to the last indicator which was already mentioned: price spreads. There are two ways of looking at this: the price spread on a specific border and the price spread between the highest and lowest price within the region, both per hour. 

Lets start with the borders, the average price spread change per border is shown in table 2 below. Here a positive price means price spread went up and a negative price means price spread went down.

<figure class="left" style="width:100%">

| border  | change avg EUR/MWh | border  | change avg EUR/MWh |
|---------|--------------------|---------|--------------------|
| DK1-SE3 | -12.77             | DK2-SE4 | 1.25               |
| NO1-SE3 | -11.11             | FI-NO4  | 1.35               |
| SE3-SE4 | -10.32             | DK1-NL  | 1.79               |
| NO3-NO5 | -10.17             | FI-SE3  | 3.38               |
| NO1-NO3 | -8.52              | SE1-SE2 | 3.46               |
| NO1-NO2 | -6.90              | SE1-NO4 | 4.04               |
| DK1-DK2 | -3.33              | SE2-SE3 | 5.28               |
| FI-SE1  | -2.08              | NO4-SE2 | 5.34               |
| NO2-NO5 | -1.50              | NO1-NO5 | 6.79               |
|         |                    | NO3-NO4 | 8.97               |
|         |                    | NO3-SE2 | 9.55               |

<figcaption class="center">Table 2: Change in price spread per border in EUR/MWh</figcaption>
</figure>
Here we see a different picture then in [the previous update post](https://boerman.dev/posts/flowbased/nordic_flowbased2/). The shifting spreads seem smaller in general but most importantly the spread shift on SE2-SE3 is now a lot smaller. This confirms that the modelling change had a positive impact here. There is still an increase in price spread but that is to be expected when flows get attracted by the south of Norway and Denmark, where a bigger welfare impact can be realized.

Lastly lets look at the price spread in the region. This is defined as the difference between the maximum and minimum price for the whole region per hour. In figure 5 this is shown, together with a comparison with production value. The blue bars signal the difference of simulation vs production, so a negative value is a decrease in the spread for that hour.   
For an interactive dashboard see [here](https://data.boerman.dev/d/_PP3MATVz/nordic-prices-nordics-external-parallel-run-flowbased?orgId=1#)

<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/_PP3MATVz/c21a5e98-1eee-59d2-984a-9b0404a8c6f7?orgId=1&from=1677452400000&to=1695592799000&panelId=3" width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 5: Price spread in Nordic region for both simulated and production values, for the set used in this post. All in EUR/MWh (live dashboard embed, interactive)</figcaption>
</figure>


On average the regional price spread drops with 2.38 EUR/MWh when taking the whole dataset into account. This corresponds to 3.24% relative to the average price spread in the historical data set. In 57% of all hours the price spread has decreased compared to the historical data. This is from a rather large dataset of 5039 hours (or almost 60% of an entire year) which has seen various checks and fixes already. Overall I would cool this a good result and encouraging for the project. 

As a last point we can ask if these results are consistent throughout all hours of a business day.To check this the average change in relative price spread is plotted in figure 6 below.
{{< plotly json="fig_convergence_hours.json" height="400px" caption="Figure 6: Relative change in regional price spread, averaged by hour of the day over the whole dataset (figure is interactive)">}}
From here we can see that, while not evenly distributed, on average every hour of the day sees some decrease in price spread. A nice result for the improved capacity calculation!

## What is next
So what is next for Nordic flowbased? There were some recommendations from the NRAs, to which the TSOs will probably respond. And the new go live schedule is set to be released somewhere in November. I hope the go live will be soon so we can also see the effect of these changes on trader behaviours! Once there is sufficient new info I will probably write a new post.
