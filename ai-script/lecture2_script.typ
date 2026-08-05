#import "math.typ": *
#import "style.typ": *
#show: math-template
#show: style-template

#set heading(numbering: "1.1")
#set page(numbering: "1")
#set math.equation(numbering: "(1)")

#let hbar = $planck$
#let mstar = $m^*$
#let Veff = $V_"eff"$
#let Vext = $V_"ext"$
#let BZ = $"BZ"$

#align(center)[
  #text(size: 18pt, weight: "bold")[Quantum Transport at the Nanoscale]

  #text(size: 14pt)[Lecture 2 — Bandstructure and Quantization]

  #v(0.3em)
  #text(size: 11pt)[Study script based on lectures by Luisier, Cao, and Emboras (ETH Zürich, Spring 2026)]
]

#v(1em)
#outline(indent: 1.5em)
#pagebreak()

= From the many-body problem to single-electron physics

In Lecture 1 we established _why_ quantum transport is necessary: device dimensions are now comparable to the electron de Broglie wavelength, so the Schrödinger equation replaces classical transport models. This lecture addresses the next question: _how_ do we actually set up and solve that Schrödinger equation for electrons in a crystal? The answer requires understanding bandstructure — the allowed energy--momentum relation $E(avec(k))$ — and how confinement modifies it.

== The many-body Schrödinger equation

In principle, computing the electronic structure of a solid means solving the many-body Schrödinger equation
$ hat(H) Psi = E Psi, $ <many-body>
where the Hamiltonian for $N$ electrons and $M$ ions (each carrying charge $Z_j$) is
$ hat(H) = sum_i^N ( -frac(hbar^2, 2 m_0) nabla_i^2 - sum_j^M frac(Z_j e^2, |avec(r)_i - avec(R)_j|) + sum_(j > i) frac(e^2, |avec(r)_i - avec(r)_j|) ). $ <hamiltonian>
The three terms are, in order: the kinetic energy of each electron, the Coulomb attraction between electrons and ions, and the electron--electron repulsion. The many-body wave function $Psi = Psi(avec(r)_1, avec(r)_2, dots, avec(r)_N)$ lives in a $3N$-dimensional configuration space.

This problem is computationally intractable for more than a handful of particles. Even a tiny volume of semiconductor contains $10^3$--$10^10$ electrons. The hydrogen atom ($N=1$) can be solved exactly; the helium atom ($N=2$) already requires approximations. For a real crystal, direct solution is out of the question.

== Reduction to a single-electron equation

The standard escape is to replace the many-body problem with an effective single-electron equation:
$ hat(H) psi(avec(r)) = E thin psi(avec(r)), quad hat(H) = -frac(hbar^2, 2 m_0) nabla^2 + Veff (avec(r)). $ <single-electron>
The wave function $psi(avec(r))$ now depends on a single position $avec(r) = (x, y, z)$, and all the complicated many-body interactions — electron--ion attraction, electron--electron repulsion, exchange, correlation — are absorbed into a single effective potential $Veff (avec(r))$.

The deep question is: can such an effective potential actually exist? The answer, established by Kohn and Sham in 1965, is _yes_: density-functional theory (DFT) proves that there exists a potential $Veff$ such that the charge density obtained from the single-electron equation exactly reproduces the true many-body charge density. The catch is that DFT proves _existence_ but does not provide the _form_ of $Veff$. Since 1965, a hierarchy of approximations has been developed — local density approximation (LDA), generalized gradient approximation (GGA), hybrid functionals — each improving accuracy at increasing computational cost. Kohn received the Nobel Prize in Physics in 1998 for this work. DFT codes (VASP, Quantum ESPRESSO, CP2K, and many others) are among the largest consumers of supercomputer time worldwide.

DFT is "ab initio" — it requires no empirical input, just the atomic positions. It reproduces bandstructures well (correct effective masses, correct band shapes) but has a well-known deficiency: it systematically underestimates band gaps. For silicon, DFT gives $E_g approx 0.6$ eV versus the experimental $1.12$ eV. For narrow-gap materials like InAs, standard DFT can even predict a metal (zero gap) instead of the correct $E_g = 0.37$ eV.

