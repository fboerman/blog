---
title: "Flowbased: a quick look at first results of the Nordic Flowbased parallel run"
date: 2023-01-23
draft: false
description: "For some time now the external parallel run for the implementation of the FlowBased capacity calculation methodology in the Nordics is live. Time to look at the first results!"
plotly: true
---

The Flowbased capacity calculation methodology that I have written about earlier is not meant only for continental Europe. In the Nordics (NO, SE, DK and FI) the TSO's and market parties have been working on an implementation in their region as well. In the recent months they have started to publish results from their external parallel run. This is a process in which you run the new methodology in parallel to the old one still in production to be able to compare results.

In this post I take a quick look at these first results.

## Some remarks on the data
I have pulled the data from the publication tool as well as the [RCC page](https://nordic-rcc.net/flow-based).  
The Flowbased results are available for quite some months but during the run the process is continuously improved. I have therefor opted to view the last couple of months, arbitrary chosen starting from 2022-09-01 until the last business day available when writing this, 2023-01-23. For this timerange there is at least one constraint for every hour in the dataset.

For the simulated market results I have pulled the excel files from the RCC page. Only a couple weeks are available with gaps. Only two days in September 2022, another three in october 2022 and all days between 2022-11-11 and 2022-11-30 and again from 2022-12-11 and 2022-12-25. From 2022-12-11 they are published continuously but with a delay, so hopefully more results for after 2022-12-25 will come available soon.

UPDATE: I later found a bug in the date parsing. So the market results are actually continious starting at 2022-12-11. I have rectified this in the dashboards. For the statistics presented in this post the differences are small so I will leave it as it is. See the update for more recent data in which this bug is also rectified.

## Flowbased Domain Results
So first lets look at the set of Flowbased constraints themselves, called the final domain. It is available from [the beta version of the publication tool](https://test-publicationtool.jao.eu/nordic/), where various parameters are published.  

A couple of remarks can be made from the available final domain. Most basic information is there, the capacity given to the market (RAM) as well as the maximum physical flow (Fmax) and the reference flow (Fref) is given.  
Designations of which constraints are presolved (a subset of constraints which are the ones that are really relevant with all others being less restrictive then this subset) are also available.  
The theoretical ranges of maximum bilateral exchange and net positions published correspond with the domain when I calculated them myselves for a couple of test hours. So the basis is all there which signals a good milestone of a running process.  
On average there are 703 constraints per business hour, however this includes some helpful virtual ones as a summary for borders as well as allocation constraints. Curiously no equality constraints are published for the internal HVDC lines. When doing calculations on the domain I had to add them myself.  
When filtering for only actual CNECs 595 are left on average per business hour, or 14282 per business day. This is split out per TSO in table 1 below.
<figure class="left" style="width:100%">

| TSO | average number of constraints |
|-------|-------|
| Energinet | 155 |
| Fingrid | 107 |
| Stattnett | 149 |
| SvK | 184 |


<figcaption class="center">Table 1: Average number of constraints per business hour per TSO</figcaption>
</figure>
These numbers seem quite low to me and suggest that only a subset of operational CNECs is being used. This is quite normal at the start of conducting parallel runs. 
   
There also some things missing, again to be expected for a beginning phase of a parallel run. No EIC codes are given and many CNEC names look like placeholders. Information about  substations of a constraint is only filled in sparsely.  
Validation corrections for net security are also not present yet.  
Virtual capacities (AMR) are mainly zero, that is quite rare in CORE Flowbased and I am not sure if that is due to not publishing all of them or if they are indeed not needed.

Now to visualize the domain for some quick checks.  
In figure 1 below the average Remaining Available Margin (RAM) is shown per TSO as a percentage of the total capacity possible on a line (Fmax) over all presolved constraints.
{{< plotly json="avg_ram.json" height="400px" caption="Figure 1: Average RAM as percentage of Fmax per TSO per month, presolved domain (figure is interactive)">}}
It seems all TSO's have a quite high average RAM and all above the 70% minimum required from European regulation. I couldn't find any reference to a minimum RAM mechanism as in CORE, but the fact that this quite high average RAM is achieved it seems plausible that one is used, but not published (yet).

In figure 2 below the average reference flow as percentage of Fmax is shown. This is the flow that is already there before the day-ahead market for various reasons.
{{< plotly json="avg_fref.json" height="400px" caption="Figure 2: Average Fref as percentage of Fmax per TSO per month, presolved domain (figure is interactive)">}}
Here some interesting difference can be seen. Apparently Fingrid reports a consistently higher reference flow on average on its CNECs than the other TSOs. I am not expert on the Nordic grid and thus have no idea why. If any Nordic expert is reading this feel free to reach out ;)

This is a highover average, for a look at more detailed average RAM per TSO I have made a dashboard which is automatically updated [here](https://data.boerman.dev/d/ZsMawToVz/nordic-flowbased-parallel-run-domain-results?orgId=1).  
In figure 3 below a live embed is shown.
<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/ZsMawToVz/nordic-flowbased-parallel-run-domain-results?orgId=1&theme=dark&panelId=2" width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 3: Average RAM as percentage of Fmax for the last 30 business days (live dashboard embed, interactive)<figcaption>
</figure>

## Market Simulation Results
The Flowbased domain results are not the only outputs of the parallel run. These capacity results are also used to simulate the market with real market data. From there we can see changes in price results. As outlined above these results are not a big set, only 960 hours are available. These are only the prices and prices spreads, no social welfare analysis is shown. This is available in the reports that are published next to it, but those are only available for two weeks so I have left them out of scope for this post for now.

A simple but interesting visualization is the average price shift between simulations and production. In figure 4 below this is visualized in a map per bidding zone present in the external parallel run. Here you can also see some non Nordic bidding zones. These have interconnections with the Nordic zones and are thus also impacted.
{{<figure src="prices_diff.png" caption="Figure 4: Average difference between simulated prices and production prices per hour over all hours, negative number means a lower price on average in the simulations. All in EUR/MWh" clickable="true">}}

From here it can be seen that Denmark, Netherlands and Germany and the south of Norway have lower prices while the rest has slightly higher prices. This does not mean that the latter do not benefit. These are purely the Day Ahead prices, with the market coupling optimizing for global welfare (both producers and consumers) for all zones summed.

Price shifts are caused by shifts of import/exports. This can be visualized too by looking at the average change in netto position (the sum of all imports and exports of a zone). A negative netto position means net import and a positive number net exports. Thus a negative average difference in netto position means the zone has shifted towards the import direction and vice versa. This visualization is shown in figure 5 below.
{{<figure src="np_diff.png" caption="Figure 5: Average differnce between simulated Netto Position and production Netto Position over all hours, negative number means shift into import direction. All in MWh" clickable="true">}}

From here it can be seen that the higher load zones, the more densily populated areas of South of Norway and Sweden, shifts towards import direction while the more production heavy areas (the north of those counties) shift more to export. This corresponds to the price shifts in figure 4.

A much more interesting indicator however is the price spreads on borders. A more efficient working capacity calculation should result in more price convergence, ie lower price spreads on bidding zone borders. The average difference in price spreads per border is shown in table 2 below.
<figure class="left" style="width:100%">

| Border    | Average Difference | Border    | Average Difference |
|-----------|--------------------|-----------|--------------------|
| NO3-NO5   | -51.92             | SE4-PL    | 0.63               |
| NO1-NO3   | -48.33             | SE4-LT    | 1.03               |
| FI-NO4    | -22.03             | NO1-NO2   | 1.77               |
| NO4-SE2   | -17.99             | FI-EE     | 2.23               |
| NO4-SE1   | -12.04             | DK1-DK2   | 2.33               |
| FI-SE1    | -8.19              | DK1-NL    | 2.57               |
| DK2-SE4   | -7.61              | DK1-DE_LU | 2.66               |
| NO3-SE2   | -6.88              | SE4-SE3   | 2.69               |
| DK1-SE3   | -5.90              | NO3-NO4   | 2.81               |
| SE4-DE_LU | -4.35              | NO1-SE3   | 3.22               |
| NO3-SE1   | -3.74              | NO1-NO5   | 3.64               |
| SE2-SE3   | -3.24              | DK2-DE_LU | 3.75               |
|           |                    | NO2-NO5   | 4.57               |
|           |                    | NO2-DK1   | 5.54               |
|           |                    | NO2-NL    | 6.87               |
|           |                    | NO2-DE_LU | 7.90               |
|           |                    | FI-SE3    | 8.18               |
|           |                    | SE1-SE2   | 9.21               |

<figcaption class="center">Table 2: Average difference in price spread per bidding zone border, averaged over all hours, all in EUR/MWh</figcaption>
</figure>
The table shows a large decrease in average price spread for some borders and a small increase on others, so overall the price convergence seems indeed to be improving when using Flowbased.

Another interesting indicator is the price spread in the whole region. So the difference between the maximum and minimum price for the whole region per hour. In figure 6 this is shown, together with a comparison with production value. The blue bars signal the difference of simulation vs production, so a negative value is a decrease in the spread for that hour. Only the last full block of results is shown here.
<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/_PP3MATVz/nordic-prices-nordics-external-parallel-run-flowbased?orgId=1&from=1670626800000&to=1672095600000&panelId=3" width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 6: Price spread in Nordic region for both simulated and production values, for last continuous range available. All in EUR/MWh</figcaption>
</figure>
The average difference is -34.84 EUR/MWh and in 71% of the shown timestamps the price spread in the simulation results is lower then the prices in production. That is quite a nice result.  
The disclaimer here however is that the timerange is small and more data is needed for a more confident conclusion. But for a first result its encouraging!

The full dashboard for the simulation results I created can be found [here](https://data.boerman.dev/d/_PP3MATVz/nordic-prices-nordics-external-parallel-run-flowbased).

These are all very preliminary statements and more results and indicators are needed to say more about this. Especially the global social welfare change is the best indicator, but data on that is only available very sparsely.

## Whats next?
The publication of these first results are a big milestone for the Nordic Flowbased implementation. It shows they are able to run a stable process and get plausible results from them. Big congratulations to all involved! The planned go live date is somewhere in 2024 Q1 so there is still a year to further flesh things out. In particular I am curious abouet the net security validations and more info about the branches such as eic codes. More social welfare analysis is also crucial to build confidence in that the system really is better and more efficient for society as a whole.  
I will try to repeat this blog post later on this year when more results become available to see where it is going.
In the meantime, as always, if you have any questions or remarks please don't hesitate to contact me, especially if you are a Nordic Flowbased expert ;)
