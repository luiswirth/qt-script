#import "math.typ": *
#import "style.typ": *
#show: math-template
#show: style-template

#set heading(numbering: "1.1")
#set page(numbering: "1")
#set math.equation(numbering: "(1)")

#let hbar = $planck$
#let mstar = $m^*$
#let mt = $m_t^*$

#align(center)[
  #text(size: 18pt, weight: "bold")[Quantum Transport at the Nanoscale]

  #text(size: 14pt)[Lecture 4 — Charge Density, Current, and the Landauer--Büttiker Formula]

  #v(0.3em)
  #text(size: 11pt)[Study script based on lectures by Luisier, Cao, and Emboras (ETH Zürich, Spring 2026)]
]

#v(1em)
#outline(indent: 1.5em)
#pagebreak()

= Recap and motivation

In Lecture 3 we derived the Wave Function (WF) formalism equation for a 1-D device with open boundary conditions:
$ (E dot amat(I) - amat(H) - amat(Sigma)) dot [avec(phi)^L ; avec(phi)^R] = [avec(S)^L ; avec(S)^R]. $ <wf-equation>
This is a linear system (not an eigenvalue problem) that must be solved at each injection energy $E$. It produces two wave functions: $avec(phi)^L (E)$, obtained when electrons are injected from the left contact ($a_L = 1, a_R = 0$), and $avec(phi)^R (E)$, obtained when electrons are injected from the right ($a_R = 1, a_L = 0$). The matrix on the left-hand side is the same for both, so a single LU factorization suffices.

(Exam hint: the lecturer emphasized that being able to write down @wf-equation and explain the structure of each matrix --- $E dot amat(I)$ diagonal, $amat(H)$ the unchanged tridiagonal Hamiltonian, $amat(Sigma)$ nonzero only at positions $(1,1)$ and $(N,N)$, $avec(S)^L$ nonzero only at entry 1, $avec(S)^R$ nonzero only at entry $N$ --- is a standard exam question.)

The goal of this lecture is to answer two questions: (1) how do we compute the non-equilibrium _charge density_ $n(avec(r))$ inside the device from $avec(phi)^L$ and $avec(phi)^R$, and (2) how do we compute the _current_ $I$ flowing through the device? The answer to the second question leads to the Landauer--Büttiker formula.

== Contact bandstructure and the group velocity

Before proceeding, recall from Lecture 3 that each contact has a discrete dispersion relation
$ E(k_c) = H_(c c) - 2 T_c cos(k_c Delta x), $ <contact-dispersion>
where $c in {L, R}$, $H_(c c)$ is the on-site energy, and $T_c > 0$ is the coupling. This cosine band plays the role of the familiar parabolic $E = hbar^2 k^2 \/ (2 mstar) + V_0$ at low energies but is more physical: it has a finite bandwidth and a natural Brillouin zone $k_c in [-pi\/Delta x, pi\/Delta x]$.

The _group velocity_ of an electron at energy $E$ in contact $c$ is
$ v^c (E) = frac(1, hbar) frac(dif E(k_c), dif k_c) = frac(2 T_c Delta x, hbar) sin(k_c Delta x). $ <group-velocity>
Right-propagating states (positive velocity) occupy the branch with $k_c > 0$; left-propagating states occupy $k_c < 0$. At a given energy $E$, the injection velocity $v^L (E)$ and the exit velocity $v^R (E)$ are generally different because the two contacts may have different material parameters or different band-edge positions (the latter occurs whenever a voltage is applied). See Slide 19 for a schematic showing the contact bandstructures flanking the device, with an electron injected at energy $E$ from the left branch (positive $v^L$) arriving at the right branch (positive $v^R$).

#pagebreak()

= Why two wave functions are needed: non-equilibrium

== Fermi levels under bias

At equilibrium (no applied voltage), both contacts share the same Fermi level $E_F$. Every state, whether injected from the left or from the right, is occupied with the same probability $f(E, E_F)$. In that case one could, in principle, combine $avec(phi)^L$ and $avec(phi)^R$ into a single quantity without error.

