#import "setup.typ": *
#show: chapter.with("Current density, scattering and phonons")

Everything so far was ballistic.
An electron entered the device at one energy and left it at the same energy,
having seen nothing but the electrostatic potential.
That is why every energy could be solved on its own, and why the current was an
integral over independent energies.

This chapter lets the electron exchange energy with the crystal.
Two things have to be built for that, and they are built in this order.

The first is a current.
The Landauer-Büttiker formula @LB rests on a transmission, and a transmission
only exists when an electron arrives with the energy it left with.
We derive an expression for the current that makes no such assumption, starting
from the continuity equation and the equations of motion of the lesser Green's
function.

The second is the self-energy that does the scattering.
The same derivation produces, as a by-product, the condition that any
self-energy must satisfy for the current to be conserved.
That condition splits into a term that fills states and a term that empties
them, and reading those two terms is what tells us how to build the
electron-phonon self-energies.

== Coherent and dissipative transport

=== Two kinds of transport

#exam("L10.2")
Draw the conduction band edge along a device and put an electron on it.
#key[In #term("coherent transport") the electron keeps its total energy $E$ and
its transverse momentum $avec(k)$ from one contact to the other.]
The band edge is the potential energy, so the distance between the band edge and
$E$ is the kinetic energy.
Following the electron from source to drain, the potential energy falls and the
kinetic energy grows by the same amount.
Slide 6 draws it.
Nothing couples one energy to another, so the open system @OBC at one energy
knows nothing about any other, and the whole calculation is a family of
independent problems.

#key[In #term("dissipative transport") the electron gives part of its energy and
part of its momentum to a vibration of the crystal.]
It enters with $(E, avec(k))$ and continues with $(E - E', avec(k) - avec(q))$,
where $E'$ and $avec(q)$ are the energy and the momentum of the vibration it
excited.
Energy is still conserved; it has left the electrons and gone into the lattice.
The reverse also happens, and the electron then takes energy out of the lattice.
Slide 6 draws that too, with the emitted vibration as a wavy arrow.
#key[The energies are now coupled.
A state at $E$ is fed by states at other energies, so the equations at all
energies have to be solved together.]

=== Scattering as a self-energy

The wave function formalism can express this, and it is impractical.
Scattering injects amplitude at every grid point rather than only at the
contacts, so the linear system $A x = b$ would need one right hand side per grid
point and per phonon energy, instead of one per contact.

#key[In the Green's function formalism the interaction is one more self-energy,
added to the boundary self-energies that are already there,]
$
  (E - H - Sigma^(R,B) - Sigma^(R,S)) G^R = I,
  quad
  G^(<) = G^R (Sigma^(<,B) + Sigma^(<,S)) G^A,
$
with $B$ for boundary and $S$ for scattering.
The structure of the equations does not change at all.
This is what the formalism was built for: Kadanoff and Baym introduced it to
describe scattering, and the boundary self-energies of the earlier chapters are
the special case where the environment is a contact.

One property of a scattering self-energy costs us something.
#key[A boundary self-energy has two nonzero entries, and a scattering
self-energy is a full matrix, so the recursive algorithm of the sixth chapter no
longer applies to it as it stands.]
In practice the entries fall off away from the diagonal, so a cutoff radius
makes the matrix banded and the recursion works on blocks again.
The whole of this chapter takes the scattering self-energies to be diagonal in
position, which is the crudest form of that cutoff.#note[
  Luisier said the diagonal assumption is made for simplicity in this course and
  is not what a production code does.
]

== Current density

=== Continuity equation

The current we are after is fixed by charge conservation.
#key[Charge that leaves a region has to show up as a current through its
boundary,]
$
  partial_t rho_n (avec(r), t) + nabla dot avec(J)_n (avec(r), t) = 0,
$ <continuity>
written here for electrons alone, with
$rho_n = - e n$ the electron charge density and $avec(J)_n$ the electron current
density.
In one dimension the divergence is $partial_x J$, and the statement that this
vanishes in steady state is Kirchhoff's law: what arrives at a point leaves it
again.

The electron density has a Green's function expression, and in the time domain
it is the definition itself,
$
  n(avec(r), t) = angled(hat(Psi)^dagger (avec(r), t) hat(Psi)(avec(r), t))
    = - i planck thin G^(<) (avec(r) t; avec(r) t),
