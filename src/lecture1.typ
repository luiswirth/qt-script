#import "setup.typ": *
#show: chapter.with("Device scaling and transport regimes")

A transistor gets smaller with every generation.
At some size we can no longer describe an electron in it as a small particle
flying through the device, and we have to describe it as a wave instead.
Which description we need is decided by comparing the length of the device with
a length that the description itself brings along.
Three descriptions are in use, and each brings a different length.

== Field-effect transistor

A transistor is a switch with three terminals.
Current is meant to flow from the #term("source") to the #term("drain"), and the
#term("gate") decides whether it does.
The gate itself carries no current.
It sits above the channel and controls it electrostatically, and that is what
the #term("field effect") in the name refers to.

Slide 16 shows the two measurements that characterize such a device.
The #term("output characteristic") plots the drain current $I_d$ against the
drain-source voltage $V_(d s)$, with one curve per gate voltage.
When we compare devices of different sizes we quote $I_d$ per unit device width,
in #unit($mu A slash mu m$).
The #term("transfer characteristic") plots $I_d$ against the gate voltage
$V_(g s)$ on a logarithmic scale, at a small drain bias and at the supply
voltage.
#key[A switch is judged by the ratio between the current it passes when it is on
and the current it leaks when it is off.]
That ratio spans many decades, which is what the logarithmic axis is for.

Two figures of merit follow from it, and both recur throughout the course.
The #term("on-current") $I_"on"$ is read at $V_(g s) = V_(d s) = V_(D D)$ and
should be as large as possible.
It charges the next transistor in the circuit, so it sets the clock frequency.
The #term("off-current") $I_"off"$ is read at $V_(g s) = 0$ and
$V_(d s) = V_(D D)$ and should be as small as possible.
Every idle transistor on the chip dissipates it continuously.
Here $V_(D D)$ is the supply voltage, nowadays around #qty(0.7, $V$) to
#qty(0.8, $V$).

== Scaling and technology nodes

#key[Devices keep getting smaller for economic reasons rather than physical
ones.]
Moore observed in 1965 that the number of components per integrated circuit had
doubled every year since 1958, and he predicted that the trend would hold for
another decade.
Slide 19 reproduces his original sketch.
A new generation arrives every 18 to 24 months and reduces both the length and
the width of a transistor by 30%, so the area becomes
$
  0.7 times 0.7 = 0.49,
$
which is half of what it was.
Twice as many devices then fit on a die.
Processing a wafer costs roughly the same either way, so the cost per device
halves.
Each such step is a #term("technology node"), and the node names carry the same
factor, $X_(n+1) = 0.7 X_n$.

A node name once referred to a physical gate length, and it did so down to about
the #qty(90, $"nm"$) node.
After that the physical dimensions scaled more slowly, while the names kept
advancing by the same factor.
#key[A node name today is a marketing designation and not a measurement.]
Slide 24 gives the roadmap by manufacturer.
The industry sits at the 2 nm node in 2025, targets 1.4 nm around 2028 and 1 nm
around 2032, and the interval between generations is getting longer as the
capital cost of a fabrication plant grows.

== Electrostatic control and device geometry

Scaling the gate length is not just a matter of drawing it shorter.
#key[The potential in the channel is set by a competition between the gate and
the drain.]
The gate raises and lowers the barrier between source and drain.
The drain is a biased contact next to the same channel, and it works against the
gate.
In a long channel the gate wins easily, because it faces the channel over a
length far larger than the distance to the drain.
As the gate gets shorter the drain starts to compete, and the gate loses
authority over the barrier it is supposed to control.
Everything that has happened to transistor geometry in the last fifteen years is
a response to that loss.

