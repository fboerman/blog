---
title: "Giving back to the python community: my open source packages"
date: 2022-09-01
draft: true
description: "Slightly different then my normal posts, a quick look and highlight of my opensource contributions"
scientific: false
---

We stand on the shoulders of giants is a popular saying in programming and it is absolutely true. None of my work would have been possible without the enormous python open source community. Packages like pandas, numpy, sqlalchemy, psycopg2 and many others I use on a daily basis.   
The basis of open source is of course the people contributing to it, so a while back I have started adding my own little stone in the python open sourcing building. This blog post is slightly different then my usual ones, to highlight some of the python packages that I (co-)maintain.   
For all of them the same applies, if you have any questions, feature requests or additions, please open an issue on github or reach out to me at frank@fboerman.nl.

### entsoe-py
One of the best free sources about the european energy world is the [Entso-E transparancy platform](https://transparency.entsoe.eu/) and fortunately it has an excellent API. Unfortunately its all xml which requires some specific parsing. entsoe-py to the rescue! The package was started by the excellent people over at [EnergieID](https://www.energieid.be/) and implements a wide variety of transparancy endpoints. You can query things from day ahead prices to physical flows to generation output per unit.   

Shortly after I started in my current role at System Operations at TenneT Netherlands I found a feature that I missed and added it myself under [my TenneT account](https://github.com/EnergieID/entsoe-py/commits?author=FrankBoermanTenneT). I then also started to use it for private purposes and have since added [various extra features and bugfixes](https://github.com/EnergieID/entsoe-py/commits?author=fboerman), after I got added as co-maintainer based on my first contributions.

You can find the repo [here](https://github.com/EnergieID/entsoe-py) or install directly via ```pip install entsoe-py``` for the latest version.

Please note that for questions about the data itself and possible issues with them you should always contact the transparancy team themselves at transparency@entsoe.eu 

### jao-py
Another good data source is [JAO](https://jao.eu/). This is more specific data compared to transparancy, mostly to do with flowbased capacity calculations and capacity auctions on borders. Unfortunately there are multiple API's which can be confusing and a bit hard to find and parse. Therefor I created jao-py. It is by no means an exhaustive effort of all JAO has to offer, but it is a start to help you with the most common queries.

The recent go live of CORE flowbased capacity calculation also resulted in JAO switching to a new CORE publication tool. This tool has much better and clearer API and I have started on supporting it in jao-py. I strive to eventually support all endpoints of the publication tool. The CWE utility tool stays supported for historical research (until JAO sunsets it).

You can find the repo [here](https://github.com/fboerman/jao-py) or install directly via ```pip install jao-py``` for the latest version.


### tennet-py
TenneT also publishes some data directly on its website found [here](https://www.tennet.org/english/operational_management/export_data_explanation.aspx), besides publishing a large ammount through the Entso-E transparancy platform. That can be very interesting to analyse so I created tennet-py to pull this in. It currently supports output types of csv xml and pandas dataframe for all published endpoints. These cover mostly balancing related topics such as imbalance price and current status.

You can find the repo [here](https://github.com/fboerman/tennet-py) or install directly via ```pip install tennet-py``` for the latest version.

Please note that although I am a TenneT employee this is made purely in my own time as a hobby and is not officially supported in any way. For support questions about the data and API always contact [the service center](https://www.tennet.eu/contact/).


### My use of the packages
These packages I mainly use to create visualizations and explanations about the electricity world. I strongly believe that as energy professionals it is important to keep explaining this complicated world to non experts and politicians, and these projects enable me to do my contribution to it.

All of my work is published on this blog and crossposted to linkedin. You can also view my live dashboards [here](https://data.boerman.dev/) or my API system with some calculated data [here](https://aten.boerman.dev/).
