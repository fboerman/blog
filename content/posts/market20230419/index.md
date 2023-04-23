---
title: 'Day Ahead Market adventures: capacity restrictions and huge negative prices for business day 2023-04-19'
date: 2023-04-23
draft: false
description: 'Large capacity restrictions and prices dropping to 200 EUR/MWh below zero, what happened on trading day 2023-04-18 for business day 2023-04-19? Time for some explanations in this writeup!'
plotly: true
---

The day ahead market has fascinated me since the very first day that I started working in the sector. Many components working together to form a safe and efficient market for electricy trading. On the 18th of April this year in some of these components rare events happened. In this post, I will offer an explaination on what happened.  

## The Day Ahead market: a description and some definitions
In the Day Ahead market every day electricity is traded. The traded energy is then delivered the day after trading. This explains the name, you trade one day ahead. We call this first day the *trading day* and the second day the *business day*. For the case with the extreme negative prices in this post 2023-04-18 is thus the *trading day* and 2023-04-19 is the *business day*.  
In the EU trading is optimized over a large area called the Single Day-ahead Coupling or SDAC, more info on this can be found [on the entsoe website](https://www.entsoe.eu/network_codes/cacm/implementation/sdac/). The market algorithm which determines the prices looks at this whole region to optimize trades.
Prices from the Day Ahead (DA) market are generally refered to as the dynamic wholesale prices and differ per hour. Normally household consumers are not exposed directly to these prices, but instead are insulated through various financial instruments. However recently having a dynamic tarrif in your contract based on DA prices has become more popular. Whether that is a good idea is situation dependant, my colleague Jesse van Elteren has [written about this recently](https://jvanelteren.github.io/blog/posts/energy/2023-03-31-eprices.html).  
The SDAC area is divided in bidding zones, usually one per country, in which eletricity can be freely traded. So the interactions that are determined by the algorithm are the import/exports from zone to zone, since within the zone there are no trading restrictions.


The process of getting to the final DA prices, the so called market coupling, is broadly divided in the following steps:
1. TSOs calculate how much capacity the grid can transport safely for every hour of the day. This is called the capacity domain. There are multiple subregions within the SDAC which each have their own domain
1. The domains are published and traders can put in bids. Traders base these bids on all kinds of information, the capacity domains probably being one of them.
1. The prices per zone are calculated by the market algorithm which combines all information about capacity domain and trader bids together. The algorithm called EUPHEMIA matches supply and demand in each zone and determines import/export between the zones. It does this by making a global optimization of welfare. Specifically it finds the set of interactions (import/export) between zones, in which the so called global welfare is the maximum out of all options. Global welfare here means the sum of both producers and consumers benefit from cross border trades.

After the last step above is completed the market is called *cleared* and all traders receive information about whether their bids are accepted and the prices per zone are published.

## Negative prices in the Netherlands and Belgium
On trading day 2023-04-18 the resulting prices from the DA market were quite volatile and for NL collapsed in the afternoon. See figure 1 for DA prices for  NL and her neighbours.

{{< plotly json="fig_da_prices.json" height="400px" caption="Figure 1: DA prices for 2023-04-18 and 2023-04-19 for NL, BE and DE" >}}

Negative prices are pretty non intuitive. It is countra-intuitive to be paid to consume energy. However, it is quite logical if you keep in mind that electricity consumption and production always needs to be in balance. Some generators cannot switch off for one hour and then start up the next hour, so they keep running. Their electricity needs to be consumed so they rather pay for this to happen then to shut down. Other production sources have even less flexibility.  
Negative prices do signal that there is too much production for the consumption present. Consumption will happen but the fact that they want to be paid shows that they normally would not want to do that. In other words, it shows that for specific hours there is not enough consumption for the amount of electricity produced.

The number of hours with negative prices is on the rise due to the fast adding of renewables, especially solar pv of which there is a lot in NL. On sunny days this high production outstrips the demand for consumption. Solving this in the future requires more flexibility in the system. For example more storage or more consumers (heavy industry for example) that are capable of shifting their demand more to the hours with the highest renewable infeed.

The first occurence of negative prices in NL was 2019-06-02 14:00. But below -50 EUR/MWh has only happend in 31 hours since start of 2015 (the start of the entsoe database on prices). Below -100 EUR/MWh only 10 times! The other times were in April and May of 2022. Of the 10 hours 3 were for 2023-04-19. So this is still a very rare occurence!   
Thus, could we find other factors then just high solar and wind infeed, which contributed for this scenary on 2023-04-19 specifically?

# Capacity Domain of CORE region
NL is part of the CORE region in which the [flowbased capacity calculation](https://www.jao.eu/core-fb-mc) methodology is active. In this methodology fixed capacity on borders are not defined fixed. Insead, a set of constraints are defined, from which the import/export of one zone can (and most of the times will) influence the limitations on the import/export of another zone. From these constraints it is possible to calculate the absolute limits of import/export for each zone by doing an optimization calculation, optimizing the import/exports of all zones to enable the maximum import or export for a specific zone. This info is usually a good starting point to see whether any special capacity restrictions were active on certain hours. 
This data is expressed in min max netto positions. The netto position (NP) of a zone is the sum of all exchanges on its borders, in which a positive NP denotes net export and a negative NP net import.
In figure 2 below this info is plotted for days 2023-04-18 and 19 for NL. These numbers are defined within the subregion of CORE.

{{< plotly json="fig_np_nl.json" height="400px" caption="Figure 2: Theoretical borders of netto position of NL within the CORE region"  >}}

Here we indeed see some clear trend breaches from 18th to the 19th. It seems that the import and export boundaries are smaller, and the import boundary is even a clear straight line. This trend breach is even more visible for our neighbour BE, as shown in figure 3.

{{< plotly json="fig_np_be.json" height="400px" caption="Figure 3: Theoretical borders of netto position of BE within the CORE region"  >}}

Here the restrictions seem even larger relatively speaking compared to the day before.

Thus, what could be the cause of these restrictions?

## Individual validations
To answer this question a quick explanation is needed. As part of the capacity calculation process done together by all the Transmission System Operators (TSOs, for NL that is TenneT Netherlands), it is possible to execute a so called individual validation (IVA). This means that a TSO can do a net security calculation and if it determines that certain parts of the capacity domain result in unsafe situations, it will apply capacity restrictions on applicable constraints within the domain. This is only allowed when the TSO can show that even with all possible interventions it theoretically can still not solve the detected issue. This is done every day and all TSO's apply so called IVA's from time to time.  
All validations applied including a justification explanation are available on the excellent publication tool [here](https://publicationtool.jao.eu/core/validationReductions).

In table 1 below the application of IVA's is shown for 2023-04-18, expressed as percentage of the number of constraints in the domain on which an IVA was applied as well as the average size in % of Fmax. Fmax means the maximum amount of MW that a constraint can handle physically. Only TSOs which applied IVAs are shown.
<figure class="left" style="width:100%">

| tso            | % of num constraints | average size as % of Fmax |
|----------------|----------------|---------------------------|
| ELIA           | 0.29           | 10                        |
| PSE            | 6.10           | 0.90                      |
| RTE            | 63.64          | 24.29                     |
| TRANSELECTRICA | 19.15          | 2.44                      |

<figcaption class="center">Table 1: percentage of presolved domain on which an IVA is applied as well as the average  per TSO for 2023-04-18 <figcaption>
</figure>

Here we can see that a minority of TSO's have applied IVA's and those that did are mostly minor. RTE (French TSO) does jump out here, with quite a large part of the presolved domain being hit for French constraints. However the market seems to not have moved in that direction of those constraints that day, so no major price disturbance was visible.

In table 2 below the same data is shown for 2023-03-19, showing a much more extreme picture.

<figure class="left" style="width:100%">

| tso            | % of num constraints | average size as % of Fmax |
|----------------|----------------------|---------------------------|
| 50HERTZ        | 30.56                | 13.55                     |
| AMPRION        | 19.05                | 15.88                     |
| ELIA           | 100.00               | 69.24                     |
| PSE            | 7.02                 | 3.33                      |
| SEPS           | 2.13                 | 13.17                     |
| TENNETBV       | 27.66                | 15.38                     |
| TENNETGMBH     | 9.00                 | 7.11                      |
| TRANSELECTRICA | 17.65                | 13.08                     |

<figcaption class="center">Table 2: percentage of presolved domain on which an IVA is applied as well as the average  per TSO for 2023-04-19 <figcaption>
</figure>

Here, we can see that the majority of TSOs has applied IVAs and Elia even a very high size (last column). Why they did that is neatly published on the aforementioned publication tool page [here](https://publicationtool.jao.eu/core/validationReductions). Here we can see something very interesting when looking at the "Justification" column, most TSO's actually applied IVAs due to a failure in their local tooling, applying a so called "fallback". This is the case for 50Hertz, Amprion, TenneT NL, TenneT DE and Elia. So what does this mean exactly?

## Fallbacks
In complex systems of any kind it is always possible that something goes wrong. While the TSO systems are designed very robustly sometimes things go wrong. What exactly goes wrong can be a number of things, for example an IT crash (possibly due to bugs), missing/incomplete input data or highly implausible results (as judged by operators). To still ensure safe grid operation a fallback procedure is then used in which a reduction is applied that leads to a situation that is assumed safe regardless of the circumstances. This is by definition a quite conservative low value.  
A fallback situation is not unique to the local validation step, there are fallbacks defined for all steps of the market coupling process. These vary from rather simple things like the low values mentioned or replacement input data from a reference timestamp (for example if up to date grid models are unavailable), to more complex completely different backup processes. For example, if in the worst case the market coupling completely fails and no prices could be computed a so called "shadow auction" is held. These are a much more simplified (and thus less efficient) way to still get some trades going.  

It is important to stress that, while rare, applying fallbacks is an expected process step. TSO's have the obligation to ensure safe grid operations and less capacity but garantueed to be safe is always better than more capacity but high risk for grid safety. Errors of any kind are always possible to happen and all TSO's have responded in an agreed way. It is therefore wrong to blankly blame certain TSO's for the mere fact that they reduced capacities. No TSO does this just for fun and all fallback incidents are extensively investigated and if needed measures for the future taken.

As for the size of the fallback, each TSO is allowed to define its own fallback rules. Why Elia decided to apply such a relatively large reduction as fallback is not known. Because of its size it probably had the most impact, in interplay with the other fallbacks. It is possible that TSOs or regulators will release calculations on this in the future.

## The effect of IVAs of the 19th
The effect of these restrictions we already saw in figure 2 and 3. To clarify, the relative impact on the theoretical boundaries on the netto position is expressed in figure 4 and 5 below, as a percentage of change compared between 18th and 19th. Keep in mind that the days are not exactly the same, and these boundaries shift every day and every hour. However the fact that these days were normal workingdays directly after eachother makes it comparible as a larger picture.

{{< plotly json="fig_np_max_diff_pct.json" height="400px" caption="Figure 4: Relative change in maximum export possible for BE and NL between 2023-03-18 and 2023-04-19" >}}

{{< plotly json="fig_np_min_diff_pct.json" height="400px" caption="Figure 5: Relative change in maximum import possible for BE and NL between 2023-03-18 and 2023-04-19" >}}

Here we can see that the main zone impacted is BE, which makes sense given table 2, in which mainly BE constraints were hit by reductions. But also NL was quite impacted, especially on the main sunny hours.

For NL in the context of the highly negative prices, the most important metric here is figure 4, the export. As mentioned before, NL has a large amount of renewables (RES) infeed which outstrips demand. If not enough can be exported the prices are pushed far below zero. This is most probably what happend on the 19th. The export restrictions in the form of the various IVAs caused a large surplus within NL for the most sunny hours, pushing the prices to such extremes as we saw in figure 1.

Yet if we look at 1 the possible maximum export and 2 the realized export, we still see that this boundary was not hit. This brings up the last question I will deal with, why is that the case?

## A dive in the flowbased domain
As mentioned the min max NP is a theoretical boundary. In the capacity calculation method used in the CORE region the constraints are not fixed per border. Instead they are are a set of constraints in which the export and imports of all zones are linked together. So, for example an export from Germany to Austria can create more possible export from Netherlands to Belgium. This theoretical boundary as shown in the figures is achieved by optimizing the netto positions from all zones to achieve a maximum (or minimum in case of imports) netto position of a certain zone. 
 
If we run this optimization for the hour with the lowest price (13:00 on the 19th) to get the maximum export for NL,  we get the configuration of netto positions for all zones in the CORE region as shown in table 3. Please note that these are netto positions within the CORE subregion, not the whole SDAC region.

<figure class="left" style="width:100%">

| zone | NP needed for max NL | historical NP |
|------|----------------------|---------------|
|  AT  | -880                 | -3213         |
|  BE  | -838                 | 296           |
|  CZ  | 4260                 | -62           |
|  DE  | -10499               | 3941          |
|  FR  | 3282                 | -1155         |
|  HR  | -496                 | -410          |
|  HU  | -2698                | -431          |
|  NL  | 3519                 | 1818          |
|  PL  | 1520                 | 53            |
|  RO  | -1746                | -380          |
|  SI  | 5191                 | -460          |
|  SK  | -615                 | 2             |

<figcaption class="center">Table 3: configuration of netto positions needed to enable max export for NL on 2023-04-19 13:00 <figcaption>
</figure>

Thus, in order for NL to reach its maximum export in the capacity domain, as available on 2023-04-19 13:00, 1 Germany would need to import more then 10GW, 2 SI would have flipped from slightly importing to massive exports and 3 AT would have a much higher export as well. These extremes seem unlikely to be the best solution for the optimization. It is thus not surprising that the market algorithm decided to not go into these extreme corners.

These calculations cannot determine if without the reductions the price would have been non-negative. Determining this requires a full market simulation. However, given the large solar infeed in NL it is quite possible that the prices would be less negative but still under the zero.

## Conclusion
This post has become quite long but I hope that anybody reading it has learned a bit more about how the market works and why the 19th was such a special case. If you have any remaining questions feel free to shoot me a message on twitter or linkedin or send me an email (info on the contact page of this blog). 

DISCLAIMER: All info in this post is based on public available information. Theories and assumptions described in this post reflects only my personal view and analysis of the energy market. They are NOT, in any way, related to my position as process specialist or reflect TenneT strategy or position. For company based opinions on this topic, please contact the communication office of TenneT. 
