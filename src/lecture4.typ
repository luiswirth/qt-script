#import "setup.typ": *
#show: chapter.with("Carrier density and current")

The open system @OBC delivers one wave function per contact and per energy, and
neither is an observable.
This chapter turns them into the two quantities a device simulation reports,
the carrier density inside the device and the current through it.

What has to be supplied first is the occupation.
A scattering state carries no statement about whether it holds an electron, and
the previous chapter deliberately kept the two injection problems apart until
that statement was available.
It is available now: each state is occupied according to the reservoir it was
injected from, and under an applied bias the two reservoirs are not the same.
The rest is bookkeeping of a kind already met in the second chapter, trading
sums over wave vectors for an integral over energy, performed here on two
groups of wave vectors that are traded in opposite directions.

Contacts are labeled $c in {L, R}$ throughout.
A superscript names the contact a state was injected from, so that $phi^c$
is the wave function of the open system @OBC and $E_F^c$ the Fermi level
weighting it,
and a subscript names the contact a quantity lives in, so that $k_c$,
$v_c$ and $m_c^*$ belong to the material there.#note[
  The lectures write $E_(F L)$ and $E_(F R)$ for the two Fermi levels.
]

== Non-equilibrium

=== Bias and Fermi levels

A device is contacted by two metallic electrodes joined to a source of work, a
battery, and each electrode is characterized by its Fermi level and by nothing
else.
Applying the #term("external voltage") $V_"ext"$ to the right contact with the
left one grounded raises its electric potential, which lowers the energy of an
electron there, the electron charge being negative:
$
  E_F^R = E_F^L - q V_"ext".
$ <bias>
The elementary charge converts a voltage into an energy, and quoting energies in
#unit($"eV"$) makes the conversion numerically invisible, a bias of
#qty(0.5, $V$) shifting the Fermi level by #qty(0.5, $"eV"$).
Slide 9 shows the arrangement, the band edge sloping across the device from one
contact to the other and the two Fermi levels flat in their own reservoirs.

#key[A single Fermi level throughout is equilibrium, and two differing Fermi
levels is the definition of a system driven #term("out of equilibrium").]
Nothing else in the description changes: the open system @OBC is the same
equation, the contacts are the same flat regions,
and the entire non-equilibrium content of the
calculation enters through the two numbers $E_F^L$ and $E_F^R$.

=== Left- and right-injected states

#exam("L4.1")
The previous chapter produced two wave functions at each energy, $phi^L$ from
$a_L = 1$ and $phi^R$ from $a_R = 1$, and left them unsummed.
#key[They solve the same equation and differ only in which reservoir populates
them, so each carries the Fermi distribution of the contact it came from and the
two may not be added before that weight is applied.]
A state arriving from the left is present with probability $f(E, E_F^L)$ and a
state arriving from the right with probability $f(E, E_F^R)$, with $f$ the
Fermi distribution @FD of the second chapter.
Under the applied bias @bias these differ, so $phi^L + phi^R$ is not a state of
the system
and no equation it satisfies would mean anything.

The two are separate for a physical reason and not an algebraic one.
Their superposition is legitimate exactly when the weights coincide, which is
equilibrium, and this is why the quantities plotted below may be summed over
contacts at zero bias and must be kept apart at any other.

== Carrier density

#exam("L4.2")
The second chapter built the carrier density @carrier-density from a probability
density and an occupation, under a single Fermi level.
Two changes carry it over to an open system.
The states are labeled by the contact they were injected from as well as by
their wave vector, and each contact brings its own Fermi level,
$
  n(avec(r)) = sum_c sum_avec(k) P^c_avec(k) (avec(r))
    thin f(E(avec(k)), E_F^c).
$ <n-noneq>
Nothing else is new. The rest of this section evaluates the non-equilibrium
density @n-noneq for the one-dimensional device of the previous chapter.

=== Probability density of a scattering state

The device varies along $x$ alone and is homogeneous in the transverse plane, so
the wave function separates exactly as in a quantum well,
$
  Psi^c_(k_c, avec(k)_t) (avec(r))
    = 1 / sqrt(L) phi^c_(k_c) (x)
      1 / sqrt(A) e^(i avec(k)_t dot avec(r)_t),
$
with $A = L_y L_z$ the transverse area and $avec(k)_t = {k_y, k_z}$ the
transverse wave vector, and with
$
  P^c_(k_c, avec(k)_t) (avec(r))
    = 1 / (L A) abs(phi^c_(k_c) (x))^2.
