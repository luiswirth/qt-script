#import "setup.typ": *
#show: chapter.with("Bandstructure and the effective mass approximation")

The previous chapter left the Schrödinger equation @SE standing with two symbols
in it that we have not explained, an effective mass and a potential.
This chapter produces both.

The route starts from an equation that is exactly right and cannot be solved,
and ends at one that is approximate and tridiagonal.
We first reduce the many-body problem to a single electron in an effective
potential.
We then use the periodicity of that potential to label the states by a wave
vector.
Near a band extremum we replace the resulting dispersion by a parabola, whose
curvature is the effective mass.
The equation that survives all of this we solve in closed form for two
geometries, and on a grid for everything else.

A second thread runs alongside.
The wave function itself is not observable, and the quantities a device
simulation reports are the carrier density and the density of states.
Both are built from the same two ingredients, the probability density of a state
and the probability that the state is occupied.
We compute both for each geometry as it comes up.

== Single-electron reduction

=== Many-body Schrödinger equation

#exam("L2.2")
Everything about the electronic structure of a solid sits in the stationary
Schrödinger equation for all of its particles at once,
$
  hat(H) Psi = E Psi,
$
where $Psi = Psi(avec(r)_1, avec(r)_2, ..., avec(r)_N)$ is a single function of
the coordinates of all $N$ electrons simultaneously, and $E$ is the total energy
of the system.
Take a crystal of $N$ electrons and $M$ ions, where ion $j$ carries the charge
$Z_j q$ and sits at the fixed position $avec(R)_j$.
Its Hamiltonian is
$
  hat(H) = sum_(i=1)^N (
    - planck^2 / (2 m_0) lapl_i
    - sum_(j=1)^M (Z_j q^2) / (4 pi epsilon_0 abs(avec(r)_i - avec(R)_j))
    + sum_(j > i) q^2 / (4 pi epsilon_0 abs(avec(r)_i - avec(r)_j))
  ).
$ <MBSE>
The first term is the kinetic energy of the electrons.
Each electron is differentiated with respect to its own coordinate through
$lapl_i$, and it carries the free electron mass $m_0$ rather than any effective
one.
The second term is the attraction between electrons and ions.
It is negative, and it is what binds the electrons to the crystal at all.
The third term is the repulsion between electrons.
It is positive, and the restriction $j > i$ counts each pair once.
Here $epsilon_0 = #qty($8.854 dot 10^(-12)$, $F slash m$)$ is the vacuum
permittivity.#note[
  The slides write the Coulomb terms in Gaussian units, as $Z_j q^2 slash
  abs(avec(r)_i - avec(R)_j)$ without the $4 pi epsilon_0$.
]
We take the ions to sit at fixed positions, which discards their kinetic energy.
That is the #term("Born-Oppenheimer approximation").
The lattice vibrations we drop here come back in a later chapter as phonons.

#key[We cannot solve the many-body Schrödinger equation @MBSE exactly, except in
a few special cases, and the term that blocks us is the electron-electron
repulsion.]
Without that term the Hamiltonian would be a sum of identical one-electron
operators, and $Psi$ would factorize into a product of one-electron functions.
With it every coordinate is coupled to every other one, and the dimension of the
domain grows as $3 N$.

=== Effective potential

#exam("L2.3")
To make the problem tractable we replace the $N$-electron function by a
one-electron function,
$
  hat(H) psi(avec(r)) = E psi(avec(r)),
  quad
  hat(H) = - planck^2 / (2 m_0) lapl + V_"eff" (avec(r)),
$ <SPSE>
where $psi(avec(r))$ depends on one position only.
#key[Everything the other electrons do to the one we are looking at is packed
into a single #term("effective potential") $V_"eff" (avec(r))$.]
The pair interaction was a function of $6$ coordinates, and it has become a
field on $3$ coordinates.
The many-body problem has become a one-body problem in a medium.

Density functional theory is what tells us that this is possible at all.
#key[Kohn and Sham proved in 1965 that an effective potential exists for which
the carrier density computed from the single-electron wave functions equals the
true many-body density exactly.]
The theorem says that the potential exists, but it does not tell us what it is.
Every practical scheme is an approximation to it.

=== Calculation methods

Three families of method are in use, and they differ in what they take as input.
#key[Density functional theory computes $V_"eff"$ from the positions of the
atoms alone, and it pays for that with an underestimated gap and a large cost.
The empirical methods get the correct gap and the correct masses cheaply, but
they need a bandstructure to fit against before they can compute anything.]

#term("Density functional theory") approximates $V_"eff"$ from the density
itself, through a chain of successively better functionals that begins with the
local density approximation.
It takes no input beyond the positions of the atoms, which is what _ab initio_
means, and it reproduces effective masses to within roughly ten percent.
Its known failure is the band gap, which it systematically underestimates.
Silicon comes out near #qty(0.6, $"eV"$) against a measured #qty(1.12, $"eV"$),
and indium arsenide, whose true gap is #qty(0.37, $"eV"$), comes out as a metal
with no gap at all.
It is also expensive, taking of the order of an hour for a bandstructure that
tight binding produces in a second.

The #term("empirical pseudopotential method") and the
#term("empirical tight-binding method") both write down a model of the coupling
between atoms, in which the coupling strengths are fitting parameters.
We adjust those parameters until the model reproduces a known bandstructure.
The reference is a density functional calculation for the dispersion together
with the experimental value for the gap, so the fitted model carries both.
This gives us the correct gap and the correct effective masses at a
computational cost that is smaller by orders of magnitude.
The price is that we need a reference to fit against before we can compute
anything at all.
Slide 9 shows the result for silicon and indium arsenide, with the indirect gap
of the one and the direct gap of the other, both correct, and with the $L$ and
$X$ valleys in their measured positions.

== Bloch's theorem

=== Crystal lattice

A crystal is built by translating a primitive unit cell along its lattice
vectors $avec(a)_1, avec(a)_2, avec(a)_3$.
A translation of the #term("Bravais lattice") is a whole number of steps along
each of them,
$
  avec(R) = n_1 avec(a)_1 + n_2 avec(a)_2 + n_3 avec(a)_3,
  quad n_1, n_2, n_3 in ZZ.
