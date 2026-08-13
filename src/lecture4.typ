#import "setup.typ": *
#show: chapter.with("Carrier density and current")

The open system @OBC gives us one wave function per contact and per energy.
Neither of them is something we can measure.
This chapter turns them into the two quantities a device simulation reports,
the carrier density inside the device and the current through it.

One ingredient is still missing, and that is the occupation.
A scattering state tells us the shape of a wave, but it says nothing about
whether an electron is in it.
That is why the previous chapter kept the two injection problems apart instead
of adding them up.
We can now supply what was missing: a state is occupied according to the
reservoir it was injected from, and under an applied bias the two reservoirs
are not equally full.

The rest of the chapter is bookkeeping of a kind we have done before.
In the second chapter we traded a sum over wave vectors for an integral over
energy.
Here we have two such sums, and we trade them in opposite directions.

We label the contacts $c in {L, R}$ throughout.
A superscript names the contact a state was injected from, so $phi^c$ is the
wave function of the open system @OBC and $E_F^c$ is the Fermi level that
weights it.
A subscript names the contact a quantity lives in, so $k_c$, $v_c$ and $m_c^*$
belong to the material there.#note[
  The lectures write $E_(F L)$ and $E_(F R)$ for the two Fermi levels.
]

== Non-equilibrium

=== Bias and Fermi levels

A device is contacted by two metallic electrodes, and the electrodes are joined
to a battery.
An electrode is characterized by its Fermi level and by nothing else.
We ground the left contact and apply the #term("external voltage") $V_"ext"$ to
the right one.
This raises the electric potential of the right contact, which lowers the
energy of an electron there, because the electron charge is negative:
$
  E_F^R = E_F^L - q V_"ext".
$ <bias>
The elementary charge converts a voltage into an energy.
If we quote energies in #unit($"eV"$) the conversion becomes invisible, since a
bias of #qty(0.5, $V$) then shifts the Fermi level by #qty(0.5, $"eV"$).
Slide 9 shows the arrangement, with the band edge sloping across the device
from one contact to the other and the two Fermi levels flat in their own
reservoirs.

#key[One Fermi level throughout the system is equilibrium.
Two different Fermi levels is what we mean by a system driven
#term("out of equilibrium").]
Nothing else in the description changes.
The open system @OBC is the same equation, and the contacts are the same flat
regions.
The entire non-equilibrium content of the calculation enters through the two
numbers $E_F^L$ and $E_F^R$.

=== Left- and right-injected states

#exam("L4.1")
The previous chapter produced two wave functions at each energy, $phi^L$ from
$a_L = 1$ and $phi^R$ from $a_R = 1$, and it left them unsummed.
#key[The two solve the same equation and differ only in which reservoir fills
them.
So each carries the Fermi distribution of the contact it came from, and we may
not add them before that weight is applied.]
A state arriving from the left is present with probability $f(E, E_F^L)$, and a
state arriving from the right with probability $f(E, E_F^R)$, where $f$ is the
Fermi distribution @FD of the second chapter.
Under an applied bias @bias these two numbers differ.
Then $phi^L + phi^R$ is not a state of the system, and no equation we write for
it would mean anything.

The reason to keep them apart is physical and not algebraic.
Adding them is legitimate exactly when the two weights coincide, which is
equilibrium.
This is why the quantities plotted below may be summed over contacts at zero
bias, and have to be kept apart at any other bias.

== Carrier density

#exam("L4.2")
The second chapter built the carrier density @carrier-density from a probability
density and an occupation, under a single Fermi level.
Two changes carry that over to an open system.
The states are now labeled by the contact they were injected from as well as by
their wave vector, and each contact brings its own Fermi level,
$
  n(avec(r)) = sum_c sum_avec(k) P^c_avec(k) (avec(r))
    thin f(E(avec(k)), E_F^c).
$ <n-noneq>
Nothing else is new.
The rest of this section evaluates the non-equilibrium density @n-noneq for the
one-dimensional device of the previous chapter.

