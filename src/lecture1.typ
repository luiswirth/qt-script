#import "setup.typ": *
#show: chapter.with("Device scaling and transport regimes")

A transistor made small enough stops admitting a description in which electrons
are particles.
Where the boundary lies is decided by comparing the length of the device against
a length carried by the description itself,
and the three descriptions in use carry three different ones.

== Field-effect transistor

A transistor is a switch with three terminals.
Current is meant to flow from the #term("source") to the #term("drain"),
and the #term("gate") decides whether it does.
The gate carries no current itself;
it sits above the channel and controls it electrostatically,
which is what the #term("field effect") in the name refers to.
Slide 16 shows the two measurements that characterize such a device.
The #term("output characteristic") plots the drain current $I_d$ #unit($A$),
quoted per unit device width in #unit($mu A slash mu m$) whenever devices of
different sizes are compared,
against the drain-source voltage $V_(d s)$ #unit($V$), one curve per gate voltage.
The #term("transfer characteristic") plots $I_d$ against the gate voltage $V_(g s)$
#unit($V$) on a logarithmic scale, at a small drain bias and at the supply voltage.
A switch is judged by the ratio between the current it passes when on and the
current it leaks when off,
and that ratio spans many decades, which is what the logarithmic axis is for.

Two figures of merit follow from it and recur throughout the course.
The #term("on-current") $I_"on"$, read at $V_(g s) = V_(d s) = V_(D D)$,
should be as large as possible,
since it charges the next transistor in the circuit and therefore sets the clock
frequency.
The #term("off-current") $I_"off"$, read at $V_(g s) = 0$ and $V_(d s) = V_(D D)$,
should be as small as possible,
since it is dissipated continuously by every idle transistor on the chip.
Here $V_(D D)$ is the supply voltage, nowadays around #qty(0.7, $V$) to #qty(0.8, $V$).

== Scaling and technology nodes

The device keeps getting smaller for economic rather than physical reasons.
Moore observed in 1965 that the number of components per integrated circuit had
doubled every year since 1958 and predicted the trend would hold for another
decade;
slide 19 reproduces his original sketch.
Each generation reduces both the length and the width of a transistor by 30%,
so the area becomes
$
  0.7 times 0.7 = 0.49,
$
half of what it was.
Twice as many devices then fit on a die,
and since the cost of processing a wafer is roughly fixed,
the cost per device halves.
Each such step is a #term("technology node"),
and successive node names carry the same factor, $X_(n+1) = 0.7 X_n$.

A node name once referred to a physical gate length, and did so down to about the
#qty(90, $"nm"$) node.
Scaling of the physical dimensions then slowed while the names kept advancing by
the same factor,
so the label is now a marketing designation rather than a measurement.
Slide 24 gives the roadmap by manufacturer:
the industry sits at the 2 nm node in 2025,
targets 1.4 nm around 2028 and 1 nm around 2032,
and the interval between generations is lengthening as the capital cost of a
fabrication plant grows.

== Electrostatic control and device geometry

Scaling the gate length is not a matter of drawing it shorter.
The channel potential is set by a competition.
The gate raises and lowers the barrier between source and drain,
and the drain, a biased contact adjacent to the same channel,
works against it.
When the channel is long the gate wins easily,
since it faces the channel over a length far exceeding the distance from the
drain.
As the gate length shrinks toward the source-drain separation the drain begins to
compete,
and the gate progressively loses authority over the barrier it is supposed to
control.
Everything that has happened to transistor geometry in the last fifteen years is
a response to that loss.

The remedy is to increase how much of the channel the gate faces.
Until 2011 transistors were planar, with a single gate above the channel;
slide 25 shows one beside its three-dimensional successor.
Intel then introduced the #term("FinFET") at the 22 nm node,
in which the channel is a narrow fin and the gate wraps it on three sides,
so that the same applied voltage commands a far larger share of the channel.
In 2022 Samsung moved to the #term("nanosheet FET") at the 3 nm node,
shown on slide 26,
where several thin silicon sheets are stacked and the gate surrounds each one
completely;
TSMC followed at the 2 nm node at the end of 2025.
This is #term("gate-all-around"), the strongest control the geometry admits,
and it removes the one weakness of the fin, whose bottom the gate could not reach.
Control is tightened further by thinning the sheets themselves, to #qty(4, $"nm"$)
or #qty(5, $"nm"$),
and the expected continuation is to draw them into stacked #term("nanowires") three to
four nanometers in diameter.