$
All cells are identical, so the effective potential has the same periodicity,
$
  V_"eff" (avec(r) + avec(R)) = V_"eff" (avec(r)).
$

A plane wave $e^(i avec(k) dot avec(r))$ has that same periodicity for some wave
vectors and not for others.
It has it when $e^(i avec(k) dot avec(R)) = 1$ for every translation $avec(R)$,
which asks $avec(k) dot avec(R)$ to be a multiple of $2 pi$.
#key[The wave vectors that do this are themselves a lattice, the
#term("reciprocal lattice"),]
$
  avec(G) = m_1 avec(b)_1 + m_2 avec(b)_2 + m_3 avec(b)_3,
  quad m_1, m_2, m_3 in ZZ,
$
whose vectors $avec(b)_j$ are fixed by
$
  avec(a)_i dot avec(b)_j = 2 pi delta_(i j).
$
That condition is what makes $avec(G) dot avec(R)$ a multiple of $2 pi$ for
every pair of them.

=== Bloch's theorem

#exam("L2.4")
Now we ask what the periodicity means for the wave function.
The answer is not that $psi$ repeats from cell to cell.
What repeats is what we can observe of it.
An electron is no more likely to be found in one cell than in another, so the
probability density repeats,
$
  abs(psi(avec(r) + avec(R)))^2 = abs(psi(avec(r)))^2 .
$
A modulus fixes a function only up to a phase, so this says
$
  psi(avec(r) + avec(R)) = e^(i theta) psi(avec(r)).
$
The phase $theta$ may depend on the translation.
Translations compose, and shifting by $avec(R)$ and then by $avec(R)'$ has to
give the same phase as shifting by $avec(R) + avec(R)'$.
So $theta$ is additive in the translation, and therefore linear in it.
A linear function of $avec(R)$ is a scalar product with some vector.
We call that vector $avec(k)$, the #term("wave vector"),
$
  psi_avec(k) (avec(r) + avec(R)) = e^(i avec(k) dot avec(R)) psi_avec(k) (avec(r)).
$ <phase>
#key[#term("Bloch's theorem") says that a function with this property is a plane
wave times something that has the periodicity of the lattice,]
$
  psi_avec(k) (avec(r)) = u_avec(k) (avec(r)) e^(i avec(k) dot avec(r)),
  quad
  u_avec(k) (avec(r) + avec(R)) = u_avec(k) (avec(r)).
$ <Bloch>
The two forms say the same thing.
Substitute the Bloch form @Bloch into the left side of the phase relation
@phase, use the periodicity of $u_avec(k)$, and the right side comes back.
The plane wave carries the phase from cell to cell, and $u_avec(k)$ carries the
structure inside one cell.

We have gained a label.
The wave function and its eigenvalue now depend on $avec(k)$ too,
$
  hat(H) psi_avec(k) (avec(r)) = E(avec(k)) psi_avec(k) (avec(r)).
$ <schroedinger-k>
#key[What was one eigenvalue problem is now a family of them, one for each
$avec(k)$.]
The resulting $E(avec(k))$ is the #term("dispersion") of one band, and all bands
together are the #term("bandstructure").
A stationary state carries the time dependence $e^(-i E t \/ planck)$, so
$E = planck omega$, and this is the relation $omega(avec(k))$ of wave theory
written in energy units.

Two objects are now in play, and they are easy to confuse.
The bandstructure is energy against wave vector, and it belongs to a material.
The #term("band diagram"), which appears below, is energy against position, and
it belongs to a structure assembled from several materials.

=== Brillouin zone

Only the phase $avec(k) dot avec(R)$ has any meaning, and a phase is defined
modulo $2 pi$.
So $avec(k)$ and $avec(k) + avec(G)$ label the same state, for every reciprocal
lattice vector $avec(G)$.
#key[One region of $avec(k)$-space is therefore enough, provided it holds every
state once.
Every wave vector outside it is a copy of one inside.]
The #term("Brillouin zone") is the region we take, and it consists of the points
that are closer to the origin than to any other reciprocal lattice point.
Its faces are the perpendicular bisectors of the $avec(G)$, which is the Bragg
condition.
Among all regions that would do, this is the one that carries the symmetry of
the crystal, and that is what makes the high-symmetry labels $Gamma$, $X$, $L$
mean anything.
Solving the crystal means solving the eigenvalue problem @schroedinger-k for
every $avec(k)$ in the zone.
We then report the dispersion along a path joining those high-symmetry points,
which is what the horizontal axis of slide 9 is.

== Probability and occupation

=== Probability density

#exam("L2.5")
An electron occupying the state $psi_avec(k)$ has the
#term("probability density")
$
  P_avec(k) (avec(r)) = abs(psi_avec(k) (avec(r)))^2
$ <prob-density>
of being found at $avec(r)$, and it carries #unit($m^(-3)$).
It is a density, not a probability.
The probability of finding the electron in a region is the integral of the
probability density @prob-density over that region, and the probability of
finding it at one single point is zero.
The condition that goes with it says that the electron is somewhere,
$
  integral_V dif^3 avec(r) thin P_avec(k) (avec(r)) = 1,
$ <norm>
where the integral runs over the volume the electron is confined to, which for a
device is the device.
#key[The normalization condition @norm fixes the prefactor of every wave
function below.
It is also why $psi$ carries #unit($m^(-3 slash 2)$) instead of being
dimensionless.]

Knowing $P_avec(k)$ tells us how an electron in the state $avec(k)$ is spread
out in space.
It tells us nothing about whether that state holds an electron at all.

=== Fermi distribution

#exam("L2.6")
The probability that the state $psi_avec(k)$, of energy $E(avec(k))$, is
occupied is the #term("Fermi distribution")
$
  f(E) = 1 / (1 + exp((E - E_F) slash (k_B T))),
