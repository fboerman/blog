---
title: "Graduation project part 2: De-Dispersion"
date: 2019-12-22
draft: false
description: "In part 2 of the series about my graduation project we dive into the algorithms of de-dispersion"
scientific: true
---

# Introduction
This second post of the series about my graduation project focusses on the De-Dispersion methods that are considered and their algorithms. These build on the models presented in [part 1](/posts/graduation/pulsars/). Equation numbers are numbered through in all parts, so references can be towards part 1.

# Coherent versus In-Coherent De-Dispersion
De-dispersion is the process of reversing the effects of frequency dispersion of a signal, in this case the signal of a radio pulsar transmitted through the ISM.  
The two models presented in part 1 with equation (2) and (4) can each be used as the basis for a de-dispersion method.  

In the first method (so called in-coherent de-dispersion) the time shift per frequency channel is calculated with (2). Then this time shift is applied to the whole channel time series. This successfully removes the dispersion between the channels. The advantage of this method is that it has a relatively low computational intensity, which is an important factor due to the scale of pulsar observations. The disadvantage of this is that only the dispersion *between* the channels is negated, but there is still dispersion left *within* the channel. Especially for low frequencies and/or high $DM$'s this dispersion can still be very significant [1].  

In the second method (so called coherent de-dispersion) the transfer function of (4) is used. Here the input signal is convolved in the time domain with the inverse of the transfer function (4). Since this is a phase only filter this convolution needs to be done on the complex input signal, so before the traditional squaring of the signal done by telescope systems, due to needing the phase information. Using the Convolution theorem [[wiki]](https://en.wikipedia.org/wiki/Convolution_theorem) convolution in the time domain is element wise multiplication in the frequency domain. So the high level flow of coherent de-dispersion then becomes:
{{< figure src="img/dedispersionflow.svg" caption="Coherent de-dispersion flow diagram" >}}
In general coherent de-dispersion is more computational and hardware intensive. Both in higher data rate due to needing the full complex signal, as well as computational intensity due to using convolution instead of simple multiplication in time domain.

# Pulsar search
Now lets take a step back and look at the ultimate goal: searching for pulsars. Summarizing from part 1, pulsars are fascinating objects and very valuable for physics research. Observations of them are hampered by the effect of frequency dispersion. This dispersion can be modelled and removed with help of these models. However these require knowing the correct parameter $DM$ for a certain observation. This is not known beforehand and its possible range is vast. Therefor a big part of pulsar search in terms of de-dispersion converges on brute forcing many trails of $DM$'s to find the correct one, if there is a radio pulsar present in the data.  
These $DM$ trails are completely independent of each other and over large ranges. There are some proven bounds on the possible range of $DM$ depending on the direction in the galaxy[3], but the search space is very large, depending on the step size between trails. In the below figure the $DM$'s of known pulsars are plotted versus their rotation period $P(s)$. It's colors correspond to different projects that discovered these radio pulsars. Both axis are a logarithmic scale, showing the vast range of possibilities.
{{< figure src="img/dm-spread.png" caption="Spread of $DM$ of known radio pulsars with their rotation period $P(s)$" >}}

Doing one $DM$ trail reveals nothing about the direction of the correct $DM$. If it is close to the correct one it *is* possible to see some pulse emerging, it can not be seen  if the $DM$ should be higher or lower. To see if the trail has succeeded can be done by visual tools or by automated systems. This *pulsar candidate selection* is in itself a huge field of research, which this project will not touch. Recent advancements include for example the use of neural networks [2].  

The two main methods of de-dispersion each have their own trade-off. Coherent is more accurate but more computational intensive, incoherent vice versa. Combining these can help negate their draw backs. By using coarse grained trails of incoherent de-dispersion and then switching to fine grained de-dispersion when a pulse seems emerging the drawbacks of the two models can be negated. This is called semi-coherent approach.  
Below figure shows the smearing due to the combined effects of dispersion within a channel, finite time resolution, and finite DM steps over the full band-width, as a function of DM. Taken from figure 3 in [4]. This illustrates the combined coarse and fine grained de-dispersion, which results in the seawaves like line of semi-coherent. This shows that by combining the methods, de-dispersion can be performed, with less computational intensity.  
{{< figure src="img/semi-coherent.png" caption="smearing in semi-coherent dedispersion (figure 3 from [4])" style="width:75%" >}}  
This project will further focus on the computational intensitive coherent de-dispersion and its performance.


# Coherent Dispersion Measure Trials (cdmt)
The Coherent Dispersion Measure Trails is an algorithm implementing the coherent de-dispersion method as a convolving synthetic filterbank, that de-disperses with as high as possible throughput of $DM$'s [4]. By splitting the input into independent parts and then utilizing a heavily parallelized computation platform (in the original paper a GPU, or graphics card in popular culture) a high throughput is obtained.  
As introduced before, the observations are split into multiple frequency bands. This is done at the telescope input and has nothing to do with the algorithm itself. This first split is thus a split in the *frequency domain*. The algorithm itself splits the timeseries of a single channel into blocks, this second split is a split in the *time domain*. This is an important distinction to keep in mind.  

To describe the algorithm some parameters need to be introduced, there are $n_s$ input frequency channels, $n_c$ blocks in the timeseries of size of $N\_{bin}$ samples with $n_d$ samples overlap per block. This means that each block has $NN=N\_{bin}-n_d$ unique samples. These settings are used in $n\_{DM}$ trails.    
$N_{bin}$ is also the FFT size, thus this influences the frequency resolution of the Fourier transform. Each split block in a timeseries of a channel has $n_d$ samples overlap according to the *overlap-save* method [[wiki]](https://en.wikipedia.org/wiki/Overlap%E2%80%93save_method) to prevent pollution by the wrap around region of the Fourier transform. The amount of overlap $n_d$ for fully preventing pollution is based on the sample rate of the input and the dispersion sweep within the channel. However to vastly reduce complexity and make the operations more efficient a fixed $n_d$ will be used. This will reduce the efficiency of the algorithm, but makes the time series blocks fully independent from eachother and thus better parallelizable.  

In the original description of cdmt [4] the parameters are chosen for optimal use with the LOFAR [5] telescope system. This means $N\_{bin}=2^{16}=65536$ (or $64k$) and $n_d=2^{11}=2048$ (or $2k$). To compare the results of the final implementation fairly, these parameters are also used throughout this project.     
The $n_c$ depends on the total length of the timeseries $N$ that the algorithm runs on. Then it becomes $n_c=\dfrac{N}{NN}$, $n_c$ needs to be an integer so $N\\%NN==0$.  
For the Fourier transform the FFT algorithm [6] is used in its radix-$2^2$ form. More on this in later parts.  
For the actual dedispersion the transfer function from (4) is inverted by substituting $i$ with $-i$ and then combined with a so-called taper function. This taper function has some anti-aliasing properties but has no real effect on the transform itself. This combination is called the *chirp function*.

For any given $DM$ the algorithm thus goes through the follow steps for a single frequency channel:  
1. Read the timeseries of the target frequency channel and chop it into $n_c$ blocks of length $N\_{bin}$ with overlap $n_d$ according to the *overlap-save* method.

1. Compute the chirp function for the given $DM$ with length $N\_{bin}$

1. For each block $n^i_c$ do:
    1. convert $n^i_c$ to the frequency domain by computing the FFT
    1. multiply the chirp function with the result of the FFT (so in the frequency domain)
    1. convert back to the time domain by computing the IFFT of the result of the previous step
    1. cut off the overlap padding from the block

1. Append all resulting blocks together to get the final output signal



# Synchronous Dataflow
As mentioned in part 1, the design will be done using Synchronous (or static) Dataflow (SDF) in the library StaccatoLab (embedded in python) created by [Kees van Berkel of the TU/e](https://www.tue.nl/en/research/researchers/kees-van-berkel/) who is my graduation supervisor. This means that this project is a form of Dataflow programming.    
Broadly speaking there are two trends to use dataflow programming in computer science.  
The first and most used one is to use it to model the flow and dependencies of asynchronous models. This can for example be used to identify bottle necks in platforms with multiple calculation units that need to exchange data. But also algorithms and processes with more general parallel behaviour can be modeled.  
The second trend extends this and uses dataflow to do actual programming that can be executed with actual data, instead of only abstract flow. In other words when the dataflow graph is executed with real input data, real output data (as opposed to abstract observations) is the output. So the full model is actually executed with data instead of only as an abstraction to analyse its flow. This will be the method used in this project.  
Further implementation details can be found in the StaccatoLab docs [9], but for a basic understanding of the to be presented dataflow graphs the following rules summarize the specific model used in StaccatoLab:  
* A dataflow graph consists of nodes, that execute actual actions on the data, edges that connect the nodes, in the form of queues, and tokens that flow through the graph according to its rules, consisting of certain data. Execution of a node is also called *firing*.
* Each node is *self-timed*. This means that a node can fire immediately when there are sufficient tokens on each of its input edges
* A graph is clocked, so the firing of firable nodes is synced globally. In practise this means that time is an integer and that a firing can only occur on a multiple of an integer.
* Only one output token per firing: at most one token is produced per output by a firing node
* The queues in edge have a certain capacity (called slack), a node will only fire if there is either enough slack on its output edges, or it is guaranteed that by simultaneous firing of connected nodes enough slack will be freed up

More information on the fundamentals of SDF see [8] and [[wiki]](https://en.wikipedia.org/wiki/Dataflow_programming).

# High Level Simulation
To see how the algorithm works a high level simulation was performed. For such a simulation test data is needed.  
The author of [4] has supplied a program to generate a pulsar signal in the same format as real observations. This was used to generate test data by taking this input signal and convolving the entire input signal with a generated inverse chirp function. *Inverse chirp function* means that the frequency dispersion effect is *applied* instead of *removed*, in other words the result is a dispersed signal for a de-dispersion method. This data is used as input to the high level simulation.  

In the figure below the dataflow graph of the high-level simulation is plotted.  
{{< figure src="img/high_level_sim.svg" caption="Dataflow graph of high level simulation of coherent dedispersion algorithm" >}}  
In this graph each token holds a vector representing a block of data of complex values. A short description of all the nodes:  
The src outputs the $n_c$ blocks of size $NN$  
The $ovlp$ node then adds overlap of size $n_d$ samples and outputs tokens holding vectors of size $N\_{bin}$  
The $fft$ node calculates the complex FFT of a block  
The $dm$ node generates possible $DM$ values. For this simulation that is only a single one to show the working  
The $chirp$ node uses this $DM$ value to calculate the chirp with size $N\_{bin}$  
The $mlpl$ node does a element wise complex multiplication of the chirp with block $n^i_c$ in the frequency domain  
The $ifft$ node converts the block $n^i_c$ back to the time domain by inverse FFT  
Lastly the $unpd$ node removes the padding and the $snk$ appends the resulting blocks of size $NN$ together to form the final output

The result from a simulation run is plotted in the figure below. This is an example with aforementioned test data and parameters. Thus the $DM$ is already the correct one and this is done for one channel.
{{< figure src="img/sim_high_level_result.svg" caption="Output of high level simulation" >}}  
The blue peaks are the simulation results. It can be seen that although these are at the same position as the green original signal, they sometimes vary in magnitude with respect to the original green signal. This is due to the effects of splitting the signal into blocks for de-dispersion, in combination with the generation method of the test data, which is not a fully realistic model. This method was explained earlier.

[//]: # (TODO: this should also be added to this part)
[//]: # (# Implementation platform choice)
[//]: # ( computation load, plotten op rooflines, GPU vs FPGA, explaining why FPGA, which is important for design choices)
[//]: # (make use of ska and lofar numbers)


# Implementation Details in parts: step by step
Now that the high level overview of the algorithm is clear, the details can be fleshed out step by step. The major parts for this are:  
* setting up the channelized input data
* setting up the $DM$ trails
* implementing the FFT such that it has a high throughput
* generating the chirp function
* saving the output data

Due to the fact that coherent de-disperion moves the problem largely to the frequency domain, the FFT becomes dominant in the complexity of the implementation work. Therefor the next parts of this series will focus on what turned out to be the largest part of the implementation: the FFT.  
For this a pipelined radix-$2^2$ feedforward architecture is selected, presented in [7]. An analyses on why this is a good candidate is explained in the next part of this series. Furthermore the next part will go into detail of how this architecture works and how it is implemented in a dataflow programming model, as well as presenting simulation of these models to verify its correctness.


# References
{{< references_graduation_dedispersion >}}

{{< ping key="graduation_part2" >}}