=== Probability density of a scattering state

Our device varies along $x$ and is homogeneous in the transverse plane.
So the wave function separates, exactly as it did in a quantum well,
$
  Psi^c_(k_c, avec(k)_t) (avec(r))
    = 1 / sqrt(L) phi^c_(k_c) (x)
      1 / sqrt(A) e^(i avec(k)_t dot avec(r)_t),
$
with $A = L_y L_z$ the transverse area and $avec(k)_t = {k_y, k_z}$ the
transverse wave vector.
The probability density is
$
  P^c_(k_c, avec(k)_t) (avec(r))
    = 1 / (L A) abs(phi^c_(k_c) (x))^2.
$ <obc-prob>

This is the quantum well ansatz @qw-ansatz with one replacement: the bound
state along $x$ has become a scattering state.
That replacement changes how we normalize.
#key[A scattering state does not decay, so $integral dif x thin abs(phi)^2$
diverges and we cannot impose the condition we used for a bound state.
We normalize $phi$ over a length $L$ instead.]
The length $L$ plays the role that the volume $V$ played in the bulk
calculation, and it cancels in the same way.
We take it to be the length of the device, so that $x = L$ is its right end, as
in the previous chapter.

The label $k_c$ is the wave vector that the state has in the contact it was
injected from.
The energy fixes it through the discrete band @discrete-band of that contact.
It is not a quantum number of the device, since the device has no periodicity.
It enters only as a way of parametrizing the injection.

=== Two sums, two treatments

The energy of a state splits into a longitudinal and a transverse part,
$
  E(k_c, avec(k)_t) = E(k_c)
    + (planck^2 abs(avec(k)_t)^2) / (2 m_t^*),
$ <energy-split>
where the first term is the discrete band @discrete-band and the second is the
free motion in the transverse plane, with $m_t^*$ the effective mass there,
taken equal along $y$ and $z$.
Put the probability density @obc-prob and the energy split @energy-split into
the non-equilibrium density @n-noneq,
$
  n(x) = 1 / (L A) sum_c sum_(k_c) sum_(avec(k)_t)
    abs(phi^c_(k_c) (x))^2
    thin f(E(k_c) + E(avec(k)_t), E_F^c),
$
which is a function of $x$ alone, because the transverse plane is homogeneous.

Two sums over wave vectors are left, and we get rid of them in opposite ways.
#key[We trade the longitudinal sum for an integral over energy, since energy is
the variable the whole calculation is organized by.
We perform the transverse sum in closed form, and it disappears into the
occupation.]
Group each sum with the factor it belongs to,
$
  n(x) = sum_c [1 / L sum_(k_c) abs(phi^c_(k_c) (x))^2
    (1 / A sum_(avec(k)_t) f(E(k_c) + E(avec(k)_t), E_F^c))].
$
We treat the inner bracket first, because it depends on $avec(k)_t$ alone and
its value is a function of $E(k_c)$.

=== Density of states of a contact

Convert the longitudinal sum in one dimension,
$
  1 / L sum_(k_c) arrow.r 1 / (2 pi) integral dif k_c,
$ <sum-to-integral-1d>
which is the conversion @sum-to-integral in one dimension.
It carries no spin factor, since we account for spin once in the transverse sum
below.
Now change the variable of integration from $k_c$ to the energy $E' = E(k_c)$
of the contact band,
$
  abs((dif E(k_c)) / (dif k_c)) dif k_c = dif E',
$
and read off whatever multiplies the occupation.
That factor is the #term("density of states") of contact $c$,
$
  g^c (E, x) = 1 / (2 pi) abs(phi^c_E (x))^2
    abs((dif E(k_c)) / (dif k_c))^(-1)_(E(k_c) = E),
$ <g-obc>
and it carries #unit($J^(-1) m^(-1)$), so states per unit energy per unit
length.
We evaluate the Jacobian at the wave vector the injected state has at energy
$E$, and $phi^c_E$ is the solution of the open system @OBC at that energy.