$ <n-time>
by the definition @four-GF of the lesser Green's function with both arguments at
the same point and the same time.
In steady state the Fourier transform of $t - t'$ turns this into the energy
integral @n-lesser we have been using, since $t = t'$ makes the exponential
factor one.

So the left hand side of @continuity is the time derivative of a lesser Green's
function on its diagonal, and that derivative is something the equations of
motion know.

=== Two equations of motion

The Green's function carries two times, and setting them equal after
differentiating is what a diagonal element needs.
For a product of two functions,
$
  dif / (dif t) [f(t) g(t)]
    = lim_(t' arrow.r t) (partial_t + partial_(t')) f(t) g(t'),
$
and $G^(<)$ is built from two operators in exactly that way, one carrying $t$ and
one carrying $t'$.
#key[Differentiating the diagonal therefore needs an equation of motion in each
of the two times.]

The equation in $t$ is the one of the sixth chapter @keldysh, written before it
was solved,
$
  i planck partial_(t_1) G^(<) (1, 2) - H(avec(r)) G^(<) (1, 2)
    - integral dif 3 thin Sigma^R (1, 3) G^(<) (3, 2) \
    = integral dif 3 thin Sigma^(<) (1, 3) G^A (3, 2),
$ <eom-t>
with the abbreviation of that chapter, $1$ for $(avec(r), t)$ and $2$ for
$(avec(r)', t')$.
The equation in $t'$ has the same content with the roles exchanged, so the
Hamiltonian acts on the second position and the self-energies multiply from the
other side,
$
  - i planck partial_(t_2) G^(<) (1, 2) - G^(<) (1, 2) H(avec(r)')
    - integral dif 3 thin G^(<) (1, 3) Sigma^A (3, 2) \
    = integral dif 3 thin G^R (1, 3) Sigma^(<) (3, 2).
$ <eom-tprime>
Both lead to the same solution @keldysh, which is the check that they are one
pair of equations and not two unrelated ones.

Add the two and put the result into @continuity.
The differential operators combine into the derivative of the diagonal, the two
Hamiltonian terms stay apart because they act on different positions, and the
four integral terms collect,
$
  partial_t rho_n = e lim_(avec(r)' arrow.r avec(r))
    (H(avec(r)) - H(avec(r)')) G^(<) (avec(r) t; avec(r)' t) \
  - integral dif 2 thin (
    G^(<) (1, 2) Sigma^A (2, 1) + G^R (1, 2) Sigma^(<) (2, 1) \
    quad - Sigma^R (1, 2) G^(<) (2, 1) - Sigma^(<) (1, 2) G^A (2, 1)
  ).
$ <charge-rate>
The limit in the first term is the same device as the limit in time.
The two Hamiltonians act on different arguments of $G^(<)$, so the arguments are
kept apart until after the operators have acted.

=== Current conservation condition

#exam("L10.3")
Compare @charge-rate with the continuity equation @continuity.
The first term is a difference of Hamiltonians acting on a Green's function,
which is what will become the divergence of a current.
The second term is not of that form, and there is nothing for it to be.
#key[So the collision term of @charge-rate has to vanish on its own.
That is the condition Kadanoff and Baym derived, and every self-energy has to
satisfy it or the current it produces is not conserved,]
$
  integral dif 2 thin (
    G^(<) (1, 2) Sigma^A (2, 1) + G^R (1, 2) Sigma^(<) (2, 1) \
    quad - Sigma^R (1, 2) G^(<) (2, 1) - Sigma^(<) (1, 2) G^A (2, 1)
  ) = 0.
$ <conservation-raw>
We come back to this below and read the physics out of it.
For the current we may simply drop it.

=== Current density in the continuum

What is left of @charge-rate is
$
  nabla dot avec(J)_n (avec(r), t)
    = e lim_(avec(r)' arrow.r avec(r))
      (H(avec(r)') - H(avec(r))) G^(<) (avec(r) t; avec(r)' t),
$
and in steady state $partial_t rho_n = 0$, so the divergence vanishes and the
current is constant along a one-dimensional device.
That alone would tell us nothing about its value.
The expression above is more than that statement, and it is what we work on.

Fourier transform the time difference and insert the effective mass
Hamiltonian,
$
  H(avec(r)) = - planck^2 / (2 m_0) nabla_avec(r)^2 + V(avec(r)),
$
where $V$ carries every many-body effect, as the second chapter's density
functional argument left it.
Two simplifications follow immediately.
#key[The potential drops out, because $V(avec(r)') - V(avec(r))$ is a difference
of numbers and the limit sends it to zero.
So the current does not depend on the unknown form of $V$.]
What remains is a difference of two Laplacians, and it factors,
$
  nabla_avec(r)^2 - nabla_(avec(r)')^2
    = (nabla_avec(r) + nabla_(avec(r)')) dot
      (nabla_avec(r) - nabla_(avec(r)')).
$
The first factor is the same combination that appeared in time: acting on a
function of two arguments and then setting them equal is the gradient of the
diagonal, so it is the divergence sitting on the left hand side.
Strip it from both sides,
$
  avec(J)_n (avec(r)) = (e planck) / (2 m_0) integral (dif E) / (2 pi)
    lim_(avec(r)' arrow.r avec(r))
      (nabla_avec(r) - nabla_(avec(r)')) G^(<) (E; avec(r) avec(r)').
$ <current-continuum>

#key[This is the current density of the formalism, and it holds in every case:
ballistic transport, elastic scattering and dissipative scattering alike.]
It asks for no transmission, so nothing in it requires the electron to keep its
energy.
Its shape is the probability current @prob-current-1d of the third chapter, with
the antisymmetric derivative of a wave function and its conjugate replaced by
the antisymmetric derivative of the correlation function between two points.
That is what $G^(<)$ generalizes: the wave function version compares a state
with itself, and the Green's function version compares two points of a system
that need not be in a pure state at all.#note[
  Luisier named this as the one result of the derivation he expects: the current
  is the energy integral of $(partial_x - partial_(x'))G^(<)$, obtained from the
  continuity equation with the electron density written through $G^(<)$. The
  prefactors he does not ask for.
]

=== Discretized current

The derivation used a continuous Hamiltonian, and our device is a grid.
Running the same argument with the discrete Hamiltonian
@discrete-hamiltonian gives the discrete current.
The gradient difference becomes a difference of hopping terms across a bond,
$
  J_n (x_i) = (e Delta x) / planck integral (dif E) / (2 pi)
    "tr" (H_(i, i+1) G^(<)_(i+1, i) (E) - G^(<)_(i, i+1) (E) H_(i+1, i)),
$ <current-discrete>
which is the current flowing from grid point $i$ to grid point $i + 1$.#note[
  The expression is from C. Caroli and coworkers, 1971, which the slides cite for
  the derivation. The trace is there for a full-band or multi-dimensional model,
  where the blocks are matrices; in the one-dimensional effective mass model they
  are numbers and the trace does nothing.
]
#key[The current lives on the bonds between grid points, not on the points, and
it is built from the hopping across a bond times the correlation between its two
ends.]
The two terms are conjugates of each other, so their difference is imaginary and
the current is real.
A correlation $G^(<)_(i+1, i)$ that is real would carry no current at all: as in
the third chapter, current comes from the phase between two points.

This is the expression a program evaluates, at every bond and at every energy.
Its value has to come out the same on every bond, and that is the practical test
of a converged calculation.

== In- and out-scattering

=== Reading the conservation condition

#exam("L10.3", "L10.5")
Return to the condition @conservation-raw.
It holds at every position, so we may integrate it over $avec(r)$ and over
$avec(r)'$, and in steady state we may Fourier transform it into energy.
Neither step changes its content, and both make it symmetric enough to
simplify.

Under the double integral the names of the two positions may be exchanged in any
term, since both are integrated over.
Do that in the second and fourth terms.
Every term then carries $G^(<) (E; avec(r) avec(r)')$ or
$Sigma^(<) (E; avec(r) avec(r)')$ in the first factor, and the second factors
pair up,
$
  integral dif E integral dif avec(r) integral dif avec(r)' thin (
    G^(<) [Sigma^A - Sigma^R] + Sigma^(<) [G^R - G^A]
  ) = 0,
$
with all second factors at $(avec(r)' avec(r))$.
Now use the identities of the sixth chapter, @GF-relation and @SE-relation, on
both brackets.
The first becomes $Sigma^(<) - Sigma^(>)$ and the second $G^(>) - G^(<)$, so the
two terms in $Sigma^(<) G^(<)$ cancel and
$
  integral dif E integral dif avec(r) integral dif avec(r)' thin (
    Sigma^(<) (E; avec(r) avec(r)') G^(>) (E; avec(r)' avec(r)) \
    quad - G^(<) (E; avec(r) avec(r)') Sigma^(>) (E; avec(r)' avec(r))
  ) = 0.
$ <conservation>
#key[Current conservation is the statement that two terms balance, one built
from $Sigma^(<) G^(>)$ and one from $G^(<) Sigma^(>)$.]
The retarded and advanced functions are gone, and only the two that carry
occupation are left.

=== In-scattering and out-scattering

#exam("L10.4", "L10.5")
Read the two terms of @conservation one at a time.
Recall what the two functions count: $G^(<)$ counts occupied states and $G^(>)$
counts empty ones.

#key[The term $Sigma^(<) G^(>)$ is #term("in-scattering").
An empty state at energy $E$ is available, counted by $G^(>) (E)$, and the
mechanism in $Sigma^(<) (E)$ fills it.
The term $G^(<) Sigma^(>)$ is #term("out-scattering").
An occupied state at energy $E$, counted by $G^(<) (E)$, is emptied by the
mechanism in $Sigma^(>) (E)$.]
So $Sigma^(<)$ is the rate at which carriers are put into states and
$Sigma^(>)$ the rate at which they are taken out.#note[
  Datta writes these $Sigma^"in"$ and $Sigma^"out"$, which says what they do at
  the cost of hiding that they are the same objects as the lesser and greater
  self-energies of the contacts.
]
The pairing is the thing to remember: a lesser always meets a greater.
Filling needs a place to put something and a mechanism that puts it there.

Two remarks on what @conservation does and does not require.
#key[It is the energy integral that vanishes, not the integrand.
A state at $E$ may be filled from a state at another energy $E'$, and the two do
not balance separately.]
That is dissipative transport, and it is the signature of an exchange of energy
with something outside the electron system, phonons here, other electrons in a
GW calculation.
For a mechanism that changes momentum but not energy, an impurity or a rough
surface, the balance holds at each energy on its own and the energy integral may
be dropped from @conservation.
Such scattering is elastic, and it keeps the transport coherent in the sense
that energies stay uncoupled.

== Phonons

=== Crystal vibrations

#exam("L10.1")
At zero temperature the atoms sit at their equilibrium positions.
At any finite temperature they move about them,
$avec(R)_n (t) = avec(R)_n (0) + avec(u)_n (t)$ with $avec(u)_n$ the
displacement of atom $n$.
#key[A #term("phonon") is a quantum of a collective vibration of the lattice.]
It is collective and not the motion of one atom: displacing one atom pulls on
its bonds, the neighbors follow, and what results is a mode of the whole crystal
that also travels through it.
Sound in air is the same phenomenon in a medium without a lattice.

A traveling mode has a wave vector $avec(q)$ and a frequency $omega(avec(q))$,
so phonons have a band structure just as electrons do, plotted on slide 24 for
silicon.
Its energy scale is tens of #unit("meV"), against electronvolts for electrons.
#key[A crystal with $r$ atoms in its unit cell has $3 r$ branches.
Three of them are #term("acoustic") and the rest are #term("optical").]
Silicon has two atoms per cell and therefore six branches.
The distinction is what the atoms of one cell do relative to each other.
In an acoustic mode they move together, so at $avec(q) = 0$ the mode is a
uniform translation of the crystal, which costs no energy, and $omega arrow.r 0$
there.
In an optical mode they move against each other, which stretches the bonds
inside the cell and costs energy even at $avec(q) = 0$, so those branches start
at a finite frequency.
The name is historical: in a polar crystal that opposed motion carries a dipole
and couples to light.

The dispersion is computed with a #term("valence force field") model, which
gives every bond length and bond angle a spring constant and fits them to
experiment.
It stands to a phonon calculation as tight binding does to an electronic one,
empirical and cheap, and slide 24 shows that it reproduces the measured spectrum
well.

=== Bose-Einstein occupation

Phonons are bosons, and this is the one property of them that the scattering
needs.
#key[Any number of phonons may occupy the same mode, so their occupation is not
a probability between zero and one but a mean number,]
$
  N_"ph" (omega) = 1 / (e^((planck omega) / (k_B T)) - 1),
$ <bose>
which grows without bound as the temperature rises and falls to zero as
$T arrow.r 0$.
Compare the Fermi distribution @FD, where a state is either filled or not and
the occupation stays below one.

Two factors appear in every rate below, and they come from this.
#key[Absorbing a phonon from a mode carries the factor $N_"ph"$, and emitting
one into it carries $N_"ph" + 1$.]
Absorption needs a phonon to be there, so its rate is proportional to how many
there are.
Emission has two parts: a stimulated part proportional to $N_"ph"$, which is
also there for absorption, and a spontaneous part which is not.
An electron can always emit into an empty mode, and that is the $1$.
At low temperature $N_"ph"$ vanishes and only emission survives, which is why a
cold device can still lose energy to the lattice but cannot take any from
it.#note[
  The lectures read $N_"ph" + 1$ as a number of free phonon states, by analogy
  with the empty electron states counted by $1 - f$. A boson mode has no limit
  on its occupation, so the factor is the stimulated and spontaneous emission
  above rather than a count of vacancies.
]

== Electron-phonon self-energies

=== The four processes

#exam("L10.2", "L10.4")
Fix one phonon mode of energy $planck omega_"ph"$ and one electron energy $E$.
Four processes change what sits at $E$, two filling it and two emptying it.
Slides 26 and 27 draw all four, with a filled circle for an occupied state and
an empty one for an empty state.

In-scattering fills the state at $E$, and it can come from either side:

/ Emission: an occupied state at $E + planck omega_"ph"$ drops to $E$ and emits
  a phonon. It needs an electron up there, which is $G^(<) (E + planck
  omega_"ph")$, and it carries the emission factor $N_"ph" + 1$.
/ Absorption: an occupied state at $E - planck omega_"ph"$ climbs to $E$ by
  absorbing a phonon. It needs $G^(<) (E - planck omega_"ph")$ and carries
  $N_"ph"$.

Out-scattering empties the state at $E$, and the same two moves run the other
way:

/ Absorption: the electron at $E$ climbs to $E + planck omega_"ph"$, which has
  to be empty, so the factor is $G^(>) (E + planck omega_"ph")$, and it absorbs
  a phonon, so it carries $N_"ph"$.
/ Emission: the electron at $E$ drops to $E - planck omega_"ph"$, which has to
  be empty, giving $G^(>) (E - planck omega_"ph")$, and emits, so it carries
  $N_"ph" + 1$.

#key[Every process needs three things: an electron where it starts, a place to
put it where it ends, and a phonon factor for the direction of the energy
exchange.]
The Green's function supplies the first two and the Bose factor the third.

=== Self-energies

#exam("L10.6")
Collect the four terms into two self-energies.
The strength of the coupling between electrons and the lattice is not something
this course derives, so it enters as a constant $D_"e-ph"$, which depends on the
material and on the phonon mode.
#key[The in-scattering self-energy sums the two processes that fill, and the
out-scattering self-energy the two that empty,]
$
  Sigma^(<) (E) = D_"e-ph" (
    (N_"ph" + 1) G^(<) (E + planck omega_"ph")
    + N_"ph" G^(<) (E - planck omega_"ph")),