The remedy is to give the gate more of the channel to face.
Until 2011 transistors were planar, with a single gate above the channel, and
slide 25 shows one next to its three-dimensional successor.
Intel then introduced the #term("FinFET") at the 22 nm node.
There the channel is a narrow fin and the gate wraps around it on three sides,
so the same applied voltage commands a much larger share of the channel.
In 2022 Samsung moved to the #term("nanosheet FET") at the 3 nm node, shown on
slide 26, where several thin silicon sheets are stacked and the gate surrounds
each one completely.
TSMC followed at the 2 nm node at the end of 2025.
This is #term("gate-all-around"), the strongest control the geometry allows, and
it fixes the one weakness of the fin, whose bottom the gate could not reach.
Thinning the sheets themselves tightens the control further, to #qty(4, $"nm"$)
or #qty(5, $"nm"$).
The expected continuation is to draw them into stacked #term("nanowires") three
to four nanometers in diameter.

Each of these steps confines the channel more tightly in order to control it
better.
#key[An electron stops behaving as a particle under exactly this kind of
#term("confinement"), on the scale of a few nanometers.]
So the engineering remedy and the physical difficulty have the same cause.

== Device simulation

A new device is designed from intuition, experience and extrapolation from the
previous generation.
It is then fabricated, characterized and compared against its specification.
The first prototype essentially never meets it, and every iteration of that loop
costs a run through a clean room.
Simulation replaces some of those iterations with computation, and in this
context it is called #term("Technology Computer Aided Design") (TCAD).
Slides 27 and 28 show the loop and what a simulator is expected to deliver.
It delivers measurable quantities such as the current, and also internal ones
such as the charge distribution, which no measurement reaches.
The nanowire transistor of slide 4 shows such an internal quantity.
Electrons crossing the channel emit #term("phonons"), which are the quanta of
lattice vibration, and each emission takes a discrete amount of energy out of
the carrier and deposits it in the lattice.

#key[Choosing the physical model is the whole difficulty, because physical
completeness and computational cost trade against each other.
We cannot have both.]
A model that resolves every atom, the vibrations of the lattice and the coupling
between them only runs on systems small enough to be called toy examples, at
least without a supercomputer.
A model that omits quantum mechanics runs on a realistically sized device, but
it may miss the very effect that decides how the device behaves.

== Transport models

#exam("L1.1")
Three families of transport model are in use.
They differ in what they take the unknown to be, and therefore in what they
resolve.
#key[Each family brings a length, and we compare the length of the device
against it.
That comparison decides whether the model applies at all.]

=== Drift-diffusion and mobility

At the classical level the unknowns are the carrier densities $n_s$
#unit($m^(-3)$), where the species $s in {n, p}$ are electrons and holes.
We write $n$ and $p$ when we mean one species.
The current density is
$
  avec(J)_s = q_s mu_s n_s avec(cal(E)) - q_s D_s nabla n_s.
$ <DD>
The quantities in it are the #term("current density") $avec(J)$, which is charge
crossing unit area per unit time; the charge of the species $q_s$, with
$q_n = -q$ and $q_p = +q$ for the elementary charge
$q = #qty($1.602 dot 10^(-19)$, $C$)$; the electric field $avec(cal(E))$; the
#term("mobility") $mu_s$ #unit($m^2 slash (V thin s)$), defined below; and the
#term("diffusion coefficient") $D_s$ #unit($m^2 slash s$), which relates a
particle flux to the density gradient driving it and contains no charge.
The charge is signed, and every quantity we derive from it carries that
sign.#note[
  The lectures and the experimental literature leave it unsigned and carry the
  magnitudes $abs(mu_s)$, the sign sitting in the species label,
  and split the drift-diffusion current @DD into one equation per species.
]

The first term is #term("drift"), driven by the field.
The second is #term("diffusion"), driven by the density gradient.
The two terms treat the charge differently.
Drift picks it up twice, once through the force $q_s avec(cal(E))$ and once
through the current, since a current is a particle flux times the charge
carried.
That is why $q_s mu_s = q_s^2 tau_s slash m_s^*$ below is positive for both
species.
Diffusion picks the charge up once, so it changes sign between the species.
Electrons and holes in one field drift in opposite directions and carry opposite
charge, so their currents add.
In one density gradient they diffuse the same way, so their currents subtract.