The Jacobian is a velocity.
The #term("band velocity") of the first chapter is
$v = planck^(-1) dif E slash dif k$, which is exactly what the derivative
produces, so
$
  g^c (E, x) = abs(phi^c_E (x))^2 / (2 pi planck abs(v_c (E))),
  quad
  v_c (E) = 1 / planck (dif E(k_c)) / (dif k_c).
$ <g-velocity>
#key[Slow states are weighted heavily, because a flat band puts many wave
vectors into a given energy window.
At a band edge $v_c$ vanishes and the density of states @g-velocity diverges.]
That divergence is the one-dimensional density of states growing as
$1 slash sqrt(E)$, where the bulk one of @g-bulk grew as $sqrt(E)$.
Evaluating $v_c$ from the discrete band @discrete-band gives
$
  planck v_c (E) = 2 t_c Delta x sin(k_c Delta x),
$
which vanishes at both ends of the discrete band and is largest in its middle.
We have met this quantity before.
The imaginary part of the boundary self-energy of the previous chapter is
$- t_c sin(k_c Delta x)$, which is $- planck v_c slash 2 Delta x$.
So the rate at which a contact absorbs probability is the speed at which it
carries it away.

The sum over $k_c$ runs over one branch of the contact band, not over the whole
Brillouin zone.
Only states travelling toward the device are injected, and those all have a
velocity of one sign.
On that branch the map $k_c arrow.bar E$ is one-to-one, so the energy integral
covers the band exactly once.
The states with the opposite velocity are the outgoing ones, and $phi^c$ already
contains them through its reflected part.

#key[This density of states is not the one we defined in the second chapter,
because we left the transverse wave vectors out of it.]
There the sum over all of $avec(k)$ went into $g$, which is what produced the
$sqrt(E)$ of bulk and the staircase of a quantum well.
Here the transverse sum goes into the occupation instead.
Both routes give the same carrier density, and only the intermediate quantity
differs.
So we should not expect the contact density of states @g-obc plotted against
energy to look like the bulk one @g-bulk.

=== Fermi integral

We perform the transverse sum once and for all.
Convert it to an integral over two dimensions with a factor $2$ for spin.
The integrand depends on $avec(k)_t$ only through its magnitude, so
$
  1 / A sum_(avec(k)_t) f
    = 2 / (4 pi^2) integral dif k_y dif k_z thin f
    = 2 / (4 pi^2) integral_0^infinity dif abs(avec(k)_t) thin
      2 pi abs(avec(k)_t) f,