$ <eph-lesser>
$
  Sigma^(>) (E) = D_"e-ph" (
    N_"ph" G^(>) (E + planck omega_"ph")
    + (N_"ph" + 1) G^(>) (E - planck omega_"ph")),
$ <eph-greater>
both diagonal in position under the approximation of this chapter, so
$Sigma^(<)_(i i)$ is built from $G^(<)_(i i)$ alone.
A real calculation sums such a pair over every phonon branch and every wave
vector, each with its own $omega_"ph"$ and its own coupling.

Two things are worth reading off these expressions.
#key[A scattering self-energy at energy $E$ is built from Green's functions at
other energies.
That is what couples the energies to each other, and it is exactly what a
boundary self-energy never did.]
And the lesser self-energy is built from lesser Green's functions while the
greater is built from greater ones, which is the pairing of the previous
section seen from the other side.

The retarded scattering self-energy is what the equation for $G^R$ needs, and
there is no closed expression for it.
It is obtained from the broadening it produces,
$Gamma = i (Sigma^(>) - Sigma^(<))$, through
$
  Sigma^R (E) = "P" integral (dif E') / (2 pi) (Gamma(E')) / (E - E')
    - i / 2 Gamma(E),
$ <eph-retarded>
where P is the principal value.
#key[This is causality written out: the imaginary part of a retarded quantity
determines its real part, and the integral relating them is the Hilbert
transform.]
The second term is the broadening we already know from the third chapter, local
in energy and cheap.
The first term shifts the states in energy, is nonlocal in energy, and is
usually dropped.#note[
  Luisier gave the reason as computational. The energies are distributed over
  processors, and the principal value integral would need all of them at once.
  For phonons the shift it produces is a small renormalization, while for
  electron-electron interaction it is a central part of the physics and cannot
  be dropped.
]