Everything the drift-diffusion current @DD knows sits in the mobility.
So the question of when we may use the model is the question of when a mobility
exists at all.
To answer it, consider one carrier injected into a slab with a constant field
across it.
The argument runs along the field, in one dimension, so $cal(E)$ means the field
component along it.
Between collisions the carrier obeys Newton's law.
It carries the mass it has inside the crystal, not the one it has in vacuum.
That is the #term("effective mass") $m_s^*$, which is fixed by the curvature of
the band the carrier occupies and which we compute in the next lecture.
We customarily give it as a multiple of the free electron mass
$m_0 = #qty($9.109 dot 10^(-31)$, $"kg"$)$, so that $m_n^* = 0.32 m_0$ in
silicon is a number rather than a measurement in kilograms.
Newton's law reads
$
  m_s^* (dif v) / (dif t) = q_s cal(E),
$
so the velocity $v$ grows linearly in time.
Then the carrier scatters, off another electron, an impurity or a surface, and
loses the momentum it had built up.
It accelerates again over a different interval, randomly distributed, until it
leaves the device.
This picture of free flight interrupted by collisions that reset the momentum is
the #term("Drude model").

Steady state is the balance between the two processes.
Write $angled(v)$ for the velocity averaged along the trajectory, called the
#term("drift velocity"), and $tau_s$ for the #term("mean free time"), the
average interval between two scattering events.
Momentum is gained at the rate $q_s cal(E)$ and lost at the rate
$m_s^* angled(v) slash tau_s$.
Equate the two and we get
$
  angled(v) = (q_s tau_s) / m_s^* cal(E) =: mu_s cal(E),
  quad mu_s := (q_s tau_s) / m_s^*.
$
Since $mu_s slash q_s = tau_s slash m_s^*$ is positive, an electron drifts
against the field and a hole drifts along it.
Both $tau_s$ and $m_s^*$ depend on the species, so the two mobilities differ in
magnitude and not only in sign.

The mobility is a statement about scattering.
The longer a carrier survives between collisions, the faster it moves, and the
faster it moves, the higher the clock frequency the circuit sustains.
The length that goes with it is the #term("mean free path") $lambda_"mfp"$,
$
  lambda_"mfp" = abs(angled(v)) tau_s,
$ <mfp>
which is the average distance covered between two scattering events, a speed
times a time.#note[
  The Drude picture returns a carrier to rest after every collision, which is
  what leaves the drift velocity in the mean free path @mfp.
  Thermal motion, which dominates the drift velocity at low field,
  would put the thermal velocity there instead.
]

Both $tau_s$ and $angled(v)$ are averages, and averaging over scattering events
needs enough events to average over.
So we can define a mobility, and apply drift-diffusion @DD, only when
$
  L >> lambda_"mfp",
$
where $L$ is the length of the device.
#key[A device shorter than its own mean free path gives us no statistics to
build a mobility from.
There the model loses its meaning, not just its accuracy.]
Stated in times instead of lengths, the same condition says that the transit
time through the device is much longer than the energy relaxation time, so a
carrier relaxes many times over before it leaves.
Drift-diffusion can be derived from the Boltzmann transport equation below, and
that derivation adds a second restriction, to states only slightly perturbed
away from equilibrium.

#key[Two things are missing from drift-diffusion @DD by construction, and no
adjustment of $mu_s$ or $D_s$ puts them in.]
There is no #term("tunneling"), so a barrier reflects every carrier whose energy
lies below it, however thin the barrier is.
And there is no #term("quantization"), so a quantum well carries a continuum of
states instead of a discrete set.
Quantum corrections exist and are widely used, but they reproduce the symptoms
of effects that the model does not contain.

=== Boltzmann transport equation