$ <FD>
which is dimensionless and takes values in $cc(0, 1)$.
Here $k_B = #qty($1.381 dot 10^(-23)$, $J slash K$)$ is the Boltzmann constant,
$T$ is the temperature, and $E_F$ is the #term("Fermi level"), the energy at
which the occupation is exactly one half.
The combination $k_B T$ is an energy, #qty(25.9, $"meV"$) at #qty(300, $K$).
It is the only scale in the Fermi distribution @FD, since the distribution
depends on $E$ and $E_F$ only through $(E - E_F) slash k_B T$.
So $k_B T$ measures the width of the region over which $f$ falls from one to
zero.

#key[At $T = 0$ the Fermi distribution @FD is a step, with every state below the
Fermi level filled and every state above it empty.
Raising the temperature rounds that step off symmetrically about $E_F$, over a
range of a few $k_B T$ to either side.]
The step is what the exponent leaves behind, since it is $minus infinity$ below
$E_F$ and $plus infinity$ above it.
The rounding empties states just below the Fermi level and fills states just
above it.
Slide 13 has the curves for #qty(0, $K$), #qty(100, $K$), #qty(300, $K$) and
#qty(500, $K$).
They all cross at $f = 1 slash 2$, which they have to, since $E = E_F$ makes the
exponent vanish at any temperature.
Far above the Fermi level the exponential dominates the denominator and
$f approx exp(-(E - E_F) slash k_B T)$.
That is the #term("Boltzmann tail"), and it is the thermionic population that
carried the leakage current of the previous chapter.

=== Metals, semiconductors and insulators

#exam("L2.7")
#key[Where the Fermi level sits relative to the bands is what classifies the
material.]
Slide 14 shows the three cases side by side.

In a #term("metal") the Fermi level lies inside a band.
States immediately above the occupied ones are available at no energy cost, so
an arbitrarily small field redistributes the electrons, and the material
conducts well.

In a #term("semiconductor") the Fermi level lies in a gap $E_g$ between a filled
valence band and an empty conduction band.
The gap is small enough that a few $k_B T$ of thermal energy promote a usable
population across it.
A filled band carries no current, because every state a field would move an
electron into is already occupied.
So conduction is carried entirely by the few electrons that are thermally
excited into the conduction band, and by the holes they leave behind.

In an #term("insulator") the Fermi level again lies in the gap, but the gap is
so wide that thermal activation across it is negligible at any temperature the
material survives.

The distinction between the last two is quantitative and has no sharp boundary.
A more useful criterion than the size of the gap is whether doping works.
A semiconductor accepts foreign atoms that shift $E_F$ toward one band or the
other and make it $n$-type or $p$-type, and an oxide generally does not.
Even this fails at the margin, since gallium nitride has a gap near
#qty(3, $"eV"$) and can be doped, while oxides of the same gap cannot.

== Carrier density and density of states

=== Carrier density

#exam("L2.8")
Now we combine the two ingredients.
#key[The #term("carrier density") $n(avec(r))$ #unit($m^(-3)$) counts electrons
per unit volume at $avec(r)$.
Each state contributes the probability density of finding its electron there,
weighted by the probability that the state is occupied.]
Summing over the states,
$
  n(avec(r)) = sum_(avec(k) in "BZ") P_avec(k) (avec(r)) thin f(E(avec(k))).
$ <carrier-density>
This counts carriers, and the charge density proper is $-q n$
#unit($C slash m^3$).
Neither factor alone would do the job.
Dropping $f$ would count every state as full, and dropping $P_avec(k)$ would
give a number of electrons instead of a density.
Slide 15 shows the carrier density @carrier-density evaluated for a resonant
tunneling diode and for a double-gate transistor, which are the internal
quantities of the previous chapter that no measurement reaches.

=== Density of states

#exam("L2.9")
The carrier density @carrier-density is a sum over the Brillouin zone, and
$avec(k)$ is an inconvenient variable to work in.
We can trade it for energy at no cost.
Insert a delta function together with an integral that undoes it,
$
  n(avec(r))
    &= integral dif E sum_avec(k) P_avec(k) (avec(r)) thin
       delta(E - E(avec(k))) thin f(E(avec(k))) \
    &= integral dif E underbrace(
         sum_avec(k) P_avec(k) (avec(r)) delta(E - E(avec(k))),
         g(E, avec(r))
       ) thin f(E),
$
where $f(E(avec(k)))$ became $f(E)$ because the delta function enforces
$E = E(avec(k))$ wherever the integrand is nonzero.
The bracketed quantity is the #term("density of states")
$
  g(E, avec(r)) = sum_avec(k) P_avec(k) (avec(r)) thin delta(E - E(avec(k))),
$ <DOS>
which carries #unit($J^(-1) m^(-3)$), so states per unit energy per unit volume.
The delta function selects, out of all of $avec(k)$-space, the states whose
energy is $E$, and $P_avec(k)$ distributes each of them over position.
#key[The sum over $avec(k)$ has not disappeared, it has moved.
We now perform it once, in the definition of $g$, instead of every time we want
a carrier density.]
The carrier density is then
$
  n(avec(r)) = integral dif E thin g(E, avec(r)) f(E).
$ <n-from-g>

#exam("L2.10")
#key[The two factors of the energy integral @n-from-g separate cleanly.
The density of states is a property of the structure alone, and the distribution
is a property of the reservoir the structure is in equilibrium with.]
The density of states belongs to the geometry and the materials, and it is fixed
once the structure is.
It says how many states exist at energy $E$ and position $avec(r)$, and it would
say the same at any temperature and any bias.
The distribution enters through $E_F$ and $T$ alone and knows nothing about the
structure.
Their product $g(E, avec(r)) f(E)$ is the
#term("density of occupied states"), electrons per unit energy per unit
volume,#note[
  Slide 17 pictures the crystal as a hotel, $g$ counting the rooms on floor $E$
  and $f$ saying whether they are taken.
]
and that is what the energy integral @n-from-g accumulates into a carrier
density.
A transport calculation needs the same product resolved in energy rather than
integrated, since current is carried by electrons in a particular range of
energies and not by the total.

== Effective mass approximation

