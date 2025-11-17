---
title: 'Opinion: Why Single Market Coupling Operator is a good thing'
date: '2025-07-14'
description: 'It has been talked about for quite some time and the European Commission is also looking into it now. An opinion post about why I am in favor of reforming SDAC into having a Single Market Coupling Operator (SMCO)'
plotly: false
scientific: false
draft: true
---

Recently most of my posts are more explanatory and based on data analysis and visualization. While I enjoy creating them, one of the reasons I started this blog is to also share more of my own thoughts and opinions. So today I will write a first opinion piece on some of my personal opinion surrounding the organization of the coupled markets in the EU, SDAC and SIDC. This post is thus more opinion based instead of purely fact based. If you disagree I would love to hear from you!  
Two remarks before I start. First, the regulatory situation on this is currently under heavy discussion. When I use the word "currently" I mean at times of writing. Second, please note that anything in this post is my personal opinion and does not represent in any way the views of my employer TenneT.

# Current Situation
The market coupling in the EU has come a long way. For day-ahead it started in 2014 in North-Western Europe, it has involved to be a fully coupled market called [SDAC](https://www.nemo-committee.eu/sdac) since 2021. The market clearing of SDAC is governed by the EUPHEMIA algorithm. This algorithm is developed, owned and operated by the PCR (price coupling region) power exchanges (NEMO's). This means they also run the daily operations. On a rotating basis one NEMO is in the lead while the others verify its outputs.  
For intraday markets the [SIDC](https://www.nemo-committee.eu/sidc) coupling started in 2018 through the XBID platform and has expanded since, including the whole EU by 2022. The XBID system is owned and operated by Deutsche Börse.

{{< details title="Who are PCR NEMO's">}}
Currently there are 8 members of the PCR group: EPEX, Nordpool, GME, OMIE, HENEX, OPCOM, OTE, TGE
{{< /details >}}

# Problems with the current setup
There are many angles to look at the current organization structure. In my eyes there are currently three major issues.  
First there is the problem of intellectual property. Because EUPHEMIA is owned by the NEMO's, its outputs are too. This creates issues with data transparency. Some data is published on the ENTSO-E transparency platform (ETP), namely netpositions and day ahead prices. But specifically those data items come with a special legal license and are often delayed in publication for various zones. Bid curves and other such details are not published on the ETP at all. Bid curves are sometimes available for the last 2 businessdays on the website of some NEMO's, but not all. Some NEMO's only provide them as static pictures in a PDF. For EUPHEMIA usage in the intraday auctions the situation is even worse. Results are scattered across NEMO's websites, with various levels of access and nothing on the ETP.  
As a trader or researcher you can actually buy the results from the NEMO's. This solves the mentioned issues, you get more details and with more reliable interface. But this is very very expensive and you have to buy licenses of multiple NEMO's to gather data from all the zones.    
A similar problem occurs in intraday. In fact it is even worse, no XBID data is public. It needs to be bought from the NEMO's and you only get the trade information for their own orderbooks.  
This hinders market transparency and access for researches and new market players.

Second, if you want to become a NEMO you need to go through a lot of difficult legal steps to negotiate with all the different NEMO's. This creates high barriers for new players with possible new innovations to come in. As far as I know only two have even tried in recent years. NASDAQ tried in the nordic area, but gave up after a while, selling the assets they did establish to nordpool. ETPA has entered in Netherlands and Germany in intraday and is currently moving to day-ahead as well. They have commented many times in public how difficult this was and that they had the feeling they got obstructed by the existing club of NEMO's. They probably only managed after some significant regulatory pressure.  
This has thus resulted in a small number of NEMO's. And even this number is a bit misleading, from a technical innovation perspective there are only 6 truly seperate systems, everyone else licenses one of these. These are EPEX, Nordpool, GME, OMIE, HENEX and the new ETPA.

Third, the governance. The market operation is in the conflicting situation of being governed by a group of parties that have to work together, while at the same time also compete with eachother. This does not foster the best environment for cooperation and creates possible conflict of interests. This stretches beyond the NEMO's. Grid operators (TSO's) also have to work in this governance together with the NEMO's. While thus far this has gone well in terms of results, the difference between all these parties and the growing number of market zones that are being coupled creates a risk that the system becomes ungovernable in the long run. The ship becomes too large and inefficient to steer, to say it in more visual terms.
