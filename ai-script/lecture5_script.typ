#import "math.typ": *
#import "style.typ": *
#show: math-template
#show: style-template

#set heading(numbering: "1.1")
#set page(numbering: "1")
#set math.equation(numbering: "(1)")

#let hbar = $planck$
#let mstar = $m^*$
#let GR = $G^R$
#let GA = $G^A$
#let Gless = $G^<$
#let SigR = $Sigma^R$
#let SigA = $Sigma^A$
#let Sigless = $Sigma^<$

#align(center)[
  #text(size: 18pt, weight: "bold")[Quantum Transport at the Nanoscale]

  #text(size: 14pt)[Lecture 5 — Electrostatics and Introduction to NEGF]

  #v(0.3em)
  #text(size: 11pt)[Study script based on lectures by Luisier, Cao, and Emboras (ETH Zürich, Spring 2026)]
]

#v(1em)
#outline(indent: 1.5em)
#pagebreak()

= Part I: Poisson's equation and electrostatics

== Why electrostatics matters

So far, the potential $V(x)$ entering the Schrödinger equation has consisted solely of the _band discontinuity_ --- the conduction band offset $Delta E_"CB"$ between different materials. But in a real device, the electrostatic potential created by all the charges (electrons, holes, ionized dopants) also contributes to $V(x)$. The total potential energy seen by an electron is
$ V(x) = V_"band" (x) - q Phi(x), $ <V-total>
where $V_"band"(x)$ encodes the material-dependent band edges and $Phi(x)$ is the electrostatic potential. The Schrödinger equation and the electrostatic potential are therefore _coupled_: the wave functions determine the charge density $rho$, and $rho$ determines $Phi$ through Poisson's equation, which in turn modifies the Hamiltonian $amat(H)$ (through its diagonal entries $H_(i i) = V(x_i) + "kinetic terms"$).

== Poisson's equation

The electrostatic potential $Phi(avec(r))$ and the charge density $rho(avec(r))$ are related by Poisson's equation:
$ nabla dot (epsilon(avec(r)) nabla Phi(avec(r))) = -rho(avec(r)), $ <poisson>
where $epsilon(avec(r))$ is the (position-dependent) dielectric permittivity. The charge density in a semiconductor is
$ rho(avec(r)) = q (p(avec(r)) - n(avec(r)) + N_D (avec(r)) - N_A (avec(r))), $ <charge-density>
with $p$ the hole concentration, $n$ the electron concentration, $N_D$ the ionized donor concentration, and $N_A$ the ionized acceptor concentration. In the n-type devices we consider, $p approx 0$ and $N_A = 0$, so $rho = q(N_D - n)$.

Note the form of @poisson: the divergence acts on $epsilon nabla Phi$, not on $nabla Phi$ alone. This is the correct weak form that ensures the electric displacement $avec(D) = epsilon avec(E)$ (with $avec(E) = -nabla Phi$) is continuous across material interfaces where $epsilon$ jumps. This is entirely analogous to the BenDaniel--Duke ordering in the Schrödinger equation, where $nabla dot (1\/mstar) nabla$ ensures current continuity across mass discontinuities.