#exam("L2.11")
Computing $E(avec(k))$ from tight binding or from density functional theory
gives us the full bandstructure, all bands across the whole Brillouin zone.
Almost none of it matters for transport.
The electrons available for transport sit within a few $k_B T$ of the conduction
band minimum, and the holes within a few $k_B T$ of the valence band maximum.
So we only ever sample the immediate neighborhood of an extremum.

Near an extremum a smooth function equals its own quadratic Taylor expansion.
The linear term vanishes there, so in one dimension
$
  E(k) = E_"CB" + 1/2 (dif^2 E) / (dif k^2) k^2 + ...,
$
which is a parabola in $k$.
A free particle already has a parabola.
A free particle of mass $m$ obeys $E = planck^2 k^2 slash 2 m$, whose second
derivative is $planck^2 slash m$, so its mass is its curvature inverted.
The curvature is the only place where $m$ enters that dispersion, and it enters
through a denominator, which is why a curve gives us $1 slash m$ rather than
$m$.
Reading a mass off a band is the same measurement, performed on a different
curve.
This defines the #term("effective mass"),
$
  1 / m^* = 1 / planck^2 (dif^2 E(k)) / (dif k^2),
$ <effective-mass>
evaluated at the extremum, so that
$
  E(avec(k)) = E_"CB" + (planck^2 abs(avec(k))^2) / (2 m^*).
$ <parabola>
#key[The effective mass is a curvature and nothing else.
A flat band means a heavy electron and a sharply curved band means a light one.
The sign of the curvature is what distinguishes the electron-like minimum of the
conduction band from the hole-like maximum of the valence band.]

Slide 18 puts the parabolic dispersion @parabola against the computed bands of
silicon and indium arsenide.
The fit is good over a wider range for silicon, whose $m^* = 0.91$ at the $X$
valley is heavy, than for indium arsenide, whose $m^* = 0.023$ at $Gamma$ is
light and whose band leaves the parabola within a few tenths of an electronvolt.
The reason is geometric and not material.
A light mass is a sharply curved band, a sharply curved band has large higher
derivatives, and those higher derivatives are exactly what the quadratic
truncation throws away.

The effective mass @effective-mass is valuable because it removes $V_"eff"$ from
the problem.
#key[The periodic potential of the crystal is what made the one-electron problem
@SPSE hard.
Its entire effect on a carrier near a band edge is to change the coefficient of
$k^2$ in the dispersion.]
So if we replace $m_0$ by $m^*$ we reproduce that dispersion with no potential
at all,
$
  (- planck^2 / (2 m^*) lapl + V_"ext" (avec(r))) psi_avec(k) (avec(r))
    = E(avec(k)) psi_avec(k) (avec(r)),
$ <EMA>
which is the #term("effective mass approximation") and the form we use for the
rest of the course.
We treat an electron in a crystal as a free electron that carries a mass the
crystal has given it.

The potential that reappears in the effective mass approximation @EMA is not the
one we removed.
$V_"eff"$ was the periodic potential of the lattice, and it is gone, absorbed
into $m^*$.
$V_"ext" (avec(r))$ is everything the lattice does not supply: the electrostatic
potential generated by the charges in the device, which we get from Poisson's
equation, and the #term("band offsets") where materials of different gap meet.
The effective mass may itself depend on position, since it is a property of the
local material, and in a heterostructure it does.

Two limitations come with the effective mass approximation @EMA.
It holds near a band extremum and nowhere else, so a process that reaches far
into a band is outside it.
And $m^*$ need not be isotropic.

=== Anisotropy and valley degeneracy

The effective mass @effective-mass is a second derivative along one direction.
A band that is curved differently along different directions therefore gives a
different mass for each of them.
Take the axes along which the curvature is extremal, where the mixed derivatives
vanish.
The dispersion is then
$
  E(avec(k)) = planck^2 / 2 (
    k_x^2 / m_x^* + k_y^2 / m_y^* + k_z^2 / m_z^*
  ),
$ <aniso>
whose surfaces of constant energy are ellipsoids instead of spheres, and slide
24 shows both.

Silicon is the case that matters here.
#key[Its conduction band minimum does not sit at $Gamma$, but on the six
equivalent $Delta$ directions, which gives six #term("valleys").
Each valley is an ellipsoid elongated along its own axis, with a
#term("longitudinal mass") $m_L = 0.91 m_0$ along that axis and a
#term("transverse mass") $m_T = 0.19 m_0$ along the two perpendicular to it.]
The crystal as a whole is cubic and therefore isotropic.
The anisotropy belongs to the individual valley.

#key[Where we want a single mass, as in a density of states, we replace the
ellipsoid by the sphere of equal volume, whose radius is the geometric mean of
the three semi-axes.]
This defines the #term("density of states effective mass")
$
  m_"DOS" = (m_L m_T^2)^(1 slash 3),
$ <m-dos>
which for silicon is $(0.91 dot 0.19^2)^(1 slash 3) m_0 = 0.32 m_0$, the value
the previous chapter used for the de Broglie wavelength.#note[
  This is the shape of one valley, and silicon has six.
  Its total bulk density of states therefore carries a further factor $6$,
  equivalently $6^(2 slash 3)$ in the mass, which the lectures leave out.
]

== Bulk

#exam("L2.12")
We solve the effective mass approximation @EMA first in a #term("bulk") crystal,
which is a chunk of one material of volume $V = L_x L_y L_z$ with nothing done
to it.
The whole assumption is homogeneity.
No material changes and no electrostatics, so
$
  V_"ext" (avec(r)) = 0,
$
and we take the wave function periodic across the chunk,
$psi_avec(k)(avec(r) + {L_x, L_y, L_z}) = psi_avec(k)(avec(r))$.
This #term("periodic boundary condition") is a device for counting states in a
finite volume and not a physical statement.
Nothing below depends on it once $V$ has cancelled.

What is left of the effective mass approximation @EMA is the free-particle
equation
$
  - planck^2 / (2 m^*) lapl psi_avec(k) (avec(r))
    = E(avec(k)) psi_avec(k) (avec(r)),
