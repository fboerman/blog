---
title: "Aten: Market Cap Reached Incident Baltics 2022"
date: 2022-08-29
draft: false
description: "Recently the baltics reached the current price cap in DA market of 4 thousand euros per MWh. Can we see indications why? And what is this price cap?"
plotly: true
---
This post is part of a series  written to celebrate the launch of [Amun Analytics](https://amunanalytics.eu/). This company will serve as the business umbrella for all my data analytics projects. If you have some interesting data analysis and visualization projects in which you need some help, shoot me [an email](mailto:frank@amunanalytics.eu)! Now lets dive into the topic of today.

## High Prices in the Baltics
On Wednesday 17th August 2022, the Day Ahead (DA) market price in the Baltic region  hit the price cap of €4000 per Mwh. Between 17:00 and 18:00, the price for Estonia, Latvia and Lithuania hit simultaneously the then active price cap (depicted in figure 1 below).

{{< plotly json="prices_incident_baltics.json" height="400px" caption="Figure 1: Day Ahead prices for the incident day for Baltic region (figure is interactive)">}}

 What is interesting about this event is the pattern of the hours before and after this sudden increase, as shown in table 1 below.
<figure class="left" style="width:100%">

| hour  | Lithuania(LT)     | Latvia (LV)     | Estonia (EE)     |
|-------|--------|--------|--------|
| 16:00 | 750.08 | 750.08 | 750.08 |
| 17:00 | 4000   | 4000   | 4000   |
| 18:00 | 750.08 | 750.08 | 750.08 |
<figcaption class="center">Table 1: Excerpt of hour before and after price increase</figcaption>
</figure>
From one hour to the next (i.e. from 16:00 to 17:00 hrs) there is a sudden sharp increase in the price. This is followed by a sharp decrease (i.e. from 17:00 to 18:00hrs) to the exact same level. What factors may possibly explain this movement? What is so different at this specific hour in which the price cap was reached?

##### Intermetzo: the Price Cap
Although the Day Ahead (DA or spot) market prices have been continuously high across Europe when compared to the year before, hitting the price cap is still very rare. So what is this price cap exactly?  
In order to have some algorithmic price limitation, market biddings in day ahead have a cap. This mechanism also acts as a circuit breaker to try to calm down extreme situations. It can be seen similar to mechanisms found in stock markets, but with a much longer timespan.  
At the beginning of this year the price cap stood at €3000/MWh. However European regulations determine that if the DA price hits more then 60% of the current price cap anywhere in the market area [SDAC](https://www.entsoe.eu/network_codes/cacm/implementation/sdac/) for any hour, a price cap increase of €1000/MWh will be applied five weeks from that day.  
This increase already happened at 4th of April 2022 in France. Hence the cap stood at €4000 euros per MWh at the 17th of August.  
With the DA price hitting the price cap again on the 17th of August the price cap will be €5000 per MWh five weeks after. There is currently no theoretical limit to this process.

## The Market situation
Back to the Baltics. Lets take a look at the market situation. The energy exchange Nordpool publishes the so called aggregated bid curves, one for supply and one for demand. These curves are calculated by adding all supply bids and all demand bids that were available, all expressed in a price for a certain amount of power that is being offered to sell or buy. The final clearing market price is then derived from where supply and demand intersects. This is all done on an hourly basis. Nordpool publishes these for the whole Baltic region.    
For the price capped hour these are displayed in figure 2 below.
{{<figure src="aggregated_bid_curves_1700.png" caption="Figure 2: Aggregated bid curves for Baltic region for 2022-08-17 17:00" >}}
The hour after is displayed in figure 3, the hour before looks very similar and is not shown here.
{{<figure src="aggregated_bid_curves_1800.png" caption="Figure 3: Aggregated bid curves for Baltic region for 2022-08-17 18:00" >}}
As you can see the situation is very tight for both hours. But specifically if the supply curve(blue) was only shifted with approximately 50 MW, a non capped price could have been found (Nordpool does not publicly publish these figures as numbers so exact calculation is impossible). In fact when, comparing the hour 17:00 in figure 2 with the hour 18:00 in figure 3, it seems the situation is very similar except about 50MW in supply is missing. The hour before (not shown here) displays the same behavior.  
What could be the cause of this missing supply for hour 17:00?

## Capacities on the Borders of the Baltics
The Baltics are a corner of the SDAC region, but with often used connections to Sweden and Poland in the South (with Lithuania) and to Finland in the north (with Estonia). Power can also be exchanged with Russia and Belarus, but here capacity is offered only incidentally.  
Let's see if a possible cause of the mentioned missing MW can be found in how much capacity was available for import (import gives more supply, export more demand).  
For the northern border, the capacities offered to the market to move power in (so called Net Transfer Capacity or NTC) are shown in figure 4 below for Estonia for the import direction (for example FI > EE).
{{<plotly json="import_capacities_incident_EE.json" height="400px" caption="Figure 4: Import NTC for Estonia for the incident day (figure is interactive)" >}}
Although a decrease was apparently applied for part of the day it is not specific to the hour 17:00. In other words, this cannot be a plausible cause for the specific shortage in the hour we are investigating.

Now let's look at the southern borders, again import NTC's are shown, this time for Lithuania. See figure 5 below.
{{<plotly json="import_capacities_incident_LT.json" height="400px" caption="Figure 5: Import NTC for Lithuania for the incident day (figure is interactive)" >}}

Here we do see an interesting situation around 17:00. It seems that the Polish border was restricted between 16:00 and 22:00. Simultaneously the cable from Sweden was also restricted between 10:00 and 18:00.  
To make this more clear, let's add up all the import capacities on all borders, to look at the total import capacity per zone for the Baltic region, excluding internal transfer capacity. This result can be seen in figure 6 below.
{{<plotly json="total_imports_incident.json" height="400px" caption="Figure 6: Total import NTC for the Baltics for the incident day, excluding internal transfer capacity (figure is interactive)" >}}
A clear small dip can be seen at the hour 17:00. To zoom in on this, the numbers are put in table 2 below.
<figure class="left" style="width:100%">

| hour  | Lithuania(LT)     | Latvia (LV)     | Estonia (EE)   |
|-------|------|----|-----|
| 16:00 | 1050 | 0  | 858 |
| 17:00 | 1010 | 0  | 858 |
| 18:00 | 1050 | 0  | 858 |
<figcaption class="center">Table 2: Excerpt of import NTC for the hours before during and after the 4k EUR price </figcaption>
</figure>
Thus, it seems that at the exact hour of the shortage (17:00) there was a 40MW lower import capacity for the Baltics on the southern borders with Poland and Sweden. In the hour before and after a bit more capacity was available on the Polish and Swedish connection respectively. Together with the bidding curves shown earlier (figure 3 and 4 above) this seems like a plausible cause for the sudden increase in price at hour 17:00 and normalization in the hour after.  

This reasoning only holds if the full import capacity was actually used Otherwise it is not constraining the situation. To check this reasoning the utilization, defined as scheduled commercial exchange divided by the capacity offered, is plotted per external border in figure 7 below.
{{<plotly json="baltics_utilization_incident.json" height="400px" caption="Figure 7: Import capacity utilization for the incident day for all external Baltic borders" >}}
From the figure above, it is possible to infer that the market did indeed use 100% of the import capacities available for 17:00. Thus  the restricted capacity is a plausible cause of the hitting of the price cap, especially compared to the lower priced hours before and after.

## In Conclusion
The hitting of the price cap in the Day Ahead market is a rare and extreme situation. The market in the Baltics was quite tight in terms of supply and demand. However, the market was able to clear far below the price cap for most hours. At 17th August 2022 17:00 it did not.  
From the bid curves it followed that an extra supply of 40-50MW would probably have been enough to make the market clear and keep a similar price compared to rest of the day. A plausible cause for this difference is a restriction on the import capacities for the Baltic region at that hour.  

So is this a definitive cause to blame for this sudden hitting of the price cap? No, the aggregated bidcurves are only available as simple images and the market coupling algorithm is much more advanced than simply shifting some curves around. More complex market interactions could have been contributing. However the above laid out analysis does point to it as a strong plausible contributing factor.

It can also be said that you cannot "blame" any such specific factors of the system. After all, it worked as its designed to. Capacity restrictions are there for many reasons. Grid operators do not restrict capacities because they think it is fun. They do from a net security perspective. Worst case scenario, it is possible that without the restriction no grid would have been possible to operate at all at that hour! To confirm this case there is not enough public information available. We remain thus waiting for a proper debrief by the regulating authorities.  
In the end it comes down most simply to the fact that there was not enough supply for that hour willing to sell at a price that demand was willing to pay. 

Finally, what this also mostly shows is the importance of interconnectivity for the grid. A relatively small change in interconnectivity can have major consequences. Its important to keep this in mind for any person or entity who have to take decisions concerning this.

## Appendix
To show that 2022-08-17 was a non typical day in terms of capacities, we can repeat figure 6 for a reference day, for example the same weekday a week earler. This is shown in below figure.
{{<plotly json="total_imports_reference.json" height="400px" caption="Appendix A: Total import NTC for the baltics for reference day, excluding internal transfer capacity (figure is interactive)" >}}
Again there is some restriction on the north border but the total picture is much less severe then the incident day of 17th.

The prices for the same day are also more balanced and in line with the rest of the SDAC, as shown in below figure as a repeat of figure 1.
{{<plotly json="prices_reference_baltics.json" height="400px" caption="Appendix B: Total import NTC for the Baltics for reference day, excluding internal transfer capacity (figure is interactive)" >}}
