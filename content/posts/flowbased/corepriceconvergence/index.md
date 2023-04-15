---
title: 'Flowbased: A look at the CORE price convergence since golive'
date: 2023-04-15
draft: false
description: "The go live of flowbased CORE coincided with the worst energy crisis in Europe in a long time. How did the price convergence in the CORE region held up in these circumstances?"
plotly: true
---

<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/E-r9pZc4k/energy-market-day-ahead-analyses-core?orgId=1&from=1654725600000&to=1680299999000&kiosk=tv&theme=dark&panelId=5"  width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 1: DA prices for CORE region, excluding Poland (live dashboard embed, interactive)<figcaption>
</figure>

{{< plotly json="fig_price_mean.json" height="400px" caption="Figure 2: Average DA price per month in CORE region, excluding Poland (figure is interactive)" >}}

<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/E-r9pZc4k/energy-market-day-ahead-analyses-core?orgId=1&from=1654725600000&to=1680299999000&kiosk=tv&theme=dark&panelId=12"  width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 3: mean DA price for CORE region excluding Poland as a heat map<figcaption>
</figure>

{{< plotly json="fig_pricespread_mean.json" height="400px" caption="Figure 4: Average DA price spread per month in CORE region, excluding Poland (figure is interactive)" >}}

<figure class="left" style="width:100%">

<iframe src="https://data.boerman.dev/d-solo/E-r9pZc4k/energy-market-day-ahead-analyses-core?orgId=1&from=1654725600000&to=1680299999000&kiosk=tv&theme=dark&panelId=10"  width="100%" height="500vh" frameborder="0"></iframe>

<figcaption class="center">Figure 5: Price spread in CORE region as heat map<figcaption>
</figure>

{{< plotly json="fig_spread_abs.json" height="400px" caption="Figure 6: Absolute hourly price spreads in CORE region excluding Poland, binned in categories." >}}

{{< plotly json="fig_spread_pct.json" height="400px" caption="Figure 7: Hourly price spreads in CORE region excluding Poland, relative to hourly mean price, binned in categories." >}}