When an external voltage $V_"ext"$ is applied (say to the right contact, with the left grounded), the Fermi levels split:
$ E_(F L) - E_(F R) = q V_"ext". $ <fermi-split>
The left contact populates its states according to $f(E, E_(F L))$ and the right contact according to $f(E, E_(F R))$. These are different functions of $E$, so states originating from the left and from the right are occupied with different probabilities. One cannot simply add $|phi^L|^2 + |phi^R|^2$ and multiply by a single Fermi function; the two contributions must be kept separate and weighted by their respective Fermi distributions. See Slide 9 for the band diagram under bias, showing $E_(F L)$ and $E_(F R)$ at different levels.

This is what it means for the system to be _out of equilibrium_: the occupation functions of the two reservoirs differ. The entire machinery of non-equilibrium charge and current computation rests on this distinction.

#pagebreak()

= Non-equilibrium charge density <charge-section>

== General formula

In Lecture 2, we computed the equilibrium charge density as a sum over all $avec(k)$-states of the probability density times the Fermi function:
$ n(avec(r)) = sum_avec(k) |psi_avec(k) (avec(r))|^2 f(E(avec(k)), E_F). $

In the non-equilibrium case with multiple contacts, this generalizes to
$ n(avec(r)) = sum_(avec(k), c) |psi^c_avec(k) (avec(r))|^2 f(E(avec(k)), E_(F c)), $ <charge-general>
where $c$ runs over all contacts (here $c in {L, R}$) and $psi^c_avec(k)$ is the wave function produced by injection from contact $c$.

== Specialization to the 1-D device

For the 1-D transport problem, the full wave function separates into a longitudinal part $phi^c_(k_x)(x)$ (computed by solving @wf-equation) and transverse plane waves $e^(i avec(k)_t dot avec(r)_t) \/ sqrt(A)$:
$ Psi^c_(k_x, avec(k)_t) (avec(r)) = frac(1, sqrt(L)) phi^c_(k_x (E)) (x) dot frac(1, sqrt(A)) e^(i avec(k)_t dot avec(r)_t), $
where $L$ is the (fictitious) normalization length in the transport direction and $A$ is the transverse area. The factor $1\/sqrt(L)$ normalizes the longitudinal wave function. The probability density is then
$ P^c_(k_x, avec(k)_t) (avec(r)) = frac(1, L A) |phi^c_(k_x (E)) (x)|^2. $
Substituting into @charge-general:
$ n(avec(r)) = frac(1, L A) sum_(k_x) sum_(avec(k)_t) sum_c |phi^c_(k_x) (x)|^2 f(E(k_x, avec(k)_t), E_(F c)). $ <charge-1d-raw>

The total energy separates as $E(k_x, avec(k)_t) = E(k_x) + hbar^2 |avec(k)_t|^2 \/ (2 mt)$, where $E(k_x)$ is the contact dispersion @contact-dispersion and $mt$ is the transverse effective mass. This separation allows us to handle the sums over $k_x$ and $avec(k)_t$ independently.

== From sums to energy integrals

The sum over $k_x$ is converted to an integral using the standard prescription $1\/L sum_(k_x) arrow 1\/(2 pi) integral dif k_x$. A change of variables from $k_x$ to $E' = E(k_x)$ introduces the Jacobian $|dif E \/ dif k_x|^(-1)$:
$ frac(1, L) sum_(k_x) |phi^c_(k_x) (x)|^2 (dots) arrow frac(1, 2 pi) integral dif k_x |phi^c_E (x)|^2 (dots) = integral dif E' thin g^c (E', x) thin (dots), $
where $g^c (E, x)$ is the *contact-resolved density of states*:
$ g^c (E, x) = frac(1, 2 pi) |phi^c_E (x)|^2 lr(|frac(dif E(k_c), dif k_c)|)^(-1)_(E(k_c) = E). $ <dos-contact>

Note the key ingredient: the inverse of $|dif E \/ dif k_c|$, which is the derivative of the contact dispersion. In the continuum (parabolic) limit this factor is $mstar \/ (hbar^2 k)$, recovering the familiar $1\/sqrt(E)$ factor in the 1-D DOS. In the discrete model it involves the sine of $k_c Delta x$ (from differentiating the cosine dispersion), which is automatically more physical at high energies.