$ <obc-prob>
This is the quantum well ansatz @qw-ansatz with the bound state along $x$
replaced by a scattering state, and the replacement is what changes the
normalization.
#key[A scattering state does not decay, so $integral dif x thin abs(phi)^2$
diverges and the condition used for a bound state cannot be imposed;
$phi$ is instead normalized over a length $L$, which plays the role the volume
$V$ played in the bulk calculation and cancels in the same way.]
That length is taken to be the length of the device, so that $x = L$ is its
right end as in the previous chapter.

The label $k_c$ is the wave vector the state has in the contact it was
injected from, fixed by the energy through the discrete band @discrete-band of
that contact.
It is not a quantum number of the device, which has no periodicity, and it
enters only as a way of parametrizing the injection.

=== Two sums, two treatments

The energy of a state separates into a longitudinal and a transverse part,
$
  E(k_c, avec(k)_t) = E(k_c)
    + (planck^2 abs(avec(k)_t)^2) / (2 m_t^*),
$ <energy-split>
the first term being the discrete band @discrete-band and the second the free
motion in the transverse plane, with $m_t^*$ the effective mass there, taken
equal along $y$ and $z$.
Substituting the probability density @obc-prob and the energy split
@energy-split into the non-equilibrium density @n-noneq,
$
  n(x) = 1 / (L A) sum_c sum_(k_c) sum_(avec(k)_t)
    abs(phi^c_(k_c) (x))^2
    thin f(E(k_c) + E(avec(k)_t), E_F^c),
$
a function of $x$ alone, the transverse plane being homogeneous.

Two sums over wave vectors remain, and they are disposed of in opposite
directions.
#key[The longitudinal sum is traded for an integral over energy, which is the
variable the calculation is organized by, while the transverse sum is performed
in closed form and disappears into the occupation.]
Grouping each with the prefactor it belongs to,
$
  n(x) = sum_c [1 / L sum_(k_c) abs(phi^c_(k_c) (x))^2
    (1 / A sum_(avec(k)_t) f(E(k_c) + E(avec(k)_t), E_F^c))].
$
The inner bracket is treated first because it depends on $avec(k)_t$ alone and
its value is a function of $E(k_c)$.

=== Density of states of a contact

Converting the longitudinal sum in one dimension,
$
  1 / L sum_(k_c) arrow.r 1 / (2 pi) integral dif k_c,
$ <sum-to-integral-1d>
which is the conversion @sum-to-integral in one dimension and carries no spin
factor, spin
being accounted for once in the transverse sum below.
Changing the variable of integration from $k_c$ to the energy
$E' = E(k_c)$ of the contact band,
$
  abs((dif E(k_c)) / (dif k_c)) dif k_c = dif E',
$
and reading off the bracket multiplying the occupation gives the
#term("density of states") of contact $c$,
$
  g^c (E, x) = 1 / (2 pi) abs(phi^c_E (x))^2
    abs((dif E(k_c)) / (dif k_c))^(-1)_(E(k_c) = E),
$ <g-obc>
carrying #unit($J^(-1) m^(-1)$), states per unit energy per unit length.
The Jacobian is evaluated at the wave vector the injected state has at energy
$E$, and $phi^c_E$ is the solution of the open system @OBC at that energy.

The Jacobian is a velocity.
The #term("band velocity") of the first chapter, $v = planck^(-1) dif E slash
dif k$, is exactly what the derivative produces, so
$
  g^c (E, x) = abs(phi^c_E (x))^2 / (2 pi planck abs(v_c (E))),
  quad
  v_c (E) = 1 / planck (dif E(k_c)) / (dif k_c).
$ <g-velocity>
#key[States that move slowly are weighted heavily, since a flat band puts many
wave vectors into a given energy window, and the divergence of the density of
states @g-velocity at a band edge, where $v_c$ vanishes,
is the one-dimensional density of states
growing as $1 slash sqrt(E)$ where the bulk one of @g-bulk grew as $sqrt(E)$.]
Evaluating $v_c$ from the discrete band @discrete-band,
$
  planck v_c (E) = 2 t_c Delta x sin(k_c Delta x),
