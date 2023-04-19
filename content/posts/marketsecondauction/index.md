---
title: 'Day Ahead Market adventures: capacity restrictions and second auction for business day 2023-04-19'
date: 2023-04-19
draft: false
description: 'Large capacity restrictions, a second auction and prices dropping to 200 EUR/MWh below zero, what happened on trading day 2023-04-18 for business day 2023-04-19? Time for some explanations in this writeup!'
plotly: true
---

The day ahead market has fascinated me since the very first day that I started my current job at TenneT. Many components working together to form a safe and working market for electricy traded for delivery for the next day. On the 18th of April this year in some of these components rare events happened with some unusual outcomes. In this post I will try to explain broadly how it normally works and what exactly happened.  
First a short disclaimer: through my work at TenneT I have intimate knowledge about details of what happened in operations. However in this public post I will only use public available info to construct a picture. To some open questions I already know the answer, but it is not my place to tell here.

## The Day Ahead market: a description and some definitions
In the Day Ahead market everyday electricity is traded for delivery of the next day, hence the name. We call this the *trading day* and the *business day* respectively. For the case I am taking a closer look on there this means that 2023-04-18 is thus the *trading day* and 2023-04-19 is the *business day*.  
In the EU a large area is coupled together in this market, so the market algorithm looks at the whole region to optimize trades (more on this later). This is called the Single Day-ahead Coupling or SDAC, more info on this can be found [on the entsoe website](https://www.entsoe.eu/network_codes/cacm/implementation/sdac/).  
Prices from the Day Ahead (DA) market are generally refered to as the dynamic wholesale prices and differ per hour. Normally household consumers are not exposed directly to these prices, but instead are insulated through various financial instruments. However recently having a dynamic contract to pay directly the DA prices (with some taxes on top) has become more popular. Wether that is a good idea is situation dependant, my colleague Jesse van Elteren has [written about this recently](https://jvanelteren.github.io/blog/posts/energy/2023-03-31-eprices.html).  
The SDAC area is divided in bidding zones, usually one per country, in which eletricity can be freely traded. So the real question is the import/exports from zone to zone.

The process of getting to the prices, the so called market coupling, is broadly divided in the following steps:
1. TSOs calculate how much capacity they think is safe to release for possible interactions. This is called the capacity domain. There are multiple subregions within the SDAC which each have their own domain
1. The domains are published and traders can put in bids. They usually draw from all kinds of information, the capacity domains can be one of them.
1. The market algorithm combines all information about capacity domain and trader bids together to calculate the prices per zone. The algorithm called EUPHEMIA matches supply and demand in each zone and determines import/export between the zones to make this possible. It makes a global optimization of welfare, ie it finds the set of interactions between zones in which both producers and consumers added together benefit from cross border trades in the most optimal way.

After the last step is completed the market is called *cleared* and all traders receive information about if their bids are accepted and the prices per zone are published.

## Negatie prices in NL
So on trading day 2023-04-18 the results were pretty volatile and for NL the prices collapsed in the afternoon. See figure 1 for DA prices for  NL and her neighbours.

{{< plotly json="fig_da_prices.json" height="400px" caption="Figure 1: DA prices for 2023-04-18 and 2023-04-19 for NL, BE and DE" >}}

Negative prices are pretty non intuitive, its seems weird to be paid to consume energy. However it is quite logical if you keep in mind that electricity consumption and production always needs to be in balance. Some generators cannot switch off for one hour and then start up the next hour, so they rather keep running. Their electricity needs to be consumed so they rather pay for this to happen then to shut down. Other production sources have even less flexibility.  
Negative prices do signal that there is too much production for the consumption present, consumption will happen but the fact that they want to be paid shows that they normally would not want to do that. In other words it shows that for specific hours there is not enough consumption that you would like to see for the amount of electricity produced.

The number of hours with negative prices is on the rise due to the fast adding of renewables, especially solar pv of which there is a lot in NL. On more sunny days this outstrips the demand for consumption. Solving this in the future requires more flexibility in the system, so for example more storage but also more consumers (heavy industry for example) that is capable of shifting more of their demand to the hours with the highest renewable infeed.

The first occurence of negative prices in NL was 2019-06-02 14:00. But below -50 EUR/MWh has only happend in 31 hours since start of 2015 (the start of the entsoe database on prices) and below -100 EUR/MWh only 10 times! The other times were in April and May of 2022. Of the 10 hours 3 were for 2023-04-19. So this is still a very rare occurence!   
Could we find some factors which contributed to this for 2023-04-19 specifically, except for high solar and wind infeed?

# Capacity Domain of CORE region
NL is part of the CORE region in which the [flowbased capacity calculation](https://www.jao.eu/core-fb-mc) methodology is active. In this methodology there is not fixed capacity on the border defined, but a set of constraints in which the import/export of one zone can (and most of the times will) influence the limitations on the import/export of another zone. From these constraints it is possible to calculate the absolute limits of import/export for each zone by doing an optimization calculation, optimizing the import/exports of all zones to enable the maximum import or export for a specific zone. This info is usually a good starting point to see if any special capacity restrictions were active on certain hours. 
This data is expressed in min max netto position. The netto position (NP) of a zone is the sum of all exchanges on its borders, in which a positive NP denotes net export and a negative NP net import.
In figure 2 below this info is plotted for days 2023-04-18 and 19 for NL. These numbers are defined within the subregion of CORE.

{{< plotly json="fig_np_nl.json" height="400px" caption="Figure 2: Theoretical borders of netto position of NL within the CORE region"  >}}

Here we indeed see some clear trend breaches from 18th to the 19th. It seems that the improt and export boundaries are smaller, and the import boundary is even a clear straight line. This trend breach is even more intens for our neighbour BE, as shown in figure 3.

{{< plotly json="fig_np_be.json" height="400px" caption="Figure 3: Theoretical borders of netto position of BE within the CORE region"  >}}

Here the restrictions seem even larger relatively speaking compared to the day before.

So what is the cause of these restrictions?

## Individual validations
To answer this question a quick explanation is needed. As part of the capacity calculation process done commonly by the Transmission System Operators (TSOs, for NL that is TenneT Netherlands) it is possible to execute an individual validation (IVA). This means that a TSO can do a net security calculation and if it determines that certain parts of the capacity domain result in unsafe situations, it will apply capacity restrictions on applicable constraints within the domain. This is only allowed if the TSO can show that even with all possible interventions it has in its toolbox it theoretically can still not solve the detected issue. This is done every day and all TSO's apply so called IVA's from time to time.  
All validations applied including a justification explanation are available on the excellent publication tool [here](https://publicationtool.jao.eu/core/validationReductions).

In table 1 below the application of IVA's is shown for 2023-04-18, expressed as percentage of the number of constraints in the domain on which an IVA was applied as well as the average size in % of Fmax. Fmax means the maximum amount of MW that a constraint can handle physically.
<figure class="left" style="width:100%">

| tso            | % of presolved | average size as % of Fmax |
|----------------|----------------|---------------------------|
| 50HERTZ        | 0.00           |                           |
| AMPRION        | 0.00           |                           |
| APG            | 0.00           |                           |
| CEPS           | 0.00           |                           |
| ELES           | 0.00           |                           |
| ELIA           | 0.29           | 10                        |
| HOPS           | 0.00           |                           |
| MAVIR          | 0.00           |                           |
| PSE            | 6.10           | 0.90                      |
| RTE            | 63.64          | 24.29                     |
| SEPS           | 0.00           |                           |
| TENNETBV       | 0.00           |                           |
| TENNETGMBH     | 0.00           |                           |
| TRANSELECTRICA | 19.15          | 2.44                      |
| TRANSNETBW     | 0.00           |                           |


<figcaption class="center">Table 1: percentage of presolved domain on which an IVA is applied as well as the average  per TSO for 2023-04-18 <figcaption>
</figure>

Here we can see that some TSO's have applied IVA's, but not very big ones. RTE (French TSO) is a bit higher then average but not hugely. This is a fairly typical day.


## The effect of IVAs of the 19th

## Why no maximum export? A dive in the flowbased domain