$
where the angular integration contributes the circumference of a circle, as it
did for the quantum well.
Now substitute $u = planck^2 abs(avec(k)_t)^2 slash 2 m_t^*$, so that
$abs(avec(k)_t) dif abs(avec(k)_t) = (m_t^* slash planck^2) dif u$.
What is left is an elementary integral of the Fermi distribution over $u$, whose
antiderivative is a logarithm.
This defines the #term("Fermi integral")
$
  F(E', E_F) = 1 / A sum_(avec(k)_t) f(E' + E(avec(k)_t), E_F)
    = (m_t^* k_B T) / (pi planck^2)
      ln(1 + exp((E_F - E') / (k_B T))).
$ <FI>
It carries #unit($m^(-2)$), because it is the areal density of occupied
transverse states sitting above the longitudinal energy $E'$.
The factor $2$ for spin is inside it, which is where the $pi$ rather than
$2 pi$ in its prefactor comes from.

#key[The Fermi integral has the same shape as the distribution it was built
from.
It falls off exponentially above the Fermi level and grows linearly below it.]
For $E' - E_F >> k_B T$ we may expand the logarithm and get
$F approx (m_t^* k_B T slash pi planck^2) exp((E_F - E') slash k_B T)$, which is
the Boltzmann tail of @FD again.
For $E_F - E' >> k_B T$ the exponential dominates its own logarithm and
$F approx (m_t^* slash pi planck^2)(E_F - E')$, which is one transverse
subband's worth of states filled up to the Fermi level.
Because we have the Fermi integral @FI in closed form, the transverse dimensions
never enter a numerical calculation at all.

=== Non-equilibrium carrier density

Collect the two results.
The carrier density of a one-dimensional device between two contacts is
$
  n(x) = integral dif E thin (
    g^L (E, x) thin F(E, E_F^L) + g^R (E, x) thin F(E, E_F^R)
  ).
$ <n-obc>
#key[Each contact contributes its own density of states, weighted by its own
occupation.
We add the two contributions only after that weighting.]
This is the energy integral @n-from-g with one term per contact, and with the
Fermi function replaced by the Fermi integral.
That replacement is the price of having summed the transverse dimensions away.
A structure with more than two contacts gets one term per contact, since nothing
in the derivation used that there are two of them.

=== Density of states in a barrier structure

Slide 15 plots $g^L + g^R$ against position and energy, for the barrier of the
previous chapter, at zero bias and at #qty(0.1, $V$).
The sum is meaningful at zero bias, where both terms carry the same weight.
Under bias it is plotted only to be looked at, since the carrier density needs
the two terms separately.

The pattern to either side of the barrier is interference.
A state injected from the left is partly reflected by the barrier.
The incident and the reflected wave then form a standing wave, whose maxima are
the bright arcs.
How many arcs there are is fixed by how many half wavelengths fit between the
contact and the barrier.
Since $lambda = 2 pi slash k$ gets shorter as the energy rises, the count
increases with energy, and each arc marks the place where one more maximum has
appeared.
The structure is symmetric at zero bias, and so is the picture.

Below the band edge of the left contact the same slide carries weight in a
region no contact can inject into directly.
The band edge of a contact is the bottom of its discrete band, and nothing is
injected below it.
Yet the well formed between the barrier and the sloping band edge holds states,
and those states are reached by tunneling from the far side.
#key[A state that no contact can reach by propagation may still be populated
through a barrier.
So density of states appears where a purely classical count would put none.]

=== Energy range

The carrier density @n-obc is an integral over energy, and we evaluate it on a
grid, with one solution of the open system @OBC per grid point.
So we have to bound the range at both ends.
#key[The lower limit is the lower of the two contact band edges, below which
neither contact has a propagating state to inject.
The upper limit is set by the occupation instead of by the structure.]
Above the higher of the two Fermi levels the Fermi integral falls off
exponentially, so
$
  E_min = min(V_L, V_R),
  quad
  E_max approx max(E_F^L, E_F^R) + 20 k_B T,
$
where the second is an empirical margin at which $F$ has fallen by $e^(-20)$ and
contributes nothing.
Neither limit has anything to do with the height of the barrier in the middle.
The barrier decides how much of the range carries current, not which states
exist.
The grid between the two limits is uniform, and it has to be fine enough to
resolve the features of $g^c$, of which the resonances are the narrowest.

=== Carrier density under bias

Slide 17 shows the carrier density @n-obc for the barrier structure at three
biases, next to the band diagram it was computed from.
At zero bias the density is symmetric, as the structure is.
Applying a bias depletes the right side and accumulates carriers on the left.
Both effects follow from where the band edge sits relative to the Fermi level.

#key[Under bias the band edge at a given point moves down by less than the Fermi
level of the contact feeding it.
So the states there sit higher above the Fermi level than before, and their
occupation falls.]
That is the depletion, and it is a statement about the Fermi integral @FI alone,
which decays exponentially in $E - E_F$.
The accumulation is a statement about $g$ instead.
The sloping band edge and the barrier form a triangular well on the source side.
That well holds bound states of the kind we computed in the second chapter, and
those states fill.
Why the bands slope the way they do is electrostatics, and it is the subject of
the next chapter.

== Current

=== Two counter-propagating fluxes

#exam("L4.3")
A one-dimensional device between two contacts carries two fluxes of carriers.
One is injected from the left and travels right, the other is injected from the
right and travels left, and we compute each from its own wave function.
#key[The total current is the difference of the two,]
$
  I_"tot" = I_(L R) - I_(R L),
$ <i-tot>
where we write $I_(L R)$ and $I_(R L)$ each as a magnitude, so that the
subtraction is what produces the direction.
Slide 20 draws the two arrows.

#key[Both fluxes are there whether or not we apply a bias.
Zero current means that they cancel, not that nothing moves.]
At equilibrium carriers cross the device in both directions in equal numbers,
because the two reservoirs are equally populated.
This is worth holding on to.
It means that whenever the current is small, the total current @i-tot is a
difference of two large numbers.