$
which plane waves solve.
Normalize over $V$ with the normalization condition @norm.
The modulus of a plane wave is one, so the integrand is constant, and
$
  psi_avec(k) (avec(r)) = 1 / sqrt(V) e^(i avec(k) dot avec(r)),
  quad
  E(avec(k)) = (planck^2 abs(avec(k))^2) / (2 m^*),
$ <bulk-solution>
with the anisotropic dispersion @aniso in place of the energy when the mass is
anisotropic.
#key[The dispersion that comes out is the parabola the effective mass
approximation @EMA was built to reproduce.
That is the consistency check on the whole construction, since the equation
whose solution defines the effective mass returns the band it was fitted to.]

#key[The periodic boundary condition quantizes $avec(k)$ on a grid of spacing
$2 pi slash L_j$.
Each allowed wave vector then occupies a volume $8 pi^3 slash V$ of
$avec(k)$-space, which lets us turn a sum over states into an integral.]
Requiring $e^(i avec(k) dot {L_x, L_y, L_z}) = 1$ forces each component to
satisfy $k_j L_j in 2 pi ZZ$, so
$
  k_j = n_j (2 pi) / L_j,
  quad n_j in ZZ.
$
The conversion is
$
  sum_avec(k) arrow.r V / (8 pi^3) integral dif^3 avec(k),
$ <sum-to-integral>
exactly as a Riemann sum becomes an integral when the spacing goes to zero, and
here the spacing is small because $L_j$ is macroscopic.

=== Bulk carrier density

#exam("L2.13")
The probability density of the bulk plane wave @bulk-solution is
$
  P_avec(k) (avec(r)) = abs(psi_avec(k) (avec(r)))^2 = 1 / V,
$
which does not depend on position, so the carrier density @carrier-density
collapses to
$
  n_"bulk" = 1 / V sum_avec(k) f(E(avec(k))).
$
The position dependence is gone.
#key[This had to happen.
We assumed the structure was homogeneous, so a carrier density that varied with
position would have contradicted the assumption we computed it under.]

=== Bulk density of states

#exam("L2.13")
The same substitution in the density of states @DOS gives
$
  g_"bulk" (E) = 1 / V sum_avec(k) delta(E - E(avec(k))),
$
and we convert the sum into an integral by @sum-to-integral, with a factor $2$
for the two spin orientations that each $avec(k)$ accommodates,
$
  g_"bulk" (E) = 2 / (8 pi^3) integral dif^3 avec(k) thin delta(E - E(avec(k))).
$
The dispersion is isotropic, so the integrand depends on $avec(k)$ only through
$abs(avec(k))$.
The angular integration then contributes the area $4 pi abs(avec(k))^2$ of a
sphere,
$
  g_"bulk" (E) = 2 / (8 pi^3) integral_0^infinity dif abs(avec(k)) thin
    4 pi abs(avec(k))^2 delta(E - E(avec(k))).
$
Change the variable from $abs(avec(k))$ to
$E' = planck^2 abs(avec(k))^2 slash 2 m^*$, so that
$abs(avec(k))^2 dif abs(avec(k)) = 1/2 (2 m^* slash planck^2)^(3 slash 2)
sqrt(E') dif E'$.
What is left is an integral that the delta function performs,
$
  g_"bulk" (E) = (8 pi sqrt(2 m^(*3))) / h^3 sqrt(E).
$ <g-bulk>
Here we measure the energy from the band edge, and $g_"bulk"$ vanishes below it,
since there are no states in the gap.

#key[Two features of the bulk density of states @g-bulk carry the physics.
It grows as $sqrt(E)$ from the band edge, and it grows as $m^(*3 slash 2)$ with
the mass.
The prefactor carries no physics.]#note[
  Luisier said in the lecture that he likes to ask for the $sqrt(E)$ behavior
  and for two curves of different effective mass to be drawn and identified,
  and that he does not expect the $m^(*3 slash 2)$ prefactor to be recalled.
]
The growth in energy starts smoothly from zero at the band edge, because the
number of states inside a sphere of radius $abs(avec(k))$ grows as
$abs(avec(k))^3$ while $E$ grows as $abs(avec(k))^2$.
The growth in mass means that a heavy band carries more states at a given energy
than a light one.
A heavy mass is a flat band, a flat band reaches a given energy only at large
$abs(avec(k))$, and a large $abs(avec(k))$ encloses many states.
Slide 27 plots the bulk density of states @g-bulk for the three masses
$0.023 m_0$, $0.065 m_0$ and $0.32 m_0$, of indium arsenide, gallium arsenide
and silicon, and the ordering of the three curves is the ordering of the masses.
For silicon the mass to use is $m_"DOS"$ of @m-dos.

The bulk density of states @g-bulk is exact only for a parabolic band.
Against a real bandstructure the sum over $avec(k)$ has no closed form, and we
evaluate it numerically, with the delta function broadened into a Gaussian or a
Lorentzian.

== Quantum well

A #term("quantum well") is the first structure that is not bulk.
It is a thin layer of one material between two thick layers of another with a
wider gap, and the case we treat here is gallium arsenide between aluminium
gallium arsenide.
#key[The periodicity is broken along the growth direction $x$ and kept along
$avec(r)_t = {y, z}$, over which the structure has area $A = L_y L_z$.]
Everything below follows from that one asymmetry.

=== Band diagram

The potential $V_"QW" (x)$ that enters the effective mass approximation @EMA
comes from the bands of the two materials.
Slide 30 superimposes the bandstructures of gallium arsenide and
$"Al"_(0.3)"Ga"_(0.7)"As"$ near $Gamma$.
The conduction band minimum of the alloy lies above that of gallium arsenide by
$Delta E_"CB"$, and its valence band maximum lies below by $Delta E_"VB"$.
So the wider gap of the barrier material is split between the two band edges.

#key[We construct the #term("band diagram") by walking along $x$ and recording,
at each position, the band edge of whichever material is there.]
We take the conduction band, since we only treat electrons, and we put its zero
in the well,
$
  V_"QW" (x) = cases(
    0 &quad "in the well",
    Delta E_"CB" &quad "in the barriers"
  ),
