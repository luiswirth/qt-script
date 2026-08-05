#import "math.typ": *
#import "style.typ": *
#show: math-template
#show: style-template

#set heading(numbering: "1.1")
#set page(numbering: "1")
#set math.equation(numbering: "(1)")

#let hbar = $planck$
#let mstar = $m^*$
#let lam = $lambda$

#align(center)[
  #text(size: 18pt, weight: "bold")[Quantum Transport at the Nanoscale]

  #text(size: 14pt)[Lecture 1 — Introduction: Why Quantum Transport?]

  #v(0.3em)
  #text(size: 11pt)[Study script based on lectures by Luisier, Cao, and Emboras (ETH Zürich, Spring 2026)]
]

#v(1em)
#outline(indent: 1.5em)
#pagebreak()

= The physical setting: transistors at the nanoscale

The entire course is motivated by a single engineering reality: transistors — the binary switches that make up every digital circuit — have been shrinking for over 60 years and are now so small that classical physics can no longer describe how electrons move through them.

== What a transistor does

A transistor is a three-terminal device: source (S), drain (D), and gate (G). Current flows from source to drain through a semiconductor channel. The gate controls whether this current flows or not by raising or lowering a potential energy barrier in the channel. When the barrier is high (gate "off"), no classical current flows. When the barrier is lowered (gate "on"), electrons pass over it and current flows. This on/off switching is the physical basis of digital logic.

The key electrical characteristics are the *output characteristic* $I_d$–$V_(d s)$ (current vs. drain voltage at fixed gate voltage) and the *transfer characteristic* $I_d$–$V_(g s)$ (current vs. gate voltage), which shows the transition from off-state to on-state. The ratio between on-current and off-current (the leakage in standby) determines the transistor's usefulness: high on-current for fast switching, low off-current for low power consumption.

== Why they keep shrinking: Moore's law

In 1965, Gordon Moore observed that the number of transistors per integrated circuit was doubling roughly every two years. This empirical trend — *Moore's law* — has driven the semiconductor industry for six decades. The mechanism is straightforward: if you shrink each transistor's width and length by a factor of $0.7$, the area halves, so you fit twice as many on the same chip. Each such step is called a *technology node*.

The consequence is that transistor dimensions have gone from micrometers in the 1970s to a few nanometers today. At the 2 nm node (in production around 2025), the gate length — the distance between source and drain — is on the order of 10–12 nm, and the semiconductor channel thickness can be as small as 4–5 nm. At these scales, the electrons flowing through the device have a de Broglie wavelength comparable to the device dimensions, and quantum mechanical effects that were previously negligible become dominant.

== Transistor architectures: from planar to 3-D

As transistors shrank, their geometry had to change to maintain electrostatic control of the channel:

*Planar MOSFETs* (before 2011): The gate sits on top of a flat channel. This is a single-gate geometry — the gate controls the channel only from one side. At short gate lengths, the source and drain start to "fight" with the gate for control of the channel, causing leakage.

*FinFETs* (2011–2022): The channel is turned on its side to form a tall, thin "fin." The gate wraps around three sides (triple-gate), giving much better electrostatic control. As the lecturer put it: holding a pen with three fingers gives you much more control than pressing from the top with one finger.

*Nanosheet FETs / Gate-All-Around* (2022–present): The channel is split into multiple thin horizontal sheets, each fully surrounded by the gate. This is the ultimate electrostatic control geometry — the gate acts on the channel from all sides. The sheets are typically only 4–5 nm thick.

The key insight is that better gate control delays the onset of short-channel effects (source-to-drain leakage), allowing further scaling. But the thinner the channel, the stronger the quantum confinement effects — which brings us to the central question of this course.

= Three levels of electron transport models

The question "how do electrons move through a device?" can be answered at three levels of physical sophistication. Each level captures more physics but costs more computationally. Choosing the right level for a given problem is an essential engineering judgment.

== Classical: the Drift-Diffusion model

The simplest model treats electrons as a continuous fluid characterized by a local concentration $n(avec(r))$ and a current density:
$ avec(J)_n = q n mu_n avec(E) + q D_n nabla n. $ <dd>
The first term is *drift*: the electric field $avec(E)$ accelerates charged particles, and the *mobility* $mu_n$ relates the resulting average velocity to the field strength via $avec(v) = mu_n avec(E)$. The second term is *diffusion*: electrons spread from regions of high concentration to low concentration, governed by the diffusion coefficient $D_n$.

