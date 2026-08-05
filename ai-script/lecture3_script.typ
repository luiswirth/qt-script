#import "math.typ": *
#import "style.typ": *
#show: math-template
#show: style-template

#set heading(numbering: "1.1")
#set page(numbering: "1")
#set math.equation(numbering: "(1)")

#let hbar = $planck$
#let mstar = $m^*$
#let DL = $D_L$
#let TLc = $T_L$
#let DR = $D_R$
#let TRc = $T_R$

#align(center)[
  #text(size: 18pt, weight: "bold")[Quantum Transport at the Nanoscale]

  #text(size: 14pt)[Lecture 3 — First Step into Transport: Open Boundary Conditions]

  #v(0.3em)
  #text(size: 11pt)[Study script based on lectures by Luisier, Cao, and Emboras (ETH Zürich, Spring 2026)]
]

#v(1em)
#outline(indent: 1.5em)
#pagebreak()

= From closed systems to transport

In the first two lectures we set up the Schrödinger equation under the effective mass approximation and solved it as a closed eigenvalue problem --- finding the bound states (energy levels and wave functions) of a quantum well. That required imposing $phi(0) = phi(L) = 0$ at the boundaries of the simulation domain, which amounts to saying that no electron can exist outside the device.

This is adequate for computing bandstructure and energy quantization, but it is fundamentally incompatible with _transport_: if we want to model a device through which current flows, electrons must be able to _enter_ the simulation domain from one side, scatter off whatever potential landscape lies inside, and _exit_ --- either back the way they came (reflection) or out the other side (transmission). A wave function that is forced to vanish at the boundaries cannot describe any of this.

The goal of this lecture is to replace the closed boundary conditions $phi(0) = phi(L) = 0$ with _open boundary conditions_ that allow injection, reflection, and transmission. The result will be a modified Schrödinger equation --- no longer an eigenvalue problem, but a linear system of equations --- that can be solved at any given injection energy $E$ to obtain the wave function inside the device.

== Recap: the discretized Schrödinger equation

Recall from Lecture 2 that the 1-D effective-mass Schrödinger equation with position-dependent mass,
$ (-frac(hbar^2, 2 m_0) frac(dif, dif x) frac(1, mstar (x)) frac(dif, dif x) + V(x)) phi(x) = E thin phi(x), $
when discretized on a grid $x_1, x_2, dots, x_N$ with spacing $Delta x$, yields the tridiagonal recurrence
$ (E - H_(i i)) phi_i - H_(i,i+1) phi_(i+1) - H_(i,i-1) phi_(i-1) = 0 $ <discrete-schrodinger>
for each grid point $i$. Here $H_(i i)$ encodes the on-site energy (kinetic + potential) at point $i$, while $H_(i,i+1)$ and $H_(i,i-1)$ are the nearest-neighbour couplings arising from the discretization of the second derivative. On a uniform grid, $H_(i,i+1) = H_(i+1,i)$.

Collecting all $N$ equations into matrix form gives $amat(H) avec(phi) = E avec(phi)$, where $amat(H)$ is a real symmetric $N times N$ tridiagonal matrix. This is the eigenvalue problem we solved in Exercise 1 by calling a standard eigensolver.

== How closed boundary conditions enter

The recurrence @discrete-schrodinger couples each interior point $i$ to its neighbours $i plus.minus 1$. At the boundaries, the first point $i = 1$ couples to $i = 0$ (the first point _outside_ the domain on the left), and the last point $i = N$ couples to $i = N+1$ (the first point outside on the right). For closed boundary conditions, we simply set
$ phi_0 = 0, quad phi_(N+1) = 0, $
so the boundary coupling terms $H_(1,0) phi_0$ and $H_(N,N+1) phi_(N+1)$ vanish. The resulting $N times N$ tridiagonal system is self-contained: there are no unknowns outside the domain.