At the #term("semiclassical") level the unknown is richer.
It is the #term("distribution function") $f(avec(r), avec(k), t)$, the
occupation of a point of phase space.
It is dimensionless and takes values in $cc(0, 1)$, since it counts the fraction
of available states that are filled rather than a number of particles.
Its arguments are the position $avec(r)$, the wave vector $avec(k)$ and the time
$t$.
The wave vector carries the momentum $avec(p) = planck avec(k)$, and it is the
natural variable because a crystal quantizes momentum rather than velocity.
The distribution function obeys the #term("Boltzmann transport equation"),
$
  (partial / (partial t) + avec(v)(avec(k)) dot nabla_avec(r)
    + q_s / planck avec(cal(E))(t) dot nabla_avec(k)) f(avec(r), avec(k), t)
    = ((dif f) / (dif t))_"collision".
$ <BTE>
Here $planck = h slash 2 pi = #qty($1.055 dot 10^(-34)$, $J thin s$)$ is the
reduced Planck constant, which has the dimension of an action, energy times
time.

The left hand side is one derivative written out.
A carrier follows the #term("characteristic curve")
$gamma(t) = (avec(r)(t), avec(k)(t))$ in phase space.
It moves through real space at the #term("band velocity") $avec(v)(avec(k))$,
which is not an independent quantity but the group velocity of the band,
$avec(v) = planck^(-1) nabla_avec(k) E(avec(k))$.
It moves through momentum space under the field by Newton's law in the form
$planck dot(avec(k)) = q_s avec(cal(E))$.
Lift the curve to $t arrow.bar (t, gamma(t))$ and its tangent
$partial_t + dot(gamma)$ is a single direction in time and phase space together.
The three terms on the left are then the derivative of $f$ along that direction,
which is the direction the state actually moves in.
Along such a curve the partial differential equation becomes an ordinary one in
$t$ alone, $dif f slash dif t = (dif f slash dif t)_"collision"$.

The right hand side holds what following the trajectory cannot account for,
which is exactly what a collision does.
The notation there names a rate and not a derivative of anything.
Scattering moves a carrier from one $avec(k)$ to another at fixed position and
in no time at all, so it enters as the net change in occupation per second that
such jumps produce at $(avec(r), avec(k))$.
Quantum mechanics enters the Boltzmann equation @BTE in two places only, through
the band velocity and through the collision term.
Read as mathematics this is a kinetic equation on phase space, and we can
recover drift-diffusion @DD from it in the diffusive limit.
That is the precise sense in which drift-diffusion sits below the Boltzmann
equation instead of beside it.

What the extra variables buy us is the collision operator on the right.
#key[Drift-diffusion compresses all scattering into the single number $tau_s$,
while the Boltzmann equation @BTE keeps every mechanism explicitly.]
The mechanisms enter as a table of processes, selected according to their
probabilities as a carrier propagates.
So scattering is resolved event by event instead of on average, and the validity
condition relaxes from $L >> lambda_"mfp"$ to
$
  L approx lambda_"mfp",
$
which makes the semiclassical level the right one for devices too short to
average over but not yet short enough to be waves.
At the short end of that range a trajectory stops being followable at all.
A potential that varies sharply over 10 to 20 nm has to be met with waves,
whatever the mean free path is.
In practice we do not discretize the Boltzmann equation @BTE directly, since its
phase space is too large, and we solve it by Monte Carlo methods instead.
The Wigner transport equation is a variant of the same description.

The Boltzmann equation @BTE does not repair the more serious limitation.
#key[The semiclassical description still treats carriers as point particles that
follow trajectories.
So like drift-diffusion it contains neither tunneling nor quantization.]
Both models fail on exactly the same physics, and they fail by kind rather than
by resolution.

=== Quantum transport and de Broglie wavelength

At the quantum level the unknown is the wave function, and the equation we solve
is the stationary #term("Schrödinger equation")
$
  (- planck^2 / (2 m^*) lapl + V(avec(r))) psi(avec(r)) = E psi(avec(r)).
