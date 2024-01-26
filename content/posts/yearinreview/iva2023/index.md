---
title: "Year in review 2023: Flowbased CORE Individual Validations"
date: 2024-01-23
draft: false
description: "Another year is over so time for a year in review series! First up: Individual Validations in CORE"
plotly: true
scientific: true
---
Another year is over and I wanted to write a 'year in review' series about 2023! First up is a look at how different TSOs adjust the Flowbased Domain for grid security reasons, the so called Individual Validations or IVA for short.

But first a quick shout out to the sponsor of my database server: [Code Yellow](https://codeyellow.nl/), who have provided me with hosting of my flowbased domain database server. Without them the analysis in this post would be a lot more work, so many thanks!

Please note that this post is quite technical and about a specific capacity calculation topic. I tried to explain it to non experts as well, but you do need a basic idea of the flowbased domain.   
This post is specifically about the validation results of Flowbased CORE, Nordic Flowbased has of yet no implementation of the validation step.


## What are virtual capacities and individual validations
Lets start with an introduction to the topic. Experts can skip this part.  
Virtual capacity is the capacity that a TSOs releases on top of the capacity calculated in the normal capacity calculation, to reach regulatory minimum capacity requirements. These requirements are also informally called the "70% rule".  
Ever since the introduction of these virtual capacities the question arose about how to ensure grid security for this virtual part. To tackle this the validation step was put into the Flowbased Capacity Calculation methodology.   
This step allows TSOs to reduce capacity on elements (CNECs) in the domain if **and only if** they can prove that they cannot secure that capacity, even when activating all available remedial actions (RA). Such actions are usually forms of redispatch.  Adjusting a CNEC is called Individual Validation Adjustment, IVA for short.  
The idea behind this is that the non virtual part you get for free, but if the market uses the virtual part it incurs a TSO (and thus societal) cost. This then spurs grid investments to make sure you can reach the target capacity with as little virtual capacity as possible. 

Process wise, the validaton step is one of the last steps in Flowbased, the last being addition of LTnom flows. The validation is called individual and thus is in in principle being run by local tooling of individual TSOs. The exception to this will be explained later.  
Stepwise the process to the final capacity then becomes as follows:
1. Calculate real capacity ($RAM_{init}$)
1. Add virtual capacity until regulatory target ($AMR$)
1. Execute validation and subtract IVAs if needed ($IVA$)

So the final capacity then becomes: $RAM_{final}=RAM_{init}+AMR-IVA$  
Please note that this is a simplified picture of the whole flowbased process, but it explains the IVA flow.

With the rising of regulatory targets this validation of virtual capacities is becoming more and more important. For more information about these rising targets you can read for example the dutch action plan about this [here](https://www.rijksoverheid.nl/ministeries/ministerie-van-economische-zaken-en-klimaat/documenten/publicaties/2019/12/20/actieplan-verhoging-beschikbaarheid-zone-overschrijdende-transportcapaciteit-elektriciteitshandel).

### Remarks on the data
The dataset spans the whole of 2023, so a total of 8760 hours. At two days this year Elia had an exceptional unintended fallback causing a very distorted picture on IVAs. For this reason, Elia IVAs for the full day of 2023-04-19 as well as hour 11, 12 and 13 of 2023-08-21 have been filtered out. More information about the first day can be found in my post [here](https://boerman.dev/posts/market20230419/).

Now that the topic and data remarks are introduced, lets get into the analysis.
## IVAs in 2023
As a start, how many hours were actually impacted by such IVAs? In figure 1 below an overview is given over the whole of 2023.

{{<plotly json="fig_overview_donut.json" height="300px" caption="Figure 1: Overview 2023 IVAs" >}}

Here we can see that in only 36% of the time no IVA was applied on presolved or active constraints. This sounds like quite a lot of IVA, but there are big differences between those hours in how much IVA was applied and on how many constraints. Further more not every TSO applies the same methodology, since its a local responsibility. Lets look at these differences per TSO.

## Differences between TSOs: methodologies
So first off the most confusing part of this story: not all *Individual* Validations are actually done *Individual*. The TSOs of Germany, Austria and the Netherlands have decided to work together and have one tool that calculates IVAs for all three countries. This also allows them to apply IVAs on for example German CNECs to solve an overload in NL, which from a social welfare perspective is more efficient. Their tool is called DAVinCy.  
In fact pooling the whole region would be more efficient and this is also forseen in the methodology, the so called Common Validation Adjustment or CVA. This is not implemented yet however, but is actively being worked on.

As mentioned each TSO is responsible for their own validation. Except for the common DAVinCy group, all CORE TSOs have thus developed their own methodologies of validation. Detailed explanations of these methodologies of each TSO (including the DAVinCy group) can be found in the appendix of CORE Consultative Group slides of 2023-03-28, starting from slide 41 [here](https://eepublicdownloads.blob.core.windows.net/public-cdn-container/clean-documents/Network%20codes%20documents/Implementation/ccr/2023/28_Jan_2023_Meeting_Presentation.pdf).
Explaining each of them is outside the scope of this post. Instead this post will focus on the trend differences among TSOs.

## IVA trends between TSOs: number of occurences
Lets start with looking at the number of hours in which a TSO had at least one active IVA in the presolved domain. In figure 2 below this is shown in both number of hours and percentage of the whole year.
{{<plotly json="fig_hours_count.json" height="400px" caption="Figure 2: Number of hours with IVA per TSO for presolved domain of 2023" >}}
Here we can see that there is a clear trend difference between the top 3 TSOs RTE, SEPS and Transelectrica and the rest. These three apply IVAs in many more hours, RTE even applies them in almost 1/3 of all hours.

When this is divided per month this trend is visible, but also a second one emerges. This is shown in figure 3 below.
{{< plotly json="fig_num_hours_iva_month_scatter.json" height="500px" caption="Figure 3: Number of hours with IVA per TSO per month of 2023 (presolved domain)" >}}
Here it can be seen that Transelectrica applies more at the first half of the year, while RTE has them more in the second half of the year. All the other TSOs have less clear trends, with flare ups through out the year.

## IVA trends between TSOs: sizes
So lets now take a look at the sizes of IVAs. To make the comparison between CNECs fair, this is expressed as a % of the maximum thermal flow on an element (Fmax). Please note that due to negative reference flows it is possible to have an IVA which is > 100% of Fmax. This is a fairly uncommon case. In 2023 only the DAVinCy group applied such IVAs.  
All presolved domain IVAs are shown in a boxplot in figure 4 below. Each dot next to the boxplot is a datapoint in the set.
{{<plotly json="fig_box_iva_pct.json" height="500px" caption="Figure 4: Average IVA as % of Fmax per TSO over whole of 2023 (presolved domain) Hover to see quartiles" >}}
From here clear differences can be seen. CEPS, Mavir, DAVinCy and RTE apply fairly large IVA's. CEPS has a median of almost 40% of Fmax, but that is based on very few applications. Mavir, DAVinCy and RTE have a median of around 20%, with DAVinCy having a quite large spread outside of their box. Elia has this spread too, but their median is quite low.  
So again there is a group of about three TSOs which are scoring higher then the rest on this indicator.

This indicator too can be split out per month, as shown in figure 5 below.

{{< plotly json="fig_avg_iva_pct_month_scatter.json" height="500px" caption="Figure 5: Average IVA as % of Fmax per TSO per month of 2023 (presolved domain)" >}}
Here no clear trend can be seen. The only thing that stands out, is that the high spread of Elia is apparently caused by IVA spikes in February and August.

# Conclusion of trends
So is there an overall trend to be concluded?   
Its clear that there are major differences in when and how much IVAs are applied across TSOs. Their statistics are summarized in table 1 below. This is the table form of figure 2 and 4.
 
<figure class="left" style="width:100%">

|       TSO      | #CNECs | mean IVA<br/>(%Fmax) | min IVA<br/>(%Fmax) | median IVA<br/>(%Fmax) | max IVA<br/>(%Fmax) | #hours | % hours of year |
|:--------------:|--------:|----------------------:|---------------------:|------------------------:|---------------------:|--------:|----------------:|
|      CEPS      | 10.0    | 40.23                 | 27.09                | 38.92                   | 51.66                | 10      | 0.11            |
|     DAVinCy    | 1733.0  | 28.45                 | 0.05                 | 19.96                   | 142.62               | 218     | 2.49            |
|      ELES      | 198.0   | 5.18                  | 0.09                 | 4.46                    | 20.56                | 155     | 1.77            |
|      ELIA      | 397.0   | 17.10                 | 0.60                 | 6.17                    | 99.06                | 277     | 3.16            |
|      HOPS      | 194.0   | 4.95                  | 0.08                 | 3.65                    | 30.21                | 181     | 2.07            |
|      MAVIR     | 408.0   | 16.75                 | 0.29                 | 16.46                   | 55.16                | 249     | 2.84            |
|       PSE      | 700.0   | 10.30                 | 0.07                 | 6.21                    | 36.19                | 339     | 3.87            |
|       RTE      | 2949.0  | 22.24                 | 0.03                 | 21.72                   | 55.38                | 2450    | 27.97           |
|      SEPS      | 3330.0  | 6.43                  | 0.07                 | 5.28                    | 30.01                | 2232    | 25.48           |
| TRANSELECTRICA | 3602.0  | 10.51                 | 0.08                 | 8.75                    | 73.40                | 1804    | 20.59           |

<figcaption class="center">Table 1: statistics overview of CORE Flowbased IVAs in 2023 per TSO</figcaption>
</figure>

From this table 1 the TSOs can be categorized along the axis of number hours and the median IVA (expressed as % of Fmax). This is plotted in figure 6 below. CEPS is quite an outlier of being very little hours and very high median IVA % so is excluded from the graph for readability.

{{< plotly json="fig_scatter_tso.json" height="400px" caption="Figure 6: Summary of TSO trends for IVAs in 2023 (CEPS excluded as outlier)" >}}

From figure 6 four catagories of trends can be concluded:
1. RTE has a high number of hours with also a high median IVA value
2. Transelectrica and SEPS have a high number of hours but low median IVA value
3. ELES, HOPS, Elia and PSE have lower number of hours and low median IVA value
4. DAVInCy group, MAVIR and CEPS (last one not shown) have low number of hours but high median IVA

There are a couple of important things to note with this trend conclusion:
- there is no right or wrong here, individual validation is a tailored process to each grid. There are multiple ways to handle the validation and its the individual responsibility of each TSO
- there is a small bias here to larger TSOs. Larger TSOs have more CNECs and have thus a larger chance of being presolved and needing to apply IVAs. 

So that concludes this first post in the "year in review" series. More to follow later this year!  
 If you have any questions or suggestions feel free to reach out to me on linkedin, twitter (on either search with my real name) or via email at [frank@fboerman.nl](mailto:frank@fboerman.nl).

Disclaimer: anything in this post is meant for informational purpose, written by somebody working on the topic. Nothing in this post can be taken as an official opinion or position of my employer TenneT in any way shape or form.