== Empirical methods: tight-binding and pseudopotentials

When DFT is too expensive or its band-gap error is unacceptable, empirical methods provide an alternative. Two important ones are:

*Empirical pseudopotentials (EPP):* The effective potential experienced by valence electrons is approximated by a smooth pseudopotential, with parameters fitted to experimental data. Introduced by Phillips (1958).

*Empirical tight-binding (ETB):* The Hamiltonian is constructed from a basis of localized atomic-like orbitals, with coupling parameters between neighbouring atoms fitted to reproduce known bandstructures. Introduced by Slater and Koster (1954). Tight-binding is extremely efficient — a full bandstructure calculation takes seconds on a laptop, versus tens of minutes (or hours) for DFT. It faithfully reproduces band gaps, effective masses, and the positions of conduction band valleys at the high-symmetry points $Gamma$, $X$, and $L$ of the Brillouin zone.

For a comparison of tight-binding bandstructures of Si (indirect gap, $E_g = 1.12$ eV) and InAs (direct gap, $E_g = 0.37$ eV), see Slide 9.

= Bloch's theorem and the electron wave vector

== Periodicity of the crystal potential

A crystal is built by periodically repeating a primitive unit cell (containing one or a few atoms) along lattice vectors $avec(a)_1, avec(a)_2, avec(a)_3$. Any lattice point can be written as $avec(R) = n_1 avec(a)_1 + n_2 avec(a)_2 + n_3 avec(a)_3$ with $n_i in ZZ$. Because every unit cell is identical, the effective potential inherits the lattice periodicity:
$ Veff (avec(r) + n avec(a)) = Veff (avec(r)). $

== From periodicity to Bloch functions

In a perfect crystal with no applied field and no defects, the probability of finding an electron must be the same in every unit cell: $|psi(avec(r) + n avec(a))|^2 = |psi(avec(r))|^2$. This does _not_ require $psi(avec(r) + n avec(a)) = psi(avec(r))$ — the wave functions need only agree up to a phase factor. As the lecturer emphasized in the transcript: $e^(i phi)$ disappears when you take the modulus squared.

