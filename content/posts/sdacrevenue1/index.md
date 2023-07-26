---
title: 'DA market: the benefits of the Day-Ahead market design for NL'
date: 2023-07-24
draft: false
description: 'Recently some people criticized the DA market design as being a bad business case. But is that really true? A short discovery tour'
plotly: true
---
Recently a well known participant in the dutch energy debate, lector Martien Visser, wrote [tweets](https://twitter.com/BM_Visser/status/1680873687979786243) and a [column](http://mail.energiepodium.nl/artikel/verdienmodel-noordzee) setting out his view that the current day ahead market design is not a good business case for NL anymore. He is not the only one, this sentiment is widespread on social media. While I do agree that in a RES dominated system it could be possible to have a better tweaked market mechanism, I disagree that the current one is a very bad one, especially for NL. In this post I present some figures to support that.


## SDAC net revenue NL
A couple months ago, my colleague Joost Greunsven proposed a nice way to visualize the revenue of all SDAC border exchanges for NL [detailed here](https://www.linkedin.com/posts/greunsven_sdac-revenues-nl-de-fr-2021-vs-2022-activity-7018848981258551296-uA92). This is a scatter plot in which each hour of the year is represented as a dot on a scale of import/export vs the revenue (sum of all border flows x DA price). I created a webapp to display such figures for more zones which can be found [here](https://sdacrevenue.amunanalytics.eu/). In figure 1 below, the figure of Joost is repeated for NL for the first half of 2023.

{{< plotly json="fig_scatter_nl.json" height="400px" caption="Figure 1: the net revenue for NL for all hours in first half of 2023" >}}

This plot can be broken down in four quadrants. The top left (quadrant I) is import with negative price, the top right (quadrant II) is export with positive price, the bottom left (quadrant III) is import with positive price and the bottom right (quadrant IV) export with negative price. Quadrant II and III is what most people would feel as "normal" and are the ones that are by far the most common. However, quadrant I and IV can also happen due to the fact that the market optimizes for the whole region and not only a single zone. For example, it can be beneficial for the whole region if some zones export with negative prices. 
 
The core argument from opponents of the current market design is that with high renewables infeed quadrant IV is getting so large it's a net loss for the Netherlands. When power is exported for a negative price, NL pays for its power export, effectively subsidizing its neighbours. This tends to happen when large amounts of subsidized power floods on the market. In NL that is mostly solar power. Subsidies push the power price to be negative and if there is a large surplus this is then exported.  

The title of figure 1 already shows that the overall business case for NL is still quite positive. The sum of net revenue is a positive 434.4 Million Euros. In figure 2 below a breakdown per quadrant is shown in a waterfall chart.

{{< figure src="fig_NL_2023_waterfall.svg" width="100%" height="400px" caption="Figure 2: Breakdown of net revenue of SDAC for NL in first half of 2023" >}}

Here we can clearly see that quadrant IV is actually quite small compared to the big export and import with positive price quadrants. In fact when expressed in relative numbers quadrant IV is only 2.7% of the total absolute sum of all revenue points. This constitutes only 2.9% of all hours in the first half of 2023.  
This is by no means a historical fluke. In fact, this is an all time high since it started occuring in the dutch market in 2020, but it is still very small. In figure 3 the past 5 years net revenue is plotted with the total revenue of exporting with negative price next to it.

{{< plotly json="fig_nl_overtime.json" height="400px" caption="Figure 3: Total net revenue vs Total revenue export with negative price for NL over the past 5 years" >}}

Here it can clearly be seen that this part has always been smalli. In addition, for the past four years NL has seen a positive net revenue from SDAC interactions. The year 2022 is exceptionally high here due to the extreme high prices that year with the gas crisis. Based on thisi, I would argue that the current market design is still very beneficial for the dutch generators.

Now the argument is sometimes made that this revenue loss is mainly on the important hours of solar PV and that NL mainly makes a profit with its gas turbines at night. Figure 4 below shows the summed revenue in NL per hour of the day.

{{< plotly json="fig_nl_revenue_perhour.json" height="400px" caption="Figure 4: Total net revenue per hour of the day for NL in first half of 2023" >}} 

Figure 4 clearly shows that NL actually makes the most positive revenue around midday when solar power peaks. There is even no hour which has a negative sum.


## SDAC revenue abroad
All that export also means that some zones are net importers. A good example of this is our big neighbour Germany. It used to have a positive net revenue, but this year it is actually importing more. This results in the breakdown shown in figure 5. But even for DE it is sometimes optimal that it exports with negative prices. Quadrant IV is however relatively smaller then NL, representing 0.47% of total absolute revenue.

More on SDAC revenue for other zones in a later post!

{{< figure src="fig_2023_DE.svg" width="100%" height="400px" caption="Figure 5: Breakdown of net revenue of SDAC for DE in first half of 2023" >}}
