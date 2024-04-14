---
title: "Year in review 2023: Day-Ahead market results"
date: 2024-04-14
draft: false
description: "In this second part of my year in review series we take a look at the day ahead market results, specifically prices"
plotly: true
scientific: true
---
A while ago, I [wrote the first part](https://boerman.dev/posts/yearinreview/iva2023/) of my "year in review" series of 2023. In this series, I take a look back at some key indicators of 2023. This series looks at indicators that I find most interesting. Those are also the ones I have the most knowledge about. 

Today, we are going to look at the Day Ahead market results in the CORE region (AT, BE, CZ, DE_LU, FR, HR, HU, NL, RO, SI, SK, PL), with a focus on prices.  
Please note that this is **not** an exhaustive list of all indicators that you can frame a year in. For a more exhaustive look, wait for the TenneT Annual Market Update, to which I also contribute. I will also publish more parts in this series soon.  
If you are a frequent reader of my blog you will recognize some of the ones used in this post, as I reused some ideas from earlier blogs.  
Please note that due to the [aggresive polish allocation constraint](https://data.boerman.dev/d/jS3wx4Q4z/allocation-constraint-pl-statistics?orgId=1), which regularly closes the borders for import and export, Poland has been excluded from all CORE indicators.

## Prices
To start with, in figure 1 below the average hourly price in CORE is shown averaged by month.
{{<plotly json="fig_price_mean.json" height="300px" caption="Figure 1: Average Day Ahead price in CORE (excl. Poland) for 2023" >}}

It is interesting to compare this monthly price average to the same average of previous years. For this analyse,  the data is zoomed out to a 5 year range in figure 2. The dashed red line here is the yearly average.
Here we can see that, while prices have subsided substantially in comparison to the previous year (2022), in a historical perspective they are still high. In fact, the yearly average of 2023 comes at 101.03 EUR/MWh, which is marginally lower than the one from 2021 (107.13 EUR/MWh.) This is even with the somewhat skewed 2021 average towards the gas crisis as prices were already exploding the last months of 2021.

{{<plotly json="fig_price_mean_longer.json" height="400px" caption="Figure 2: Average Day Ahead price in CORE (excl. Poland) for 2018-2023" >}}

Another indicator which is interesting to look at is the average per hour of the day, which results in 24 averages for 2023 and is shown in figure 3 below.

{{<plotly json="df_prices_mean_hour_of_day.json" height="400px" caption="Figure 3: Average Day Ahead price in CORE (excl. Poland) for 2023 per hour of the day" >}}

Here we can observe a clear trend. Prices peak in morning and evening, with a valley during the middle of the day. This is the famous "duck curve" of solar infeed. The duck curve exists because in the hours in which solar infeed is large, during the middle of the day, prices get suppressed by the cheap solar infeed. Then, during the rest of the day, a more expensive generation is activated and the prices bounce back.
The roll out of solar pv panels is now so strong that the effect of solar energy can thus even be seen in all seasons of the year, and not only during summer.
The decrease of the evening peak compared to the afternoon low (something I would like to coin "the duck curve indicator") is a whopping 45.8% for the whole region, as shown in this figure. For specific countries dominated by solar pv infeed this is even more extreme. For example, for Germany, this is 48.8% and for the Netherlands as high as 52.1%!

## Pricespreads
For a larger region, besides the average prices, another interesting indicator is the price spreads per hour within that region. This indicator is defined as the delta between the max and min price within an hour, within a region.  When a price spread is zero it is called full price convergence and thus no grid constraint actively limited the optimal market solution.
First let’s take the monthly average again. This time, for absolute price spreads in EUR/MWh. This is displayed in figure 4 below.

{{<plotly json="fig_pricespread_mean.json" height="300px" caption="Figure 4: Average hourly DA price spread, per month in CORE region (excl. Poland) for 2023" >}}

Except for a peak in January, this analysis does not show any clear trends. When we zoom out in figure 5 below the same trend as with the average prices in figure 2 can be seen, average price spread has dropped only marginally back to the 2021 pre gas crisis level.

{{<plotly json="fig_pricespread_mean_month_longer.json" height="400px" caption="Figure 5: Average hourly DA price spread, per month in CORE (excl. Poland) for 2018-2023" >}}


## Pricespread relative performance
Price spreads in itself don't say that much because it is context dependent on the prices underlying it. A 100 EUR/MWh spread between 10 and 110 is much more impactful than, for instance, between 700 and 800 EUR/MWh.
To better look at the price spread indicator in context, we introduce a new indicator C%. This indicator is defined as the “hourly price spread (percentage) of the mean price in a determined hour”.
Or more mathematically :

$$ C_{\\%}(t) = \dfrac{\overline{P_{spread}(t)}}{\overline{P(t)}}\cdot 100[\\%] $$
in which the $\overline{bar}$ denotes the average over all CORE zones excluding PL at timestamp $t$

Now, let’s revisit the above example for a simple situation of two zones. A 10-110 spread is then expressed as a C% of 167%, while for the 700-800 spread the C% comes down to a mere 13.3%.

Now we apply this method to recreate figure 4 in figure 6 below, in which thus the average relative price spread is show.

{{<plotly json="fig_pricespread_pct_mean.json" height="300px" caption="Figure 6: Average relative price spread, per month in CORE region, (excl. Poland) for 2023" >}}

The result is a quite volatile picture for which I do not have a good explanation. There can be many interplaying factors, including high/low RES infeed as well as changing temporary grid constraints due to outages or maintenance.

A different way to look at this is binning the results over the whole dataset. This results in figure 7 below.

{{<plotly json="fig_spread_pct.json" height="300px" caption="Figure 7: Histogram of relative price spread CORE region (excl. Poland) in 2023" >}}

Here we can see that, in 27% of all timestamps there was full price convergence in the region. In other words, there was a single price in those hours. In another 31.3% of the hours, the price spread was less than 25% of the mean price. Combined, those results  mean that in a little over half of the time (58.3%) the price spreads are less than a quarter of the mean price. This seems a quite good result!  
It also seems to be quite stable, as in my [previous post](https://boerman.dev/posts/flowbased/corepriceconvergence/) for the first year of CORE, which is half 2022 and half 2023, it came out on 55.57%.
I do not compare to pre 2022 levels here given that the CORE region switched capacity calculation halfway through 2022, which has a big impact on price convergence and is thus a biased comparison for market price results.

For the final indicator in this post, figure 8 below shows again the relative price spread, but this time averaged per hour of the day.

{{<plotly json="fig_spread_pct_perhour.json" height="400px" caption="Fgiure 8: Average relative price spread per hour of the day, CORE region (excl. Poland) in 2023" >}}

Here we can see a reversed duck curve! The middle of the day hours have high relative price spread. This is another effect of the solar pv . The mean price may be low, but due to the large differences between zones in terms of installed capacity of solar pv this can cause high price spreads.


This concludes the second post on the "year in review" series. The next parts will focus on market revenues within CORE and zoom in on the Netherlands. Furthermore, soon the TenneT Annual Market update will be published in which some of my indicators will be used. Stay tuned on my linkedin for updates!

 If you have any questions or suggestions feel free to reach out to me on linkedin, twitter (on either search with my real name) or via email at [frank@fboerman.nl](mailto:frank@fboerman.nl).

Disclaimer: all information described in this post is meant for informational purpose. Nor information neither any conclusion written in this post can be taken as an official opinion or position of my employer TenneT in any way, shape or form.