$ <SE>
The potential energy $V(avec(r))$, which we quote in #unit($"eV"$) throughout,
is what the device geometry and the applied voltages supply, and $E$ is the
energy eigenvalue.
The #term("wave function") $psi(avec(r))$ has the dimension
#unit($m^(-3 slash 2)$) in three dimensions.
That dimension is forced on us: $abs(psi)^2$ is a probability density per unit
volume, so it carries #unit($m^(-3)$), and $psi$ carries its square root.
A wave function has no meaning without the normalization that fixes this, and
every quantity we compute from it inherits the convention.

As written, this is an eigenvalue problem, a self-adjoint spectral problem for
the #term("Hamiltonian").
#key[An eigenvalue problem describes a closed system, so the Schrödinger
equation @SE is not yet a transport equation.]
A device is open.
It is joined to contacts through which carriers enter and leave, and we have to
modify the Schrödinger equation @SE before it can express that.
Doing so properly occupies the next several lectures, and it is where the two
formalisms of this course part company, the wave function one and the
non-equilibrium Green's function one.

#exam("L1.2")
The criterion for needing the Schrödinger equation @SE at all is again a length.
A carrier of momentum $p$ has the #term("de Broglie wavelength") $lambda$,
$
  lambda = h / p = h / sqrt(2 m^* E),
$ <dB>
where the second form reads the momentum off the energy through the
non-relativistic $E = p^2 slash 2 m^*$, and
$h = #qty($6.626 dot 10^(-34)$, $J thin s$)$ is Planck's constant, unreduced.
#key[Wave behavior matters once a dimension of the device becomes comparable to
$lambda$, and it is enough that this happens along one of the three
dimensions.]
Confinement in a single direction already quantizes the spectrum.

Take carriers #qty(0.1, $"eV"$) above the conduction band edge, where their
concentration is largest.
The de Broglie wavelength @dB then gives#note[
  Slide 35 rounds $lambda("Si")$ down to #qty(6.8, $"nm"$).
]
$
  lambda("Si") &= #qty(6.9, $"nm"$), quad m^* = 0.32 m_0, \
  lambda("GaAs") &= #qty(15.2, $"nm"$), quad m^* = 0.065 m_0.
$
Since $lambda prop 1 slash sqrt(m^*)$, the lighter carriers of GaAs are the more
demanding case, and a GaAs device is already quantum mechanical at dimensions
where a silicon one is still classical.
Compare these numbers with the structure on slide 35, a channel #qty(5, $"nm"$)
thick with a gate #qty(20, $"nm"$) long, and with the stated goal of the course,
gate lengths of #qty(5, $"nm"$) to #qty(20, $"nm"$).
A silicon channel of #qty(5, $"nm"$) lies below $lambda("Si")$ outright.
For such a device quantum transport is the only applicable description.

=== Choice of model

A device carries electrons and holes, while the de Broglie wavelength @dB
contains one effective mass.
Usually only one of the two species conducts, since an n-type transistor is
carried by electrons and a p-type one by holes.
#key[Where both species matter, as in a tunnel FET, the smaller effective mass
decides, because it gives the longer wavelength.
We then treat the whole device at the level that mass demands.]
Mixing models, quantum transport for electrons and drift-diffusion for holes, is
not advisable.
The one defensible exception is a device such as a bipolar transistor, in which
one carrier is demonstrably classical and the other is not.
There the two descriptions may be coupled through the electrostatics, which
means through Poisson's equation.

#table(
  columns: 5,
  align: (left, left, left, left, left),
  table.header([*model*], [*unknown*], [*applies when*], [*resolves*], [*cost*]),
  [drift-diffusion],
  [$n$, $p$],
  [$L >> lambda_"mfp"$],
  [scattering on average],
  [low],

  [Boltzmann],
  [$f(avec(r), avec(k), t)$],
  [$L approx lambda_"mfp"$],
  [each scattering event],
  [high],

  [quantum transport],
  [$psi(avec(r))$],
  [$L approx lambda$],
  [quantization, tunneling],
  [highest],
)