$ <v-qw>
which is the square well on the right of slide 30.
This is energy against position, so it is a band diagram.
The panel we constructed it from is energy against wave vector, so it is a
bandstructure.

=== Schrödinger equation in a quantum well

#exam("L2.14")
With the well potential @v-qw the effective mass approximation @EMA reads
$
  (- planck^2 / (2 m^*) lapl + V_"QW" (x)) psi_(avec(k)_t) (avec(r))
    = E(avec(k)_t) psi_(avec(k)_t) (avec(r)).
$ <qw-schroedinger>
#key[The potential depends on $x$ alone.
So the transverse directions are still those of a homogeneous crystal and carry
plane waves, while $x$ carries an unknown factor.]
The ansatz is
$
  psi_(avec(k)_t) (x, avec(r)_t)
    = 1 / sqrt(A) e^(i avec(k)_t dot avec(r)_t) phi(x),
  quad
  integral dif x thin abs(phi(x))^2 = 1,
$ <qw-ansatz>
where $avec(k)_t = {k_y, k_z}$ has lost the component $k_x$, since there is no
periodicity along $x$ for a wave vector to label.
The normalization splits between the two factors, with $1 slash sqrt(A)$
handling the transverse plane wave and the condition on $phi$ handling $x$, so
that the product satisfies the normalization condition @norm.
This makes $phi$ carry #unit($m^(-1 slash 2)$).

Substitute the ansatz @qw-ansatz into the well equation @qw-schroedinger.
The transverse Laplacian acts on the plane wave and returns
$-abs(avec(k)_t)^2$, while the $x$ derivative acts on $phi$ alone.
Divide out the common transverse factor and we are left with
$
  (- planck^2 / (2 m^*) (dif^2) / (dif x^2) + V_"QW" (x)) phi(x)
    = (E(avec(k)_t) - (planck^2 abs(avec(k)_t)^2) / (2 m^*)) phi(x).
$ <qw-1d>
The left side does not contain $avec(k)_t$, so the right side cannot either, and
the bracket is a constant of the transverse motion.
Call it $E_n$, the eigenvalues of the one-dimensional problem.
The dispersion of the well is then
$
  E_n (avec(k)_t) = E_n + (planck^2 abs(avec(k)_t)^2) / (2 m^*).
$
#key[Each $E_n$ is the bottom of a parabolic #term("subband") in the transverse
plane, which is free motion along $y$ and $z$ built on a confined state along
$x$.]#note[
  The slides write the eigenvalue of the one-dimensional problem @qw-1d as
  $cal(E)$ and reserve $E$ for the total.
  Since $cal(E)$ is already the electric field here,
  and since $E_n$ is exactly $E_n (avec(k)_t)$ at $avec(k)_t = 0$, the script writes $E_n$
  throughout, as slide 38 does.
]
We have reduced a three-dimensional problem to a one-dimensional eigenvalue
problem plus a formula.

=== Infinite barriers

#exam("L2.15", "L2.16")
The one-dimensional problem @qw-1d has no closed-form solution for the square
well @v-qw.
It does have one in the limit $Delta E_"CB" arrow.r infinity$.
That limit is worth solving, because it shows the quantization with nothing else
in the way.

Outside a barrier of infinite height the wave function vanishes identically.
The reason is worth stating, because the finite case turns on it.
Below a barrier the solution is not oscillatory but exponentially decaying,
$phi prop e^(-kappa x)$, with the #term("decay constant")
$
  kappa = sqrt(2 m^* (V_"QW" - E)) slash planck,
$ <kappa>
and $kappa arrow.r infinity$ as the barrier height does.
Continuity of $phi$ then imposes, on a well of width $L_"QW"$ occupying
$0 < x < L_"QW"$,
$
  - planck^2 / (2 m^*) (dif^2 phi) / (dif x^2) = E phi,
  quad phi(0) = phi(L_"QW") = 0,
$ <infinite-well>
where the potential is zero throughout the region in which we solve the
equation.

The general solution of the infinite well @infinite-well is
$phi(x) = a cos(k_x x) + b sin(k_x x)$ with $E = planck^2 k_x^2 slash 2 m^*$,
where both signs of $k_x$ give the same energy and so both enter.
The condition $phi(0) = 0$ kills the cosine, so $a = 0$.
The condition $phi(L_"QW") = 0$ then requires $b sin(k_x L_"QW") = 0$.
Taking $b = 0$ returns the trivial solution $phi equiv 0$, which is no state at
all.
What is left is a condition on $k_x$,
$
  k_x L_"QW" = n pi, quad n = 1, 2, 3, ...,
$
where $n = 0$ is excluded because it gives $phi equiv 0$ again, and negative $n$
gives nothing new.
The wave vector along the confined direction is quantized, and through the
dispersion so is the energy,
$
  E_n = planck^2 / (2 m^*) ((n pi) / L_"QW")^2,
  quad
  phi_n (x) = sqrt(2 / L_"QW") sin((n pi) / L_"QW" x),
$ <infinite-well-solution>
where the prefactor of $phi_n$ is fixed by
$integral dif x thin abs(phi_n)^2 = 1$.

Everything about the spectrum is in the infinite-well solution
@infinite-well-solution.
#key[The spectrum is discrete, which is #term("energy quantization"), and this
is the quantized bandstructure that the previous chapter showed on slide 37
without computing it.]
The levels go as $n^2$, so the spacing $E_(n+1) - E_n prop 2n + 1$ widens as we
climb, visibly so among the four states plotted on slide 34 for a
#qty(5, $"nm"$) gallium arsenide well.
The state $phi_n$ has $n$ antinodes and $n - 1$ interior nodes, so we can read
the index off a picture of the wave function.
#key[The scale of the whole ladder is $E_1 prop 1 slash (m^* L_"QW"^2)$.
So the confinement energy grows as the well gets narrower and falls as the
carrier gets heavier.
That is why a light mass makes a device quantum mechanical at dimensions where a
heavy one does not.]

=== Finite barriers

#exam("L2.16")
#key[A real barrier is finite, with $V_"QW" = Delta E_"CB"$ outside the well.
Three things then change: the wave function leaks into the barrier, the
eigenvalues are no longer given in closed form, and the number of bound states
is finite.]