Each flux is a sum over the states that carry it,
$
  I_(L R) = sum_(k_L, avec(k)_t) I_(L R) (E) |_(E = E(k_L, avec(k)_t)),
$
which is the same decomposition we built the carrier density from, and we
resolve it the same way.

=== Coherent transport

Four assumptions fix what this calculation describes, and slide 19 carries all
of them in one picture.
A contact is characterized by its bandstructure and by nothing else.
A state travelling toward the right occupies the branch of that bandstructure
with positive velocity, and a state reflected back occupies the branch with
negative velocity, since the sign of $dif E slash dif k$ is the direction of
travel.
#key[Transport is #term("ballistic"), so a carrier keeps the energy it was
injected with all the way across the device.
There is nothing in the model for it to exchange energy with.]
Emitting a phonon would take energy out of it and absorbing one would add
energy, and neither process is in the model.
Both return in a later chapter.

Constant total energy does not mean constant velocity.
Under bias the two contacts sit at different potential energies, so the kinetic
energy differs by the same amount in the other direction.
The injection velocity $v_L (E)$ and the exit velocity $v_R (E)$ are therefore
two different numbers, read off two different bands at the same height.
Slide 19 shows them as the slopes of the two dispersions at one energy.

=== Where the current is evaluated

#exam("L4.4")
Current is conserved, so we may compute it at any point of the device and get
the same answer.
That makes the choice of point a matter of convenience.
Inside the device the wave function of a left-injected state is a superposition
of a right-travelling and a reflected left-travelling part, and any expression
for the current there involves both of them.
#key[Just inside the right contact the left-injected state is a single outgoing
plane wave, since nothing is reflected back from a contact.
So we compute the current there, where it involves one amplitude only.]
The mirror statement holds for the right-injected state, whose current we
evaluate just inside the left contact.
This is the second thing the contacts were built for.
They are the regions where we know the solution, and knowing it makes both the
coupling and the current elementary.

The current is charge times velocity.
For the left-injected flux, at $x = L$,
$
  I_(L R) (E, E(avec(k)_t))
    = - q thin n^L (E, E(avec(k)_t), x = L) thin abs(v_R (E)),
$ <i-charge-velocity>
which is the carrier density that the left contact has put into the first point
of the right reservoir, times the speed at which the right reservoir removes it,
times the electron charge.
The modulus of the velocity makes $I_(L R)$ the magnitude of a flux, which is
what the total current @i-tot subtracts.

=== Current from the left

The carrier density in the flux @i-charge-velocity is the probability density
@obc-prob at one point, weighted by one occupation, with no sum at all,
$
  n^L (E, E(avec(k)_t), x = L)
    = 1 / (L A) abs(phi^L_E (L))^2 thin f(E + E(avec(k)_t), E_F^L),
$
and we know the wave function there from the contact ansatz @contact-ansatz.
At $x = L$ the outgoing wave in the right contact is $b_R^L e^(i k_R (x - L))$
with nothing incoming, so
$
  phi^L_E (L) = b_R^L (E),
$
where $b_(c')^c$ is the amplitude in contact $c'$ of the state injected from
contact $c$.#note[
  The lectures write $b_(R L)$ for $b_R^L$ and $b_(L R)$ for $b_L^R$, ordering
  the two indices the other way round from the transmission $T_(L R)$ below.
]
The infinitesimal current is therefore
$
  I_(L R) (E, E(avec(k)_t))
    = - q / (L A) abs(b_R^L (E))^2 / abs(a_L)^2
      abs(v_R (E)) thin f(E + E(avec(k)_t), E_F^L),