=== Self-consistent Born approximation

The self-energies @eph-lesser and @eph-greater are built from the Green's
functions, and the Green's functions are computed from the self-energies.
#key[So the scattering problem is nonlinear and has to be iterated, exactly as
Poisson's equation and the Schrödinger equation had to be in the fifth chapter.]
Iterating this pair is the #term("self-consistent Born approximation"), drawn as
a flow chart on slide 30:

+ Set $G^R$, $G^(<)$ and $G^(>)$ to zero and compute the boundary self-energies.
+ Compute the scattering self-energies @eph-lesser, @eph-greater and
  @eph-retarded from the current Green's functions. In the first pass they
  vanish, so the first solve is the ballistic one.
+ Solve the NEGF equations with the boundary and scattering self-energies
  together, giving new $G^R$, $G^(<)$ and $G^(>)$.
+ Go back to step 2 until the iteration has converged.

Convergence is not tested on the Green's functions themselves.
#key[The test is current conservation: evaluate @current-discrete at every bond,
and stop when the current at the source and at the drain agree to within a
fraction of a percent.]
The reason is the conservation condition @conservation.
It constrains the part of the Green's functions that carries the occupation, and
that part is small next to the real parts that dominate their norm, so a
criterion on the Green's functions can look converged while the current is
still drifting.