This works beautifully for bound-state problems. For a quantum well with infinite barriers, the wave functions naturally vanish at the boundary and the Dirichlet condition introduces no error. For finite barriers, the wave function has exponential tails that extend beyond the well; the Dirichlet condition truncates them, which is acceptable only if the simulation domain is wide enough that the tails have decayed to negligible values before reaching the boundary. (As discussed in class: if a confined state's tail has not decayed sufficiently, the boundary artificially forces it to zero and distorts the eigenvalue --- the remedy is to widen the barrier regions until the result converges. See Slide 8 for the contrast between an infinite-barrier well and a finite-barrier well where the second state is visibly affected by the boundary.)

== Why transport requires open boundaries

Now consider a different physical situation: an electron is _injected_ into the device from the left. It propagates through the potential landscape, and some fraction is reflected back to the left while the rest is transmitted to the right. The wave function at the boundaries is decidedly nonzero --- its value there encodes precisely how much reflection and transmission occur. Setting $phi(0) = phi(L) = 0$ would mean zero probability of finding the electron at the boundary, which is physically wrong and mathematically inconsistent with a propagating wave.

We therefore need to find explicit expressions for $phi_0$ and $phi_(N+1)$ (or, equivalently, to modify the Schrödinger equation so that the boundary terms are handled correctly without setting them to zero). The resulting boundary conditions are called _open_ because the system is open to its environment: electrons flow in and out.

#pagebreak()

= Transmission through a potential barrier <barrier-section>

Before tackling the general problem, we work through a canonical example --- quantum tunnelling through a rectangular potential barrier --- that can be solved analytically. This example establishes the physical picture (injection, reflection, transmission) and introduces the matching conditions that will later be generalized.

== Problem setup

Consider the 1-D Schrödinger equation with a piecewise-constant potential:
$ V(x) = cases(0 & "if" x < 0, Delta V & "if" 0 <= x <= L, 0 & "if" x > L.) $ <barrier-potential>
This describes a barrier of height $Delta V$ and width $L$ sandwiched between two flat regions. The effective mass may differ between the barrier and the surroundings: we write $mstar_L$ for $x < 0$, $mstar_C$ for $0 <= x <= L$, and $mstar_R$ for $x > L$.

Because the potential is constant in each of the three regions, the Schrödinger equation reduces to a constant-coefficient ODE in each region, and the general solution is a superposition of two plane waves (or exponentials). For an electron injected from the left with energy $E < Delta V$:

$ phi(x) = cases(
  a_L e^(i k_L x) + b_L e^(-i k_L x) & x < 0,
  a_C e^(-kappa_C x) + b_C e^(kappa_C x) & 0 <= x <= L,
  b_R e^(i k_R (x - L)) & x > L,
) $ <barrier-ansatz>
where
$ k_L = sqrt(frac(2 mstar_L E, hbar^2)), quad kappa_C = sqrt(frac(2 mstar_C (Delta V - E), hbar^2)), quad k_R = sqrt(frac(2 mstar_R E, hbar^2)). $ <barrier-kvectors>

The physical interpretation of each term is as follows. In the left region, $a_L e^(i k_L x)$ is a right-propagating plane wave (the injected electron) and $b_L e^(-i k_L x)$ is a left-propagating wave (the reflected part). Inside the barrier, the wave vector becomes imaginary because $E < Delta V$, so the solutions are real exponentials: one decaying and one growing. In the right region, only a right-propagating wave $b_R e^(i k_R (x-L))$ appears, because we assume injection from the left only --- there is nothing coming in from the right. (The origin of the right-region plane wave is shifted to $x = L$ for notational convenience.)

Note the crucial difference from the closed-system picture: the wave function is _not_ zero at the boundaries. Its value at $x = 0$ is $a_L + b_L$ and at $x = L$ it is $b_R$, both generally nonzero.

== Matching conditions at the interfaces

The five coefficients $a_L, b_L, a_C, b_C, b_R$ are related by four equations: two at each interface ($x = 0$ and $x = L$). The two conditions at each interface are:

*Continuity of the wave function:* $phi(x)|_(x = x_0^-) = phi(x)|_(x = x_0^+)$. This is required for the probability density $|phi|^2$ to be well-defined.

*Continuity of the probability current density:* $1/mstar_- (dif phi)/(dif x)|_(x_0^-) = 1/mstar_+ (dif phi)/(dif x)|_(x_0^+)$. The probability current in the effective mass framework is $j = (hbar)/(2 i) (1/mstar) (phi^* phi' - phi phi'^*)$, and demanding its continuity across a material interface (where $mstar$ jumps) yields this condition. Note the factor $1\/mstar$ --- without it, current would not be conserved across a mass discontinuity.

At the left interface ($x = 0$):
$ a_L + b_L &= a_C + b_C, $ <match-phi-left>
$ frac(i k_L, mstar_L) (a_L - b_L) &= frac(kappa_C, mstar_C) (-a_C + b_C). $ <match-j-left>

At the right interface ($x = L$):
$ a_C e^(-kappa_C L) + b_C e^(kappa_C L) &= b_R, $ <match-phi-right>
$ frac(kappa_C, mstar_C) (-a_C e^(-kappa_C L) + b_C e^(kappa_C L)) &= frac(i k_R, mstar_R) b_R. $ <match-j-right>

Since $|a_L|^2$ represents the injection probability and can be freely chosen (it cancels when we form ratios), we set $a_L = 1$. The four matching equations then determine $b_L, a_C, b_C, b_R$ uniquely.

== The transmission coefficient

The quantity of physical interest is the _transmission coefficient_ (or transmission probability):
$ T_(L R)(E) = frac(|b_R|^2, |a_L|^2). $ <transmission-def>
This is the ratio of the transmitted probability flux to the injected flux. Solving the matching equations for $b_R$ yields $b_R = 1\/F$, where $F = F_1 + F_2 - F_3 - F_4$ is a sum of four terms involving $k_L, kappa_C, k_R$, the effective masses, and $L$ (see Slide 16 for the explicit expressions). The important point is not the algebraic detail but that $T_(L R)$ is completely determined by the barrier parameters and the injection energy $E$.

For a concrete example --- a 5 nm barrier with $Delta V = 0.3$ eV, $mstar_"barrier" = 0.1 m_0$, and $mstar_"side" = 0.065 m_0$ --- see Slide 17. The left panel shows the probability density $|phi(x)|^2$ at two energies: at $E = 60$ meV (well below the barrier), the wave function shows standing waves on the injection side and is nearly zero after the barrier; at $E = 210$ meV (closer to $Delta V$), a small but nonzero amplitude appears on the transmitted side. The right panel shows $T_(L R)(E)$ growing roughly exponentially as $E$ increases toward $Delta V = 0.3$ eV.

Several features are worth noting. First, the wave function is _not_ zero at the domain boundaries; it is a propagating plane wave on each side of the barrier. Second, the energy $E$ is now an _input_ parameter (we choose which energy to inject at), not an _output_ (eigenvalue) as in the closed problem. Third, the problem is solved at each energy independently --- we sweep over an energy grid.

== Above-barrier transmission: interference oscillations

What happens when $E > Delta V$, i.e. the electron has more energy than the barrier? One might naively expect $T = 1$ (everything gets through), but this is not the case. The wave vector inside the barrier becomes real:
$ k_C = sqrt(frac(2 mstar_C (E - Delta V), hbar^2)), $
so the solution inside the barrier is now an _oscillating_ plane wave rather than an exponential decay. The electron can propagate freely through the barrier region, but at each interface there is a mismatch in wave vector (and possibly effective mass), which causes partial reflection. The reflected waves interfere with the incoming wave.

The transmission coefficient oscillates as a function of $E$, reaching $T = 1$ at specific resonance energies and dipping below 1 in between. The condition for perfect transmission ($T = 1$) is _constructive interference_: the barrier width $L$ must equal an integer number of half-wavelengths inside the barrier,
$ L = n frac(lambda_C, 2) = n frac(pi, k_C), quad n = 1, 2, 3, dots $ <resonance-condition>
At these energies, the nodes of the standing wave inside the barrier fall exactly at the interfaces, so the wave "doesn't feel" the barrier. This is completely analogous to a Fabry--Pérot cavity in optics, or to the resonance condition in thin-film interference. Substituting the expression for $k_C$ gives the resonance energies:
$ E_n = Delta V + frac(hbar^2, 2 mstar_C) (frac(n pi, L))^2. $ <resonance-energies>

Between resonances, $T < 1$ due to partial destructive interference, but the dips become shallower at higher energies. Far above the barrier, the wave-vector mismatch at the interfaces becomes relatively small, and $T arrow 1$ smoothly.

(Exam hint: understanding _why_ the above-barrier transmission oscillates, and being able to derive @resonance-condition from the constructive interference condition, is the kind of qualitative reasoning that is expected.)

== Limitations of the analytical approach

The analytical solution above relied entirely on the fact that $V(x)$ is piecewise constant: we could write down the general solution (plane wave or exponential) in each region, and then "glue" the solutions together using the matching conditions at each interface. This fails as soon as $V(x)$ has a nontrivial spatial profile --- for instance, a barrier with an applied electric field (a linear ramp), or any realistic device potential. In such cases, there is no closed-form solution in the interior of the device, and we cannot apply the interface matching approach.

We need a method that: (i) handles _any_ potential profile $V(x)$ inside the device numerically (via the discretized Schrödinger equation we already have), and (ii) still correctly accounts for injection, reflection, and transmission at the boundaries. This is what the open boundary condition formalism achieves.

#pagebreak()

= Generalization: semi-infinite contacts <contacts-section>

== The key idea: flat-band contact regions

The analytical barrier problem worked because we knew the solution of the Schrödinger equation in the flat regions on either side of the barrier. We now generalize this by _always_ ensuring that the regions outside the device have a flat (constant) potential, regardless of what happens inside.

Concretely, we extend the simulation domain by attaching _semi-infinite_ flat-band regions on the left and right. On the left, the potential is fixed at $V(0)$ (the value at the first device grid point); on the right, at $V(L)$ (the value at the last device grid point). These extensions are called *contacts*, *reservoirs*, or *leads*. See Slide 22 for the picture: the device with its arbitrary $V(x)$ is treated as a "black box," flanked by semi-infinite flat-band contacts.

Because the potential is constant in each contact, the Schrödinger equation is analytically solvable there --- the solutions are plane waves, exactly as in the flat regions of the barrier problem. The _interior_ of the device is solved numerically using the discretized Schrödinger equation as before. The art is in connecting the two: replacing the unknown boundary values $phi_0$ and $phi_(N+1)$ with expressions derived from the known analytical solution in the contacts.

A crucial physical requirement is that the potential _actually be flat_ at the contact boundaries. In practice this means the device simulation domain must be chosen large enough that the potential has settled to a constant value at the edges. As the lecturer noted, this is naturally satisfied in real devices due to charge neutrality in the heavily doped source/drain regions --- a point that will be made precise when we introduce Poisson's equation in a later lecture.

== Plane wave ansatz in the contacts

In the left contact ($x < x_1$), the wave function is a superposition of incoming and outgoing plane waves:
$ phi_l (x) = a_L e^(i k_L x) + b_L e^(-i k_L x), quad "Re"(k_L) >= 0. $ <left-contact-ansatz>
In the right contact ($x > x_N$):
$ phi_r (x) = a_R e^(-i k_R (x - L)) + b_R e^(i k_R (x - L)), quad "Re"(k_R) >= 0. $ <right-contact-ansatz>

The convention is: $a_L e^(i k_L x)$ propagates to the right (into the device), $b_L e^(-i k_L x)$ propagates to the left (away from the device, either by reflection or transmission from the other contact). Similarly, $a_R e^(-i k_R (x-L))$ propagates to the left (into the device from the right), and $b_R e^(i k_R (x-L))$ propagates to the right (away from the device).

== Two sub-problems: left-injection and right-injection

The general transport problem decomposes into two independent sub-problems:

*Left injection* ($a_L = 1$, $a_R = 0$): An electron is injected from the left contact. Part of it is reflected back to the left ($b_(L L)$), and part is transmitted to the right ($b_(R L)$). This produces the _left-injected wave function_ $phi^L (x)$.

*Right injection* ($a_R = 1$, $a_L = 0$): An electron is injected from the right contact. Part is reflected back to the right ($b_(R R)$), and part is transmitted to the left ($b_(L R)$). This produces the _right-injected wave function_ $phi^R (x)$.

The reason we must solve _both_ problems is that in a device under bias, the two contacts have different Fermi levels (different chemical potentials), so electrons are injected from each side with different occupation probabilities. The total charge density and current are obtained by combining both solutions, weighted by the respective Fermi--Dirac distributions. This will be developed in Lecture 4.

#pagebreak()

= Derivation of the open boundary conditions <derivation-section>

We now carry out the central derivation of this lecture: starting from the discretized Schrödinger equation and the plane wave ansatz in the contacts, we eliminate the unknowns outside the device ($phi_0, phi_(-1), dots$) and arrive at a closed system of equations for the $N$ grid points inside the device.

The full derivation is given in the appendix of the lecture slides (pages 36--39). Here we present the logic step by step, following the board derivation from the lecture.

== Setup: extending the grid into the contacts

We focus on the left contact; the right contact is handled identically by symmetry.

The device occupies grid points $i = 1, dots, N$. The first three points outside the device on the left are $i = 0, -1, -2$, separated by a uniform spacing $Delta x$ (the same spacing used in the contact). Because the material properties in the contact are identical to those at the first device point, the Hamiltonian entries in the contact are all the same:
$ D_L equiv E - H_(0,0) = E - H_(-1,-1) = E - H_(1,1)|_"contact", $ <DL-def>
$ T_L equiv -H_(0,1) = -H_(-1,0) = -H_(0,-1) = -H_(1,0). $ <TL-def>
Here we define $D_L$ as the diagonal entry and $T_L$ as the (negative of the) off-diagonal coupling, both evaluated with the contact material parameters. Note that $T_L$ appears with a minus sign relative to $H$: the coupling entries $H_(i,i+1)$ are negative (they correspond to $-hbar^2 \/ (2 mstar Delta x^2)$), so $T_L > 0$.

== Writing the equations at $i = 1$, $i = 0$, and $i = -1$

The discretized Schrödinger equation @discrete-schrodinger at $i = 1$ reads
$ (E - H_(1 1)) phi_1 - H_(1,2) phi_2 + T_L (a_L + b_L) = 0, $ <eq-i1>
where we already used $phi_0 = a_L + b_L$ from the plane wave ansatz evaluated at $x = 0$.

At $i = 0$ (using the contact parameters):
$ T_L phi_1 + a_L (D_L + T_L e^(-i k_L Delta x)) + b_L (D_L + T_L e^(i k_L Delta x)) = 0. $ <eq-i0>
Here $phi_(-1) = a_L e^(-i k_L Delta x) + b_L e^(i k_L Delta x)$ has been substituted and the terms grouped by $a_L$ and $b_L$.

At $i = -1$ (using $phi_0$ and $phi_(-2)$ from the ansatz):
$ a_L (D_L e^(-i k_L Delta x) + T_L e^(-2 i k_L Delta x) + T_L) + b_L (D_L e^(i k_L Delta x) + T_L e^(2 i k_L Delta x) + T_L) = 0. $ <eq-im1>

The key observation about @eq-im1 is that it involves _only_ contact quantities --- no device wave function values appear. This equation establishes a relationship between $a_L$ and $b_L$ that is independent of the device interior. But physically, the reflection coefficient $b_L$ _must_ depend on what is inside the device. Therefore, both the coefficient of $a_L$ and the coefficient of $b_L$ in @eq-im1 must vanish independently.

== Extracting $k_L$: the contact dispersion relation

Setting either coefficient in @eq-im1 to zero (they yield the same equation after multiplying by appropriate phase factors), we obtain
$ D_L + 2 T_L cos(k_L Delta x) = 0, $
which gives
$ k_L = frac(1, Delta x) arccos(-frac(D_L, 2 T_L)). $ <kL-expression>

This is the _discrete dispersion relation_ of the contact. It plays the same role as $k = sqrt(2 mstar E \/ hbar^2)$ in the continuum theory, but it is more accurate: it accounts for the discretization and automatically captures the finite bandwidth of the discrete lattice. At low energies, expanding $cos(k_L Delta x) approx 1 - (k_L Delta x)^2 \/ 2$ and using the explicit forms of $D_L$ and $T_L$ recovers the parabolic relation $E approx hbar^2 k_L^2 \/ (2 mstar) + V(0)$. At higher energies, the cosine introduces a deviation from parabolicity and defines a natural Brillouin zone with $k_L in [0, pi\/Delta x]$, beyond which the band folds back. This is physically reasonable --- a real crystal also has a finite bandwidth --- and more accurate than an unbounded parabolic dispersion. (This correspondence is explored in the exercises.)

== Extracting $b_L$: relating reflection to the device

With $k_L$ determined, the relation @eq-im1 is automatically satisfied, and the constraint that was implicit in @eq-im1 has been absorbed into @kL-expression. We now use @eq-i0 to solve for $b_L$. Substituting the identity $D_L + T_L e^(plus.minus i k_L Delta x) = -T_L e^(minus.plus i k_L Delta x)$ (which follows from the dispersion relation) simplifies @eq-i0 to
$ b_L = phi_1 e^(i k_L Delta x) - a_L e^(2 i k_L Delta x). $ <bL-expression>

This is a satisfying result: the reflection coefficient $b_L$ now depends on $phi_1$ (a device quantity --- the wave function at the first grid point inside the device) as well as on $a_L$ (the injection amplitude). The relationship between injection and reflection is mediated by the device, as it must be.

== Closing the system: the self-energy and injection vector

We substitute @bL-expression into @eq-i1. Collecting the $phi_1$ terms on the left and the $a_L$ terms on the right:
$ (E - H_(1 1) + T_L e^(i k_L Delta x)) phi_1 - H_(1,2) phi_2 = -a_L T_L (1 - e^(2 i k_L Delta x)). $ <eq-final-left>

Comparing with the original equation at $i = 1$ under closed boundary conditions (where $phi_0 = 0$ and there was no right-hand side), we see two modifications:

*A correction to the diagonal entry:* The term $T_L e^(i k_L Delta x)$ has been added to the $(1,1)$ position. We define the _left boundary self-energy_:
$ Sigma_(1 1) = -T_L e^(i k_L Delta x). $ <sigma11>

*A source term on the right-hand side:* The injection amplitude $a_L$ produces a driving term. We define the _left injection vector_ entry:
$ S^L_(1 1) = -a_L T_L (1 - e^(2 i k_L Delta x)). $ <S11>

The self-energy $Sigma_(1 1)$ is complex-valued (note the phase $e^(i k_L Delta x)$), which makes the modified Hamiltonian $amat(H) + amat(Sigma)$ non-Hermitian. This is physically meaningful: the system is no longer closed, so probability is not conserved within the device --- electrons can leak out through the contacts. The imaginary part of $Sigma$ encodes this leakage. (If you have encountered the Dirichlet-to-Neumann map in the context of PDE domain decomposition or perfectly matched layers, the self-energy plays an analogous role: it represents the exact effect of the semi-infinite exterior on the finite computational domain.)

== The right contact

Repeating the identical procedure for the right contact ($i = N, N+1, N+2$) with $a_R = 0$ (for left-injection), we obtain
$ (E - H_(N N) + T_R e^(i k_R Delta x)) phi_N - H_(N, N-1) phi_(N-1) = 0, $ <eq-final-right>
where
$ k_R = frac(1, Delta x) arccos(-frac(D_R, 2 T_R)), quad Sigma_(N N) = -T_R e^(i k_R Delta x), $ <sigma-right>
and the right-hand side is zero because we are not injecting from the right ($a_R = 0$).

For right-injection ($a_R = 1$, $a_L = 0$), the self-energies $Sigma_(1 1)$ and $Sigma_(N N)$ remain the same, but the source term appears at position $N$ instead of position 1:
$ S^R_(N N) = -a_R T_R (1 - e^(2 i k_R Delta x)). $

== The final system: $(E - amat(H) - amat(Sigma)) avec(phi) = avec(S)$ <final-system>

Collecting all $N$ equations, the open-boundary Schrödinger equation in matrix form is
$ (E dot amat(I) - amat(H) - amat(Sigma)) dot avec(phi) = avec(S). $ <master-equation>

Here:

$E dot amat(I)$ is the energy times the $N times N$ identity matrix.

$amat(H)$ is the device Hamiltonian --- the _same_ tridiagonal matrix as in the closed-boundary problem. No entry of $amat(H)$ is modified; all the physics of open boundaries resides in $amat(Sigma)$ and $avec(S)$.

$amat(Sigma)$ is the *open boundary self-energy matrix*, an $N times N$ matrix with only two nonzero entries: $Sigma_(1,1)$ from the left contact and $Sigma_(N,N)$ from the right contact.

$avec(phi)$ is the wave function vector of length $N$, containing the values $phi_1, dots, phi_N$ inside the device.

$avec(S)$ is the *injection vector* of length $N$.

For left-injection ($a_L = 1$, $a_R = 0$), $avec(S)$ has a single nonzero entry $S^L_(1 1)$ in position 1, and the solution is the left-injected wave function $avec(phi)^L$. For right-injection ($a_R = 1$, $a_L = 0$), $avec(S)$ has a single nonzero entry $S^R_(N N)$ in position $N$, and the solution is $avec(phi)^R$.

Both problems share the _same_ left-hand-side matrix $E dot amat(I) - amat(H) - amat(Sigma)$, so they can be solved simultaneously: we factorize the matrix once and solve for two right-hand sides:
$ (E dot amat(I) - amat(H) - amat(Sigma)) dot [avec(phi)^L, avec(phi)^R] = [avec(S)^L, avec(S)^R]. $

This is the central equation of the *Wave Function formalism* (also called the *Quantum Transmitting Boundary Method*, QTBM). It must be solved for each energy $E$ on a suitably chosen energy grid. The matrix $E dot amat(I) - amat(H) - amat(Sigma)$ is tridiagonal and complex, so each solve costs $O(N)$ via LU factorization --- much cheaper than inverting a full matrix.

Note the fundamental change in mathematical structure compared to the closed-boundary case:

The closed problem $amat(H) avec(phi) = E avec(phi)$ is an _eigenvalue problem_: $E$ is an unknown to be found, and the solutions form a discrete set of eigenstates.

The open problem $(E dot amat(I) - amat(H) - amat(Sigma)) avec(phi) = avec(S)$ is a _linear system_ of the form $amat(A) avec(x) = avec(b)$: the energy $E$ is prescribed, and we solve for the wave function at that energy. The solution exists for _every_ $E$ (the spectrum is continuous, as expected for an open system connected to infinite reservoirs).

(Exam hint: the lecturer explicitly stated what is expected on the exam for this topic. You should understand the following chain of reasoning: (1) the device is extended by semi-infinite flat-band contacts on each side; (2) the contacts are flat so that the analytical plane-wave solution of the Schrödinger equation is known there; (3) to connect the analytical solution to the numerical device, we write the discrete Schrödinger equation at $i = 1$, $i = 0$, and $i = -1$; (4) in each equation, we replace $phi_0$, $phi_(-1)$, $phi_(-2)$ by their plane-wave expressions; (5) the $i = -1$ equation gives $k_L$, the $i = 0$ equation gives $b_L$, and substituting into the $i = 1$ equation gives the final boundary condition with $Sigma_(1 1)$ and $S^L_(1 1)$. You should be able to reproduce the final form @master-equation and explain what each ingredient means. You do _not_ need to carry out every algebraic step from scratch --- but you do need to understand the logical flow and not confuse it with the continuum matching conditions from the barrier problem. As the lecturer emphasized: the continuity conditions on $phi$ and $j$ at an interface are _automatically_ built into the discrete Schrödinger equation. The derivation proceeds purely within the discrete framework.)

#pagebreak()

= Summary

This lecture made the transition from closed (bound-state) quantum mechanics to open (transport) quantum mechanics:

*Closed boundary conditions* ($phi_0 = phi_(N+1) = 0$) turn the discretized Schrödinger equation into a Hermitian eigenvalue problem $amat(H) avec(phi) = E avec(phi)$, suitable for computing bandstructure and confined states. They forbid any exchange of electrons with the environment.

*Open boundary conditions* allow electrons to enter and leave the device. They are implemented by attaching semi-infinite flat-band contacts to each side of the device, in which the wave function is known analytically (plane waves). By substituting the plane-wave ansatz into the discrete Schrödinger equation at the boundary grid points, the infinite hierarchy of equations outside the device is reduced to a finite correction: a complex self-energy $amat(Sigma)$ added to the Hamiltonian, and an injection source vector $avec(S)$.

The resulting *Wave Function formalism* equation $(E dot amat(I) - amat(H) - amat(Sigma)) avec(phi) = avec(S)$ is a linear system solved at each injection energy $E$. It yields the wave function inside the device for electrons injected from either contact, from which the transmission coefficient, charge density, and current can be computed.

The transmission through a rectangular potential barrier served as a pedagogical precursor: it demonstrated the physics of tunnelling (exponential decay below the barrier), above-barrier oscillations (Fabry--Pérot resonances from constructive interference), and the concept of a transmission coefficient. But the analytical matching approach is limited to piecewise-constant potentials, whereas the self-energy formalism handles arbitrary $V(x)$.

*Next lecture:* using $avec(phi)^L$ and $avec(phi)^R$ to compute the non-equilibrium charge density and current density in a device under applied bias.