$
which vanishes at both ends of the discrete band and is largest at its middle.
The same quantity has already been met: the imaginary part of the boundary
self-energy of the previous chapter is $- t_c sin(k_c Delta x)$, so it
is $- planck v_c slash 2 Delta x$, and the rate at which a contact absorbs
probability is the speed at which it carries it away.

The sum over $k_c$ runs over one branch of the contact band and not over
the whole Brillouin zone.
Only states travelling toward the device are injected, and those are the ones
with velocity of one sign, so the map $k_c arrow.bar E$ is one-to-one on
that branch and the energy integral covers the band exactly once.
The states with the opposite velocity are the outgoing ones, and they are
already contained in $phi^c$ through its reflected part.

#key[The density of states defined here is not the one defined in the second
chapter, the transverse wave vectors having been left out of it.]
There the sum over all of $avec(k)$ went into $g$, which is what produced the
$sqrt(E)$ of bulk and the staircase of a quantum well;
here the transverse sum goes into the occupation instead.
Both routes give the same carrier density, and it is the intermediate quantity
that differs, so the contact density of states @g-obc plotted against energy is
not expected to look like the bulk one @g-bulk.

=== Fermi integral

The transverse sum is performed once and for all.
Converting it to an integral over two dimensions with a factor $2$ for spin,
and using that the integrand depends on $avec(k)_t$ only through its magnitude,
$
  1 / A sum_(avec(k)_t) f
    = 2 / (4 pi^2) integral dif k_y dif k_z thin f
    = 2 / (4 pi^2) integral_0^infinity dif abs(avec(k)_t) thin
      2 pi abs(avec(k)_t) f,