$
where we have divided through by the injection amplitude $abs(a_L)^2$.
#key[Every amplitude of the left-injection problem is proportional to $a_L$, and
$a_L$ is something we choose rather than compute.
Dividing by it removes a choice that no measurable quantity may depend on.]

The two sums go the same way they did for the carrier density.
The transverse one gives the Fermi integral @FI.
The longitudinal one becomes an integral over energy by @sum-to-integral-1d, and
this time we write the Jacobian as a velocity from the start,
$
  abs((dif E(k_L)) / (dif k_L)) dif k_L = planck abs(v_L (E')) dif k_L
    = dif E',
$
so the velocity of the injecting contact ends up in a denominator.
What comes out is
$
  I_(L R) = - q / planck integral (dif E) / (2 pi)
    thin T_(L R) (E) thin F(E, E_F^L),
$ <i-lr>
with the #term("transmission probability")
$
  T_(L R) (E) = abs(b_R^L (E))^2 / abs(a_L)^2
    thin abs(v_R (E)) / abs(v_L (E)).
$

This is the transmission @transmission of the previous chapter, now with the
velocity ratio that was flagged there and not yet needed.
#key[Transmission is a ratio of currents, not a ratio of probability densities.
Where the two contacts have different potentials or different masses, a carrier
leaves at a different speed than it arrived with, and the ratio of the two
speeds belongs in the definition.]
It is a probability and lies in $cc(0, 1)$ for the single propagating mode of a
one-dimensional device.
In the symmetric structure of the previous chapter the two velocities cancel,
which is why we could omit the factor there.

The current from the right is the same construction mirrored, evaluated just
inside the left contact,
$
  I_(R L) = - q / planck integral (dif E) / (2 pi)
    thin T_(R L) (E) thin F(E, E_F^R),
  quad
  T_(R L) (E) = abs(b_L^R (E))^2 / abs(a_R)^2
    thin abs(v_L (E)) / abs(v_R (E)),
$ <i-rl>
with the roles of the two contacts exchanged everywhere, so the injecting
velocity is now $v_R$ and the exit velocity is $v_L$.

=== Landauer-Büttiker formula

#exam("L4.5")
The two transmissions are equal,
$
  T_(L R) (E) = T_(R L) (E) =: T(E).
$ <T-symmetry>
This follows from time-reversal symmetry.
A trajectory traversed backwards in time returns to where it started, so the
structure transmits equally in both directions.#note[
  Luisier stated the symmetry @T-symmetry without proof, saying a proof is
  beyond the scope
  of the lecture, and pointed at the third exercise, where both transmissions
  are computed and come out identical in every configuration.
]
It is a property of the structure and not of the bias, since we compute both
transmissions from the same $V(x)$.

Put the two fluxes @i-lr and @i-rl into the total current @i-tot and use the
symmetry @T-symmetry.
This gives one equation for the current,
$
  I_"tot" = - q / planck integral (dif E) / (2 pi)
    thin T(E) thin (F(E, E_F^L) - F(E, E_F^R)).
$ <LB>
#key[The current is an integral over energy of a transmission times the
difference of the occupations of the two contacts.
Everything about the device sits in $T(E)$, and everything about the driving
sits in the difference.]
This is the #term("Landauer-Büttiker formula").#note[
  Luisier said what he expects on this equation: an integral over energy, a
  transmission function, and the difference of the two Fermi integrals. He said
  the prefactor $- q slash planck$ and the $2 pi$ are not part of the answer.
]
The formula as it is usually written carries the Fermi functions of the two
contacts rather than the Fermi integrals.
The Landauer-Büttiker formula @LB is the form that the transverse dimensions
leave behind once we have summed over them, and it reduces to the usual one for
a device that is confined in those dimensions.