Each step confines the channel more tightly in order to control it better,
and #term("confinement") on the scale of a few nanometers is precisely the condition under
which an electron ceases to behave as a particle.
The engineering remedy and the physical difficulty have the same cause.

== Device simulation

A new device is designed from intuition, experience, and extrapolation from the
previous generation,
then fabricated, characterized, and compared against its specification.
The first prototype essentially never meets it,
and every iteration of the loop costs a run through a clean room.
Simulation, in this context called #term("Technology Computer Aided Design") (TCAD),
replaces some of those iterations with computation;
slides 27 and 28 show the loop and what a simulator is expected to deliver,
namely both measurable quantities such as current and internal ones such as the
charge distribution, which no measurement reaches.
The nanowire transistor of slide 4 is such an internal quantity made visible:
electrons crossing the channel emit #term("phonons"), the quanta of lattice vibration,
and each emission takes a discrete amount of energy out of the carrier and
deposits it in the lattice.

Choosing the physical model is the whole difficulty,
because physical completeness and computational cost trade against each other and
cannot both be had.
A model resolving every atom, the vibrations of the lattice, and the coupling
between them
is confined to systems small enough to be called toy examples,
supercomputer aside.
A model omitting quantum mechanics runs on a realistically sized device but may
miss the effect that decides its behavior.

== Transport models

#exam("L1.1")
Three families of transport model are in use,
distinguished by what they take the unknown to be and by what they therefore
resolve.
Each carries a length that the length of the device must be compared against,
and the comparison decides whether the model applies at all.

=== Drift-diffusion and mobility

At the classical level the unknowns are the carrier densities $c_s$
#unit($m^(-3)$), the species $s in {n, p}$ being electrons and holes,
and the current density is
$
  avec(J)_s = q_s mu_s c_s avec(cal(E)) - q_s D_s nabla c_s.
$ <drift-diffusion>
The quantities appearing here are the #term("current density")
$avec(J)$ #unit($A slash m^2$), charge crossing unit area per unit time;
the charge of the species $q_s$,
$q_n = -q_0$ and $q_p = +q_0$ for the elementary charge
$q_0 = #qty($1.602 dot 10^(-19)$, $C$)$;
the electric field $avec(cal(E))$ #unit($V slash m$)\;
the #term("mobility") $mu_s$ #unit($m^2 slash (V thin s)$), defined below;
and the #term("diffusion coefficient") $D_s$ #unit($m^2 slash s$),
which relates a particle flux to the density gradient driving it,
no charge entering it.
The charge is signed, and every quantity derived from it carries that sign.#note[
  The lectures and the experimental literature leave it unsigned, write $q$ for
  $q_0$ and carry the magnitudes $abs(mu_s)$, the sign sitting in the species
  label, write $n$ and $p$ for $c_n$ and $c_p$,
  and split @drift-diffusion into one equation per species.
]

The first term is #term("drift"), driven by the field, the second
#term("diffusion"), driven by the density gradient.
Drift carries the charge twice, through the force $q_s avec(cal(E))$ and again
through the current, a current being a particle flux times the charge carried,
so $q_s mu_s = q_s^2 tau_s slash m_s^*$ below is positive for either species,
while diffusion carries it once and changes sign between them.
Electrons and holes in one field drift in opposite directions carrying opposite
charge, so their currents add,
and in one density gradient they diffuse the same way, so their currents
subtract.

The content of @drift-diffusion sits in the mobility,
so the question of when the model may be used is the question of when a mobility
exists at all.
Consider one carrier injected into a slab across which a constant field is
applied.
The argument is one-dimensional, along the field,
so $cal(E)$ denotes the field component throughout it.
Between collisions the carrier obeys Newton's law,
$
  m_s^* (dif v) / (dif t) = q_s cal(E),
$
in which $m_s^*$ #unit($"kg"$) is the #term("effective mass"),
the mass a carrier appears to carry inside the crystal rather than in vacuum,
fixed by the curvature of the band it occupies and computed in the next lecture;
$v$ #unit($m slash s$) is the velocity
and $dif v slash dif t$ #unit($m slash s^2$) the acceleration.
The effective mass is customarily given as a multiple of the free electron mass
$m_0 = #qty($9.109 dot 10^(-31)$, $"kg"$)$,
so that $m_n^* = 0.32 m_0$ in silicon is a number and not a measurement in
kilograms.
Its velocity therefore grows linearly in time.
It then scatters, off another electron, an impurity, or a surface,
losing the momentum it had accumulated,
and accelerates again over a different, randomly distributed interval until it
leaves the device.
Free flight interrupted by collisions that reset the momentum is the
#term("Drude model").