An important remark from the lecture: this density of states $g^c$ is defined _differently_ from the equilibrium DOS of Lecture 2. In Lecture 2, the transverse sum over $avec(k)_t$ was absorbed _into_ the DOS (giving the staircase $g_"QW"$). Here, the transverse sum stays _outside_ the DOS and is instead absorbed into the Fermi integral (defined below). The two approaches give the same final charge density, but the intermediate quantities $g^c$ look different --- in particular, $g^c$ does not have the staircase shape.

== The transverse sum: analytical Fermi integral

The sum over transverse wave vectors $avec(k)_t$ can be performed analytically. Using $1\/A sum_(avec(k)_t) arrow 2_"spin" \/ (2 pi)^2 integral dif^2 avec(k)_t$ and switching to polar coordinates ($dif^2 avec(k)_t = 2 pi |avec(k)_t| dif |avec(k)_t|$), then changing variables to $epsilon = hbar^2 |avec(k)_t|^2 \/ (2 mt)$, the sum evaluates to
$ frac(1, A) sum_(avec(k)_t) f(E' + frac(hbar^2 |avec(k)_t|^2, 2 mt), E_(F c)) = frac(mt k_B T, pi hbar^2) ln(1 + exp(frac(E_(F c) - E', k_B T))) equiv F(E', E_(F c)). $ <fermi-integral>
This is the *Fermi integral* $F(E', E_(F c))$, which replaces the transverse $avec(k)_t$-sum by a single closed-form expression. It depends on the longitudinal energy $E'$, the contact Fermi level $E_(F c)$, the transverse mass $mt$, and the temperature $T$.

The steps are the same as those used in Lecture 2 to derive the quantum well DOS, except that here the 2-D $avec(k)_t$-integral acts on the Fermi function rather than on a delta function.

== Final expression for the charge density

Putting everything together, the non-equilibrium electron density in a 1-D system with two contacts is
$ n(avec(r)) = integral dif E' (g^L (E', x) thin F(E', E_(F L)) + g^R (E', x) thin F(E', E_(F R))). $ <charge-final>

This is the working equation for charge density in the WF formalism. Each term is a product of a contact-resolved DOS (which encodes the spatial structure of the wave function) and a Fermi integral (which encodes the occupation probability from that contact). The two terms must remain separate because $E_(F L) != E_(F R)$ under bias.

== Choosing the energy integration range

To evaluate @charge-final numerically, we must choose the integration limits $E_"min"$ and $E_"max"$:

$E_"min" = min(V(0), V(L))$, the lower of the two contact band edges. Below this energy, no states can be injected from either contact (the contact bandstructure has no propagating modes), so the integrand is identically zero.

$E_"max" = max(E_(F L), E_(F R)) + "a few" times k_B T$ (typically $+ 20 thin k_B T$). Far above the highest Fermi level, the Fermi integral decays exponentially ($exp(-(E - E_F)\/k_B T)$), so the integrand is negligible.

Within this range, the energy grid should be fine enough to resolve all features of the DOS (standing-wave oscillations, resonances). The grid can be uniform.

== Example: charge density in a potential barrier

See Slide 17 for the computed charge density in a tunnelling barrier at $V_"ext" = 0$, $0.25$ V, and $0.5$ V. At zero bias the charge density is symmetric. Under bias, an _accumulation_ of electrons appears on the source side (a triangular quantum well forms and its bound-like states are filled) while a _depletion_ occurs on the drain side (the band edge moves away from the Fermi level, reducing occupation). The mechanism is simple: the Fermi integral decreases exponentially when the energy of the state moves far above $E_F$, so lowering $E_F$ on one side (by applying voltage) empties states on that side.

The density of states $g^L + g^R$ is shown on Slide 15 for both $V_"ext" = 0$ and $V_"ext" = 0.1$ V. The characteristic pattern of bright lobes (high DOS) and dark regions (low DOS) comes from the standing-wave interference between injected and reflected waves: at higher energies the electron wavelength decreases, fitting more half-wavelengths in the flat region and producing more lobes. The small amount of DOS visible _below_ the band edge on one side of the barrier (at finite bias) comes from tunnelling --- states injected from the opposite contact penetrate the barrier and produce a nonzero $|phi^c|^2$ in the classically forbidden region.

#pagebreak()

= Current density <current-section>

== Physical setup

The total current $I_"tot"$ through the device is the difference between the left-to-right electron flow $I_(L R)$ and the right-to-left flow $I_(R L)$:
$ I_"tot" = I_(L R) - I_(R L). $ <current-decomposition>
Even at zero bias ($E_(F L) = E_(F R)$), both $I_(L R)$ and $I_(R L)$ are nonzero --- electrons still flow in both directions --- but the two fluxes exactly cancel and $I_"tot" = 0$.

Each flux is a sum over all occupied $(k_x, avec(k)_t)$-states of the single-state current contributions.

== Derivation of $I_(L R)$

=== Current as "charge $times$ velocity"

By current conservation, the current has the same value at every position along the device. We are therefore free to evaluate it wherever is most convenient. For left-injected states, the simplest choice is $x = L$ --- the first point inside the right contact --- because there the wave function consists of a single right-propagating plane wave $phi^L_E (x = L) = b_(R L)(E) e^(i k_R (x - L))|_(x = L) = b_(R L)(E)$. There is no reflected component to deal with.

The current contribution at energy $E$ and transverse wave vector $avec(k)_t$ is "charge $times$ velocity":
$ I_(L R)(E, E(avec(k)_t)) = -e thin n^L (E, E(avec(k)_t), x = L) times v^R (E), $ <current-single>
where $n^L$ is the left-injected charge density at $x = L$ and $v^R (E)$ is the group velocity in the right contact.

=== Evaluating the charge at $x = L$

The charge density at $x = L$ for left-injected states is
$ n^L (E, E(avec(k)_t), x = L) = frac(1, L A) |phi^L_E (x = L)|^2 thin f(E + E(avec(k)_t), E_(F L)) = frac(1, L A) frac(|b_(R L)(E)|^2, |a_L|^2) f(E + E(avec(k)_t), E_(F L)), $
where we divided by $|a_L|^2$ to normalize out the arbitrary injection amplitude. Substituting into @current-single:
$ I_(L R)(E, E(avec(k)_t)) = -frac(e, L A) frac(|b_(R L)(E)|^2, |a_L|^2) |v^R (E)| thin f(E + E(avec(k)_t), E_(F L)). $ <current-component>

=== Summing over $k_x$ and $avec(k)_t$

The total left-to-right current is obtained by summing @current-component over all longitudinal modes $k_(x L)$ and all transverse modes $avec(k)_t$:
$ I_(L R) = -frac(e, L) sum_(k_(x L)) frac(|b_(R L)(E)|^2, |a_L|^2) |v^R (E)| thin frac(1, A) sum_(avec(k)_t) f(E + E(avec(k)_t), E_(F L)) lr(|)_(E = E(k_(x L))). $

We now perform the same manipulations as for the charge density. The sum over $k_(x L)$ becomes an integral: $1\/L sum_(k_(x L)) arrow 1\/(2 pi) integral dif k_(x L)$. The change of variables from $k_(x L)$ to $E$ introduces a factor $|dif E \/ dif k_(x L)|^(-1) = 1\/(hbar |v^L (E)|)$ --- this is how the _injection velocity_ $v^L (E)$ enters the expression. The transverse sum gives the Fermi integral $F(E, E_(F L))$ as before.

The result is:
$ I_(L R) = -frac(e, hbar) integral frac(dif E, 2 pi) T_(L R)(E) thin F(E, E_(F L)), $ <ILR>
where we have defined the *transmission coefficient from left to right*:
$ T_(L R)(E) = frac(|b_(R L)(E)|^2, |a_L|^2) frac(|v^R (E)|, |v^L (E)|). $ <TLR-def>

This transmission coefficient differs from the one in Lecture 3 (where the contacts were identical) by the velocity ratio $|v^R| \/ |v^L|$. When the two contacts have different band edges (as under bias), the electron speeds up or slows down as it moves from one contact to the other, and the velocity ratio corrects for this. The transmission is a number between 0 and 1 (for a single-mode 1-D system), with $T_(L R) = 1$ corresponding to perfect transmission.

== Current from right to left

By the same procedure (injecting from the right, evaluating the current at $x = 0$):
$ I_(R L) = -frac(e, hbar) integral frac(dif E, 2 pi) T_(R L)(E) thin F(E, E_(F R)), $ <IRL>
where
$ T_(R L)(E) = frac(|b_(L R)(E)|^2, |a_R|^2) frac(|v^L (E)|, |v^R (E)|). $ <TRL-def>

== Time-reversal symmetry and $T_(L R) = T_(R L)$

A crucial property of the coherent (scattering-free) transport problem is _time-reversal symmetry_: if an electron can propagate from left to right at energy $E$, then the time-reversed trajectory (right to left at the same $E$) is equally valid. This implies
$ T_(L R)(E) = T_(R L)(E) equiv T(E). $ <time-reversal>
There is no formal proof of this within the scope of the lecture, but it can be verified numerically: in Exercise 3, the code computes both $T_(L R)$ and $T_(R L)$ for various device configurations, and they always coincide.

#pagebreak()

= The Landauer--Büttiker formula <landauer-section>

Combining @current-decomposition, @ILR, @IRL, and @time-reversal, the total current is
$ I_"tot" = I_(L R) - I_(R L) = -frac(e, hbar) integral frac(dif E, 2 pi) T(E) (F(E, E_(F L)) - F(E, E_(F R))). $ <landauer-buttiker>

This is the *Landauer--Büttiker formula* for current in the 1-D Wave Function formalism. It is one of the central results of mesoscopic transport theory.

The structure is transparent: the current is an integral over energy of the product of two factors. The transmission $T(E)$ encodes the quantum-mechanical scattering properties of the device (how easily electrons at energy $E$ pass through it). The difference $F(E, E_(F L)) - F(E, E_(F R))$ encodes the _driving force_: it is nonzero only where the two contacts have different occupation, which is the energy window between $E_(F R)$ and $E_(F L)$ (broadened by temperature).

Several important observations:

*No current without a driving force.* If $E_(F L) = E_(F R)$ (no voltage), then $F(E, E_(F L)) = F(E, E_(F R))$ for all $E$, and $I_"tot" = 0$ regardless of $T(E)$. The two counter-propagating fluxes cancel exactly.

*Voltage is not the only driving force.* The Fermi integral $F$ also depends on temperature through the Boltzmann factor $k_B T$. If the left and right contacts are held at different temperatures ($T_L != T_R$), the two Fermi integrals differ even when the Fermi levels are equal, and a current flows. This is the *Seebeck effect* (thermoelectric current generation), briefly mentioned in the lecture.

*The formula is general.* The true Landauer--Büttiker formula uses the Fermi _function_ $f(E, E_F)$ rather than the Fermi _integral_ $F(E, E_F)$. Our version involves $F$ because we analytically integrated the transverse degrees of freedom. For a strictly 1-D system (no transverse directions), $F$ reduces to $f$, and the standard textbook form $I prop integral T(E)(f_L - f_R) dif E$ is recovered.

(Exam hint: the lecturer explicitly stated what is expected. You should know that the current is given by the Landauer--Büttiker formula: an integral over energy of the transmission function times the difference of the Fermi integrals. The precise prefactor $-e\/(hbar dot 2 pi)$ is not critical; what matters is the structure: integral over $E$, $T(E)$, and $F_L - F_R$.)

== Example: current through a tunnelling barrier

See Slide 28 for a numerical example: a 4 nm barrier ($Delta V = 0.3$ eV) under increasing bias $V_"ext"$. The left panel shows $I_d$ vs $V_"ext"$: the current increases roughly exponentially at low bias (tunnelling regime) and then more steeply at higher bias as the barrier is pulled down. The right panel shows the _spectral current_ $T(E)(F(E, E_(F L)) - F(E, E_(F R)))$ superimposed on the band diagram at $V_"ext" = 0.6$ V. The current flows primarily at energies _above_ an electrostatic barrier that forms in front of the material barrier (a consequence of doping and electrostatics, to be discussed in the next lecture). Below that barrier, the tunnelling distance is too long for appreciable transmission.

These spectral current maps are valuable in practice: they reveal not just _how much_ current flows, but _where_ in position and energy it flows, providing insight into the dominant transport mechanism (thermionic vs. tunnelling).

#pagebreak()

= Current conservation and the probability current <continuity-section>

The Schrödinger equation guarantees probability conservation through the continuity equation
$ frac(partial, partial t) rho(avec(r), t) + nabla dot avec(j)(avec(r), t) = 0, $ <continuity>
where the probability density is $rho(avec(r), t) = |psi(avec(r), t)|^2$ and the probability current density is
$ avec(j)(avec(r), t) = frac(i hbar, 2 mstar) lim_(avec(r)' -> avec(r)) (nabla_(avec(r)') - nabla_(avec(r))) psi^* (avec(r)', t) psi(avec(r), t). $ <prob-current-general>

In 1-D, this simplifies to
$ j(x) = frac(i hbar, 2 mstar) (frac(dif psi^*, dif x) psi - psi^* frac(dif psi, dif x)). $ <prob-current-1d>

This expression gives the probability current at _every_ point $x$ inside the device --- it is a more local quantity than the Landauer--Büttiker formula (which gives a single number for the total current). For the time-independent case we consider, the continuity equation reduces to $dif j \/ dif x = 0$, meaning $j$ is constant throughout the device. This is precisely the current conservation that justified evaluating the current at the most convenient point ($x = L$) in the Landauer--Büttiker derivation.

The current continuity equation also provides the deeper justification for the interface matching conditions used in Lecture 3 (continuity of $phi$ and of $(1\/mstar) dif phi \/ dif x$ across a material interface). If we require $j(x = 0^-) = j(x = 0^+)$ using the definition @prob-current-1d (where $mstar$ may differ on the two sides of the interface), both conditions follow: continuity of $phi$ ensures the $psi^*$ factors match, and the $1\/mstar$ factor in the derivative condition ensures the derivative terms contribute equally to $j$ on both sides. As the lecturer noted: plug the interface conditions into @prob-current-1d on each side of the interface to verify that $j$ is indeed continuous.

#pagebreak()

= Summary

This lecture completed the Wave Function formalism by showing how to extract the physical observables --- charge density and current --- from the wave functions $avec(phi)^L$ and $avec(phi)^R$.

*Non-equilibrium charge density.* Under bias, the two contacts have different Fermi levels, so left- and right-injected states are occupied with different probabilities. The charge density is $n = integral dif E (g^L F_L + g^R F_R)$, where $g^c$ is the contact-resolved DOS and $F_c$ is the analytically evaluated Fermi integral that absorbs the transverse $avec(k)_t$-sum. The key point is that $g^L$ and $g^R$ must remain separate because they multiply different Fermi integrals.

*Current and the Landauer--Büttiker formula.* The total current is the difference of two counter-propagating fluxes, $I_"tot" = I_(L R) - I_(R L)$. By computing each flux as "charge $times$ velocity" at the exit contact, converting the $k$-sum to an energy integral (which introduces the group velocity and hence the transmission coefficient $T(E) = |b_"trans"|^2 / |a_"inj"|^2 dot |v_"exit"| / |v_"inj"|$), and using time-reversal symmetry $T_(L R) = T_(R L)$, one arrives at $I_"tot" = -(e\/hbar) integral (dif E \/ 2 pi) T(E)(F_L - F_R)$. Current flows only when the two Fermi integrals differ --- either because of an applied voltage (different $E_F$) or a temperature gradient (Seebeck effect).

*Current conservation.* The Schrödinger equation implies a continuity equation for probability, ensuring that the current is the same at every point in the device. This justifies both the freedom to evaluate the current at the most convenient position and the interface matching conditions ($phi$ continuous, $(1\/mstar) phi'$ continuous) used in the open boundary condition derivation.

*Next lecture:* Poisson's equation (self-consistent electrostatics) and introduction to the Non-Equilibrium Green's Function (NEGF) formalism.