The wave function no longer vanishes at the interface.
Below the barrier top the solution outside is the decaying exponential of
@kappa, so $phi$ leaks into the barrier over a length $1 slash kappa$ before it
dies away.
Its shape inside the well is still sinusoidal, but it no longer fits a whole
number of half-wavelengths into $L_"QW"$, since the sine is cut off before it
returns to zero.
This is the #term("wave function penetration") of slide 38 of the previous
chapter, and it has no classical counterpart.

The eigenvalues are no longer given in closed form.
Match the interior sinusoid to the exterior exponential at both interfaces,
using continuity of $phi$ and of $(1 slash m^*) dif phi slash dif x$.
For a well symmetric about the origin this gives the two conditions
$
  k_x tan((k_x L_"QW") / 2) = m_w^* / m_b^* kappa,
  quad
  - k_x cot((k_x L_"QW") / 2) = m_w^* / m_b^* kappa,
$
where the first selects the states that are even under $x arrow.r -x$ and the
second the odd ones, and $m_w^*$ and $m_b^*$ are the masses in the well and in
the barrier.
These are transcendental, and we solve them numerically or graphically.

The number of #term("bound states") is finite.
A state needs $E < Delta E_"CB"$ for the decay constant @kappa to describe a
decaying solution at all.
So the ladder of levels @infinite-well-solution is cut off where it crosses the
barrier top, and above that the spectrum is continuous and the states are
unbound.
In one dimension a symmetric well always binds at least one state, however
shallow it is.

Each level lies below its infinite-barrier counterpart.
Penetration gives the wave function more room than $L_"QW"$, and an effectively
wider well has a lower ground state, since $E_1 prop 1 slash L_"QW"^2$.
The shift is largest for the highest bound state, whose $kappa$ is smallest and
which therefore leaks furthest.

=== Quantum well carrier density

#exam("L2.17")
Two things change in the carrier density @carrier-density.
The label $avec(k)$ becomes the pair $(avec(k)_t, n)$, a transverse wave vector
and a subband index, so the sum runs over both.
And $P$ regains a position dependence that it did not have in bulk, since the
well is inhomogeneous along $x$.
From the ansatz @qw-ansatz,
$
  P_(avec(k)_t, n) (avec(r)) = 1 / A abs(phi_n (x))^2 .
$
The carrier density is therefore
$
  n_"QW" (x)
    = 1 / A sum_n sum_(avec(k)_t) abs(phi_n (x))^2
      f(E_n + (planck^2 abs(avec(k)_t)^2) / (2 m^*)),
$
a function of $x$ alone, constant in the transverse plane.
#key[Its shape along $x$ is the sum of the $abs(phi_n)^2$, weighted by how
populated each subband is.
At low temperature and low filling it is essentially $abs(phi_1)^2$, peaked at
the center of the well.]

=== Quantum well density of states

#exam("L2.17")
The same substitution in the density of states @DOS gives
$
  g_"QW" (E, x)
    = 1 / A sum_n sum_(avec(k)_t) abs(phi_n (x))^2
      delta(E - E_n - (planck^2 abs(avec(k)_t)^2) / (2 m^*)),
$
and we convert the transverse sum as we did in bulk, but over two dimensions
rather than three,
$
  1 / A sum_(avec(k)_t) arrow.r 1 / (4 pi^2) integral dif^2 avec(k)_t,
$
with the angular integration contributing the circumference
$2 pi abs(avec(k)_t)$ of a circle and a factor $2$ for spin.
The variable change $E' = planck^2 abs(avec(k)_t)^2 slash 2 m^*$ now gives
$abs(avec(k)_t) dif abs(avec(k)_t) = (m^* slash planck^2) dif E'$, with no
$sqrt(E')$ left over.
So the remaining integral is $integral dif E' thin delta(E - E_n - E')$, which
is one for $E > E_n$ and zero below.
That is the Heaviside step $Theta$, and
$
  g_"QW" (E, x) = m^* / (pi planck^2) sum_n abs(phi_n (x))^2 thin Theta(E - E_n).
$ <g-qw>

The difference from bulk comes from one line of the derivation.
In three dimensions the shell had area $4 pi abs(avec(k))^2$ and left a
$sqrt(E')$ behind.
In two dimensions it has circumference $2 pi abs(avec(k)_t)$ and leaves nothing.
#key[A two-dimensional parabolic band has a density of states that does not
depend on energy.
A quantum well is a stack of them, one per subband, each switched on at $E_n$.]

Averaged over the well, the quantum well density of states @g-qw loses its $x$
dependence and gives the quantity that is plotted,
$
  g_("QW","av") (E)
    = 1 / L_"QW" integral dif x thin g_"QW" (E, x)
    = m^* / (L_"QW" pi planck^2) sum_n Theta(E - E_n),
$ <g-qw-av>
using $integral dif x thin abs(phi_n)^2 = 1$.
This is a staircase, flat between subband edges and stepping up at each one.
#key[Both features of the step depend on the effective mass, and they depend on
it in opposite directions.]
The height $m^* slash (L_"QW" pi planck^2)$ is the same for every step and grows
with $m^*$.
The spacing is set by $E_n prop 1 slash m^*$, so a heavier mass puts the steps
closer together.
Slide 38 shows both effects for the three masses.
The silicon staircase has the tallest and the most closely spaced steps, and the
indium arsenide staircase has the shortest and the widest.

=== Bulk and quantum well density of states compared

#exam("L2.1")
The two densities of states answer the same question about the same material,
and they differ only in whether one direction is confined.
#key[Bulk gives the smooth $sqrt(E)$ of @g-bulk, rising continuously from the
band edge.
The well gives the staircase of @g-qw-av, which is identically zero below $E_1$
and constant between steps.]
This is the difference between the classical and the quantum mechanical density
of states in a MOSFET channel of the previous chapter, now computed instead of
asserted.
A drift-diffusion model uses the smooth curve in a channel that is thin enough
to need the staircase.