Steady state is the balance between those two processes.
Write $angled(v)$ #unit($m slash s$) for the velocity averaged along the
trajectory, the #term("drift velocity"),
and $tau_s$ #unit($s$) for the #term("mean free time"), the average interval
between two scattering events.
Momentum is gained at the rate $q_s cal(E)$ and lost at the rate
$m_s^* angled(v) slash tau_s$,
and equating the two gives
$
  angled(v) = (q_s tau_s) / m_s^* cal(E) =: mu_s cal(E),
  quad mu_s := (q_s tau_s) / m_s^*.
$
Since $mu_s slash q_s = tau_s slash m_s^*$ is positive,
an electron drifts against the field and a hole along it.
Both $tau_s$ and $m_s^*$ depend on the species,
so the two mobilities differ in magnitude and not in sign alone.
The mobility is not an independent material parameter but a statement about
scattering:
the longer a carrier survives between collisions the faster it moves,
and the faster it moves the higher the clock frequency the circuit sustains.
The length that goes with it is the #term("mean free path") $lambda_"mfp"$ #unit($m$),
$
  lambda_"mfp" = abs(angled(v)) tau_s,
$ <mfp>
the average distance covered between two scattering events,
a speed times a time.#note[
  The Drude picture returns a carrier to rest after every collision, which is
  what leaves the drift velocity in @mfp. Thermal motion, which dominates the
  drift velocity at low field, would put the thermal velocity there instead.
]

Both $tau_s$ and $angled(v)$ are averages,
and averaging over scattering events presupposes there are enough events to
average over.
A mobility can be defined, and @drift-diffusion applied, only when
$
  L >> lambda_"mfp",
$ <dd-validity>
with $L$ the length of the device.
A device shorter than its own mean free path offers no statistics to support a
mobility,
so the model does not merely lose accuracy there, it loses meaning.
In times rather than lengths the same condition reads that the transit time
through the device far exceeds the energy relaxation time,
a carrier having to relax many times over before it leaves.
Drift-diffusion is derivable from the Boltzmann transport equation below,
and inherits from that derivation a second restriction,
to states perturbed only slightly away from equilibrium.

Two things are absent from @drift-diffusion by construction,
and no adjustment of $mu_s$ or $D_s$ introduces them.
There is no #term("tunneling"), so a barrier reflects every carrier whose energy
lies below it, however thin it is.
And there is no #term("quantization"), so a quantum well carries a continuum of states
rather than a discrete set.
Quantum corrections exist and are widely used,
but they reproduce the symptoms of effects the model does not contain.

=== Boltzmann transport equation

At the #term("semiclassical") level the unknown is richer.
It is the #term("distribution function") $f(avec(r), avec(k), t)$,
the occupation of a point of phase space,
and it is dimensionless, taking values in $cc(0, 1)$,
since it counts the fraction of available states that are filled rather than a
number of particles.
Its arguments are position $avec(r)$ #unit($m$),
wave vector $avec(k)$ #unit($m^(-1)$),
which carries momentum $avec(p) = planck avec(k)$ and is the natural variable
because a crystal quantizes momentum rather than velocity,
and time $t$ #unit($s$).
It obeys the #term("Boltzmann transport equation"),
$
  (partial / (partial t) + avec(v)(avec(k)) dot nabla_avec(r)
    + q_s / planck avec(cal(E))(t) dot nabla_avec(k)) f(avec(r), avec(k), t)
    = ((dif f) / (dif t))_"collision".
$ <bte>
The left-hand side is the total derivative of $f$ along a classical trajectory,
which is what the three terms together amount to and why the right-hand side is
written as one:
what a trajectory cannot account for is exactly what a collision does.
The first term is the explicit time dependence,
the second moves a carrier through real space at the #term("band velocity")
$avec(v)(avec(k))$ #unit($m slash s$),
which is not an independent quantity but the group velocity of the band,
$avec(v) = planck^(-1) nabla_avec(k) E(avec(k))$,
and the third accelerates it through momentum space under the field,
which is Newton's law once more, in the form
$planck dot(avec(k)) = q_s avec(cal(E))$.
Here $planck = h slash 2 pi = #qty($1.055 dot 10^(-34)$, $J thin s$)$
is the reduced Planck constant,
which has the dimension of an action, energy times time.
Quantum mechanics enters @bte in two restricted places,
through the band velocity and through the collision term, and nowhere else.
Read as mathematics this is a kinetic equation on phase space,
and @drift-diffusion is recoverable from it in the diffusive limit,
which is the precise sense in which drift-diffusion sits below the Boltzmann
equation rather than beside it.

