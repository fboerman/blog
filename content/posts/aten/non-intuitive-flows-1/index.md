---
title: "Aten: non-intuitive flows in flowbased capacity calculation: NL -> BE"
date: 2022-03-16
draft: false
description: "An intuitive look at an example of a non-intuitive flow close to home. Based on research done with my colleague Joost Greunsven"
scientific: true
---
## Intuitive and non intuitive flows
The recent market developments put the spot light on all kinds of interesting behaviour of the way European electricity market works. One of those is non intuitive flows. At 4th November 2020 the electricity day ahead market value broke a fundamental rule: allocation of cross border flows was no longer restricted to go from a low price zone to a high price zone. Flows from a low to a  high price zone are called intuitive, since it is intuitive that exporting from a low price to high price will average out the final price between the zones and maximize global welfare.  
However this is not always the best optimization. Sometimes the optimal approach is to allocate a flow from a high to a low price zone (also known as non intuitive flows). For example if it makes capacity available for a flow from a low price zone to a high price zone on a different border.   
Another example is when a flow goes from a high price zone to a low price zone to an even higher price zone. 
Non intuitive optimization was enabled for the first time to optimize the integration process within the European electricity market at the 4th of november 2020. 

Side note: A more ellaborate explanation of flowbased flows can be found on [energeia (subscription needed)](https://energeia.nl/trilemma/40090522/evolutie-in-flow-based-marktkoppeling-kan-voor-verrassingen-zorgen), written by my colleague Joost Greunsven. 

So how many times do these flows occur in practise? And how large are they are relatively to the maximum possible exchange?

## Border flow utilization
To more easily compare border flows on different timestamps, we define a border flow utilization percentage. This is a percentage indicating the share a commercial scheduled flows ($F_{scheduled}$) takes on the maximum possible exchange between two zones ($bex_{max}$) per hour.

Mathematically, the utilization of cross border flows is then defined as follows, for for example in the direction $NL \rightarrow BE$ :
$$ F^{NL \rightarrow BE}\_{util} = \dfrac{F^{NL \rightarrow BE}\_{scheduled}}{bex^{NL \rightarrow BE}\_{max}}*100 [\\%] \tag{1}  $$
With:
* $F^{NL \rightarrow BE}\_{util}$ as the utilization [%]
* $F^{NL \rightarrow BE}\_{scheduled}$ as the amount of day-ahead scheduled commercial flows [MW]
* $bex^{NL \rightarrow BE}\_{max}$ the maximum possible bilateral exchange as calculated by the CWE capacity calculation [MW]

To determine whether a flow is intuitive we look at the price delta in the direction of the flow, defined as:
$$ \Delta P_{NL \rightarrow BE} = P_{BE} - P_{NL} \tag{2}  $$
For a positive $\Delta{P}$ a flow goes from a low price to a high price zone and is thus considered an intuitive flow. Vice versa a negative $\Delta{P}$ signals a non intuitive flow.


## Non intuitive flows in practice
So outside theory, how does this look in practise?  
In the below figure we can observe the border utilization for the first half of March 2022 for the $NL \rightarrow BE$ border. The yellow line depicts the $\Delta P_{NL \rightarrow BE}$. Every bar corresponds to an hour on the day-ahead market. Intuitive flows, those which occur when $\Delta P \geq 0$, are colored *green*. Non intuitive flows are then flows which occur when $\Delta P < 0$ and are colored *blue*.  
From this figure, we can observe that most of the time there are intuitive flows. However, there are periods of multiple hours in which non-intuitive flows occur. The border utilization on those hours is about the same as directly before and after these periods.
{{< figure src="NL-BE_Pdelta_BE_NL_1080p.png" caption="border trade utilization for border NL -> BE with price delta NL (click to enlarge)" clickable="true" >}}
Why are these non intuitive flows occuring? The answer seems to be the related to the second reason given at the start of this post. The flow is going to an even higher price zone: France. Although France is historically an energy exporter, due to various factors (out of the scope for this post) it has been importing electricity for the past two months. It has seen relatively high day ahead market prices because of these factors.
This effect becomes clear when we plot the price delta on the Belgian border towards France, so $\Delta P_{BE\rightarrow FR}$, as depicted in the below figure.
{{< figure src="NL-BE_Pdelta_FR_BE_1080p.png" caption="border trade utilization for border NL -> BE with price delta BE (click to enlarge)" clickable="true" >}}
Here the non intuitive flows (blue bars) clearly line up with high peaks of the $\Delta P$. Thus it seems the market algorithm has allocated flows going from $NL\rightarrow BE\rightarrow FR$. That explains the non intuitive flow pattern on the Dutch Belgium border. A beautiful example of the advantages of optimizing on a larger area specifically and the advantages of the European market integration project in general!

{{< linkedin url="https://www.linkedin.com/posts/frank-boerman-477613164_recently-there-were-quite-some-electricity-activity-6910127717778665473-2dWQ?utm_source=linkedin_share&utm_medium=member_desktop_web" >}}


## Utilization methodology technical remarks
There are some limitations to our method of defining an utilization.  
Comparing maxbex with scheduled exchanges is a bit comparing apples with oranges:
* The maxbex is calculated within CWE flow-based capacity calculation and represents the maximum possible flow between two CWE bidding zones, if all other exchanges between CWE bidding zones are 0 (CWE being the Central Western European capacity calculation region).
* The scheduled exchanges result from all day-ahead exchanges, not just those in CWE.

As a result, utilisation values may reach  >100% on a border. For example if a relative high amount of non-CWE exchanges are scheduled on a zone border, they may surpass the maxbex value.
However, maxbex cannot be calculated for non-CWE. In addition, scheduled commercial flows are only available on EU level. Therefor,  *this is the closest we can get* to defining a semi accurate percentage measure.

## Acknowledgments
This post is based on the research done in close collaboration with my wonderful colleague and walking encyclopedia of the electricity markets [Joost Greunsven](https://twitter.com/JoostGreunsven).

## Data sources
All data comes from the public sources of ENTSO-E transparancy platform and JAO utility tool.

{{< ping key="aten4" >}}
