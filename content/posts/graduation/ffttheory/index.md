---
title: "Graduation project part 3: FFT theory"
date: 2020-02-13
draft: false
description: "In part 3 of this series we go into the theory of the dominating part of the implementation: the Fourier Transform"
scientific: true
---

# Introduction
Welcome back to a new part in my blog series about my graduation project. As mentioned in the previous parts, the Fourier Transform will be dominant in the implementation of the Coherent De-Dispersion. This part will dive into the relevant theory behind the Fourier Transform. This includes another algorithm that is need to accomplish the implementation of the Fourier Transform: the CORDIC.

# The Fourier Transform
### DFT
The *Fourier Transform*, named after its inventor Joseph Fourier, converts a signal from the time to the frequency domain [[wiki]](https://en.wikipedia.org/wiki/Fourier_transform). The *Inverse Fourier Transform* does the opposite, converting a signal from the frequency domain to the time domain.  
In other words the Fourier Transform decomposes a signal in time into its frequency components, showing which frequencies make up the original signal. Both the time signal and the frequency signal can be complex, which in that case constitutes the phase information of the signal. In its continious form the transform it is defined as show in equation 1 below.  

$$ F(x) = \int^{\infty}_{\infty}f(x)e^{-2\pi ix \xi}dx \tag{1}  $$  

The system that is being designed is however not continious but discrete, therefor the *Discrete Fourier Transform* [[wiki]](https://en.wikipedia.org/wiki/Discrete_Fourier_transform) is needed. The DFT is defined as shown in equation 2,

$$X[k]=\sum^{N-1}_{n=0}x[n]\cdot W^{nk}_N, k=0,1,...,N-1 \tag{2}$$  

in which 

$$ W^{nk}_N=e^{\dfrac{-j\cdot2\pi\cdot nk}{N}}=W^{\phi}_N=e^{\dfrac{-j\cdot2\pi\cdot \phi}{N}} \tag{3} $$  

This $W^{nk}_{N}$ is called the *twiddle factor*. More on this below.


### Radix-$2$

For implementing the DFT of size $N$, in which $N$ is a power of 2, the *Fast Fourier Transform* (FFT) is used[1]. This *divide and conquer* type algorithm recursively breaks up the DFT into 2 smaller DFT's per iteration of size $N=N_1N_2$, in which $N_1$ and $N_2$ are also a power of two. This reduces the complexity from $\mathcal{O}(N^2)$ to $\mathcal{O}(N\cdot log_2\cdot N)$. This pattern can then be written out in so called *stages* of *butterflies*.  
The FFT is calculated in a series of these stages, with total number stages  $S=log_r(N)$, as can be seen for example in the figure below (taken from [2]). The $r$ here is called the *base of the radix* and is also the number of inputs to each knot in the graph, so the figure corresponds to *radix-$2$*. The pattern of crossing wires in the flow diagram are named butterflies. The most simple butterfly can be observed near the output at the right of the flow diagram, everything left of it are interleaved butterflies. The number of inputs of each knot is equal to the radix base $r$, in this example 2. Then each butterfly (consisting of two of these knots) with input pair $A,B$ calculates $A+B,A-B$ as two outputs. So each bottow line of the butterfly is multiplied with $-1$, which is not shown in the diagram.     
Each number in the flow diagram represents a complex rotation $\phi$ as defined in equation 2. These rotation factors are called twiddle factors or twiddles. It follows that there is no rotation needed for $\phi=0$ and for $\phi=[N/4,N/2,3N/4]$ the rotations are trivial: $W^\phi_N=[1,-j,-1,j]$. These trivial rotations can be executed by swapping the real and complex components.  
{{< figure src="img/radix2-flowdiagram.png" caption="radix-$2$ flow diagram for $N=16$ , taken from [2]" >}}

### DIF and DIT

There are actually two ways to use the optimization of the FFT. These are called the division in time (DIT) and division in frequency (DIF). In terms of optimization they are identical. In later parts it will be shown that they are identical in implementation cost as well. Their main difference is the order of in and output samples.  
The way the butterflies are defined means that any FFT will reshuffle the order of samples in a way that corresponds to the bit reversing of the indices. Lets look at a small example. For an FFT of size $N=16$ the indices are bitwise expressed in $\log_2{(N)}=4$ bits. A sample at index $2$ is "0010" in binary, reversed this is "0100" which is $4$ in decimal. So in other words a sample with index 2 ends up at index 4. The difference between DIT and DIF is that with DIF the input samples are in natural order, but the output samples are in *bit reversed order*. With DIT this is the other way around.

The above figure is an example of DIF, which can be recognized in the order of output indices that are shown. In terms of flow diagram DIF starts splitting the DFT according to the FFT algorithm into two parts from the end of the sample stream. This is illustrated in the figure below, for a small FFT of size $N=8$:
{{< figure src="img/flow-DIF.png" caption="flow diagram DIF FFT $N=8$, taken from [2]" >}}
In contrast, the DIT starts splitting the DFT from the beginning of the sample stream, as illustrated in below figure.
{{< figure src="img/flow-DIT.png" caption="flow diagram DIT FFT $N=8$, taken from [2]" >}}
The consequence of this is the aforementoined sample ordering, *natural order* input -> *bit reversed* output for DIF and *bit reversed order* input -> *natural order* output for DIT. The above figures also mean that that the flow diagrams of the DIF and the DIT are the *transpose* of eachother. This is important for the actual implementation, described in later parts.

An example of a higher radix is shown in the figure below, which depicts a radix-$4$ flow [3]. One butterfly in radix-$4$ can be seen as a rewritten double radix-$2$ butterfly. This results in a reduction of multiplications by 25\% and an increase in the number of additions with 50\%, as proven in [4] and measured in [3]. From dataflow programming mapping to dsp slices in the FPGA, it follows that for every adder there is also a multiplier present. So a trade-off of less multiplications but more additions does not have any actual gain in our programming model. Therefor radix-$2$ is the chosen FFT type.
{{< figure src="img/radix4-flowdiagram.png" caption="radix-$4$ flow diagram for $N=8$, taken from [3]" >}}

### Radix-$2^2$
The series of stages of radix-$2$ can be further optimized. Rewriting the twiddle factors by splitting all non trivial rotations $\phi$ into a trivial and non trivial part $\phi'$ results in the following expression:

$$Ae^{-j\dfrac{2\pi}{N}\phi'}\pm Be^{-j\dfrac{2\pi}{N}(\phi'+N/4)}=[A\pm(-j)B]\cdot e^{-j\dfrac{2\pi}{N}\phi'} \tag{4}$$
in which A and B are the inputs of the butterfly and $\phi'=\phi$ mod $N/4$. In the resulting expression the bracketed part has only a trivial rotation. This is then rotated with a non trivial angle. In practice this is used to move the non trivial part to the next stage for all odd stages, as depicted in the figure below. This method reduces the total number of non trivial rotations in the flow graph at the expense of a slighter more complex control circuit.
{{< figure src="img/radix22-flowdiagram.png" caption="Radix-$2^2$ DIF flowdiagram, taken from [5], only the rotation angles have changed with respect to previous radix-$2$ flowdiagram" >}}

# FFT Implementation Architecture
For the actual implementation architecture of the FFT there are two main choices to be made. The sample flow direction: feed forward only or with feedback, and the amount of inputs: serial or parallel. The four possibilities out of these two choices are called Single-path Delay Feedback (SDF), Multi-path Delay Feedback (MDF), Single-path Delay Commutator (SDM) and Multi-path Delay Commutator (MDC) architectures class for serial feedback, parallel feedback, serial feed forward and parallel feed forward respectively.  

In the feedback options SDF can be used for very high $N$ as seen in [6], but it has a very high latency due to the extensive use of large buffers in a serial fashion. MDF generally requires more hardware due to the feedback loops, as shown in [3], and most designs focus on smaller FFT's both in terms of $N$ as well as in the amount of parallel samples $P$ such as in [7][8]. Due to this focus they are very hard to scale up.  
The feedback loops in both SDF and MDF would also mean encountering complex problems with fixed point scaling with higher $N$, more on this in later parts.  

SDC has this problematic focus on small size as well, with literature focusing on achieving high speed but lower $N$. One example for a more scalable SDC combines the SDC with SDF  [9], but this is only scaling in FFT size $N$ and not in parallel input $P$. It also removes the *bit reverse* ordering after one forward FFT pass, which is not optimal in the general flow of the de-dispersion design, as will be shown later.  
Taking mentioned aspects in consideration, MDC seems most optimal to use for $DM$-trails, for high throughput, low latency and avoidance of complex scaling methods. But the selected MDC architecture needs to be able to scale to $N=2^{16}=65k$ and a high $P=8$ or $P=16$. There are many ways to do this, for example using memory banks in a rotating way [9]. Another way is using cascading building blocks both in time (in terms of $S$) as in parallel samples (in terms $P$). Examples are [3], [11], [5] and [12]. The first two are not focused on larger scale in terms of $P$, but the latter promise high throughput, low latency and high scalability. Therefor this architecture will be the one to form the basis of the implementation of this project. Please note that [12] is an expanded and updated form of the architecture in [5] with added complexity. For our use case this is not strictly necessary and overcomplicates the project. Therefor [5] will be used as the basis for the implementation for our $DM$-trails. The details and implementation steps will be discussed in the next part.

# Twiddle factor generation
The mentioned architecture mainly sets out the way to implement the flow diagram, however it is missing in a way to generate the twiddle factors. Twiddle factors are complex numbers that denote a rotation in the complex plane. There are many ways to generate them, but due to time constraints for this project a relative simple method is used. It makes use of the specific pattern of twiddle factors that are needed for the choosen architecture. More details will be given in the next part about the implementation, however in terms of mathematical theory there are two steps: generating a base angle, rotating this angle with itself. The CORDIC and self rotations are important since the quantization error of the FFT is largely depending on the error in its twiddles factors. These will be discussed below to complete the relevant theory part of this project.

### Rotation matrix

Both of these steps make use of the standard rotation matrix $R$. $R$ defines a rotation in 2D space for a given angle $\varphi$ and is defined as show in equation 5 below:
<div>
$$R(\varphi)=
\begin{bmatrix}
\cos(\varphi) & -\sin(\varphi) \\
\sin(\varphi) & \cos(\varphi) 
\end{bmatrix}
 \tag{5}$$
</div>

By taking a complex number $C=x+yj$ as a vector on the complex 2D plane, written as $V_C=[x;y]$, this standard rotation matrix can then be used to generate a desired twiddle factor by rotating the starting vector $[1;0]$ with the desired angle.


### CORDIC

The standard way of rotations in hardware is making use of the CORDIC algorithm. The **CO**ordinate **R**otation **DI**igital **C**omputer algorithm, sometimes also referred to as Volder's algorithm after its inventor, is a multifunctional algorithm which in its most simple form (the *rotation mode*) rotates a vector with a given angle [[wiki]](https://en.wikipedia.org/wiki/CORDIC).

The rotation mode CORDIC (from now on refered to as CORDIC) iteratively decomposes the desired angle of rotation $\alpha$ into smaller angles which are easily translatable into hardware. Some notable variations on it are the repeating of the CORDIC principle in multiple stages with special versions of angles in [15]  and a simplification of the hardware scheme to prevent scaling in [14]. More versions as well as extensive background can be found in the historical overview in [13].

The CORDIC rewrites the standard rotation matrix in a form with only two angle dependent parts and a scaling and then decomposes the rotation angle into steps of an angle that is easily computed in hardware. The algorithm then runs for a number of iterations, approximating the desired angle further each extra iteration. Each iteration adds or subtracts the remaining angle with the iteration angle. This iteration angle is chosen as the inverse $\tan$ of a power of two. In the rewritten rotation matrix this results in a simple power of two multiplication. Afterwards it scales the end result, which follows from the rotation matrix rewriting.  

First the rotation matrix is rewritten using trigonometric identities, shown in equation 6 below.
<div>
$$
R(\alpha)=
\begin{bmatrix}
\cos(\alpha) & -\sin(\alpha) \\
\sin(\alpha) & \cos(\alpha) 
\end{bmatrix}
=
\dfrac{1}{\sqrt{1+\tan^2(\alpha)}}
\begin{bmatrix}
1 & -\tan(\alpha) \\
\tan(\alpha) & 1
\end{bmatrix} \tag{6}
$$
</div>
Here angle $\alpha$ is then chosen as follows:
$\alpha=\sum^{n-1}_{i=0} d_i\cdot \tanh(2^{-i}) \tag{7}$
with $d_i\in\{+1,-1\}$ the decision variable per iteration and $n$ the number of total iterations. When this choice of $\alpha$ is filled in the expression becomes equation 8 below.
<div>
$$
\begin{bmatrix}
x_{i+1} \\
y_{i+1}
\end{bmatrix}
=
K_i
\begin{bmatrix}
1 & -d_i2^{-i} \\
d_i2^{-i} & 1
\end{bmatrix}
\cdot
\begin{bmatrix}
x_i \\
y_i
\end{bmatrix}
\tag{8}
$$
</div>

From this last  matrix the iterations can be written as a series of state equations per iteration shown in equation 8 below (taken from [13]). These are then finally directly implemented as a cascade of dataflow nodes that execute these state equations, with tokens holding a vector of all states. The states are described as: $x_i$ and $y_i$ for the real and imaginary part of a vector on the complex plane representing the rotated vector, $\omega_i$ as the remaining angle and $d_i$ as the decision variable. Here $i$ is the iteration number with $i \in \{0,1, ..., n-1\}$

<div>
$$\begin{aligned}
&x_{i+1}=x_i-d_i\cdot 2^{-i} \cdot y_i \\
&y_{i+1}=y_i+d_i\cdot 2^{-i} \cdot x_i \\
&\omega_{i+1}=\omega_i-d_i\cdot \tanh(2^{-i})\\
&d_i=-sign(\omega_i)
\end{aligned} \tag{8}$$
</div>

The higher the total iteration number $n$, the more accurate the approximation. As a rule of thumb the accuracy improves approximately 1 bit per iteration. However if the desired angle can be approximated exactly by a number of decomposed angles, then increasing iterations after that will decrease accuracy. The most common scenario for this to happen is with the first iteration $i=0$ which corresponds exactly to $\tanh(2^{-0})=\dfrac{\pi}{4}$. So if the desired angle is 45 degrees the first iteration of the CORDIC already approximates that angle within 1 iteration and any further iterations will decrease the accuracy. Special care should be taken in the implementation to prevent this from happening, since there are indeed twiddle factors which correspond to this angle.

### Self Rotation

For the twiddle generator it is necesarry to rotate a complex number with its own angle once or twice, i.e. $\alpha'=2\alpha$ or $\alpha'=3\alpha$. How to do this in a simple and hardware implementable way?  
First write the complex number $x+yj$ as a rotation of the base vector $[1;0]$ in the complex plane, this is the standard rotation matrix for $\alpha$, $R(\alpha)$, shown in equation 9 below. This results in a form that can also be deduced from the euler formula [[wiki]](https://en.wikipedia.org/wiki/Euler%27s_formula): $e^{jx}=\cos{x}+j\sin{x}$.

<div>
$$\begin{bmatrix}
x \\
y
\end{bmatrix}
=
\begin{bmatrix}
\cos(\alpha) & -\sin(\alpha) \\
\sin(\alpha) & \cos(\alpha) 
\end{bmatrix}
\cdot
\begin{bmatrix}
1 \\
0
\end{bmatrix}
=
\begin{bmatrix}
\cos(\alpha) \\
\sin(\alpha)
\end{bmatrix} \tag{9}
$$
</div>

Then the trigonometric identities [[wiki]](https://en.wikipedia.org/wiki/List_of_trigonometric_identities#Double-angle,_triple-angle,_and_half-angle_formulae) can be used to rewrite the expression into the parts of the input complex number $x+yj$. This is shown for $\alpha'=2\alpha$ in equation 10 and for $\alpha'=3\alpha$ in equation 11.

<div>
$$\begin{bmatrix}
x'\\
y'
\end{bmatrix}
=
\begin{bmatrix}
\cos(2\alpha) \\
\sin(2\alpha)
\end{bmatrix}
=
\begin{bmatrix}
\cos^2(\alpha)-\sin^2(\alpha) \\
2\cdot\sin(\alpha)\cdot\cos(\alpha)
\end{bmatrix}
=
\begin{bmatrix}
x^2-y^2\\
2\cdot x\cdot y
\end{bmatrix}
\tag{10}$$
</div>

<div>
$$\begin{bmatrix}
x'\\
y'
\end{bmatrix}
=
\begin{bmatrix}
\cos(3\alpha) \\
\sin(3\alpha)
\end{bmatrix}
=
\begin{bmatrix}
4\cdot\cos^3(\alpha)-3\cdot\cos(\alpha)\\
3\cdot\sin(\alpha)-4\cdot\sin^3(\alpha)
\end{bmatrix}
=
\begin{bmatrix}
4\cdot x^3-3\cdot x\\
3\cdot y-4y^3 \cdot y
\end{bmatrix}
\tag{11}$$
</div>

# Conclusion
This concludes the overview of relevant math theory of the FFT part. In the next part of this series the Garrido architecture is discussed, extended and implemented in the floating point domain. In the part after that the conversion to fixed point domain is discussed and a full simulation of the coherent de-dispersion is presented and discussed.

# References
{{< references_graduation_ffttheory >}}

{{< ping key="graduation_part3" >}}