What the extra variables buy is the collision operator on the right.
Where drift-diffusion compresses all scattering into the single number $tau_s$,
@bte keeps each mechanism explicitly,
as a table of processes selected according to their probabilities as a carrier
propagates.
Scattering is thus resolved event by event rather than on average,
and the validity condition relaxes from @dd-validity to
$
  L approx lambda_"mfp",
$
which makes the semiclassical level the right one for devices too short to
average over but not yet short enough to be waves.
The upper end of that range is where a trajectory stops being followable at all:
a potential varying sharply over 10 to 20 nm has to be met with waves,
whatever the mean free path.
In practice @bte is not discretized directly but solved by Monte Carlo methods,
its phase space being too large for a direct attack.
The Wigner transport equation is a variant of the same description.

What @bte does not repair is the more serious limitation.
It still treats carriers as point particles following trajectories,
so like drift-diffusion it contains neither tunneling nor quantization.
Both models fail on exactly the same physics,
and the failure is not one of resolution but of kind.

=== Quantum transport and de Broglie wavelength

At the quantum level the unknown is the wave function,
and the equation solved is the stationary #term("Schrödinger equation")
$
  (- planck^2 / (2 m^*) lapl + V(avec(r))) psi(avec(r)) = E psi(avec(r)).
$ <schroedinger>
The potential energy $V(avec(r))$ #unit($J$), in practice #unit($"eV"$),
is what the device geometry and the applied voltages supply,
and $E$ #unit($J$) is the energy eigenvalue.
The #term("wave function") $psi(avec(r))$ has the dimension #unit($m^(-3 slash 2)$) in
three dimensions,
which is not a curiosity but forced:
$abs(psi)^2$ is a probability density per unit volume,
so it must carry #unit($m^(-3)$), and $psi$ carries its square root.
A wave function has no meaning without the normalization that fixes this,
and any quantity computed from it inherits the convention.

As written this is an eigenvalue problem,
a self-adjoint spectral problem for the #term("Hamiltonian"),
and in that form it describes a closed system.
It is not yet a transport equation.
A device is open, joined to contacts through which carriers enter and leave,
and @schroedinger has to be modified before it can express that.
Doing so properly occupies the next several lectures,
and it is where the two formalisms of this course,
the wave function and the non-equilibrium Green's function,
part company.

#exam("L1.2")
The criterion for needing @schroedinger at all is again a length.
An electron of energy $E$ carries momentum $p = sqrt(2 m^* E)$
#unit($"kg" thin m slash s$),
from the non-relativistic $E = p^2 slash 2 m^*$,
and hence the #term("de Broglie wavelength") $lambda$ #unit($m$),
$
  lambda = h / sqrt(2 m^* E) = h / p,
$ <de-broglie>
with $h = #qty($6.626 dot 10^(-34)$, $J thin s$)$ Planck's constant, unreduced,
since the relation is $lambda = h slash p$ and not $planck slash p$.
The dimensions check:
an action divided by a momentum is
#unit($J thin s slash ("kg" thin m slash s)$), which reduces to #unit($m$).
Wave behavior matters once a device dimension becomes comparable to $lambda$,
and it is enough that this holds along one of the three dimensions,
since confinement in a single direction already quantizes the spectrum.

Taking carriers #qty(0.1, $"eV"$) above the conduction band edge,
where their concentration is largest, @de-broglie
gives#note[Slide 35 rounds $lambda("Si")$ down to #qty(6.8, $"nm"$).]
$
  lambda("Si") &= #qty(6.9, $"nm"$), quad m^* = 0.32 m_0, \
  lambda("GaAs") &= #qty(15.2, $"nm"$), quad m^* = 0.065 m_0.
$
Since $lambda prop 1 slash sqrt(m^*)$,
the lighter carriers of GaAs are the more demanding case,
and a GaAs device is already quantum mechanical at dimensions where a silicon one
is still classical.
Set these against the structure on slide 35,
a channel #qty(5, $"nm"$) thick with a gate #qty(20, $"nm"$) long,
and against the stated goal of the course, gate lengths of #qty(5, $"nm"$) to #qty(20, $"nm"$).
A silicon channel of #qty(5, $"nm"$) lies below $lambda("Si")$ outright.
Quantum transport is not a refinement here, it is the only applicable description.

=== Choice of model