$
the angular integration contributing the circumference of a circle as it did for
the quantum well.
Substituting $u = planck^2 abs(avec(k)_t)^2 slash 2 m_t^*$, so that
$abs(avec(k)_t) dif abs(avec(k)_t) = (m_t^* slash planck^2) dif u$, leaves an
elementary integral of the Fermi distribution over $u$, whose antiderivative is
a logarithm, and defines the #term("Fermi integral")
$
  F(E', E_F) = 1 / A sum_(avec(k)_t) f(E' + E(avec(k)_t), E_F)
    = (m_t^* k_B T) / (pi planck^2)
      ln(1 + exp((E_F - E') / (k_B T))).
$ <FI>
It carries #unit($m^(-2)$), being the areal density of occupied transverse
states sitting above the longitudinal energy $E'$, and the factor $2$ for spin
is inside it, which is where the $pi$ rather than $2 pi$ in its prefactor comes
from.

#key[The Fermi integral inherits the shape of the distribution it was built
from, falling off exponentially above the Fermi level and growing linearly below
it.]
For $E' - E_F >> k_B T$ the logarithm may be expanded and
$F approx (m_t^* k_B T slash pi planck^2) exp((E_F - E') slash k_B T)$, the
Boltzmann tail of @FD again;
for $E_F - E' >> k_B T$ the exponential dominates its own logarithm and
$F approx (m_t^* slash pi planck^2)(E_F - E')$, one transverse subband's worth
of states filled up to the Fermi level.
Having the Fermi integral @FI in closed form means the transverse dimensions
never enter a numerical calculation at all.

=== Non-equilibrium carrier density

Collecting the two results, the carrier density of a one-dimensional device
between two contacts is
$
  n(x) = integral dif E thin (
    g^L (E, x) thin F(E, E_F^L) + g^R (E, x) thin F(E, E_F^R)
  ).
$ <n-obc>
#key[Each contact contributes its own density of states weighted by its own
occupation, and the two contributions are added only after that weighting.]
This is the energy integral @n-from-g with one term per contact and with the
Fermi function replaced
by the Fermi integral, the replacement being the price of having summed the
transverse dimensions away.
A structure with more than two contacts carries one term per contact, nothing in
the derivation having used that there are two.

=== Density of states in a barrier structure

Slide 15 plots $g^L + g^R$ against position and energy for the barrier of the
previous chapter, at zero bias and at #qty(0.1, $V$).
The sum is meaningful at zero bias, where both terms carry the same weight, and
under bias it is plotted only to be looked at, the carrier density needing the
two separately.

The pattern to either side of the barrier is interference.
A state injected from the left is partly reflected by the barrier, and the
incident and reflected waves form a standing wave whose maxima are the bright
arcs.
Their number is fixed by how many half wavelengths fit between the contact and
the barrier, and since $lambda = 2 pi slash k$ shortens as the energy rises,
the count increases with energy;
each arc marks the place where one more maximum has appeared.
The structure is symmetric at zero bias and so is the picture.

Above the top of the barrier the same slide carries weight in a region no
contact can inject into directly.
The band edge of a contact is the bottom of its discrete band and nothing is
injected below it, yet the well formed between the barrier and the sloping
band edge holds states, and those states are reached by tunneling from the far
side.
#key[A state that no contact can reach by propagation may still be populated
through a barrier, so density of states appears where a purely classical count
would put none.]

=== Energy range

The carrier density @n-obc is an integral over energy and is evaluated on a
grid, one solution of the open system @OBC per point, so the range has to be
bounded at both ends.
#key[The lower limit is the lower of the two contact band edges, below which
neither contact has a propagating state to inject, and the upper limit is set
by the occupation rather than by the structure.]
Above the higher of the two Fermi levels the Fermi integral falls off
exponentially, so
$
  E_min = min(V_L, V_R),
  quad
  E_max approx max(E_F^L, E_F^R) + 20 k_B T,
$
the second being an empirical margin at which $F$ has fallen by $e^(-20)$ and
contributes nothing.
Neither limit has anything to do with the height of the barrier in the middle,
which decides how much of the range carries current but not which states exist.
The grid between them is uniform and has to be fine enough to resolve the
features of $g^c$, the resonances being the narrowest thing in it.

=== Carrier density under bias

Slide 17 shows the carrier density @n-obc evaluated for the barrier structure at
three biases,
beside the band diagram it was computed from.
At zero bias the density is symmetric, as the structure is.
Applying a bias depletes the right side and accumulates carriers on the left,
and both follow from where the band edge sits relative to the Fermi level.

#key[Under bias the band edge at a given point moves down by less than the
Fermi level of the contact feeding it, so the states there sit higher above the
Fermi level than before and their occupation falls.]
That is the depletion, and it is a statement about the Fermi integral @FI alone,
which decays exponentially in $E - E_F$.
The accumulation is a statement about $g$ instead: the sloping band edge and the
barrier form a triangular well on the source side, which holds bound states of
the kind computed in the second chapter, and those states fill.
Why the bands slope as they do is electrostatics and is the subject of the next
chapter.

== Current

=== Two counter-propagating fluxes

#exam("L4.3")
A one-dimensional device between two contacts carries two fluxes of carriers,
one injected from the left and travelling right and one injected from the right
and travelling left, and each is computed from its own wave function.
#key[The total current is their difference,]
$
  I_"tot" = I_(L R) - I_(R L),
$ <i-tot>
with $I_(L R)$ and $I_(R L)$ each written as a magnitude so that the
subtraction is what makes the direction.
Slide 20 draws the two arrows.

#key[Both fluxes exist whether or not a bias is applied, and zero current is
their cancellation rather than the absence of motion.]
Carriers cross the device in both directions at equilibrium, in equal numbers,
because the two reservoirs are equally populated.
This is worth holding onto, since it is what makes the total current @i-tot a
difference of two large numbers in the regime where the current is small.

Each flux is a sum over the states carrying it,
$
  I_(L R) = sum_(k_L, avec(k)_t) I_(L R) (E) |_(E = E(k_L, avec(k)_t)),
$
which is the same decomposition the carrier density was built from and is
resolved the same way.

=== Coherent transport

Four assumptions fix what the calculation describes, and slide 19 carries all
of them in one picture.
The contacts are characterized by their bandstructure and by nothing else.
A state travelling toward the right occupies the branch of that bandstructure
with positive velocity, and a state reflected back occupies the branch with
negative velocity, the sign of $dif E slash dif k$ being the direction of
travel.
#key[Transport is #term("ballistic"), so a carrier keeps the energy it was
injected with all the way across the device, having nothing to exchange it
with.]
Emitting a phonon would take energy out of it and absorbing one would add
energy, and neither is in the model;
both return in a later chapter.

Constant total energy does not mean constant velocity.
The potential energy differs between the two contacts under bias, so the kinetic
energy differs by the same amount in the other direction, and the injection
velocity $v_L (E)$ and the exit velocity $v_R (E)$ are two different numbers
read off two different bands at the same height.
Slide 19 shows them as the slopes of the two dispersions at one energy.

=== Where the current is evaluated

