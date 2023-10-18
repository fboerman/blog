---
title: "Flowbased: update 2 about the the Nordic Flowbased parallel run results"
date: 2023-10-16
draft: false
description: "The Nordic Flowbased go-live has unfortunately been postponed. However the parallel run is still going strong, so time for an updated look on the results!"
plotly: true
---

Recently, it [was announced](https://nordic-rcc.net/go-live-of-nordic-flow-based-capacity-calculation-delayed/) that the Nordic Flowbased go-live was delayed due to IT issues. While this is obviously a pity to hear, other positive things have been announced.  
The evaluation report from NRAs [was published](https://nordic-rcc.net/wp-content/uploads/2023/06/Parallel-run-report_final_public.pdf). It was evaluated and [found sufficient by the NRAs](https://www.nordicenergyregulators.org/2023/07/nra-communication-regarding-the-tsos-june-2023-epr-report/), although with some extra remarks.  
A very interesting summary containing issues found and lessons learned, [was published](https://nordic-rcc.net/wp-content/uploads/2023/06/Operational-learning-points.pdf) alongside the report. In there a point-by-point analysis is done for specific issues that were encountered during the parallel run. A very interesting read for experts!

I want to highlight one important issue, the modelling between SE2 and SE3. The price spread on that border was puzzling high when compared to the NTC historical results in the beginning of the parallel run. This was apparently explained by a modelling mistake, which was presented on march 27th in the stakeholder meeting. [Slides can be found online](https://nordic-rcc.net/wp-content/uploads/2023/03/5.-Result-elaboration-DA.pdf).  
In figure 1 below a slide from that meeting explaining this issue is shown.

{{<figure src="modelling_SE2_SE3.png" caption="Figure 1: slide 8 stakeholder meeting 2023-03-27 showing the modelling issues on SE-SE3 border" >}}

In summary: this modelling mistake made less capacity on the SE2-SE3 border available in Flowbased, when compared to the historical situation of NTC. This was rectified from week 9 (2023-02-27) onwards, which should decrease the price spread on this border in the parallel run.

## Remarks on the dataset
In this post I will look at the simulated market results. As a recap, market results are resulting from simulations with historical orders. However this is done with the new Flowbased domain from the parallel run. From these simulations, the prices and net positions are then published.  
I have chosen the starting point of the dataset for this post to be 2023-02-27, as this is when the SE2-SE3 mistake was fixed. This cut-off point still leaves a large set with both winter and summer days. There are 5039 hours between 2023-02-27 and the last simulated day in the external parallel run, which is 2023-09-24 (as of the time of writing this post).  
The simulation results can be downloaded from [Nordic RCC](https://nordic-rcc.net/flow-based/simulation-results/). This dataset contains 5093 hours, therefor all hours have been successfully simulated.

## Market Simulation Results: Prices
So, let's look at the main indicators, starting with prices.  
We begin with the simplest visualization: the average shift in prices per bidding zone. Negative values mean a lower price in the simulation compared to the historical result. On the contrary, positive values indicate higher prices. This is shown in a map form in figure 2 below. 
{{< plotly json="fig_mean_price_diff.json" height="700px" caption="Figure 2: Average difference between simulated prices and production prices  between 2023-02-27 and 2023-09-24,over all hours. Negative number means a lower price on average in the simulations. All in EUR/MWh (figure is interactive)">}}

Now, while using absolute prices is interesting for showing which prices goes up and down, it is important to interpret those prices in context. In figure 3, the same data is shown. However, this time, percentages of the mean price per zone are used.
{{< plotly json="fig_mean_price_diff_pct.json" height="700px" caption="Figure 3: Average difference between simulated prices and production prices  between 2023-02-27 and 2023-09-24, over all hours, as a percentage of the mean price of the zone. (figure is interactive)">}}
Here you can see that an impact of a couple of euros on SE2 is relatively much higher then the couple of euros euros change on NO2.  
From both figures, it can be seen that the price in Sweden and northen Norway has mainly moved up, while the price in South Norway and Denmark has dropped. Especially within Norway, there is a sharp divide. In general, it seems that northern zones have increased prices while southern ones have dropping prices.  
Why is that the case?

## Market Simulation Results: Net Positions
To answer this, we will take a look at a different key indicator: the net positions.

A net position is the summed import/export over all borders of a zone. Here, conventionally, **negative** NP means **import**, and **positive** NP means **export**.  
In figure 4 below, the average change in hourly NP per zone is plotted, as percentage of the mean of historical NP. In table 1 the data underlying this map is shown.

{{< plotly json="fig_np_diffs_pct.json" height="700px" caption="Figure 4: Average difference between simulated Net Position and production Net Position between 2023-02-27 and 2023-09-24 over all hours, as a percentage of the mean NP of the zone. Negative number means shift into import direction. (figure is interactive)">}}

Here we can see a correlation between the price shifts in figure 3 and the NP shifts in figure 4. Cheaper zones import more, while more expensive zones export more.  
This correlation, between prices and netto position shifts, makes sense because Flowbased has made it possible to shift more power from a historical cheap zone (thus, increasing the prices and the export) to a historical more expensive zone (thus, decreasing prices and increasing import). This is one of the core goals of improved capacity calculation: decreasing of price spreads. In effect, the prices "move" towards eachother. Figure 3&4  thus show that Flowbased is doing what it is designed for!

The data also shows extreme percentages on there. For instance 200% for Finland and 100% for south of Norway. Why are these so extreme?

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

Here we can see that for extreme zones, such as FI and NO2, the NP has a large difference compared with historical results, while the zone had historically a small net position. So Finland for example became 100MW more exporting, while at first it was importing on average 50MW. This results in a large relative number.


## Price Spreads
Now, we go back to the last indicator: price spreads. There are two ways of looking at it: the price spread on a specific border or the price spread between the highest and lowest price within the region, both per hour. 

We start with the borders. The average price spread change per border is shown in table 2. Here, a positive price means price spread went up and a negative price means price spread went down.

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

Here we see a different picture than in the previous update [post](https://boerman.dev/posts/flowbased/nordic_flowbased2/). The shifting spreads seem smaller but most importantly the spread shift on SE2-SE3 is now a lot smaller. This confirms that the change in net modelling had a positive impact. There is still an increase in price spread. However, this is to be expected when flows get attracted by the south of Norway and Denmark, where a bigger welfare impact can be realized.

Lastly we will look at the price spread in the region. Price spread in the region is defined as the difference between the maximum and minimum price for the whole region per hour. In figure 5 this price spread in the region is shown, together with a comparison with production value. The blue bars signal the difference of simulation vs production. Thus, a negative value represents a decrease in the spread for that hour.   
For an interactive dashboard see [here](https://data.boerman.dev/d/_PP3MATVz/nordic-prices-nordics-external-parallel-run-flowbased?orgId=1#)

<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/_PP3MATVz/c21a5e98-1eee-59d2-984a-9b0404a8c6f7?orgId=1&from=1677452400000&to=1695592799000&panelId=3" width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 5: Price spread in Nordic region for both simulated and production values, for the set used in this post. All in EUR/MWh (live dashboard embed, interactive)</figcaption>
</figure>


On average, the regional price spread drops by 2.38 EUR/MWh when taking the whole dataset into account. This corresponds to a drop of 3.24% relative to the average price spread in the historical data set. In 57% of all hours the price spread has decreased compared to the historical data. This result comes from a rather large dataset of 5039 hours (or almost 60% of an entire year) which has seen various checks and fixes already. Overall I would call this a good and encouraging result for the project. 

As a last point we could ask if these results are consistent throughout all hours of a business day.To check this the average change in relative price spread is plotted in figure 6 below.
{{< plotly json="fig_convergence_hours.json" height="400px" caption="Figure 6: Relative change in regional price spread, averaged by hour of the day over the whole dataset (figure is interactive)">}}
From this graph we can conclude that, while not evenly distributed, every hour of the day sees, on average, some decrease in price spread. A good result for the improved capacity calculation!

## What is next
What is next for Nordic Flowbased? There were some recommendations from the NRAs, to which the TSOs will probably respond. And the new go-live schedule is set to be released somewhere in November 2023.  
I hope the go live will be soon, so we can also see the effect of these changes on trader's behaviors! Once there is sufficient new information, I will probably write a new post.