A device carries electrons and holes, while @de-broglie contains one effective
mass.
Usually only one of the two conducts:
an n-type transistor is carried by electrons, a p-type by holes.
Where both matter, as in a tunnel FET,
the smaller effective mass decides, hence the longer wavelength,
and the whole device is treated at the level that mass demands.
Mixing models, quantum transport for electrons and drift-diffusion for holes,
is not advisable.
The one defensible exception is a device such as a bipolar transistor in which one
carrier is demonstrably classical and the other is not,
where the two descriptions may be coupled through the electrostatics,
that is, through Poisson's equation.

#table(
  columns: 4,
  align: (left, left, left, left),
  table.header([*model*], [*unknown*], [*applies when*], [*resolves*]),
  [drift-diffusion], [$c_n$, $c_p$], [$L >> lambda_"mfp"$], [scattering on average],
  [Boltzmann],
  [$f(avec(r), avec(k), t)$],
  [$L approx lambda_"mfp"$],
  [each scattering event],

  [quantum transport], [$psi(avec(r))$], [$L approx lambda$], [quantization, tunneling],
)

== Quantum effects in scaled devices

Three effects appear once a device reaches these dimensions,
and neither classical model contains any of them.

=== Band structure quantization

Bulk silicon has the band structure on the left of slide 37,
with an #term("indirect gap"):
the conduction band minimum and the valence band maximum lie at different points
of the Brillouin zone,
which is why silicon does not emit light.
Confine that same silicon to a #qty(5, $"nm"$) layer between two oxide barriers,
as in a double-gate transistor,
and the right of slide 37 shows the result.
The single conduction band is replaced by a family of discrete #term("subbands"),
each with its own dispersion, and likewise for the valence band.
The material has not changed.
Confinement has quantized the spectrum,
and the familiar square-well picture of discrete levels is exactly what this is,
computed with a full band model rather than a single parabola.

=== Interface confinement and density of states

Slide 38 makes the same point in the geometry of a real MOSFET,
cutting vertically through the channel beneath the gate.
The gate voltage bends the bands and forms a well against the oxide,
triangular rather than square,
holding a discrete set of bound states $E_1, E_2, E_3$.
Their wave functions penetrate into the oxide barrier instead of vanishing at it,
which is a purely quantum feature.

The right of the same slide carries the consequence.
Classically the #term("density of states") grows as $sqrt(E)$, smoothly from the band edge.
In the confined channel it is a staircase,
flat until $E_1$ and stepping up at each subband edge.
Since the carrier density is an integral of the density of states against the
occupation,
the difference is not cosmetic,
and the comparison between the two curves is taken up in the next lecture.

=== Intra-band tunneling

The effect that limits scaling most directly is developed on slides 39 to 41.
The geometry is a #term("double-gate FET") cut along the direction of current flow,
so the horizontal axis runs from source to drain,
and the gate raises a potential barrier between them.
In the off state that barrier is what suppresses the current.

Read the four panels of slide 40 from the bottom right,
in order of decreasing gate length.
At $L_g = #qty(13, $"nm"$)$ the barrier does its job:
carriers with energy below its peak are reflected,
and the only current is carried by the thermal tail of the distribution passing
over the top.
That is #term("thermionic emission"); it is classical, and it cannot be eliminated.
At #qty(10, $"nm"$) a second contribution appears,
with carriers crossing through the upper part of the barrier rather than over it.
At #qty(7, $"nm"$) it is stronger.
At #qty(4, $"nm"$) the barrier is effectively transparent and carriers cross it
irrespective of energy.

Slide 41 shows the cost in the quantity that matters.
On a logarithmic plot of $I_d$ against $V_(g s)$ the off-current rises only
slightly from #qty(13, $"nm"$) to #qty(10, $"nm"$),
then by orders of magnitude at #qty(4, $"nm"$),
so a transistor that is nominally switched off conducts substantially.
This is #term("source-to-drain tunneling"), also called #term("intra-band tunneling"),
since the carrier stays within the conduction band throughout,
as opposed to the #term("band-to-band tunneling") of a tunnel FET.
No drift-diffusion model and no Boltzmann solver can produce it,
since neither contains tunneling at all,
and it is a leading reason why the gate length of a production device has stopped
following the node label downward.

== Outlook

The device simulated over the semester is the double-gate FET of slides 39 to 41,
and the target is to reproduce curves like slide 41 from first principles.
Two further structures recur:
the #term("tunnel FET"), built to exploit band-to-band tunneling rather than to
suffer from it,
and the #term("resonant tunneling diode"), whose behavior rests on a single resonant state
and which therefore makes a clean test of any simulator.

The route there starts one level below transport.
@schroedinger presumes an effective mass and a band structure,
and the next lecture computes both,
for bulk material and for a quantum well,
which is the calculation whose output is the two panels of slide 37.