== Quantum effects in scaled devices

Three effects appear once a device reaches these dimensions, and neither
classical model contains any of them.

=== Band structure quantization

Bulk silicon has the band structure on the left of slide 37, with an
#term("indirect gap").
That means the conduction band minimum and the valence band maximum lie at
different points of the Brillouin zone, which is why silicon does not emit
light.
Now confine that same silicon to a #qty(5, $"nm"$) layer between two oxide
barriers, as in a double-gate transistor.
The right of slide 37 shows the result.
The single conduction band is replaced by a family of discrete
#term("subbands"), each with its own dispersion, and the same happens to the
valence band.
#key[The material has not changed.
Confinement alone has quantized the spectrum.]
This is exactly the familiar square-well picture of discrete levels, computed
with a full band model instead of a single parabola.

=== Interface confinement and density of states

Slide 38 makes the same point in the geometry of a real MOSFET, cutting
vertically through the channel beneath the gate.
The gate voltage bends the bands and forms a well against the oxide.
The well is triangular rather than square, and it holds a discrete set of bound
states $E_1, E_2, E_3$.
Their wave functions penetrate into the oxide barrier instead of vanishing at
it, which is a purely quantum feature.

The right of the same slide carries the consequence.
#key[Classically the #term("density of states") grows as $sqrt(E)$, smoothly
from the band edge.
In the confined channel it is a staircase instead, flat until $E_1$ and stepping
up at each subband edge.]
The carrier density is an integral of the density of states against the
occupation, so this difference is not cosmetic.
We take up the comparison between the two curves in the next lecture.

=== Intra-band tunneling

The effect that limits scaling most directly is developed on slides 39 to 41.
The geometry is a #term("double-gate FET") cut along the direction of current
flow, so the horizontal axis runs from source to drain, and the gate raises a
potential barrier between them.
In the off state that barrier is what suppresses the current.

Read the four panels of slide 40 from the bottom right, in order of decreasing
gate length.
At $L_g = #qty(13, $"nm"$)$ the barrier does its job.
Carriers with an energy below its peak are reflected, and the only current comes
from the thermal tail of the distribution passing over the top.
That is #term("thermionic emission"), it is classical, and we cannot eliminate
it.
At #qty(10, $"nm"$) a second contribution appears, with carriers crossing
through the upper part of the barrier instead of over it.
At #qty(7, $"nm"$) it is stronger.
At #qty(4, $"nm"$) the barrier is effectively transparent, and carriers cross it
whatever their energy is.

Slide 41 shows what this costs in the quantity that matters.
On a logarithmic plot of $I_d$ against $V_(g s)$ the off-current rises only
slightly from #qty(13, $"nm"$) to #qty(10, $"nm"$), and then by orders of
magnitude at #qty(4, $"nm"$).
A transistor that is nominally switched off then conducts substantially.
This is #term("source-to-drain tunneling"), also called
#term("intra-band tunneling"), since the carrier stays within the conduction
band the whole time.
The #term("band-to-band tunneling") of a tunnel FET is the opposite case.
#key[No drift-diffusion model and no Boltzmann solver can produce this effect,
since neither of them contains tunneling at all.
It is a leading reason why the gate length of a production device has stopped
following the node label downward.]

== Outlook

The device we simulate over the semester is the double-gate FET of slides 39 to
41, and the target is to reproduce curves like the one on slide 41 from first
principles.
Two further structures recur.
The #term("tunnel FET") is built to exploit band-to-band tunneling rather than
to suffer from it.
The #term("resonant tunneling diode") rests on a single resonant state, which
makes it a clean test of any simulator.

The route there starts one level below transport.
The Schrödinger equation @SE presumes an effective mass and a band structure,
and the next lecture computes both, for bulk material and for a quantum well.
That calculation is the one whose output is the two panels of slide 37.