The two curves touch each other.
At an energy just above the $n$-th step the averaged density of states @g-qw-av
has the value $n m^* slash (L_"QW" pi planck^2)$.
Evaluate the bulk density of states @g-bulk at that same energy $E_n$, using
$sqrt(E_n) = pi planck n slash (L_"QW" sqrt(2 m^*))$ from
@infinite-well-solution, and we get
$
  g_"bulk" (E_n) = (n m^*) / (L_"QW" pi planck^2),
$
which is the same number.
#key[The upper corner of every step lies exactly on the bulk curve.
That is what slide 39 shows, and it is a stronger statement than the
resemblance of the two curves.]
Now widen the well.
All $E_n$ drop as $1 slash L_"QW"^2$ and each step height drops as
$1 slash L_"QW"$, so we sample the same fixed curve at ever finer intervals, and
the staircase converges to $g_"bulk"$.
Releasing the confinement recovers the bulk result from the confined one, as it
has to.

== Numerical solution

#exam("L2.18")
Outside the infinite well there is no analytical solution, so we have to solve
the one-dimensional problem @qw-1d on a computer.
For a heterostructure its kinetic term
$- planck^2 slash 2 m^* thin dif^2 slash dif x^2$ is the wrong one, because the
effective mass varies with position.
We replace it by the #term("BenDaniel–Duke operator")
$
  - planck^2 / 2 dif / (dif x) 1 / (m^* (x)) dif / (dif x),
$ <BDD>
which has the mass between the derivatives instead of in front of them.
This ordering is forced on us.
#key[Integrate the one-dimensional problem @qw-1d across an interface where
$m^*$ jumps.
The potential term and the eigenvalue term contribute nothing in the limit of a
vanishing interval, so $(1 slash m^*) dif phi slash dif x$ has to be continuous
there.]
If we wrote $(1 slash m^*) dif^2 phi slash dif x^2$ instead, then
$dif phi slash dif x$ would be continuous, which is the wrong condition and does
not conserve probability current across the interface.
The BenDaniel–Duke operator @BDD is also self-adjoint, which
$(1 slash m^*) dif^2 slash dif x^2$ is not, and only a self-adjoint operator has
the real eigenvalues that an energy needs.

The equation we have to solve is therefore
$
  (- planck^2 / 2 dif / (dif x) 1 / (m^* (x)) dif / (dif x) + V_"QW" (x))
    phi(x) = E phi(x).
$ <qw-general>
To discretize it we sample $phi$ on a grid $x_1, ..., x_N$ of spacing $Delta x$,
instead of representing it as a function,
$
  phi arrow.r [phi_1, phi_2, ..., phi_N], quad phi_i = phi(x_i),
$
which slide 42 shows against the continuous wave function.
#key[The grid has to resolve the oscillation of the states we want, so we choose
$Delta x$ to be a small fraction of the shortest half-wavelength in play.
Only the lowest states of the resulting spectrum are trustworthy.]

=== Discretized Hamiltonian

#exam("L2.19")
The BenDaniel–Duke operator @BDD is a derivative of a flux, and we discretize it
as one.
Evaluate the inner derivative on the midpoints between grid points, where the
mass is
$m^*_(i plus.minus 1 slash 2) = (m^*_i + m^*_(i plus.minus 1)) slash 2$, and
evaluate the outer derivative on the grid points themselves,
$
  [dif / (dif x) 1 / m^* (dif phi) / (dif x)]_i approx 1 / (Delta x) (
    (phi_(i+1) - phi_i) / (m^*_(i + 1 slash 2) Delta x)
    - (phi_i - phi_(i-1)) / (m^*_(i - 1 slash 2) Delta x)
  ).
$
Collecting the three coefficients gives the entries of the Hamiltonian,
$
  H_(i, i plus.minus 1) &= - planck^2 / (2 m^*_(i plus.minus 1 slash 2) Delta x^2), \
  H_(i, i) &= planck^2 / (2 Delta x^2) (
    1 / m^*_(i + 1 slash 2) + 1 / m^*_(i - 1 slash 2)
  ) + V_i,
$ <discrete-hamiltonian>
so the heterostructure problem @qw-general becomes, row by row,
$
  H_(i, i-1) phi_(i-1) + H_(i, i) phi_i + H_(i, i+1) phi_(i+1) = E phi_i .
$ <row>
For a constant mass on a uniform grid this reduces to the familiar form
$
  H_(i, i plus.minus 1) = - t,
  quad H_(i, i) = 2 t + V_i,
  quad t = planck^2 / (2 m^* Delta x^2),
$ <hopping>
in which $t$ is the only parameter, an energy set by the grid spacing.
The same $t$ reappears later as the hopping energy of a nearest-neighbor
tight-binding chain.

The Hamiltonian entries @discrete-hamiltonian satisfy
$H_(i,i) = V_i - H_(i,i+1) - H_(i,i-1)$.
So a constant $phi$ on a flat potential gives $H phi = V phi$, which means the
discrete kinetic operator annihilates constants, as the continuous one does.
A discretization that failed this would assign a kinetic energy to an electron
at rest.

Assembled, the rows @row are the eigenvalue problem
$
  H phi = E phi.
$
#key[The $N times N$ matrix $H$ is real symmetric tridiagonal.
It is symmetric through the midpoint mass, which rows $i$ and
$i plus.minus 1$ share.
It is tridiagonal through the second derivative, which couples each point to its
two neighbors and to nothing else.]
Symmetry guarantees real eigenvalues and orthogonal eigenvectors.
Dirichlet conditions close the system, since $phi_0 = phi_(N+1) = 0$ removes the
missing neighbor from the first and the last row and leaves their diagonal
entries unchanged.
The eigenvalues are the $E_n$ and the eigenvectors are the $phi_n$ sampled on
the grid, normalized by $sum_i abs(phi_i)^2 Delta x = 1$ so that they carry the
#unit($m^(-1 slash 2)$) that the continuous $phi$ does.

The structure of $H$ is what the rest of the course builds on.
A closed system gives a Hermitian matrix, a discrete spectrum and bound states,
and that is what we have solved here.
A device is open, and the next chapter attaches contacts to exactly this matrix.