This loop sits inside the self-consistent Schrödinger-Poisson loop, which is
inside the loop over bias points.
Scattering changes the charge density, the charge density changes the potential,
and the potential changes everything again.

== Effects in devices

=== Reduced current in a nanowire transistor

#exam("L10.7")
Slides 32 to 34 show a silicon nanowire transistor, $3 thin #unit("nm")$ in
diameter with a gate $15 thin #unit("nm")$ long, computed twice, once
ballistically and once with electron-phonon scattering.
The electrons come from a tight binding model, the phonons from a valence force
field model, and both are quantized by the confinement of the wire, so the
phonon dispersion has as many subbands as the electron one.

#key[Scattering lowers the drain current, and backscattering is why.]
A phonon emission is not simply a loss of energy.
It also changes the direction of the electron, and forward and backward are
about equally likely.
An electron turned around goes back to the source and carries no current to the
drain.
Losing energy alone would not do this: an electron that emits a phonon and keeps
going still arrives.

The current maps on slide 34 show what changes inside the channel.
In the ballistic map the current sits at one energy from source to drain, a
horizontal band.
With scattering it follows the band edge downward, and the average energy at the
drain is lower than at the source.
Dividing that difference by the optical phonon energy gives the number of
phonons an electron emits on its way through, two to three here.
The injection velocity falls from $1.3 dot 10^7$ to
$0.9 dot 10^7 thin #unit("cm/s")$, partly from the backscattering and partly
because confinement raises the effective mass above its bulk value, to
$0.29 thin m_0$ here.
#key[The energy-integrated current is the same at every position in both maps.
What scattering changes is not whether the current is conserved but the
distribution in energy of what is conserved.]

