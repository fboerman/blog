---
title: 'Flowbased: One year of CORE: A look at the price convergence since go live'
date: 2023-06-06
draft: false
description: "In honour of one year anniversary of CORE go live: A look at how price convergence held up during the worst energy crisis in Europe in a long time"
plotly: true
scientific: true
---
A full year ago flowbased capacity calculation method went live in the CORE region. To celebrate this anniversary this post will take a look at the process stability and price convergence.  
Minimizing the price spread, or in other words maximizing the price convergence is one of the goals of more efficient capacity calculation in the region. When full price convergence, or price spread of zero, is achieved the market did not hit any constraint in the capacity domain.  
The go live of FB CORE at business day 2022-06-09 coincided with an ongoing worst energy crisis in Europe in recent memory. I thought it would be interesting to take a look at how the price spread in the region held up in those times as a celebration of one year since go live!

## Definitions and data remarks
To start off with some definitions: hourly price spread is defined as the difference between the maximum and minimum price within one hour within a certain region on the Day Ahead market. In this post I focus on the CORE region, however I have excluded Poland from all analysis. The reason for this is that Poland has been applying heavy additional restrictions on its import and export the past months. The polish TSO PSE says they have to conserve coal fuel due to shortages and need these restrictions for operational security. This has resulted in vastly different prices then the rest of the region which has nothing to do with flowbased. For more data on this please view [my dashboard on it](https://data.boerman.dev/d/jS3wx4Q4z/allocation-constraint-pl-statistics?orgId=1).
   
The CORE region left is thus defined as the bidding zones of: Austria (AT), Belgium (BE), Czech Republic (CZ), Germany/Luxemburg (DE_LU), France (FR), Croatia (HR), Hungary (HU), Netherlands (NL), Romenia (RO), Slovenia (SI) and Slovakia (SK).  
All data is based on the day ahead prices as published on the ENTSOE transparency platform and spans between business day 2022-06-09 and 2023-05-31. The dataset constitutes 8568 timestamps, which means there are no hours missing in that period.

## Process Stability
The Flowbased process transparently shows if the calculations were successfull for all hours. If a calculation fails there are two options: Spanning and Default Parameters.  
Spanning means that a kind of average is chosen between the hours before and after the failure to bridge the gap. This is only possible if that average is feasible and the gap is not too big.   
Default parameters are a set of minimum values that are safe to be released in terms of net security. These are a kind of fallback to apply when all other efforts failed.  
Since go live only 13 hours failed in their final calculation. Of those 13, 8 were default parameters and 5 were spanning.  
That is 0.15% of the total number of hours, a very good result for process stability after its first year!
## DA Prices
The DA prices in this period were rather extreme, both in their height but also in volatility. In figure 1 below the prices for CORE including Poland are plotted. 
<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/E-r9pZc4k/energy-market-day-ahead-analyses-core?orgId=1&from=1654725600000&to=1685570399000&kiosk=tv&theme=dark&panelId=5"  width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 1: DA prices for CORE region, including Poland (live dashboard embed, interactive)<figcaption>
</figure>

Figure 1 is not very readable so lets zoom out a bit, in figure 2 below the mean of the whole region (excluding Poland) is shown per month. Especially in July, August and September and again half way through December and early January the prices exploded. This is due to the European gas crisis, something that has been extensively covered about already by others.  

{{< plotly json="fig_price_mean.json" height="400px" caption="Figure 2: Average DA price per month in CORE region, excluding Poland (figure is interactive)" >}}

Still sometimes the prices also plummeted in some zones, due to high infeed of cheap renewables. In 3.3% of all timestamps (282 hours) at least one zone was below 1 EUR/MWh and in 2.3% of all timestamps (200 hours) it was even negative in at least one zone!  
Luckily the prices have dropped due to the easing of the gas crisis, but historically they keep being high. As a reminder in the first five months of 2021 these same averages were 56, 49, 52, 60 and 57 EUR/MWh respectively compared to 136, 142, 110, 103 and 83 EUR/MWh respectively for the first five months of 2023.

<!-- <iframe src="https://data.boerman.dev/d-solo/E-r9pZc4k/energy-market-day-ahead-analyses-core?orgId=1&from=1654725600000&to=1685570399000&kiosk=tv&theme=dark&panelId=12"  width="100%" height="500vh" frameborder="0"></iframe> -->

## Price Spreads
Prices in and of itself are interesting but not really relevant to flowbased. What is more relevant is the hourly price spread, as stated earlier defined as the delta between the max and min price within an hour within a region.  
First lets take the monthly average again, but this time for absolute price spreads in EUR/MWh, this is displayed in figure 4 below.
{{< plotly json="fig_pricespread_mean.json" height="400px" caption="Figure 4: Average DA price spread per month in CORE region, excluding Poland (figure is interactive)" >}}
July has the largest absolute spread on average here, while the months after it are in the 70-90 EUR/MWh spread range. The last three months are even in the 20-30 range. This is interesting since the mean of the overall prices swung much more. This can probably partly be explained by renewable infeed. July is generally more sunny and then cheap PV power is available in large abundance. However this installed capacity is not equally distributed across all zones. Especially for example the Netherlands has much more installed solar pv then other CORE countries. The grid will become more strained trying to move all that solar energy to other zones, thus increasing price spreads. This theory is reinforced by the picture in Figure 5, which shows an heat map of the price spread. Capped at 200 EUR/MWh means that the color range does not go above that to keep it readable.
<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/E-r9pZc4k/energy-market-day-ahead-analyses-core?orgId=1&from=1654725600000&to=1685570399000&kiosk=tv&theme=dark&panelId=10"  width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 5: Price spread in CORE region as heat map<figcaption>
</figure>

Here we can see that in July (but also a bit later) the highest price spreads are in the middle of the day. These are typically the hours that solar is the most active. Also in the last two months the afternoon hours are higher price spread now that the sun is picking up again. These do have a smaller magnitude due to lower prices overall compared to summer of '22.

## Price Spreads Performance
So how are these price spreads in the bigger picture? In figure 6 below the absolute hourly price spread is binned in categories. Each number per category shows the percentage of timestamps that fall in it, out of the total set.

{{< plotly json="fig_spread_abs.json" height="400px" caption="Figure 6: Absolute hourly price spreads in CORE region excluding Poland, binned in categories." >}}

Here we can see that in 26.98% of the hours there was full price convergence (bar A), so a price spread of 0. For a large area such as the CORE one, in crisis times, that's quite impressive!  
In almost half of the time, 49.35%, the price spread was less then 100 EUR/MWh (split out over bar B, C and D). Although that doesn't sound that much in these times, it is quite context dependent. 100 EUR/MWh spread between 10 and 110 is much more impactful then say between 700 and 800 EUR/MWh.  

To better look at this indicator in this context, we can calculate a new indicator C%. This is then defined as the hourly price spread as expressed as a percentage of the mean price in that hour.
Or more formally:

$$ C_{\\%}(t) = \dfrac{\overline{P_{spread}(t)}}{\overline{P(t)}}\cdot 100[\\%] $$
in which the $\overline{bar}$ denotes the average over all CORE zones excluding PL at timestamp $t$

So to take the above example for a simple situation of two zones, a 10-110 spread is then expressed as C% of 167%, while for the 700-800 spread the C% comes down to a mere 13.3%.

Lets now bin the resulting numbers over the whole dataset, which results in figure 7 below.

{{< plotly json="fig_spread_pct.json" height="400px" caption="Figure 7: Hourly price spreads in CORE region excluding Poland, relative to hourly mean price, binned in categories." >}}

Full convergence (or $C\\%=0$) is still 26.98% of the time. However now we can also see that in 28.59% of the time the price spread is between 0 and 25% of the mean price in an hour! So in total for a little over half of the time (55.57%) the price spreads are less then a quarter of the mean price. Within the context of the extreme market conditions this seems a quite good result! 

An even better benchmark would be to compare this with a non flowbased approach, but that is not possible because that doesn't exist anymore in the CORE region. Comparing with another flowbased region is also not possible yet, the nordic region is implementing flowbased but not yet live. Perhaps in the future it would be interesting to see how flowbased performs, price spread wise, in this different region. But for that we have to wait at least another year.

So within the context we can see now, the system seems to hold up quite nicely. It would be interesting to see that the longer flowbased CORE marketcoupling runs, how the full (or almost full) price convergence share holds up.

## Bonus Annex
As a bonus to check our earlier theory about price spreads going up in the middle of the day, we can also look at the C% indicator, averaged per hour of the day. This is shown in figure 8 below.

{{< plotly json="fig_spread_pct_perhour.json" height="400px" caption="Figure 8: Hourly price spreads relative to hourly mean price, binned per hour of the day" >}}

Here we can see a very large peak at hours 13 and 14, which typically is the peak solar hour of the day. The effect on hour 12 is less strong, but still visible. This indeed seems to confirm the theory that price spread is influenced by solar infeed.

