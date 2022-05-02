---
title: "Aten: negative prices and wind curtailment"
date: 2022-05-03
draft: false
description: "A quick look at one of the consequences of high negative prices on the dutch Day Ahead electricity market: shutting down of wind units"
---

In the weekend of 23th and 24th of April 2022 the day ahead prices in the Netherlands reached record lows. On Saturday it reached €-222.36 at 12:00 and on Sunday €-117.21 at 13:00. Now there are many discussion to be had about the place of negative prices in the current market design, which I will not get into now here. However the cause is quite clear: a huge ammount of renewable energy sources. With the growth of these sources negative prices will happen more and more in the future.  
Yet many units keep running during times with very low prices. This can have many reasons, for example because shutting down and starting up again is too expensive. Or because units are active on the balancing market instead. Only when none of these are true units shutdown.

One of the typical examples of this is offshore wind units. Shutting down and starting up is quite low cost for wind units, but on top of that they also do not receive SDE subsidies if there are six or more hours of negative prices. Blocks of these happened on both Saturday and Sunday resulting in an almost perfect correlation between plunging day ahead prices and offshore wind output, shown here below.

{{< figure src="effects-of-da-price-on-generation-nl.png" caption="Wind offshore output (blue, left axis) and day ahead price (green, left axis) for the Netherlands on 24-25 April 2022 (click to enlarge)" clickable="true" >}}

Data from [co2monitor.nl](https://co2monitor.nl/) and [ENTSO-E transparency](https://transparency.entsoe.eu/) for wind output and day ahead prices respectively.

{{< ping key="aten5" >}}