Two consequences are immediate.
Equal Fermi levels give zero current, since the two fluxes then cancel exactly
at every energy, which is the equilibrium statement made quantitative.
And a difference of Fermi levels is not the only way to make the difference in
@LB nonzero.
Holding the two contacts at the same Fermi level but at different temperatures
also leaves it nonzero, since $F$ depends on $T$ through
$(E - E_F) slash k_B T$.
The current that results is the #term("Seebeck effect"), taken up in a later
chapter.

=== Spectral current

The integrand of the Landauer-Büttiker formula @LB is worth more than the number
the integral returns.
#key[The product $T(E)(F(E, E_F^L) - F(E, E_F^R))$ tells us at which energies
the current flows.
The current is the same at every position, so we may draw this product across
the whole device on top of the band diagram.]
Slide 28 does this for a #qty(4, $"nm"$) barrier of height #qty(0.3, $"eV"$),
next to the current-voltage characteristic and the band diagram, and the current
rises roughly exponentially with the applied bias.

The picture reads directly.
The doping raises a barrier in front of the material barrier, and that one is
too wide to tunnel through, so carriers cannot cross it and the current flows
only above it.
Above that energy the carrier then tunnels through the narrow aluminium gallium
arsenide barrier.
The spectral current is concentrated in the narrow window where both are
possible.
The equivalent picture for the carrier density is slide 15, and the two together
are the internal quantities that the first chapter said no measurement reaches.

== Current continuity

The construction so far gives us one number per bias, and it gets there by
picking a convenient point and invoking conservation.
The conservation itself is worth stating, because it also settles the interface
conditions we have used since the second chapter.

#key[The Schrödinger equation conserves probability, which means that the
probability density and a probability current satisfy a continuity equation,]
$
  partial / (partial t) P(avec(r), t) + nabla dot avec(j)(avec(r), t) = 0,
  quad
  P = abs(psi)^2,
$
with the #term("probability current")
$
  avec(j)(avec(r), t) = (i planck) / (2 m^*) lim_(avec(r)' arrow.r avec(r))
    (nabla_(avec(r)') - nabla_avec(r)) psi^*(avec(r)', t) psi(avec(r), t),
$
which in one dimension is
$
  j(x, t) = (i planck) / (2 m^*) (
    (partial psi^*) / (partial x) psi - psi^* (partial psi) / (partial x)
  ).
$ <prob-current-1d>
#key[The probability current @prob-current-1d is more general than the
Landauer-Büttiker formula @LB, because it gives the current at every position
instead of one number for the whole device.]
A later chapter uses it to resolve a current in space, and it is also what makes
current conservation something we can check rather than assume.

The interface conditions follow from it.
At a material interface the wave function is continuous, since a jump in it
would be a jump in the probability density, and the same holds for its complex
conjugate.
Now require in addition that the probability current @prob-current-1d take the
same value on both sides.
This forces $(1 slash m^*) partial psi slash partial x$ to be continuous there,
with the mass entering through the prefactor and the derivative through the
bracket.
#key[Continuity of the wave function alone does not conserve the current across
an interface where the mass jumps.
It is the pair of conditions together that does.]
This is the condition the BenDaniel-Duke ordering @BDD was built to satisfy, and
the one we matched the barrier of the previous chapter with.
We have now derived it instead of asserting it.

== Outlook

The wave function formalism is complete.
We solve the open system @OBC once per energy, its solutions give us the carrier
density through @n-obc and the current through the Landauer-Büttiker formula
@LB, and we compute both from a tridiagonal linear system with two right-hand
sides.

One thing we have assumed throughout and never computed.
We took the potential $V(x)$ in $H$ as given, flat in the contacts and sloping
across the device.
In reality it is produced by the charges that the carrier density @n-obc
returns.
The next chapter closes that loop with Poisson's equation, which turns the
calculation into a self-consistent one and supplies the band diagrams that this
chapter read off the slides.
It then opens the second formalism of the course, in which we invert the same
operator $E - H - Sigma$ instead of applying it to a source.