The electric field is $avec(E)(avec(r)) = -nabla Phi(avec(r))$, and differentiating @poisson yields $nabla dot avec(E) = rho \/ epsilon$ (Gauss's law). See Slide 7 for a textbook example: the p-n junction, where the abrupt charge in the depletion region ($+q N_D$ on the n-side, $-q N_A$ on the p-side) produces a triangular electric field (by integration) and a smooth built-in potential (by a second integration).

== Boundary conditions for Poisson's equation

As a second-order elliptic PDE, Poisson's equation requires boundary conditions. Two standard types apply:

*Dirichlet:* $Phi(0) = F_0$, $Phi(L) = F_L$ --- prescribe the potential value at the boundary.

*Neumann:* $(dif Phi)/(dif x)|_(x = 0) = B_0$, $(dif Phi)/(dif x)|_(x = L) = B_L$ --- prescribe the normal derivative.

For transport problems with open boundary conditions, *homogeneous Neumann conditions* ($B_0 = B_L = 0$) are the natural choice. Setting $dif Phi \/ dif x = 0$ at the boundaries means $Phi(x) = "const"$ near the contacts, which implies $avec(E) = 0$ and hence $rho = 0$ there. This enforces *charge neutrality* at the contact boundaries: $n = N_D$ (electrons exactly compensate ionized donors). This is both physically realistic (the heavily doped source/drain regions of a transistor are charge-neutral in bulk) and consistent with the flat-band assumption we made for the Schrödinger contacts in Lecture 3 --- the potential must be flat at the contact boundaries for the plane-wave ansatz to be valid.

== Discretization and Newton--Raphson solution

Like the Schrödinger equation, Poisson's equation is discretized on the same grid of $N$ points, yielding a tridiagonal linear system $amat(M) avec(Phi) = -avec(rho)$. The matrix $amat(M)$ encodes the second-derivative operator with the position-dependent $epsilon$; its entries are derived in Exercise 4.

However, $amat(M) avec(Phi) = -avec(rho)$ cannot be solved by a single matrix inversion because $rho$ itself depends on $Phi$ (through the charge density computed from the Schrödinger equation). The system is _nonlinear_. Direct iteration (solve Schrödinger $arrow$ get $rho$ $arrow$ solve Poisson $arrow$ get new $Phi$ $arrow$ repeat) diverges in practice.

The standard remedy is the *Newton--Raphson method*. Define $avec(F)(avec(Phi)) = amat(M) avec(Phi) + avec(rho)(avec(Phi))$; the solution satisfies $avec(F) = 0$. At each iteration $n$, compute the Jacobian $amat(J) = dif avec(F) \/ dif avec(Phi) = amat(M) + dif avec(rho) \/ dif avec(Phi)$ (where $dif rho \/ dif Phi$ is a diagonal matrix), solve the linear system $-amat(J) dot dif avec(Phi)_n = avec(F)(avec(Phi)_n)$ for the correction $dif avec(Phi)_n$, and update $avec(Phi)_(n+1) = avec(Phi)_n + dif avec(Phi)_n$. Convergence is reached when $|dif avec(Phi)|$ is negligible (typically 5--10 iterations, with quadratic convergence in the best case).

== The self-consistent Schrödinger--Poisson loop

The full simulation procedure is:

1. Choose the applied voltage $V_"ext"$ and construct an initial guess $Phi_0(x)$.
2. Add $-q Phi_0$ to the diagonal of $amat(H)$ via @V-total. Solve the Schrödinger equation (WF or NEGF) to obtain $rho_0(x) = q(N_D (x) - n_0 (x))$.
3. Pass $rho_0$ to the Poisson solver. Newton--Raphson yields a correction $dif Phi_0$; update $Phi_1 = Phi_0 + dif Phi_0$.
4. Return to step 2 with $Phi_1$. Iterate until the correction is below a convergence threshold.
5. Extract the converged charge density, transmission, and current at this voltage.

For a full $I$--$V$ curve, sweep over voltages, using the converged potential from the previous bias point as the initial guess for the next.

See Slide 15 for the self-consistent solution of the tunnelling barrier: the top-left panel shows $n(x)$ and $N_D (x)$ (they match at the boundaries --- charge neutrality), the top-right panel shows $rho(x) = q(n - N_D)$ (zero at the boundaries), the bottom-left shows $avec(E)(x)$ (zero at the boundaries), and the bottom-right shows $Phi(x)$ (flat at the boundaries, with the total drop equal to $V_"ext"$).

#pagebreak()

= Part II: Non-Equilibrium Green's Functions (NEGF)

The Wave Function formalism developed in Lectures 3--4 is a complete framework for coherent quantum transport: it yields charge density, DOS, and current. The NEGF formalism provides an _alternative_ route to the same quantities, but expressed entirely in terms of _Green's functions_ and _self-energies_ rather than wave functions and injection vectors. The advantage of NEGF is twofold: (i) it generalizes naturally to include inelastic scattering (electron--phonon interactions), which breaks the coherence assumed in the WF approach; (ii) it is the standard language of the mesoscopic transport community. The derivation in this lecture is _empirical_ --- we will show that the NEGF expressions reproduce the same charge density as the WF formalism, and assign names to the resulting objects. A more systematic derivation (via the equations of motion for field operators) exists but is beyond the scope of this course.

== Green's functions: general definition <gf-general>

Given a linear differential equation $cal(L) f(x) = S(x)$, where $cal(L)$ is a linear operator (e.g. the Laplacian, or $E + hbar^2 \/ (2 mstar) partial_x^2 - V_0$) and $S$ is a source term, the *Green's function* $G(x, x')$ of $cal(L)$ is defined as the distributional solution of
$ cal(L) G(x, x') = delta(x - x'). $ <gf-def>
The solution of the original equation is then recovered via convolution:
$ f(x) = integral dif x' thin G(x, x') S(x'). $ <gf-convolution>
Verification is immediate: applying $cal(L)$ to both sides of @gf-convolution and using @gf-def gives $cal(L) f = integral delta(x - x') S(x') dif x' = S(x)$.

Two physical interpretations are useful. As a *propagator*, $G(x, x')$ describes how a point source at $x'$ influences the solution at $x$. As a *correlation function*, $|G(x, x')|$ measures how strongly the points $x$ and $x'$ are coupled through the operator $cal(L)$.

In the discrete (matrix) setting, the operator $cal(L)$ becomes an $N times N$ matrix $amat(L)$, the delta function becomes the identity matrix $amat(I)$, and the Green's function becomes an $N times N$ matrix $amat(G)$ satisfying $amat(L) amat(G) = amat(I)$, i.e. $amat(G) = amat(L)^(-1)$. The convolution becomes matrix--vector multiplication: $avec(f) = amat(G) avec(S)$.

== The retarded Green's function of the Schrödinger equation <retarded-gf>

To build intuition, consider the 1-D Schrödinger equation with a constant potential $V_0$ on a domain with open (non-reflecting) boundaries. The operator is $cal(L) = E + (hbar^2)/(2 mstar) partial_x^2 - V_0$, and the Green's function equation is
$ (E + frac(hbar^2, 2 mstar) frac(partial^2, partial x^2) - V_0) G(x, x') = delta(x - x'). $ <gf-schrodinger>
Away from the singularity at $x = x'$, the right-hand side vanishes and $G$ satisfies the homogeneous Schrödinger equation, whose general solution is a linear combination of $e^(plus.minus i k(x - x'))$ with $k = sqrt(2 mstar (E - V_0)) \/ hbar$. We need an outgoing-wave (radiation) boundary condition: physically, a point source should produce waves that propagate _away_ from $x'$ in both directions, not waves converging toward $x'$. This selects:
$ G(x, x') = cases(A^+ e^(i k (x - x')) & x > x', A^- e^(-i k (x - x')) & x < x'.) $ <gf-ansatz>

