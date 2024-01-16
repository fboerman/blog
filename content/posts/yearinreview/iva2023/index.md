---
title: "Year in review 2023: Flowbased CORE Individual Validations"
date: 2024-01-16
draft: false
description: "Another year is over so time for a year in review series! First up: Individual Validations in CORE"
plotly: true
scientific: true
---
Another year is over and I wanted to write a 'year in review' series about 2023. First up is a look at how different TSOs adjust the Flowbased Domain for net security reasons, the so called Individual Validations or IVA for short.

But first a quick shout out to the sponsor of my database server: [Code Yellow](https://codeyellow.nl/), who have provided me with hosting of my flowbased domain database server. Without them the analysis in this post would be a lot more work, so many thanks!

Disclaimer: this post is quite technical and about a specific capacity calculation topic. I tried to explain it to non experts as well, but you do need a basic idea of the flowbased domain.   
Please note that this post is specifically about the validation results of Flowbased CORE, Nordic Flowbased has of yet no implementation of the validation step.

## What are virtual capacities and individual validations
Virtual capacity is the capacity that a TSOs releases on top of the capacity calculated in the normal capacity calculation to reach regulatory minimum capacity requirements. These requirements are also informally called the "70% rule".  
Ever since the introduction of these virtual capacities the question arose about how to ensure net security for this virtual part. To tackle this the validation step was put into the Flowbased Capacity Calculation methodology. This step allows TSOs to reduce capacity on elements (CNECs) in the domain if **and only if** they can prove that they cannot secure that capacity, even when activating all available remedial actions (RA). Such actions are usually forms of redispatch.  Adjusting a CNEC is called Individual Validation Adjustment, IVA for short.  
The idea behind this is that the non virtual part you get for free, but if the market uses the virtual part it incurs a TSO (and thus societal) cost. This then spurs grid investments to make sure you can reach the target capacity with as little virtual capacity as possible. 

Process wise, the validaton step is one of the last steps in Flowbased, the last being addition of LTnom flows. The validation is called individual and thus is in in principle being run by local tooling individual TSOs. The exception to this will be explained later.  
Stepwise the process to the final capacity is then becomes as follows:
1. Calculate real capacity ($RAM_{init}$)
1. Add virtual capacity until regulatory target ($AMR$)
1. Execute validation and subtract IVAs if needed ($IVA$)

So the final capacity then becomes: $RAM_{final}=RAM_{init}+AMR-IVA$  
Please note that this is a simplified picture of the whole flowbased process, but it explains the IVA flow.


With the rising regulatory targets this validation of virtual capacities becomes more and more important. For more information about these rising targets you can read for example the dutch action plan about this [here](https://www.rijksoverheid.nl/ministeries/ministerie-van-economische-zaken-en-klimaat/documenten/publicaties/2019/12/20/actieplan-verhoging-beschikbaarheid-zone-overschrijdende-transportcapaciteit-elektriciteitshandel).

## IVAs in 2023
So how many hours were actually impacted by such IVAs? In figure 1 below an overview is given over the whole of 2023.

{{<plotly json="fig_overview_donut.json" height="300px" caption="Figure 1: Overview 2023 IVAs" >}}

Here we can see that in only 36% of the time no IVA was applied on presolved or active constraints. This sounds like quite a lot of IVA, but there are big differences between those hours in how much IVA was applied and on how many constraints. Further more not every TSO applies the same methodology, since its a local responsibility. Lets look at these differences per TSO.

## Differences between TSOs: methodologies
So first off the most confusing part of this story: not all *Individual* Validations are actually done *Individual*. The TSOs of Germany, Austria and the Netherlands have decided to work together and have one tool that calculates IVAs for all three countries. This also allows them to apply IVAs on for example German CNECs to solve an overload in NL, which from a social welfare perspective is more efficient. Their tool is called DAVinCy.  
In fact pooling the whole region would be more efficient and this is also forseen in the methodology, the so called Common Validation Adjustment or CVA. This is not implemented yet however, but is actively being worked on. DAVinCy can be seen as a foreruner of this.

Detailed explanations of the methodology of each TSO (including the DAVinCy group) can be found in the appendix of CORE Consultative Group slides of 2023-03-28, starting from slide 41 [here](https://eepublicdownloads.blob.core.windows.net/public-cdn-container/clean-documents/Network%20codes%20documents/Implementation/ccr/2023/28_Jan_2023_Meeting_Presentation.pdf).

So what do these different methodologies mean for the trends of the results?

## Differences between TSOs: occurences
Lets start with looking at the number of hours in which a TSO had at least one active IVA in the presolve domain. In figure 2 below this is shown in both number of hours and percentage of the whole year.
{{<plotly json="fig_hours_count.json" height="400px" caption="Figure 2: Number of hours with IVA per TSO for presolved domain of 2023" >}}

{{< plotly json="fig_num_hours_iva_month_scatter.json" height="500px" caption="Figure 3: Number of hours with IVA per TSO per month of 2023 (presolved domain)" >}}

## Differences between TSOs: size
