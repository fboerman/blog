---
title: 'Flowbased Tutorial: CNECs and Active Constraints and how to analyse them'
date: 2025-11-17
description: 'A short explanation on some of the key concepts of flowbased, how does the domain look like and what are CNECs and active constraints? And how can you analyse them?'
plotly: false
scientific: true
---
The flowbased capacity calculation system as a whole, and the domain specifically, can be pretty daunting to people who are just learning about it. Today I wanted to give a short introduction on some key concepts. Next to that I will present some analysis methods of the active constraints. Please note that I will assume some basic linear algebra optimization knowledge throughout this post.  
This post is partly based on the great work by my Hungarian collegues of MAVIR in their eCIGRE paper, [reference 11358-2024](https://www.e-cigre.org/publications/detail/c5-11358-2024-introduction-of-the-operational-core-day-ahead-flow-based-capacity-calculation-and-market-coupling-through-active-constraints-and-price-spread.html). MAVIR has very knowledgeable flowbased experts and are quite well known in the small flowbased community, especially through the huge amount of work moved by Ferenc Nagy.

# What is a Flowbased Domain
In essence a flowbased domain is a linear algebra matrix that describes a linear constraint problem. In this matrix the rows are grid constraints, so called CNECs, and the columns are the sensitivies to the choice variables in the market algorithm: the netpositions of all hubs.  
The reason this was invented is that if you describe your grid constraints as such a matrix, you can encode the dependencies of netpositions in your grid constraints. This is in sharp contrast to the old way of capacity calculation: the **N**et **T**ransfer **C**apacity, or **NTC**. This is a simpler method, in which each border direction has a single capacity value. If a TSO needs to calculate this NTC, it goes through various scenarios and then has to take a value which is safe in all likely scenarios, usually the lowest out of all. But this results in capacities that are independent of eachother, while in the real world these are connected. For example if Belgium is exporting a lot it could be possible that the Netherlands can import more. In Flowbased you can express this in the constraint matrix, thus enabling more capacity possibilities to be released to the market, enabling more welfare.

It is good to remember that the reason flowbased uses a linear algebra domain is that the *whole* of euphemia, the day ahead market algorithm, is a huge linear algebra optimizer. Literally *all* inputs to the day ahead market are converted in a similar form such that euphemia can do its optimizations.

So what does this look like? Each row signifies a grid constraint, more on this later, and each column is a sensitivity to a certain zone. These sensitivities are called **P**ower **T**ransfer **D**istribution **F**actors, or **PTDF**s. If a certain constraint has a PTDF of +0.1 to zone A it means that 10% of any export (defined as positive netposition) of zone A is *loaded* on this constraint.  Any import (defined as a negative netposition) then *relieves* this constraint. If the PTDF is negative this efect is the other way round. The sum of the contributions of all zones then needs to be lower or equal to the capacity released on this constraint. This capacity is called **R**emaining **A**vailable **M**argin or **RAM**. In mathematical form this then becomes:
$$ \sum_{i=1}^N PTDF_i \cdot NP_i \leq RAM $$
in which N is the total number of zones and this equation is repeated for **all** constraints in the domain.  
In addition to this, in order to not create or lose energy out of nothing, all net positions need to sum to zero:
$$ \sum_{i=1}^N NP_i = 0 $$

# What is a CNEC
So what are these constraints exactly? A **CNEC** stands for **C**ritical **N**etwork **E**lement **C**ontingency. This is an element (can be a line, can be something else) that is monitored, in the situation of an outage of a different element. This outage element is also called *the contingency*. Each row in the domain is a CNEC, and next to what element is being monitored, it has the following important properties:
* Direction: monitoring element AB from A to B is different then from B to A
* PTDFs: The sensitivities to each zone
* RAM: The capacity that is calculated to be available in this situation

# What is RAM
The **R**emaining **A**vailable **M**argin, or **RAM**, is the capacity that is available on a CNEC for the market algorithm. The RAM formula starts from the maximum physical capacity and then subtracting flows that are used for other various reasons. These flows are:
* $FRM$: A safety margin of 10%, this is done because of the many assumptions needed in the process and is set the same percentage for all CNECs
* $F_{uaf}$: Forecasted flow of commercial exchanges from/to outside of the flowbased region, this cannot be influenced by the flowbased system so this capacity is reserved
* $F_{0all}$: A flow that mainly consists of internal flows and is there because of physical reasons in the grid model. This is calculated by shifting all netpositions in the grid model to zero and check what is left on all the monitored elements.
* $F_{LTN}$: A flow that is caused by the physical long term transmission rights. These are barely used anymore and thus is very small. It is outside of the scope of this post to explain in more detail.

In addition to these, a form of virtual capacity is introduced due to European regulations. Virtual capacity is capacity that in principle does not exist, but if used is safeguarded by TSO actions (so called **R**emedial **A**ctions or **RA**), which come at a cost. Examples are redispatch (turning generation units up and down inside a zone) or counter trading (rolling back trade across a border). These actions come with a cost, but the idea behind the rule is that the welfare created by more cross border trade is more than the cost of these RA.  
The size of virtual capacity needed is outside of the scope of this post, but the general idea is as follows. First the capacity domain is blown up by adding virtual capacity to get to a certain regulatory mandated goal. Second TSOs can cut back these capacities through a validation phase, **if and only if** they can show they do not have enough RA available to safeguard those virtual capacities.

This then causes two extra terms for the RAM formula:
* $AMR$: the virtual capacity itself, this is *added* to the RAM
* $IVA$: the validation reduction from TSOs, this is *removed* from the RAM

All together the formula for RAM then becomes:
$$ RAM = F_{max} - FRM - F_{uaf} - F_{0all} - F_{LTN} + AMR - IVA $$

# What is Active Constraint
Next to the netpositions and prices the day ahead market algorithm also spits out some usefull flowbased indicators in the form of **A**ctive **C**onstraints or **AC**. These are the constraints that the algorithm identified as actively limiting the possibility for more market welfare. These AC are rows in the flowbased domain and have an attached so called *shadow price*. There are a couple of important things to keep in mind with these AC.

First of all, we can identify these constraints ourselves, by calculating the loadings of all the constraints by taking the vector of Core (not SDAC!) netpositions (the market result) and calculating the sum described in the first equation of this post. All constraints which have a loading equal to their $RAM$, in other words no RAM is left, are then your active constraints.

Second, the shadow price name is a bit unfortunate naming. It actually comes from pure mathematical theory about linear algebra optimizations. A shadow price is defined as the "<u>change in the objective function optimal value if the constraint was relaxed with one unit</u>". In other words, this **is NOT a price in the context of day ahead prices**. This is a very common misunderstanding.  
So what is this shadow price in our context of the day ahead market? We just have to fill in the definition, the objective function of euphemia is global welfare measured in EUR, and the unit of constraint is the RAM measured in MW. So the global welfare in EUR that would have been possible with 1 MW more RAM on this constraint. Hence why the shadow price unit is defined as EUR/MW.   
It is important to stress that a shadow price is *only* valid for that first unit, so the first 1 MW. If an AC is relaxed with 2 MW it is possible that a different constraint becomes active!  
The other important part is that the shadow price is heavily influenced by the market conditions. If you would run euphemia with the exact same flowbased domain, but different bids, you would get different shadow prices and active constraints.

# Analyse Active Constraints
So what can we actually do with these active constraints?  
First of all they make it possible to identify which grid elements are the most important limitations (in the context of the day ahead market) over longer time. This can help modelers and TSOs to better align their proccesses, and in the case of the latter possibly with grid investment decisions. The shadow price, while not fully comparable from day to day, can help further shift which elements are more or less important.

Second it is possible to decompose the PTDFs and the abstract shadow prices into a more intuitive contribution to price spread per border, as described in the last part of the eCIGRE paper, [reference 11358-2024](https://www.e-cigre.org/publications/detail/c5-11358-2024-introduction-of-the-operational-core-day-ahead-flow-based-capacity-calculation-and-market-coupling-through-active-constraints-and-price-spread.html). This means that it is possible to calculate per active constraint how much it increased or decreased the price spread on a specific border.  

This decomposition comes from the general formula that gives the relation between price spread and shadow prices, which is as follows:

$$ \alpha \cdot (P_z - P_y) = \sum_k (PTDF_{y,k} - PTDF_{z,k}) \cdot \texttt{shadow_price}_k $$
 for each active constraint k *within the same market time unit*, which at time of writing is 15 min, for the price spread between zones $z-y$.

The $\alpha$ is the alpha factor from euphemia, this denotes how much of the flowbased domain and how much of the LTA domain was used. Explaining the details of this is outside of the scope of this post, but it is good to know that $\alpha=1$ means the market clearing point is fully inside the flowbased domain, which is usually (but not always) the case these days.

So in other words, if we want the price contribution $P$ for a certain active constraint $k$ on border $z-y$ (the border direction doesn't matter as long as you put the signs correctly!)   
we can get this by:

$$ P_k^{z-y} = (PTDF_{y,k} - PTDF_{z,k}) \cdot\texttt{shadow_price}_k $$

or if we want to better compare over longer timeframes we can express it in the relative contribution $Prel$, corrected for the alpha factor, by doing:

$$ Prel_k^{z-y} = \frac{(PTDF_{y,k} - PTDF_{z,k}) \cdot\texttt{shadow_price}_k}{\alpha \cdot (P_z - P_y) } $$


# Wrap up
I hope after reading this you will find the flowbased domain less complicated and scary than most people think. If you break it down in its most basic building blocks it can be intuitive and  there is a kind of beauty in it. I hope this post has contributed to further understanding on this.  
I have worked out the active constraints analysis in a small interactive webapp which can be found here: [https://active-constraints.coreflowbased.eu/](https://active-constraints.coreflowbased.eu/), which you can use to view historical data on this indicator.  
I marked a couple of things out of scope in this post and I hope I can get around to explaining these concepts further in future posts.

In the meantime if you have any questions or remarks feel free to drop a comment on linkedin or reach out to me [over email](mailto:frank@amunanalytics.eu).

Again huge shoutout to my Hungarian collegues of MAVIR for writing their awesome paper. If you want more introductions to flowbased [go read it](https://www.e-cigre.org/publications/detail/c5-11358-2024-introduction-of-the-operational-core-day-ahead-flow-based-capacity-calculation-and-market-coupling-through-active-constraints-and-price-spread.html)!

# Disclaimer
There is one exception in which the formula for the active constraint does not hold, and that is the Polish allocation constraint. Technically this has a shadow price, and thus price spread contribution, too. If you look at the Polish borders and find a gap between the alpha corrected price gap and the sum of all contributions, then this gap is the contribution of the allocation constraint. This only goes for the Polish borders and only when the allocation constraint is actually active.