#exam("L4.4")
Current is conserved, so it may be computed at any point of the device and the
answer is the same, which turns the choice of point into a matter of
convenience.
Inside the device the wave function of a left-injected state is a superposition
of a right-travelling and a reflected left-travelling part, and any expression
for the current there involves both.
#key[Just inside the right contact the left-injected state is a single outgoing
plane wave, nothing being reflected back from a contact, so the current is
computed there and involves one amplitude only.]
The mirror statement holds for the right-injected state, whose current is
evaluated just inside the left contact.
This is what the contacts were built for a second time: they are the regions
where the solution is known, and knowing it makes both the coupling and the
current elementary.

The current is then charge times velocity.
For the left-injected flux, at $x = L$,
$
  I_(L R) (E, E(avec(k)_t))
    = - q thin n^L (E, E(avec(k)_t), x = L) thin abs(v_R (E)),
$ <i-charge-velocity>
the carrier density that the left contact has put into the first point of the
right reservoir, times the speed at which the right reservoir removes it, times
the electron charge.
The modulus of the velocity makes $I_(L R)$ the magnitude of a flux, which is
what the total current @i-tot subtracts.

=== Current from the left

The carrier density in the flux @i-charge-velocity is the probability density
@obc-prob evaluated at one point and weighted by one occupation, without any
sum,
$
  n^L (E, E(avec(k)_t), x = L)
    = 1 / (L A) abs(phi^L_E (L))^2 thin f(E + E(avec(k)_t), E_F^L),
$
and the wave function there is known from the contact ansatz @contact-ansatz.
At $x = L$ the outgoing wave in the right contact is $b_R^L e^(i k_R (x - L))$
with nothing incoming, so
$
  phi^L_E (L) = b_R^L (E),
$
writing $b_(c')^c$ for the amplitude in contact $c'$ of the state injected
from contact $c$.#note[
  The lectures write $b_(R L)$ for $b_R^L$ and $b_(L R)$ for $b_L^R$, ordering
  the two indices the other way round from the transmission $T_(L R)$ below.
]
The infinitesimal current is therefore
$
  I_(L R) (E, E(avec(k)_t))
    = - q / (L A) abs(b_R^L (E))^2 / abs(a_L)^2
      abs(v_R (E)) thin f(E + E(avec(k)_t), E_F^L),
$
divided through by the injection amplitude $abs(a_L)^2$.
#key[Every amplitude of the left-injection problem is proportional to $a_L$,
which is chosen and not computed, so dividing by it removes a choice that no
measurable quantity may depend on.]

The two sums are performed as they were for the carrier density.
The transverse one gives the Fermi integral @FI.
The longitudinal one is converted into an integral over energy by
@sum-to-integral-1d, and the Jacobian this time is written as a velocity from
the outset,
$
  abs((dif E(k_L)) / (dif k_L)) dif k_L = planck abs(v_L (E')) dif k_L
    = dif E',
$
so that the velocity of the injecting contact appears in a denominator.
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

This is the transmission @transmission of the previous chapter with the velocity
ratio that was flagged there and not needed.
#key[Transmission is a ratio of currents and not of probability densities, so
where the two contacts carry different potentials or different masses the
carrier leaves at a different speed than it arrived with and the ratio of speeds
belongs in the definition.]
It is a probability and lies in $cc(0, 1)$ for the single propagating mode of a
one-dimensional device.
The two velocities cancel in the symmetric structure of the previous chapter,
which is why the factor could be omitted there.

The current from the right is the same construction mirrored, evaluated just
inside the left contact,
$
  I_(R L) = - q / planck integral (dif E) / (2 pi)
    thin T_(R L) (E) thin F(E, E_F^R),
  quad
  T_(R L) (E) = abs(b_L^R (E))^2 / abs(a_R)^2
    thin abs(v_L (E)) / abs(v_R (E)),
$ <i-rl>
with the roles of the two contacts exchanged everywhere, the injecting velocity
now $v_R$ and the exit velocity $v_L$.

=== Landauer-Büttiker formula

#exam("L4.5")
The two transmissions are equal,
$
  T_(L R) (E) = T_(R L) (E) =: T(E),
$ <T-symmetry>
which is a consequence of time-reversal symmetry: a trajectory traversed
backwards in time returns to where it started, so the structure transmits
equally in both directions.#note[
  Luisier stated the symmetry @T-symmetry without proof, saying a proof is
  beyond the scope
  of the lecture, and pointed at the third exercise, where both transmissions
  are computed and come out identical in every configuration.
]
It is a property of the structure and not of the bias, both transmissions being
computed from the same $V(x)$.