The physical picture underlying this model is the *Drude model*: an electron is accelerated by the electric field, gains velocity linearly in time ($v = q E t \/ mstar$), then scatters off an impurity or a lattice vibration and loses all its directed momentum. It gets re-accelerated, scatters again, and so on. If the device is much larger than the *mean free path* $ell$ (the average distance between scattering events), then the electron undergoes many collisions during transit, and a well-defined average drift velocity — and hence a mobility — emerges.

*Limitations:* The Drift-Diffusion model is valid only when the device length $L >> ell$ (typically $ell tilde 10$–$30$ nm in silicon at room temperature). It captures no quantum mechanical effects whatsoever — no tunneling through barriers, no energy quantization from confinement.

== Semi-classical: the Boltzmann Transport Equation

At the next level, we track the full distribution function $f(avec(r), avec(k), t)$, which tells us the probability of finding an electron at position $avec(r)$ with crystal momentum $hbar avec(k)$ at time $t$. Its evolution is governed by the Boltzmann Transport Equation (BTE):
$ (frac(partial, partial t) + avec(v)(avec(k)) dot nabla_avec(r) - frac(q, hbar) avec(E)(t) dot nabla_avec(k)) f(avec(r), avec(k), t) = lr((frac(dif f, dif t))_"coll"). $ <bte>
The left-hand side describes free streaming (electrons move in space according to their group velocity $avec(v)(avec(k))$) and acceleration by the electric field. The right-hand side is the *collision operator*, which describes individual scattering events — with phonons, impurities, other electrons, surfaces, etc.