This is where the concept of _retarded_ vs. _advanced_ enters. The choice of sign in the exponentials determines the _causality_ of the Green's function:

*Retarded Green's function $GR$:* Outgoing waves propagate _away_ from the source. For $x > x'$, the wave moves to the right ($e^(+i k(x - x'))$); for $x < x'$, it moves to the left ($e^(-i k(x - x'))$). The retarded GF describes the _response_ to an excitation: it propagates the effect of a source at $x'$ to an observation point $x$.

*Advanced Green's function $GA$:* Incoming waves converge _toward_ the source. The signs of $k$ are flipped relative to $GR$. The advanced GF represents the time-reversed process: given a wave at $x$, it traces it back to the source at $x'$.

The two matching conditions at $x = x'$ --- continuity of $G$ and a jump in $partial_x G$ (obtained by integrating @gf-schrodinger across $x = x'$) --- yield $A^+ = A^- = -i mstar \/ (k hbar^2)$, so the retarded GF is
$ GR (x, x') = -frac(i mstar, k hbar^2) e^(i k |x - x'|). $ <GR-continuum>
The advanced GF is obtained by complex conjugation (equivalently, by exchanging $x$ and $x'$):
$ GA (x, x') = +frac(i mstar, k hbar^2) e^(-i k |x - x'|) = GR^* (x', x). $ <GA-continuum>

The sign flip in the exponent reflects the reversal of propagation direction.

_Remark on uniqueness._ The differential equation @gf-schrodinger does not, by itself, determine $G$ uniquely --- the boundary conditions do. The retarded and advanced GFs are both solutions of the same equation but with opposite radiation conditions. This is exactly the distinction between the outgoing and incoming fundamental solutions of the Helmholtz equation $(-Delta - k^2) G = delta$ in scattering theory. The retarded GF satisfies the _Sommerfeld radiation condition_ (outgoing waves at infinity); the advanced GF satisfies the _anti-Sommerfeld_ condition (incoming waves). In the time-dependent picture, "retarded" means the response follows the excitation in time ($t > t'$); "advanced" means the response precedes it ($t < t'$). In steady-state problems like ours, the distinction manifests as the sign of the imaginary part in the propagation phase.

#pagebreak()

== From wave functions to Green's functions: the discrete formalism <wf-to-gf>

In the discretized open-boundary Schrödinger equation from Lecture 3,
$ (E dot amat(I) - amat(H) - amat(Sigma)) avec(phi) = avec(S), $
the operator $(E dot amat(I) - amat(H) - amat(Sigma))$ is the discrete analogue of $cal(L)$. The *retarded Green's function matrix* is defined as its inverse:
$ (E dot amat(I) - amat(H) - SigR) dot GR = amat(I), quad "i.e." quad GR (E) = (E dot amat(I) - amat(H) - SigR)^(-1). $ <GR-matrix>
The self-energy $amat(Sigma)$ from Lecture 3 is now explicitly called $SigR$ (retarded self-energy) because it was derived with the outgoing-wave (retarded) radiation condition. The advanced counterpart is $SigA = (SigR)^dagger$ (the conjugate transpose, which for our 1-D case is just the entry-wise complex conjugate since $SigR$ is diagonal). The advanced Green's function is $GA = (GR)^dagger$.

The wave function is immediately recovered: $avec(phi) = GR dot avec(S)$. The crucial observation is that the charge density requires $|avec(phi)|^2$, not $avec(phi)$ itself:
$ |phi_i|^2 = (avec(phi) avec(phi)^dagger)_(i i) = (GR dot avec(S) dot avec(S)^dagger dot GA)_(i i). $ <phi-squared>

This expresses $|phi|^2$ as the diagonal of a matrix product involving only Green's functions and injection vectors. The goal of the NEGF formalism is to absorb the injection vectors $avec(S)$ into _self-energy_ objects, yielding expressions that depend only on Green's functions and self-energies.

== The lesser self-energy and lesser Green's function <lesser-gf>

Starting from the charge density derived in Lecture 4,
$ n(x) = integral dif E' sum_c g^c (E', x) F(E', E_(F c)), $
and substituting the DOS $g^c = (1)/(2 pi) |phi^c_E (x)|^2 |dif E \/ dif k_c|^(-1)$, we replace $|phi^c|^2$ by $"diag"(GR dot avec(S)^c dot avec(S)^(c dagger) dot GA)$ using @phi-squared. Grouping the contact-dependent factors between $GR$ and $GA$ defines the *lesser self-energy*:
$ Sigless (E) = i sum_c avec(S)^c dot avec(S)^(c dagger) lr(|frac(dif E, dif k_c)|)^(-1) F(E, E_(F c)) Delta x, $
and the *lesser Green's function*:
$ Gless (E) = GR (E) dot Sigless (E) dot GA (E). $ <Gless-def>
The electron density is then
$ n(x) = -frac(i, Delta x) integral frac(dif E, 2 pi) "diag"{Gless (E)}. $ <n-from-Gless>

The lesser Green's function $Gless$ is a _correlation function_: its diagonal element $Gless_(i i)(E)$ gives the electron occupation at grid point $i$ and energy $E$, while its off-diagonal elements $Gless_(i j)$ measure the quantum-mechanical correlation between points $i$ and $j$.

== The broadening function $Gamma$ and the clean form of $Sigless$

The lesser self-energy $Sigless$ still involves the injection vectors $avec(S)$ and the derivative $dif E \/ dif k_c$. We can eliminate both by introducing the *contact broadening function*:
$ Gamma_c (E) = i (Sigma^R_c - Sigma^A_c), $ <Gamma-def>
which is a real, non-negative quantity. For our 1-D system, $Gamma_c$ is a matrix with a single nonzero entry: $Gamma_(1 1) = 2 T_L sin(k_L Delta x)$ for $c = L$, or $Gamma_(N N) = 2 T_R sin(k_R Delta x)$ for $c = R$.

By explicit computation (substituting the known expressions for $avec(S)^c$ and $dif E \/ dif k_c$ from Lectures 3--4 and using trigonometric identities), one verifies that
$ Sigless_(c c) (E) = i thin Gamma_(c c)(E) thin F(E, E_(F c)). $ <Sigless-from-Gamma>
This is a key simplification: $Sigless$ is determined entirely by the retarded self-energy $SigR$ (through $Gamma$) and the Fermi integral $F$. No injection vectors or dispersion derivatives are needed.

The total lesser self-energy is the sum over contacts: $Sigless = i (Gamma_L F_L + Gamma_R F_R)$, where we use shorthand $F_c = F(E, E_(F c))$.

*Physical meaning of $Gamma$:* In a closed system, the eigenvalues of $amat(H)$ are discrete (delta-function peaks in the DOS). When the system is opened to contacts, each discrete level acquires a finite _width_ --- it broadens into a Lorentzian-like peak. The broadening function $Gamma$ measures this width. At an energy where $Gamma$ is large, the contact is strongly coupled to the device and levels are broad; where $Gamma$ is small, the coupling is weak and levels are sharp. This is directly visible in the transmission function through a resonant tunnelling structure: the narrow peak in $T(E)$ at the resonance energy has a width determined by $Gamma$ at that energy.

== Density of states in the NEGF formalism

Separating the contact sum, the charge density becomes
$ n(x) = integral dif E sum_c g^c (E, x) F(E, E_(F c)), $
with the contact-resolved DOS now expressed as
$ g^c (E, x) = frac(1, 2 pi Delta x) "diag"(GR (E) dot Gamma_c (E) dot GA (E)). $ <dos-negf>
This is the NEGF expression for the DOS. It depends only on the retarded Green's function and the broadening function --- both computable from $SigR$ alone (since $GA = (GR)^dagger$ and $Gamma = i(SigR - SigA)$). The injection vectors $avec(S)$ have been completely eliminated.

== Summary of NEGF quantities and their roles

The NEGF formalism introduces the following objects:

*$GR (E) = (E dot amat(I) - amat(H) - SigR)^(-1)$* --- the retarded Green's function. It is the matrix inverse of the operator at energy $E$. It propagates excitations from their source to the observation point.

*$GA (E) = (GR)^dagger$* --- the advanced Green's function. It propagates in the reverse direction (from observation point back to source).

*$SigR$* --- the retarded (boundary) self-energy. Same as the $amat(Sigma)$ from Lecture 3. Encodes the effect of the semi-infinite contacts on the finite device.

*$SigA = (SigR)^dagger$* --- the advanced self-energy.

*$Gamma_c = i(Sigma^R_c - Sigma^A_c)$* --- the contact broadening function. Measures how strongly contact $c$ couples to the device at each energy.

*$Sigless = i sum_c Gamma_c F(E, E_(F c))$* --- the lesser self-energy. Encodes _which states are occupied_, combining the contact coupling ($Gamma$) with the occupation probability ($F$).

*$Gless = GR dot Sigless dot GA$* --- the lesser Green's function. Its diagonal gives the energy- and position-resolved electron density.

The computational procedure for the NEGF formalism at each energy $E$ is: (1) compute $k_L, k_R$ from the contact dispersion; (2) construct $SigR$ (two nonzero entries); (3) compute $Gamma_L, Gamma_R$ from $SigR$; (4) compute $GR = (E dot amat(I) - amat(H) - SigR)^(-1)$, then $GA = (GR)^dagger$; (5) compute the DOS as $g^c = "diag"(GR Gamma_c GA) \/ (2 pi Delta x)$. The charge density and current then follow from the same formulas as in the WF formalism. In 1-D, the WF and NEGF approaches give identical results. The advantage of NEGF will become apparent when scattering is included (Lecture 6 and beyond), because scattering self-energies can be added to $SigR$ and $Sigless$ in a systematic way.

#pagebreak()

= Summary

*Part I: Electrostatics.* The potential entering the Schrödinger equation consists of band offsets _plus_ the electrostatic potential $Phi(x)$, which is determined by Poisson's equation $nabla dot epsilon nabla Phi = -rho$. The charge $rho = q(N_D - n)$ depends on $Phi$ (through $n$), making the system nonlinear. It is solved self-consistently: alternate between the Schrödinger and Poisson equations until convergence, using Newton--Raphson for the Poisson step. Neumann boundary conditions ($dif Phi \/ dif x = 0$) enforce charge neutrality at the contacts, consistent with the flat-band contact assumption.

*Part II: NEGF introduction.* The NEGF formalism reformulates quantum transport in terms of Green's functions and self-energies rather than wave functions and injection vectors. The retarded GF $GR = (E - amat(H) - SigR)^(-1)$ is the matrix inverse of the Schrödinger operator. The wave function is $avec(phi) = GR avec(S)$, but NEGF avoids $avec(S)$ entirely by defining the lesser self-energy $Sigless = i sum_c Gamma_c F_c$ (where $Gamma_c = i(Sigma^R_c - Sigma^A_c)$ is the broadening function) and the lesser GF $Gless = GR Sigless GA$. The electron density is proportional to $"diag"(Gless)$, and the DOS is $g^c = "diag"(GR Gamma_c GA) \/ (2 pi Delta x)$.

The retarded/advanced distinction corresponds to outgoing/incoming radiation conditions (Sommerfeld vs. anti-Sommerfeld), and the lesser GF encodes occupation (which states are filled). In the coherent 1-D case, NEGF and WF give identical results; the power of NEGF lies in its systematic extensibility to include scattering.

*Next lecture:* current in the NEGF formalism, the greater Green's function (for hole density), and computational shortcuts for efficient evaluation.
