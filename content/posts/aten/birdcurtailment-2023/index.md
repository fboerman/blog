---
title: 'Aten: pausing a wind park for bird migrations, a worlds first in the Netherlands'
date: 2023-05-15
draft: false
description: 'Last saturday night a world first was executed in the dutch offshore world parks: pausing the turbines for large bird migration swarms. A couple of quick images on it.'
plotly: true
---
On the 11th of May a new kind of operational message was published on the TenneT NL feed. Normally [this feed](https://www.tennet.org/english/operational_management/Operationalreports.aspx) is quite boring, announcing transport restrictions or grid status for example. But on Friday it [announced](https://www.tennet.org/english/bsmailfax/20230511_152915_Limitation_rotational_speed_of_offshore_wind_turbines.html) a special type of restriction for offshore windparks. To help large scale bird migrations the offshore windparks were restricted to very slow turning of turbines.  
The discussion whether (sea)birds get killed en masse by (offshore) wind turbines is a long one. As far as I know there is no hard scientific evidence either way, but out of extra caution the Netherlands has implemented a process to help birds anyway.  
It tries to detect and predict large bird migrations in the spring and fall over the north sea and then schdules a stop of the turbines in a controlled manner for a period of time. That way everybody involved, including TenneT for grid stability, can prepare for it.

On monday an [official message from the ministry](https://www.rijksoverheid.nl/actueel/nieuws/2023/05/15/windparken-op-zee-voor-het-eerst-stilgezet-om-trekvogels-te-beschermen) was published (dutch only) and [some dutch media](https://www.nu.nl/economie/6263769/windparken-op-noordzee-voor-het-eerst-stilgezet-om-trekvogels-te-beschermen.html) picked it up as well.

So can we see the effects of the restriction in some public data? Fortunately yes. In figure 1 below the output of Wind Offshore for the Netherlands is shown for the night of the restriction. All data is from [co2monitor.nl](https://co2monitor.nl/).

{{< plotly json="windoffshore_output_nl.json" height="400px" caption="Figure 1: Wind Offshore output NL showing the effect of the bird curtailment process" >}}

The restriction was scheduled between 00:00 and 04:00 on the night of Saturday 2023-05-13 local time. In figure 1 we can indeed see a clear dip between those hours. The wind speed in this period was pretty constant and the day ahead market prices was as well, so this is most probably fully caused by the restriction.  
Please note that the restriction is to lower the speed of the turbines a very slow rate, but not zero. So there is still a bit of generation from the parks affected, as well as some from smaller offshore parks not affected.

To see the effect even better the change for each 15 min datapoint is shown in figure 2 below.

{{< plotly json="windoffshore_output_delta_nl.json" height="400px" caption="Figure 2: Wind Offshore output NL delta per 15 min, showing the effect of the bird curtailment process" >}}

Here we can see the largest deltas at 00:00 and 04:00, with a quite large delta as well. This shows even more clearly the restriction during its cheduled time period.
