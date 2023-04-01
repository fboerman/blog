---
title: "Flowbased: an update about the the Nordic Flowbased parallel run results"
date: 2023-03-31
draft: false
description: "The Nordic Flowbased external parallel run is still going strong and its two months since my first look so time for an update!"
plotly: true
---

If you missed it, please see [the first part](https://boerman.dev/posts/flowbased/nordic_flowbased/) for a general introduction and some data remarks.

## Flowbased Domain Results
The flowbased process output seems to be still quite stable. From business day 2022-09-01 until the last business day possible, at time of writing 2023-03-31, all 5088 hours have a domain. All FB domain data in this post is for this time range.  
 According to the [FB domain backup page](https://test-publicationtool.jao.eu/nordic/FBDomainBackup) only for two business days, 2023-03-16 and 17 a fallback or backup was applied. Thats only a failure rate of 0.94%. Thats pretty good for a parallel run.

When looking at the number of average constraints per hour the numbers have barely moved since the last post. See table 1 below for current numbers per TSO, I have filtered on actual branches, so excluding virtual ones.

<figure class="left" style="width:100%">

| TSO | average number of constraints |
|-------|-------|
| Energinet | 153.6 |
| Fingrid | 110.4 |
| Stattnett | 153.1 |
| SvK | 184.9 |


<figcaption class="center">Table 1: Average number of constraints per business hour per TSO</figcaption>
</figure>
In the below figure 1 the total number of constraints per month per TSO is visualized, which seems quite stable.

{{< plotly json="num_cnecs.json" height="400px" caption="Figure 1: Total number of constriants per TSO per month (figure is interactive)">}}

To zoom in a bit on the constraints themselves, we can look at the average Remaining Available Margin (RAM) as percentage of maximum flow Fmax for the presolved domain in figure 2. Here too the picture is quite stable accross time. One thing that has changed last 2 months is that Stattnet has seen a small drop in average RAM, but still achieves >70% (an indicator that compliance with the 70% MACZT rule is in the right direction).  

{{< plotly json="avg_ram.json" height="400px" caption="Figure 2: Average RAM as percentage of Fmax per TSO per month, presolved domain (figure is interactive)">}}

The last domain indicator to look at is the average reference flow Fref in the presolved domain. Here not much has changed, with Fingrid having a consistently high Fref. Why this is the case is unclear to me. If anybody from Fingrid reads this feel free to shoot me an email about it ;)

{{< plotly json="avg_fref.json" height="400px" caption="Figure 3: Average Fref as percentage of Fmax per TSO per month, presolved domain (figure is interactive)">}}

This is a highover average, for a look at more detailed average RAM per TSO an automatically updated dashboard is (still) available [here](https://data.boerman.dev/d/ZsMawToVz/nordic-flowbased-parallel-run-domain-results?orgId=1).
In figure 4 below a live embed is shown.

<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/ZsMawToVz/nordic-flowbased-parallel-run-domain-results?orgId=1&theme=dark&panelId=2" width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 4: Average RAM as percentage of Fmax for the last 30 business days (live dashboard embed, interactive)<figcaption>
</figure>

## Market Simulation Results
Just like last time lets also look at the simulated market results. As a recap, these are simulated with historical orders but with the new flowbased domain from the parallel run. From these simulations the prices and net positions are then published.

At the time of writing this, simulated market results are available for business day 2022-11-14 until 2023-02-26 onwards. All 2520 hours in this range have a result associated with them.

Lets begin with the simplest visualization: the average shift in prices per bidding zone. Negative means a lower price in the simulation compared to the historical result, positive the other way round. This is shown in a map form in figure 5 below.
{{<figure src="prices_diff.png" caption="Figure 5: Average difference between simulated prices and production prices per hour over all hours, negative number means a lower price on average in the simulations. All in EUR/MWh" clickable="true">}}

Here we can see that the south of Norway and mainland Denmark see a decrease in prices as well as in the middle of Sweden, while other zones see increased prices. The same story arises in terms of import and export of energy. On average the zones with decreasing prices see more import and vice versa.   
This is visualized in terms of average change in netto position (the sum of all imports and exports of a zone) in figure 6 below. A negative netto position means net import and a positive number net exports. Thus a negative average difference in netto position means the zone has shifted towards the import direction and vice versa. 

{{<figure src="np_diff.png" caption="Figure 6: Average difference between simulated Netto Position and production Netto Position over all hours, negative number means shift into import direction. All in MWh" clickable="true">}}

This coupling between prices and netto position shifts makes sense in that flowbased has made it possible to shift more power from a historical cheap zone (thus increasing the prices and the export) to a historical more expensive zone (thus decreasing prices and increasing import). This largely corresponds to zones with high load, such as larger cities and industry, in Norway and Denmark.

However this high over indicator is also market situation sensitive, on how much the prices shift. A much more interesting indicator is the price spreads on borders. A more efficient working capacity calculation should result in more price convergence, ie lower price spreads on bidding zone borders. The average difference in price spreads per border is shown in table 2 below. 

<figure class="left" style="width:100%">

| border   | average difference |
|----------|--------------------|
| NO3-NO5 | -28.63             |
| NO1-NO3 | -25.55             |
| FI-NO4  | -19.47             |
| NO4-SE2 | -16.12             |
| SE1-NO4 | -12.94             |
| DK1-SE3 | -6.05              |
| DK1-DK2 | -5.22              |
| FI-SE1  | -4.55              |
| NO3-NO4 | -2.74              |
| SE3-SE4 | -0.57              |
| DK2-SE4 | 0.97               |
| DK1-NL  | 1.15               |
| NO1-SE3 | 1.21               |
| NO1-NO5 | 1.72               |
| NO1-NO2 | 3.23               |
| NO2-NO5 | 4.17               |
| FI-SE3  | 7.35               |
| SE1-SE2 | 9.11               |
| NO3-SE2 | 9.41               |
| SE2-SE3 | 13.96              |

<figcaption class="center">Table 2: Average difference in price spread per bidding zone border, averaged over all hours, all in EUR/MWh</figcaption>
</figure>

Like last time we can see large decreases on most borders and small on some others. Except the SE2-SE3 is quite big. For this I dont have an explanation, if any nordic expert is reading this feel free to send me a message about it ;)

Finally the last interesting indicator that I want to look at is the overall price spread in the whole region. So the difference between the maximum and minimum price for the whole region per hour. In figure 7 this is shown, together with a comparison with production value. The blue bars signal the difference of simulation vs production, so a negative value is a decrease in the spread for that hour.   
For an interactive dashboard see [here](https://data.boerman.dev/d/_PP3MATVz/nordic-prices-nordics-external-parallel-run-flowbased?orgId=1#)
<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/_PP3MATVz/nordic-prices-nordics-external-parallel-run-flowbased?orgId=1&from=1668294000000&to=1677538740000&panelId=3" width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 7: Price spread in Nordic region for both simulated and production values, for all data available. All in EUR/MWh (live dashboard embed, interactive)</figcaption>
</figure>

On average the price spread has decreased with 13.71 EUR/MWh over the whole dataset. That is less then my last post but that is mainly due to the fact market price volatility has decreased overall since the winter. To counter this its better to express it as a percentage change per hour, which on average calculates to a 6.73% decrease in regional price spread over the whole data set.  
When looking at the difference graph some extreme peaks can be seen at the end of November. I am not sure if that is due to market volatility in general or that something in the simulation went off. I would love to know why that is, but its not tracable from the published data. When filtering out 9 timestamps which have an increase of over 500% in price spread, the average overall comes at an even more substantial 11.15%!   

Overall the parallel run shows good results. The process seems stable and the capacity domains are available for all hours. The price convergence is still a substantial improvement when compared to the current capacity calculation system. Good results that are being backed up with more and more data as time goes on!
