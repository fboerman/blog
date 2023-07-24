---
title: 'DA market: the benefits of the Day-Ahead market design for NL'
date: 2023-07-24
draft: false
description: 'Recently some people criticized the DA market design as being a bad business case. But is that really true? A short discovery tour'
plotly: true
---
Recently a well known participant in the dutch energy debate, lector Martien Visser, wrote [tweets](https://twitter.com/BM_Visser/status/1680873687979786243) and a [column](http://mail.energiepodium.nl/artikel/verdienmodel-noordzee) about that the current day ahead market design is not a good business case for NL anymore. He is not the only one, this sentiment is more widespread on social media. While I do agree that in a RES dominated system it could be possible to have a beter tweaked market mechanism, I disagree that the current one is a very bad one, especially for NL. In this post I present some figures to support that.


## SDAC net revenue NL
My colleague Joost Greunsven proposed a nice way to visualize the revenue of all SDAC border exchanges for NL [some months ago](https://www.linkedin.com/posts/greunsven_sdac-revenues-nl-de-fr-2021-vs-2022-activity-7018848981258551296-uA92). This is a scatter plot in which each hour of the year is represented as a dot on a scale of import/export vs the revenue (sum of all border flows x DA price). I created a webapp to create such figures for more zones which can be found [here](https://sdacrevenue.amunanalytics.eu/). In figure 1 below the figure of Joost is repeated for NL for the first half of 2023.

{{< plotly json="fig_scatter_nl.json" height="400px" caption="Figure 1: the net revenue for NL for all hours in first half of 2023" >}}

This plot can be broken down in four quadrants. The top left (I) is import with negative price, the top right (II) is export with positive price, the bottom left (III) is import with positive price and the bottom right (IV) export with negative price. Quadrant II and III is what most people would feel as "normal" and are the ones that are by far the most common. But I and IV can also happen due to the fact the market optimizes for the whole region and not only a single zone. It can be beneficial for the whole region if some zones export with negative prices for example. 
 
The core argument from opponents of the current market design is that with high renewables infeed IV is getting so large its a net loss for the Netherlands. When power is exported for a negative price NL pays for its power export, effectively subsidizing its neighbours. This tends to happen when large amounts of subsidized power floods on the market, in NL that is mostly solar power. Subsidies push the power price to be negative and if there is a large surplus this is then exported.  

The title of figure 1 already shows that the overall business case for NL is still quite positive, the sum of net revenue is a positive 434.4 Million Euros. In figure 2 below a breakdown per quadrant is shown in a waterfall plot.

{{< figure src="fig_NL_2023_waterfall.svg" width="100%" height="400px" caption="Figure 2: Breakdown of net revenue of SDAC for NL in first half of 2023" >}}

Here we can clearly see that IV is actually quite small compared to the big export and import with positive price quadrants. In fact when expressed in relative numbers IV is only 2.7% of the total absolute sum of all revenue points divided over only 2.9% of all hours in the first half of 2023.  
This is by no means a historical fluke. In fact this is an all time high since it started occuring in the dutch market in 2020, but it is still very small. In figure 3 the past 5 years net revenue is plotted with the total revenue of exporting with negative price next to it.

{{< plotly json="fig_nl_overtime.json" height="400px" caption="Figure 3: Total net revenue vs Total revenue export with negative price for NL over the past 5 years" >}}

Here it can clearly be seen that this part has always been small and that for the past four years NL has seen a positive net revenue from SDAC interactions. 2022 is exceptionally high here due to the extreme high prices that year with the gas crisis. Based on this I would argue that the current market design is still very beneficial for the dutch generators.

Now the argument is sometimes made that this revenue loss is mainly on the important hours of solar PV and that NL mainly makes a profit with its gas turbines at night. Figure 4 below shows the summed revenue in NL per hour of the day.

{{< plotly json="fig_nl_revenue_perhour.json" height="400px" caption="Figure 4: Total net revenue per hour of the day for NL in first half of 2023" >}} 

Figure 4 clearly shows that NL actually makes the most positive revenue around midday when solar power peaks. There is even no hour which has a negative sum.


## SDAC revenue abroad
Now all that export also means that some zones are net importers. A good example of this is our big neighbour Germany. It used to have a positive net revenue, but this year it is actually importing more, which results in the breakdown shown in figure 5. But even for DE it is sometimes optimal that it exports with negative prices. The IV quadrant is however relatively smaller then NL, representing 0.47% of total absolute revenue.

More on SDAC revenue for other zones in a later post!

{{< figure src="fig_2023_DE.svg" width="100%" height="400px" caption="Figure 5: Breakdown of net revenue of SDAC for DE in first half of 2023" >}}