Putting the two fluxes @i-lr and @i-rl into the total current @i-tot and using
the symmetry @T-symmetry gives one equation for the current,
$
  I_"tot" = - q / planck integral (dif E) / (2 pi)
    thin T(E) thin (F(E, E_F^L) - F(E, E_F^R)).
$ <LB>
#key[The current is an integral over energy of a transmission times the
difference of the occupations of the two contacts, and everything about the
device sits in $T(E)$ while everything about the driving sits in the
difference.]
This is the #term("Landauer-Büttiker formula").#note[
  Luisier said what he expects on this equation: an integral over energy, a
  transmission function, and the difference of the two Fermi integrals. He said
  the prefactor $- q slash planck$ and the $2 pi$ are not part of the answer.
]
The formula as it is usually written carries the Fermi functions of the two
contacts rather than the Fermi integrals;
the Landauer-Büttiker formula @LB is the form the transverse dimensions leave
behind once they have been summed over,
and it reduces to the usual one for a device confined in those dimensions.

Two consequences are immediate.
Equal Fermi levels give zero current, the two fluxes cancelling exactly at every
energy, which is the equilibrium statement made quantitative.
And a difference of Fermi levels is not the only way to make the difference in
the Landauer-Büttiker formula @LB nonzero:
holding the two contacts at the same Fermi level but at different temperatures
also leaves it nonzero, since $F$ depends on $T$ through
$(E - E_F) slash k_B T$, and the current that results is the
#term("Seebeck effect"), taken up in a later chapter.

=== Spectral current

The integrand of the Landauer-Büttiker formula @LB is worth more than the number
the integral returns.
#key[The product $T(E)(F(E, E_F^L) - F(E, E_F^R))$ says at which energies the
current flows, and since the current is the same at every position it may be
drawn across the whole device on top of the band diagram.]
Slide 28 does this for a #qty(4, $"nm"$) barrier of height #qty(0.3, $"eV"$),
beside the current-voltage characteristic and the band diagram, and the current
rises roughly exponentially with the applied bias.

The picture reads directly.
Carriers cannot cross the barrier that the doping raises in front of the
material barrier, that one being too wide to tunnel through, so the current
flows only above it;
above that energy it then tunnels through the narrow aluminium gallium arsenide
barrier, and the spectral current is concentrated in the narrow window where
both are possible.
The equivalent statement for the carrier density is slide 15, and the two
together are the internal quantities the first chapter said no measurement
reaches.

== Current continuity

The construction so far produces one number per bias, and it produces it by
choosing a convenient point and invoking conservation.
The conservation itself is worth stating, since it is also what settles the
interface conditions used since the second chapter.

#key[The Schrödinger equation conserves probability, in the sense that the
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
Landauer-Büttiker formula @LB, giving the current at every position rather than
one number for the device.]
It is what a later chapter uses to resolve a current in space, and it is what
makes current conservation checkable rather than assumed.

The interface conditions follow from it.
At a material interface the wave function is continuous, since a jump in it
would be a jump in the probability density, and so is its complex conjugate.
Requiring in addition that the probability current @prob-current-1d take the
same value on both sides
forces $(1 slash m^*) partial psi slash partial x$ to be continuous there, the
mass entering through the prefactor and the derivative through the bracket.
#key[Continuity of the wave function alone does not conserve the current across
an interface where the mass jumps, and it is the pair of conditions that does.]
This is the condition the BenDaniel-Duke ordering @BDD was constructed to
satisfy and the one the barrier of the previous chapter was matched with, now
derived rather than asserted.

== Outlook

The wave function formalism is complete.
The open system @OBC is solved once per energy, its solutions give the carrier
density through @n-obc and the current through the Landauer-Büttiker formula
@LB, and both are computed from a tridiagonal linear system with two right-hand
sides.

One thing has been assumed throughout and never computed.
The potential $V(x)$ entering $H$ was taken as given, flat in the contacts and
sloping across the device, and it is in fact produced by the charges that the
carrier density @n-obc returns.
The next chapter closes that loop with Poisson's equation, which turns the
calculation into a self-consistent one and supplies the band diagrams this
chapter read off the slides.
It then opens the second formalism of the course, in which the same operator
$E - H - Sigma$ is inverted rather than applied to a source.