The BTE is semi-classical because it treats electrons as particles with definite position _and_ momentum (a phase-space description), but uses quantum mechanics to compute the scattering rates (via Fermi's golden rule) and the group velocity (via the band structure $E(avec(k))$). It is typically solved using *Monte Carlo* methods: you simulate the trajectory of many individual electrons, drawing scattering events randomly from their quantum-mechanically computed probability distributions.

*Relation to Drift-Diffusion:* The DD equations can be derived from the BTE by taking moments (integrating over $avec(k)$) and assuming near-equilibrium conditions. The mobility $mu_n$ emerges as a derived quantity from the scattering rates.

*Limitations:* The BTE works when device dimensions are comparable to or larger than the mean free path, but it still treats electrons as point particles. It cannot capture tunneling (a classical particle cannot penetrate a potential barrier higher than its kinetic energy) or energy quantization (which requires the wave nature of electrons). When the potential varies on the scale of the de Broglie wavelength, the phase-space picture breaks down — position and momentum cannot simultaneously be well-defined (Heisenberg uncertainty), and the concept of a particle trajectory loses meaning.

== Quantum: the Schrödinger equation

At the most fundamental level (for our purposes), electrons are described by wave functions $Psi(avec(r))$ governed by the time-independent Schrödinger equation:
$ (-frac(hbar^2, 2 mstar) nabla^2 + V(avec(r))) Psi(avec(r)) = E thin Psi(avec(r)). $ <schrodinger>
This is simply the eigenvalue problem for the Hamiltonian operator $hat(H) = -hbar^2 \/ (2 mstar) nabla^2 + V(avec(r))$. If you are familiar with elliptic PDEs, you can read it as: $Psi$ is a generalized eigenfunction of a second-order elliptic operator on $RR^d$ (or on a domain with appropriate boundary conditions), with eigenvalue $E$.

The kinetic energy operator $-hbar^2 \/ (2 mstar) nabla^2$ is the quantum-mechanical version of $p^2 \/ (2m)$, where the momentum $avec(p)$ has been replaced by the differential operator $-i hbar nabla$. The potential $V(avec(r))$ encodes the device geometry, material interfaces, applied voltages, and (in the effective mass approximation) the effect of the crystal lattice.

Because electrons are treated as waves, the Schrödinger equation automatically captures phenomena that are invisible to classical and semi-classical models: *tunneling* through potential barriers (the wave function decays exponentially inside a barrier but does not vanish), *energy quantization* from confinement (only certain wavelengths fit in a finite box), and *interference effects* (superposition of reflected and transmitted waves). These are precisely the effects that dominate at the nanoscale.

= When quantum effects matter: the de Broglie wavelength

The transition from classical to quantum behavior is governed by a single length scale: the *de Broglie wavelength* of the electron,
$ lam = frac(h, sqrt(2 mstar E)), $ <debroglie>
where $h = 2 pi hbar$ is Planck's constant, $mstar$ is the effective mass, and $E$ is the electron's kinetic energy. This is the wavelength associated with a quantum particle of momentum $p = sqrt(2 mstar E)$ via the de Broglie relation $lam = h \/ p$.

The rule of thumb is: *quantum effects become important when any device dimension is comparable to or smaller than $lam$.* For electrons near the conduction band edge of silicon ($mstar approx 0.32 thin m_e$, $E approx 0.1$ eV), the de Broglie wavelength is about 6.8 nm. For GaAs ($mstar approx 0.065 thin m_e$), it is about 15.2 nm due to the much lighter effective mass.

In a modern transistor at the 2 nm node, the channel thickness is 4–5 nm and the gate length is 10–12 nm — firmly in the regime where $lam$ is comparable to device dimensions. Quantum transport is not optional; it is necessary.

Note that the device can be "quantum" in some directions and "classical" in others. If the channel is 5 nm thick but extends over hundreds of nanometers in length, quantum confinement matters in the transverse direction (producing discrete sub-bands) while transport along the channel may still be semi-classical. This mixed treatment is one of the practical strategies we will develop later in the course.

= Practical examples of quantum effects in transistors

== Energy quantization from confinement

When a thin layer of silicon (say 5 nm) is sandwiched between silicon oxide barriers, electrons are confined in the transverse direction. The continuous 3-D band structure of bulk silicon is replaced by a set of discrete *sub-bands*: the allowed energies in the confined direction become quantized (like a particle in a box), while electrons remain free to move in the other two directions. The lowest allowed energy level is pushed up from the bulk conduction band edge — this is called *quantum confinement*.

In a real transistor, the gate voltage creates a triangular potential well at the oxide-semiconductor interface. The wave functions of the confined states penetrate slightly into the oxide (exponential tails), and the density of states changes from the bulk $sqrt(E)$ shape to a staircase function, with each step corresponding to the onset of a new sub-band. This changes both the charge distribution (electrons are pushed away from the interface) and the available states for transport.

== Source-to-drain tunneling

The gate creates a potential barrier in the channel that blocks current flow when the transistor is "off." Classically, electrons with energy below the barrier cannot pass. Quantum mechanically, the wave function penetrates into the barrier (decaying exponentially) and, if the barrier is thin enough, has nonzero amplitude on the other side — the electron _tunnels_ through.

The spectral current plots from the lecture illustrate this vividly. At a gate length of 13 nm, essentially all the off-state current comes from thermionic emission — electrons with enough thermal energy to pass _over_ the barrier. At 10 nm, a small tunneling contribution appears. At 7 nm, it is significant. At 4 nm, the barrier is nearly transparent: quantum tunneling dominates the leakage current, and the transistor can no longer be properly turned off.

This source-to-drain tunneling is the fundamental quantum-mechanical limit to transistor scaling. It is invisible to drift-diffusion and Boltzmann models — only a quantum transport simulation can predict it. The entire machinery we will develop in this course (the Wave Function formalism, the NEGF formalism) is designed to compute exactly this kind of quantum tunneling current through nanoscale devices.

= Course roadmap

The semester will build up a complete quantum transport simulation capability, layer by layer. The progression roughly follows: band structure and energy quantization (Lecture 2), discretization of the Schrödinger equation and open boundary conditions (Lecture 3), the Wave Function formalism for charge and current (Lecture 4), the NEGF formalism (Lectures 5–6), application to nano-transistors (Lectures 7–9), and extensions to scattering, phonon transport, and ionic transport in the final lectures.

The reference throughout is Datta's _Electronic Transport in Mesoscopic Systems_.

= Summary

This introductory lecture established the physical motivation for the course:

Transistors have shrunk to dimensions (5–20 nm) where the de Broglie wavelength of electrons ($tilde$ 7 nm in Si) is comparable to device features. At this scale, quantum effects — energy quantization from confinement and tunneling through thin barriers — fundamentally alter device behavior and cannot be captured by classical (Drift-Diffusion) or semi-classical (Boltzmann) models.

The three transport models form a hierarchy: Drift-Diffusion (cheapest, no QM), Boltzmann (treats individual scattering events, still no QM tunneling/quantization), and quantum transport via the Schrödinger equation (captures everything, most expensive). The choice depends on comparing device dimensions to the electron mean free path and de Broglie wavelength.

*Next lecture:* Band structure calculation and energy quantization — the first step toward building a quantum transport simulator.
