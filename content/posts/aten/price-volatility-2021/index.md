---
title: "Aten: introduction and the first plot"
date: 2021-12-13
draft: false
description: "Introduction of my new personal project Aten and a plot about price volatility in the energy day ahead market"
---
As those that I have spoken with personally recently are well aware by now, I am working at TenneT at the System Operation Transport division, mainly on flowbased capacity calculation and bidding zone review topics. I have chosen TenneT because I wanted to play a part in something that both fascinates my and in which I hope to make a small difference for good: the energytransition and the energy market.  
The more I work on it the more I become fascinated by all the intricate details and endless possibilities to analyse it, encouraged by my helpful co-workers. From this fascination a new hobby was born: project Aten. I like to name my projects after greek-roman, old norse or ancient egyptian mythology and this one is named after the [egyptian sungod Aten](https://en.wikipedia.org/wiki/Aten).

### Project Aten: What is it?
Project Aten is a data lake and visualization platform that I am building with all kinds of data from the energy market and energy transition that I find interesting. I am trying to look at both the market part of it (for example day ahead prices) as well as the capacity calculation part (for example the flowbased capacity domain). It is purely a personal project and will only consist of publicly available data, but ideas can (and probably will) come from from my work at TenneT.   
The pipeline of the project will be roughly: data ingestion with python -> PostgreSQL database -> plotting with grafana dashboard or a python plotting library -> live dashboards and occasional LinkedIn posts.  
On top of that I will try to make all underlying aggregated data available in the form of an API.  

### Enough talk, show me!
There will be three places of output from this project. First, the public dashboards can be viewed at [data.boerman.dev](https://data.boerman.dev/). Secondly, the API is available at [aten.boerman.dev](https://aten.boerman.dev/). Lastly, and probably the most visible, I will write occasional LinkedIn posts with attached blog post like these with some more information, you can find (and connect/follow) my profile [here](https://www.linkedin.com/in/frank-boerman-477613164/).

### I have a visualization suggestion!
Great! I always love getting feedback. Be sure to let me know either on LinkedIn (in a post comment or private message) or send me an email, my address can be found [here](https://boerman.dev/contact/).

## First output: Price volatility in DA market for 2021

{{< figure src="heat-map-da-prices-cwe.png" caption="Heat map of day-ahead electricity prices for NL in EUR/MWh (click to enlarge)" clickable="true">}}

So as a first output I created the above plot. It shows a heatmap of the day ahead electricity prices for the NL zone in EUR per MWh. Day ahead means it is the price agreed today for delivery of energy tomorrow, this is done per hour, so there is a so called DA hourly price throughout the day. At the y-axis the time is shown, starting at first January of 2021. At the x-axis the price in EUR.  
This price can actually be negative! Then there are moments that there is so much energy produced that suppliers need to get rid of, that they will pay consumers for taking it. This is a funny and quite unique aspect of the electricity market, owing to the fact that any energy produced needs to be immediately consumed every timeframe to keep the grid in balance and that its not so easy to ramp up or down on many sources. So it can be profitable to pay a consumer to take your produced energy in hour A so you can keep your generation running for hour B when you can turn a profit.  
The last couple of months the electricity market has gone crazy with very high prices, mainly due to very high fuel prices (gas) for big generators. The reasons for high gas prices warrants a whole seperate story so it is not going to be explained here. The heatmap shows not only a much higher average price but also a very high volatility of a market trying to find the sweet spot between high fuel prices for static generators and volatile renewables. Maybe the time is finally there for better flexibility solutions like battery or other forms of storage?

{{< linkedin url="https://www.linkedin.com/posts/frank-boerman-477613164_electricitymarkets-activity-6876499652737421312-9b4j" >}}

{{< ping key="aten1" >}}