=== Phonon-assisted current

Slides 35 and 36 show the opposite sign of the same effect, in a silicon device
operating on band-to-band tunneling.
Here the current with phonons is larger than the ballistic one, for two reasons
that both come from the phonon carrying momentum and energy.

Silicon has an indirect band gap, so the valence band maximum and the conduction
band minimum sit at different wave vectors, and a transition between them needs
a momentum that light or a static potential cannot supply.
#key[A phonon supplies exactly that momentum, so in an indirect material the
phonons are not a correction to the interband transition but its mechanism.]
Second, a valence electron in the source that lies below the barrier can absorb
a phonon and reach a conduction band state in the drain that was out of reach
ballistically.

#key[Whether this is a benefit depends on what the device is for.]
The transition is what makes an indirect semiconductor absorb and emit light at
all.
In a tunneling transistor the same process raises the OFF current, which is the
one number such a device exists to keep small.

== Outlook

The lattice entered this chapter as a bath: it has a temperature, a dispersion
and an occupation @bose, and it absorbs whatever energy the electrons give it.
It carries heat and a current of its own, and treating the vibrations as
transported rather than as a reservoir is a later subject.
The formalism does not change for it.
The equations of motion, the conservation condition @conservation and the
self-consistency of this chapter are statements about Green's functions, and
they hold whatever the Green's functions describe.