Bloch's theorem formalizes this. The eigenstates of the periodic Hamiltonian can be labelled by a wave vector $avec(k)$ and written as
$ psi_avec(k) (avec(r)) = u_avec(k) (avec(r)) thin e^(i avec(k) dot avec(r)), quad u_avec(k) (avec(r) + n avec(a)) = u_avec(k) (avec(r)), $ <bloch>
where $u_avec(k)$ is a function with the periodicity of the lattice. The quantity $avec(k) = (k_x, k_y, k_z)$ is the electron wave vector (related to crystal momentum via $avec(p) = hbar avec(k)$), and the energy $E$ becomes a function of $avec(k)$: the dispersion relation $E(avec(k))$. The Schrödinger equation must then be solved for each $avec(k)$:
$ hat(H) psi_avec(k) (avec(r)) = E(avec(k)) thin psi_avec(k) (avec(r)). $ <bloch-schrodinger>
The set of all allowed $avec(k)$ values forms the first Brillouin zone (#BZ), determined by the reciprocal lattice of the crystal. For a 3D crystal like silicon, the #BZ is a polyhedron in $avec(k)$-space; for a 2D material like graphene, it is a hexagon. Bandstructure plots show $E(avec(k))$ along high-symmetry paths within the #BZ (typically $L arrow Gamma arrow X arrow Gamma$ for silicon).

= Probability, occupation, and charge density

== Probability density and normalization

If an electron occupies a Bloch state $psi_avec(k)(avec(r))$, the probability density for finding it at position $avec(r)$ is
$ P_avec(k) (avec(r)) = |psi_avec(k) (avec(r))|^2, $ <prob-density>
normalized over the available volume $V$:
$ integral_V dif^3 avec(r) thin P_avec(k) (avec(r)) = 1. $

== The Fermi--Dirac distribution

Knowing _where_ an electron would be (via $P_avec(k)$) is not enough — we also need to know _whether_ a state is occupied. For electrons in thermal equilibrium, the occupation probability is given by the Fermi--Dirac distribution:
$ f(E(avec(k))) = frac(1, 1 + e^((E(avec(k)) - E_F) \/ (k_B T))), $ <fermi>
where $E_F$ is the Fermi level (the energy at which $f = 1\/2$), $k_B$ is Boltzmann's constant, and $T$ is the temperature. At $T = 0$, this is a sharp step function: all states below $E_F$ are fully occupied, all above are empty. As $T$ increases, the step smears out — some states above $E_F$ become partially occupied, and some below become partially empty. For a plot of $f(E)$ at various temperatures, see Slide 13.

The distinction between metals, semiconductors, and insulators follows from the position of $E_F$ relative to the band structure. In a metal, $E_F$ lies within a partially filled band, providing abundant mobile carriers. In a semiconductor, $E_F$ sits in a band gap between a filled valence band and an empty conduction band; thermal excitation can promote a few electrons across the gap. In an insulator, the gap is so large that thermal activation is negligible. The boundary between semiconductor and insulator is not sharp — GaN has a band gap of 3 eV yet is considered a semiconductor because it can be doped, while some oxides with similar gaps cannot be made conductive.

== Charge density and the density of states

The total charge density at position $avec(r)$ combines both ingredients — spatial distribution and occupation:
$ n(avec(r)) = sum_(avec(k) in BZ) P_avec(k) (avec(r)) thin f(E(avec(k))). $ <charge-density>
This sum runs over all $avec(k)$ in the Brillouin zone. For each $avec(k)$, we solve the Schrödinger equation to get $psi_avec(k)$ (and thus $P_avec(k)$), evaluate the energy $E(avec(k))$, and weight by the Fermi function. The result is the electron density throughout the device. (See Slide 15 for examples of computed charge densities in a resonant tunneling diode and a double-gate FET.)

It is often convenient to reformulate @charge-density as an integral over energy rather than a sum over $avec(k)$. Inserting a delta function $delta(E - E(avec(k)))$ and integrating over $E$ (which changes nothing, by the sifting property), one obtains
$ n(avec(r)) = integral dif E thin g(E, avec(r)) thin f(E), $ <charge-density-dos>
where the *density of states* (DOS) is defined as
$ g(E, avec(r)) = sum_avec(k) P_avec(k) (avec(r)) thin delta(E - E(avec(k))). $ <dos-def>
The DOS counts how many states are available at energy $E$ and position $avec(r)$; the Fermi function determines which of them are occupied. The lecturer's hotel analogy (Slide 17) captures this nicely: $g(E, avec(r))$ is the number of rooms on floor $E$ at position $avec(r)$, and $f(E)$ is the occupancy rate, which decreases as the floor number increases.

#pagebreak()

= The effective mass approximation

The full bandstructure $E(avec(k))$ is complicated and material-specific. A powerful simplification comes from observing that near a band extremum (the conduction band minimum for electrons), the dispersion is approximately _parabolic_:
$ E(avec(k)) approx E_"CB" + frac(hbar^2 |avec(k)|^2, 2 mstar). $
The curvature of the parabola is controlled by the effective mass $mstar$, defined via
$ frac(1, mstar) = frac(1, hbar^2) frac(partial^2 E, partial k^2). $ <eff-mass-def>
This is computed from the true bandstructure (obtained by DFT or tight-binding) by evaluating the second derivative at the band edge. For silicon at the $X$ valley, $mstar approx 0.91 thin m_0$ (longitudinal); for InAs at $Gamma$, $mstar approx 0.023 thin m_0$. The parabolic fit works well over a wider energy range for heavier effective masses — compare the overlays on Slide 18.

The physical content of this approximation is striking: an electron in a crystal behaves like a free electron in vacuum, except with a modified mass that encodes all the effects of the periodic crystal potential. The original Schrödinger equation with $Veff$ and the bare mass $m_0$ is replaced by
$ (- frac(hbar^2, 2 mstar) nabla^2 + Vext (avec(r))) psi_avec(k) (avec(r)) = E(avec(k)) thin psi_avec(k) (avec(r)), $ <ema-schrodinger>
where the potential $Vext$ now represents only _external_ influences: applied voltages (electrostatics via Poisson's equation) and material interfaces (band offsets at heterojunctions). The many-body crystal potential has been absorbed into $mstar$.

A few important remarks about @ema-schrodinger:

The effective mass can be *position-dependent* $mstar = mstar (avec(r))$, which happens whenever the material changes (e.g., across a heterostructure). It can also be *anisotropic*: $m_x^* eq.not m_y^* eq.not m_z^*$, in which case the kinetic operator becomes $-(hbar^2\/2)(partial_x^2 \/ m_x^* + partial_y^2 \/ m_y^* + partial_z^2 \/ m_z^*)$. Silicon's conduction band valleys have this anisotropy ($m_L = 0.91 thin m_0$, $m_T = 0.19 thin m_0$), producing ellipsoidal constant-energy surfaces in $avec(k)$-space rather than spheres.

This is the form of the Schrödinger equation used throughout the rest of the course.

= Special case 1: bulk semiconductor

== Setup and solution

A "bulk" semiconductor is a homogeneous chunk of material — same composition everywhere, no applied field, no surfaces:
$ Vext (avec(r)) = 0, quad psi_avec(k)(avec(r) + {L_x, L_y, L_z}) = psi_avec(k)(avec(r)), $
where $L_x, L_y, L_z$ are the dimensions and $V = L_x L_y L_z$ is the volume. We impose periodic boundary conditions (Born--von Karman conditions), which discretize the allowed $avec(k)$ values to $k_(x,y,z) = n_(x,y,z) dot 2 pi \/ L_(x,y,z)$ with $n_(x,y,z) in ZZ$.

The EMA Schrödinger equation reduces to
$ -frac(hbar^2, 2 mstar) nabla^2 psi_avec(k) (avec(r)) = E(avec(k)) thin psi_avec(k) (avec(r)). $
This is the free-particle equation (on a torus), with well-known solutions:
$ psi_avec(k) (avec(r)) = frac(1, sqrt(V)) e^(i avec(k) dot avec(r)), quad E(avec(k)) = frac(hbar^2 |avec(k)|^2, 2 mstar). $ <bulk-solution>
The prefactor $1\/sqrt(V)$ ensures the normalization $integral_V |psi|^2 dif^3 avec(r) = 1$. For anisotropic masses, the energy becomes $E(avec(k)) = (hbar^2 \/ 2)(k_x^2 \/ m_x^* + k_y^2 \/ m_y^* + k_z^2 \/ m_z^*)$, and the constant-energy surfaces are ellipsoids rather than spheres (see Slide 24).

== Bulk charge density

Because $P_avec(k)(avec(r)) = |psi_avec(k)|^2 = 1\/V$ is position-independent, the charge density simplifies to
$ n_"bulk" = frac(1, V) sum_avec(k) f(E(avec(k))). $
This is a constant — the electron density is uniform throughout the bulk, as expected from the translational symmetry.

== Bulk density of states

The DOS for bulk with isotropic parabolic bands is derived by converting the sum over $avec(k)$ to an integral. The steps (detailed in the Appendix slides 47--49) are: (1) replace $1\/V sum_avec(k) arrow 1\/(8 pi^3) integral dif^3 avec(k)$ using the density of $avec(k)$-points; (2) include a factor of 2 for spin degeneracy; (3) switch from Cartesian $dif k_x dif k_y dif k_z$ to spherical coordinates $4 pi |avec(k)|^2 dif |avec(k)|$, exploiting the isotropy of $E(avec(k))$; (4) change variables from $|avec(k)|$ to energy $E' = hbar^2 |avec(k)|^2 \/ (2 mstar)$. The result is:
$ g_"bulk" (E) = frac(8 pi sqrt(2 mstar^3), h^3) sqrt(E). $ <bulk-dos>
The key features (exam hint): the bulk DOS is proportional to $sqrt(E)$ and to $mstar^(3\/2)$. A heavier effective mass gives a larger DOS — more states are available per unit energy. You should be able to sketch $g_"bulk" (E)$ for two different materials and identify which has the larger effective mass from the curve that rises more steeply (see Slide 27 for a comparison of InAs, GaAs, and Si).

For the density-of-states effective mass of silicon (which has six equivalent ellipsoidal valleys), the appropriate mass entering @bulk-dos is $mstar_"DOS" = (m_L m_T^2)^(1\/3) approx 0.32 thin m_0$, where $m_L = 0.91 thin m_0$ and $m_T = 0.19 thin m_0$.

#pagebreak()

= Special case 2: quantum well

== Definition and band diagram

A quantum well (QW) is a thin layer of a narrow-gap semiconductor sandwiched between two thick layers of a wider-gap material — for example, GaAs between Al#sub[0.3]Ga#sub[0.7]As. The well layer has thickness $L_"QW"$ along $x$; in the transverse directions $y, z$, the structure extends over macroscopic lengths $L_y, L_z$ (area $A = L_y L_z$).

The key new feature is a *position-dependent potential* along $x$:
$ Vext (avec(r)) = V_"QW" (x), $
while the $y$ and $z$ directions remain periodic. The potential $V_"QW"(x)$ encodes the conduction band offset $Delta E_"CB"$ between the two materials: it equals zero inside the GaAs well and $Delta E_"CB"$ inside the AlGaAs barriers.

This potential is constructed from the _band diagram_ — a plot of the conduction band edge versus position — which must be distinguished from the _bandstructure_ (energy vs. wave vector). The band diagram is obtained by walking through the heterostructure along $x$ and reading off the conduction band minimum of whatever material is present at each position. See Slide 30 for a side-by-side comparison of bandstructure and band diagram for a GaAs/AlGaAs quantum well.

== Separation of variables and the 1-D Schrödinger equation

Since $V_"QW"$ depends only on $x$, the wave function separates:
$ psi_(avec(k)_t) (x, avec(r)_t) = frac(1, sqrt(A)) e^(i avec(k)_t dot avec(r)_t) phi(x), quad integral dif x |phi(x)|^2 = 1, $ <qw-ansatz>
where $avec(r)_t = (y, z)$ and $avec(k)_t = (k_y, k_z)$ are the transverse position and wave vector. Inserting this into @ema-schrodinger and separating the $x$-dependent part from the free-particle $(y, z)$ part yields a 1-D eigenvalue problem for $phi(x)$:
$ (-frac(hbar^2, 2 mstar) frac(partial^2, partial x^2) + V_"QW" (x)) phi(x) = cal(E) thin phi(x). $ <qw-1d>
The total energy is
$ E(avec(k)_t) = cal(E) + frac(hbar^2 |avec(k)_t|^2, 2 mstar). $ <qw-energy>
The transverse part still gives a free-electron dispersion, while $cal(E)$ — the quantized part — must be found by solving @qw-1d.

== Analytical solution: infinite potential barriers

For a quantum well of width $L_"QW"$ with _infinitely_ high barriers, $phi(x)$ must vanish at $x = 0$ and $x = L_"QW"$ (since the wave function decays as $e^(-kappa x)$ inside a barrier with $kappa arrow infinity$). With $V_"QW" = 0$ inside the well, @qw-1d becomes the free-particle equation on $(0, L_"QW")$ with Dirichlet boundary conditions.

The general solution inside the well is $phi(x) = a cos(k_x x) + b sin(k_x x)$. Applying $phi(0) = 0$ immediately gives $a = 0$. Then $phi(L_"QW") = b sin(k_x L_"QW") = 0$ requires either $b = 0$ (trivial solution) or $k_x L_"QW" = n pi$ with $n = 1, 2, 3, dots$ This gives discrete wave vectors and hence discrete energies:
$ cal(E)_n = frac(hbar^2, 2 mstar) (frac(n pi, L_"QW"))^2, quad phi_n (x) = sqrt(frac(2, L_"QW")) sin(frac(n pi, L_"QW") x). $ <qw-quantization>
The energy spectrum is no longer continuous — it is *quantized*, indexed by the quantum number $n$. The normalization constant $sqrt(2\/L_"QW")$ comes from the condition $integral_0^(L_"QW") |phi_n|^2 dif x = 1$. Each $phi_n$ has exactly $n$ half-wavelengths fitting inside the well ($n - 1$ interior nodes). The spacing between successive levels $cal(E)_(n+1) - cal(E)_n$ _increases_ with $n$ (since $cal(E)_n prop n^2$). See Slide 34 for a plot of the first four eigenstates of a 5 nm GaAs quantum well.

If you are familiar with Sturm--Liouville theory, this is a textbook example: $-phi'' = lambda phi$ on $(0, L)$ with Dirichlet conditions gives eigenvalues $lambda_n = (n pi \/ L)^2$.

== Charge density and density of states in the quantum well

Because the $x$-symmetry is broken, the probability density $P$ now depends on the transverse wave vector $avec(k)_t$ _and_ the quantum number $n$. The charge density becomes
$ n_"QW" (avec(r)) = frac(1, A) sum_n sum_(avec(k)_t) |phi_n (x)|^2 f(cal(E)_n + frac(hbar^2 |avec(k)_t|^2, 2 mstar)). $ <qw-charge>
The quantum well DOS is derived analogously to the bulk case, but now the $avec(k)$-sum is 2-dimensional (a circle in $(k_y, k_z)$-space rather than a sphere). The steps are: (1) $1\/A sum_(avec(k)_t) arrow 1\/(4 pi^2) integral dif^2 avec(k)_t$; (2) include a spin factor of 2; (3) use polar coordinates: $dif^2 avec(k)_t = 2 pi |avec(k)_t| dif |avec(k)_t|$; (4) change variables to $E' = hbar^2 |avec(k)_t|^2 \/ (2 mstar)$, and use the sifting property $integral dif E' delta(E - cal(E)_n - E') = cal(H)(E - cal(E)_n)$ where $cal(H)$ is the Heaviside step function. The result (see Slide 37 and Appendix Slide 50) is:
$ g_"QW" (E, avec(r)) = frac(mstar, pi hbar^2) sum_n |phi_n (x)|^2 thin cal(H)(E - cal(E)_n). $ <qw-dos>
The QW DOS is a *staircase function*: each time $E$ crosses a quantized level $cal(E)_n$, a new step of height $mstar \/ (pi hbar^2)$ is added (modulated by $|phi_n(x)|^2$, which carries the position dependence).

If we average over the well width, $g_("QW,av")(E) = 1\/L_"QW" integral dif x thin g_"QW"(E, avec(r))$, the $|phi_n|^2$ integrates to $1\/L_"QW"$ (by normalization) and the averaged DOS takes the simple form
$ g_("QW,av") (E) = frac(mstar, L_"QW" pi hbar^2) sum_n cal(H)(E - cal(E)_n). $

Two properties to remember (exam hint): the *step height* is proportional to $mstar$ (heavier mass $arrow$ taller steps), and the *spacing between steps* is inversely proportional to $mstar$ (since $cal(E)_n prop 1\/mstar$, heavier mass $arrow$ denser levels). See Slide 38 for a comparison across InAs, GaAs, and Si.

A satisfying consistency check: as $L_"QW" arrow infinity$, the quantized levels $cal(E)_n prop 1\/L_"QW"^2$ become infinitely dense, the staircase fills in, and $g_("QW,av")$ converges to the bulk $sqrt(E)$ DOS (see Slide 39). This is exactly what one expects — a very wide "quantum well" is indistinguishable from bulk.

#pagebreak()

= Discretization of the Schrödinger equation

== Motivation: beyond infinite barriers

The analytical solution @qw-quantization applies only to the idealized case of infinite potential barriers. For real heterostructures, the barrier height $Delta E_"CB"$ is finite (determined by the material combination), and the effective mass may differ between well and barrier regions. In this general case, the 1-D Schrödinger equation takes the form
$ (-frac(hbar^2, 2 m_0) frac(partial, partial x) frac(1, mstar (x)) frac(partial, partial x) + V_"QW" (x)) phi(x) = E thin phi(x), $ <general-1d>
where $mstar(x)$ is now sandwiched _between_ the two spatial derivatives. This particular operator ordering (the BenDaniel--Duke form) ensures current continuity across material interfaces where $mstar$ changes discontinuously — a point the lecturer noted will be proved in a later lecture.

@general-1d has no closed-form solution for a general $V_"QW"(x)$. We must solve it numerically.

== Finite-difference discretization

We sample the wave function on a uniform grid $x_1, x_2, dots, x_N$ with spacing $Delta x$, writing $phi_i equiv phi(x_i)$. The second derivative with position-dependent mass is approximated by finite differences. As part of Exercise 1, one derives that @general-1d takes the tridiagonal form
$ (E - H_(i i)) phi_i - H_(i,i+1) phi_(i+1) - H_(i,i-1) phi_(i-1) = 0, $ <discrete-schrodinger>
where $H_(i i)$, $H_(i,i+1)$, and $H_(i,i-1)$ are matrix elements encoding the kinetic energy (coupling between neighbouring grid points) and the local potential $V_"QW"(x_i)$. Deriving the explicit expressions for these entries is the main task of Exercise 1.

Collected into a matrix equation, @discrete-schrodinger becomes the $N times N$ eigenvalue problem $amat(H) avec(phi) = E avec(phi)$, where $amat(H)$ is a real symmetric tridiagonal matrix. Diagonalizing it yields $N$ eigenvalues (the quantized energies) and $N$ eigenvectors (the discretized wave functions). The grid must be fine enough to resolve the spatial oscillations of the wave function — typically several points per half-wavelength of the highest relevant state.

From a numerical PDE perspective, the discretization of @general-1d via second-order centered finite differences on a uniform grid is standard for 1-D Sturm--Liouville problems. The tridiagonal structure reflects the nearest-neighbour coupling of the three-point stencil. The fact that the operator is self-adjoint (with appropriate boundary conditions) guarantees real eigenvalues and orthogonal eigenfunctions — consistent with the physical requirements on energies and wave functions.

= Summary

This lecture covered the chain of approximations that lead from the intractable many-body Schrödinger equation to the effective-mass equation that will be used throughout the course:

Many-body problem $arrow.r$ single-electron equation (via DFT / mean-field) $arrow.r$ effective mass approximation (parabolic bands, crystal potential absorbed into $mstar$) $arrow.r$ the working Schrödinger equation with external potential $Vext$ and effective mass $mstar$.

For *bulk* semiconductors (no spatial variation), the solutions are plane waves $psi prop e^(i avec(k) dot avec(r))$ with parabolic dispersion $E = hbar^2 k^2 \/ (2mstar)$, and the DOS goes as $sqrt(E)$.

For *quantum wells* (confinement along one direction), the confined direction produces discrete energy levels $cal(E)_n prop n^2$ and a staircase DOS. The transverse directions remain free.

For general heterostructures (finite barriers, position-dependent $mstar$), the 1-D Schrödinger equation must be solved numerically via finite-difference discretization, yielding a tridiagonal eigenvalue problem.

*Next lecture:* open boundary conditions and the first step into transport — moving from closed (bound-state) problems to open systems into which electrons can be injected.
