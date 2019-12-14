---
title: "Graduation project part 1: Pulsars Stars"
date: 2019-12-13
draft: false
description: "In this series about my graduation project we start with pulsar stars and the problems observing them"
---
# Introduction

This post will be the first in a series about my graduation project. As a final deliverable I will have to write a scientific paper as well, which will be made available for download when its done. The idea behind these blog posts is that they serve as a more expanded version of this final paper for general documentation. The goal is to make it accessible for persons not directly involved with my field of study. It is highly recommended to take a look at the various links and references posted for a better understanding of the core concepts. All posts about my graduation will be in english.  
The main concept that is used for designing my work is dataflow architecture [[wiki]](https://en.wikipedia.org/wiki/Dataflow_architecture), more specifically Static (or Synchronous) Data Flow [1]. More on this in later parts.  
The implementation of this work is mainly done in StaccatoLab, a python library for programming dataflow graphs created by [Kees van Berkel of the TU/e](https://www.tue.nl/en/research/researchers/kees-van-berkel/) who is my graduation supervisor. Since the main goal is to explain my research and results I will not explain the StaccatoLab implementation part in detail. Mainly the  plots of the dataflow graphs and its simulation results will be used. More on this in later parts.  
These posts are subject to change while I work towards my final graduation and the end of February / beginning of march of 2020.  
This first part will go into the details behind the application that this project tackles: processing the signals of pulsar stars.

# Pulsar Stars
Radio Pulsars (or Pulsar Stars in popular culture) [[wiki]](https://en.wikipedia.org/wiki/Pulsar) are rapidly rotating heavily magnetised neutron stars. They are invisible to the naked eye, but can be discovered in telescope observations of the universe. In its most basic form they are a dense heavy neutron star, the exact composition being dependent on the equation of state, which is the relation between the density and pressure of matter composing the star.  
Pulsars slowly lose rotation speed over time, this energy loss $\dot{E}$ is called the spin down luminosity. The bulk of this energy is lost due to magnetic dipole radiation and pulsar winds. Only a tiny fraction of $\dot{E}$ is actual radio emission, the type of energy that reaches our earth and can be observed by us [2].  
Pulsar stars emit a beam of this radio transmission, which rotates around its axis in a circular fashion. These emissions are observed on our earth as (relative) short radio pulses. These radio pulses can be compared to the effect of light of a lighthouse near a harbour. A lighthouse emits a beam of light that is rotating. From a (relatively) fixed observation point, for example a ship, this is observed as a short light pulse that has a fixed period. For the human eye this is a blinking light.  
Below is an artist impression of a pulsar star with its radiation beam.  
{{<figure src="img/pulsar.png" caption="arist impression of a pulsar star" captionPosition="left" style="width:75%;">}}  
From this artist impression an important property of the pulse signal can be seen. The angle of the radiation beam is not necessarily a multiple of 90 degrees, as depicted. Relatively with the observation point, in most cases our earth, this means that in the vast majority of cases you only observe one half of the beam. In other words in the pulse signal there is only one pulse per period of the pulsar star. This is important when interpreting the results.  

The energy loss $\dot{E}$ causes a slow down of the spinning speed and thus an increase in the period of the pulse signal. However these phenomena are predictable and pulsars therefor have very precise timings. These timings can be used to study relativity theory as well as gravitational waves, relativity theory and many more other fundamental physics phenomena [2].

# Pulsar Star Observation
The radio signal of an observed pulse travels light years through space to reach our earth. On its way it encounters the InterStellar Medium (ISM) [[wiki]](https://en.wikipedia.org/wiki/Interstellar_medium). The ISM consist of cold ionised plasma and can be approximated with known transfer functions. The ISM acts on the signal with four distinct effects:

* Frequency Dispersion

* Faraday Rotation 

* Scintillation

* Scattering

Of these frequency dispersion is dominant and the main focus of this project. For completeness the other three will be discussed shortly below. 

Faraday Rotation [[wiki]](https://en.wikipedia.org/wiki/Faraday_effect) is caused by differential phase rotation between left and right circular polarisation of the signal. In the ISM this is dependent on a scaled quadratic relation  to the wavelength of the light: $ \beta = RM \cdot \lambda^2 $, in which $\beta$ is the angle of rotation in radians, $RM$ is the Rotation Measure constant and $\lambda$ the wavelength.

Scintillation [[wiki]](https://en.wikipedia.org/wiki/Interplanetary_scintillation) is the effect of random changes in magnitude of the signal, caused by electrons and protons in the ISM plasma. It can also be seen by the naked eye in the form of the twinkling light of stars. This effect can be modelled by putting a thin screen half way between the source and observer with a refraction index of $\Delta \mu$ [2] [3].

Scattering [[wiki]](https://en.wikipedia.org/wiki/Scattering) is the effect in which radiation (such as the emission from pulsar stars) is changed direction due to non uniform effects of the medium it is passing through. In the ISM this is thus due to the changing density of the plasma. [4]  

# Frequency Dispersion
Frequency dispersion [[wiki]](https://en.wikipedia.org/wiki/Dispersion_relation) is the effect within  a signal that is composed of multiple frequencies (and thus wave length), these frequencies have different propagation speeds through a medium. In other words the different frequencies in the signal slowly shift in time.  
This effect can be observed with the naked eye with light, due to the fact that this effect results in a different refraction angle for specific wavelengths in certain materials. The best example of this is a dispersive prism, as show in the wiki article.  
In pulsar signal observations this effect can be seen in the below figure, which is a real observation of a pulsar:  
{{< image src="img/pulsar_observation.gif" position="center" >}}
[[source]](http://www.jb.man.ac.uk/distance/frontiers/pulsars/section4.html)  
Here repetitions of the observed pulse can be seen smeared out over the frequency spectrum in time. The arrival of different frequencies (the vertical axis) at different points in time (the horizontal axis, with as unit the pulsar period) is clearly visible.  
The result of this is that when looking at the magnitude of the received signal at a telescope the pulse has been smeared out so much that it disappears into the noise floor. This can be seen in the below figure, which shows a simulated pulsar signal in green and the same signal after frequency dispersion applied in red. This is from simulated data.  
{{< figure src="img/pulsar_signal_dispersed.svg" caption="magnitude of original and dispersed signal over time (simulated data)" >}}

# Frequency Dispersion model
Before presenting the mathematical model of the frequency dispersion effect, we need to revisit the ISM and define some parameters for it. The ISM is not uniform, different paths from a pulsar to an observation point do not have the same effects. This is due to the different column density of free electrons along the travelled path by the signal. To model this effect there is the Dispersion Measure($DM$), defined as follows:  
$$ DM=\int\_0^d\eta\_e(l)dl \tag{1}$$  
Here $\eta\_e(l)$ is the amount of electrons at a point along the path, $d$ the distance of the path and $l$ the path itself. This $DM$ is the parameter that will be used in the model of Frequency Dispersion in the ISM. It is not known a priori to an observation of a radio pulsar.  

There are multiple ways to model the Frequency Dispersion in the ISM, of which two will be presented. These are tied to the two main algorithms of removing the dispersion, so called de-dispersion, whom will be presented in the next part in this series. These models both work with the concept of so called frequency channels. These are created by splitting the frequency spectrum into smaller bands of equal size. For example one of the largest projects in this field, the SKA [[wiki]](https://en.wikipedia.org/wiki/Square_Kilometre_Array), splits a bandwidth of 300 MHz into 4096 frequency channels for the SKA1-Mid system for pulsar search [7].

In the first model for a channel between $f\_1 < f < f\_2$ the time delay of the arriving frequency channel can be described by:
$$ \Delta t = 4.15\times{10}^{-6} \times DM \times (f_1^{-2} - f_2^{-2}) \tag{2}$$  
The second model describes the dispersion as a phase only filter in the following form in the frequency domain:  
$$V(f_0+f)=V_{int}(f_0+f)\times H(f_0+f) \tag{3}$$  
here $V(f)$ and $V_{int}(f_0+f)$ are the observed and emitted signals around a center $f_0$ and the filter transfer function $H(f)$.  
This transfer function is then of the following form:  
$$H(f+f_0) = exp\bigg[\dfrac{2 \pi \cdot i \cdot f^2 \cdot k_{DM} \cdot DM}{f_0^2(f+f_0)}\bigg] \tag{4}$$  
here $f_0$ is the center frequency of a frequency channel and $f$ is the frequency offset within the channel. $DM$ is the dispersion measure as discussed earlier and $k_{DM}$ is the measured constant of proportionality of the ISM model.
Please note that these models follow the physics convention in terms of writing.  

For more background information behind these models see [2].  

The parameter $DM$ is not known a priori when looking at an observation, this means that many trails over a broad range have to be done in the de-dispersion method to search for the correct one. To select the correct range for these, models of the Galactic electron density can be used to estimate the maximum $DM$ for a certain range and direction in the galaxy [6].  
Selecting the right $DM$ through many trails of de-dispersion in an efficient and fast way, so that new pulsars can be found in astronomy observations, is the main application that this graduation project will tackle. In the next part of this series the main methods of de-dispersion algorithms will be discussed. Furthermore the implementation direction will be introduced with its trade-offs.



# References
{{< references_graduation_pulsars >}}
