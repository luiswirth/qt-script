#import "setup.typ": *
#show: chapter.with("Bandstructure and the effective mass approximation")

The previous chapter left @schroedinger standing with two unexplained symbols in
it, an effective mass and a potential.
This chapter produces both.
The route runs from the equation that is exactly right and unsolvable to the one
that is approximate and tridiagonal:
the many-body problem is reduced to a single electron in an effective potential,
the periodicity of that potential is exploited to label states by a wave vector,
the resulting dispersion is replaced near its extremum by a parabola whose
curvature is the effective mass,
and the equation that survives is solved in closed form for two geometries and
on a grid for the rest.

Alongside runs a second thread.
The wave function is not itself observable, and the quantities a device
simulation reports are the carrier density and the density of states.
Both are built from the same two ingredients, the probability density of a state
and the probability that the state is occupied,
and both are computed for each geometry as it appears.

== Single-electron reduction

=== Many-body Schrödinger equation

#exam("L2.2")
Everything about the electronic structure of a solid is contained in the
stationary Schrödinger equation for all of its particles at once,
$
  hat(H) Psi = E Psi,
$
in which $Psi = Psi(avec(r)_1, avec(r)_2, ..., avec(r)_N)$ is a single function
of the coordinates of all $N$ electrons simultaneously,
and $E$ is the total energy of the system.
For a crystal of $N$ electrons and $M$ ions, the ion $j$ carrying charge $Z_j q_0$
at the fixed position $avec(R)_j$, the Hamiltonian is
$
  hat(H) = sum_(i=1)^N (
    - planck^2 / (2 m_0) lapl_i
    - sum_(j=1)^M (Z_j q_0^2) / (4 pi epsilon_0 abs(avec(r)_i - avec(R)_j))
    + sum_(j > i) q_0^2 / (4 pi epsilon_0 abs(avec(r)_i - avec(r)_j))
  ).
$ <many-body>
The three terms are the kinetic energy of the electrons,
each differentiated with respect to its own coordinate through $lapl_i$ and
carrying the free electron mass $m_0$ rather than any effective one;
the electron-ion attraction, which is negative and is what binds the electrons
to the crystal at all;
and the electron-electron repulsion, which is positive and counts each pair once
through the restriction $j > i$.
Here $epsilon_0 = #qty($8.854 dot 10^(-12)$, $F slash m$)$ is the vacuum
permittivity.#note[
  The slides write the Coulomb terms in Gaussian units, as $Z_j q_0^2 slash
  abs(avec(r)_i - avec(R)_j)$ without the $4 pi epsilon_0$.
]
The ions are taken to sit at fixed positions, which already discards their
kinetic energy and is the #term("Born-Oppenheimer approximation");
the lattice vibrations dropped here return in a later chapter as phonons.

#key[@many-body cannot be solved exactly beyond a few special cases, and the
obstruction is the electron-electron term.]
Without it the Hamiltonian would be a sum of identical one-electron operators
and $Psi$ would factorize;
with it every coordinate is coupled to every other, and the dimension of the
domain grows as $3 N$.

=== Effective potential

#exam("L2.3")
The reduction that makes the problem tractable replaces the $N$-electron
function by a one-electron function
$
  hat(H) psi(avec(r)) = E psi(avec(r)),
  quad
  hat(H) = - planck^2 / (2 m_0) lapl + V_"eff" (avec(r)),
$ <single-electron>
with $psi(avec(r))$ depending on one position only.
#key[Everything the other electrons do to the one under consideration is cast
into the single #term("effective potential") $V_"eff" (avec(r))$.]
The pair interaction, a function of $6$ coordinates, becomes a field on
$3$ coordinates,
and the many-body problem becomes a one-body problem in a medium.

That this is possible at all is the content of density functional theory:
#key[Kohn and Sham proved in 1965 that an effective potential exists for which
the carrier density computed from the single-electron wave functions equals the
true many-body density exactly.]
The theorem asserts existence and does not exhibit the potential,
and every practical scheme is an approximation to it.

=== Calculation methods

Three families are in use, and they differ in what they take as input.
#key[Density functional theory computes $V_"eff"$ from the positions of the
atoms alone and pays for it with an underestimated gap and a large cost, while
the empirical methods buy the correct gap and the correct masses cheaply and
need a bandstructure to fit against before they can compute anything.]

#term("Density functional theory") approximates $V_"eff"$ from the density
itself, through a chain of successively better functionals beginning with the
local density approximation.
It takes no input beyond the positions of the atoms, which is what _ab initio_
means, and it reproduces effective masses to within roughly ten percent.
Its known failure is the band gap, which it systematically underestimates:
silicon comes out near #qty(0.6, $"eV"$) against a measured #qty(1.12, $"eV"$),
and indium arsenide, whose true gap is #qty(0.37, $"eV"$), comes out as a metal
with no gap at all.
It is also expensive, of the order of an hour for a bandstructure that tight
binding produces in a second.

The #term("empirical pseudopotential method") and the #term("empirical tight-binding method")
both write down a model of the coupling between atoms whose strengths are
fitting parameters, adjusted until the model reproduces a known bandstructure.
The reference is a density functional calculation for the dispersion together
with the experimental value for the gap, so that the fitted model carries both.
This buys the correct gap and the correct effective masses at a computational
cost smaller by orders of magnitude,
at the price of needing a reference to fit against before anything can be
computed at all.
Slide 9 shows the result for silicon and indium arsenide, with the indirect gap
of the one and the direct gap of the other, both correct, and with the $L$ and
$X$ valleys in their measured positions.

== Bloch's theorem

#exam("L2.4")
The effective potential inherits a property of the crystal.
A crystal is built by translating a primitive unit cell along its lattice
vectors, so that the position of any cell is $n_1 avec(a)_1 + n_2 avec(a)_2 +
n_3 avec(a)_3$ with integer coefficients, written $n avec(a)$ for short.
All cells being identical, there is nothing to distinguish the potential in one
from the potential in another,
$
  V_"eff" (avec(r) + n avec(a)) = V_"eff" (avec(r)).
$
The consequence for the wave function is not immediate, and getting it right is
the whole of the argument.
What must be periodic is not $psi$ but what is observable of it.
An electron is no more likely to be found in one cell than in another, so the
probability density repeats,
$
  abs(psi(avec(r) + n avec(a)))^2 = abs(psi(avec(r)))^2 .
$
A modulus fixes a function only up to a phase, so this says
$
  psi(avec(r) + n avec(a)) = e^(i theta) psi(avec(r))
$
and not that $psi$ itself repeats.
The phase $theta$ may depend on the translation, and the translations compose:
shifting by $n avec(a)$ and then by $n' avec(a)$ must give the same phase as
shifting by $(n + n') avec(a)$, so $theta$ is additive in the translation and
therefore linear in it.
A linear function of $n avec(a)$ is a scalar product with some vector, which is
named $avec(k)$ and called the #term("wave vector"),
$
  psi_avec(k) (avec(r) + n avec(a)) = e^(i avec(k) dot n avec(a)) psi_avec(k) (avec(r)).
$ <bloch-phase>
#key[#term("Bloch's theorem") is the statement that a function with this
property is a plane wave times something with the periodicity of the lattice,]
$
  psi_avec(k) (avec(r)) = u_avec(k) (avec(r)) e^(i avec(k) dot avec(r)),
  quad
  u_avec(k) (avec(r) + n avec(a)) = u_avec(k) (avec(r)).
$ <bloch>
The two forms are equivalent: substituting @bloch into the left of
@bloch-phase and using the periodicity of $u_avec(k)$ returns the right.
The plane wave carries the phase between cells and $u_avec(k)$ carries the
structure within one.

What has entered is a label. The wave function and its eigenvalue now depend on
$avec(k)$ as well,
$
  hat(H) psi_avec(k) (avec(r)) = E(avec(k)) psi_avec(k) (avec(r)).
$ <schroedinger-k>
#key[What was one eigenvalue problem is therefore a family of them, one for each
$avec(k)$.]
The resulting $E(avec(k))$ is the #term("dispersion") of one band and the
#term("bandstructure") of all of them together.
Only the phase $avec(k) dot n avec(a)$ has meaning and it is defined modulo
$2 pi$, so wave vectors differing by a reciprocal lattice vector label the same
state.
The set of inequivalent $avec(k)$ is the #term("Brillouin zone"), a bounded
region fixed by the geometry of the unit cell,
and solving the crystal means solving @schroedinger-k for every $avec(k)$ in it.
In practice the dispersion is reported along a path joining the high-symmetry
points, which is what the horizontal axis of slide 9 is.

Two objects are now in play that are easy to conflate.
The bandstructure is energy against wave vector, and it belongs to a material.
The #term("band diagram"), which appears below, is energy against position, and
it belongs to a structure assembled from several materials.

== Occupation

=== Probability density

#exam("L2.5")
An electron occupying the state $psi_avec(k)$ has the #term("probability density")
$
  P_avec(k) (avec(r)) = abs(psi_avec(k) (avec(r)))^2
$ <prob-density>
of being found at $avec(r)$, carrying #unit($m^(-3)$).
It is a density and not a probability:
the probability of finding the electron in a region is the integral of
@prob-density over that region, and the probability of finding it at any single
point is zero.
The condition attached to it is that the electron is somewhere,
$
  integral_V dif^3 avec(r) thin P_avec(k) (avec(r)) = 1,
$ <normalization>
the integral running over the volume the electron is confined to, which for a
device is the device.
#key[@normalization is what fixes the prefactor of every wave function below,
and it is why $psi$ carries #unit($m^(-3 slash 2)$) rather than being
dimensionless.]

Knowing $P_avec(k)$ says how an electron in the state $avec(k)$ is spread out.
It says nothing about whether that state holds an electron at all.

=== Fermi distribution

#exam("L2.6")
The probability that the state $psi_avec(k)$, of energy $E(avec(k))$, is
occupied is the #term("Fermi distribution")
$
  f(E) = 1 / (1 + exp((E - E_F) slash (k_B T))),
$ <fermi>
dimensionless and valued in $cc(0, 1)$,
where $k_B = #qty($1.381 dot 10^(-23)$, $J slash K$)$ is the Boltzmann constant,
$T$ the temperature,
and $E_F$ the #term("Fermi level"), the energy at which the occupation
is exactly one half.
The combination $k_B T$ is an energy, #qty(25.9, $"meV"$) at #qty(300, $K$), and
it is the only scale in @fermi:
the distribution depends on $E$ and $E_F$ only through $(E - E_F) slash k_B T$,
so $k_B T$ measures the width of the region over which $f$ falls from one to
zero.

#key[At $T = 0$ @fermi degenerates to a step, every state below the Fermi level
filled and every state above it empty, and raising the temperature rounds that
step symmetrically about $E_F$ over a range of a few $k_B T$ to either side.]
The step is what the exponent leaves, $minus infinity$ below $E_F$ and
$plus infinity$ above it, and the rounding empties states just below the Fermi
level and fills states just above it.
The curves for #qty(0, $K$), #qty(100, $K$), #qty(300, $K$) and #qty(500, $K$)
are on slide 13, all crossing at $f = 1 slash 2$, which they must, since
$E = E_F$ makes the exponent vanish at any temperature.
Far above the Fermi level the exponential dominates the denominator and
$f approx exp(-(E - E_F) slash k_B T)$, the #term("Boltzmann tail"),
which is the thermionic population that carried the leakage current of the
previous chapter.

=== Metals, semiconductors and insulators

#exam("L2.7")
#key[Where the Fermi level sits relative to the bands classifies the material.]
Slide 14 shows the three cases side by side.

In a #term("metal") the Fermi level lies inside a band.
States immediately above the occupied ones are available at no energy cost, so
an arbitrarily small field redistributes electrons, and the material conducts
well.

In a #term("semiconductor") the Fermi level lies in a gap $E_g$ between a filled
valence band and an empty conduction band, with $E_g$ small enough that a few
$k_B T$ of thermal energy promotes a usable population across it.
A filled band carries no current, since every state that a field would move an
electron into is already occupied, so conduction is carried entirely by the few
electrons thermally excited into the conduction band and by the holes they leave
behind.

In an #term("insulator") the Fermi level again lies in the gap, but the gap is
wide enough that thermal activation across it is negligible at any temperature
the material survives.

The distinction between the last two is quantitative and has no sharp boundary.
A more useful criterion than the size of the gap is whether doping works:
a semiconductor accepts foreign atoms that shift $E_F$ toward one band or the
other and make it $n$-type or $p$-type, and an oxide generally does not.
Even this fails at the margin, gallium nitride having a gap near
#qty(3, $"eV"$) and being dopable, while oxides of the same gap are not.

=== Charge density

#exam("L2.8")
The two ingredients now combine.
#key[The #term("carrier density") $c(avec(r))$ #unit($m^(-3)$) counts electrons
per unit volume at $avec(r)$, each state contributing the probability density of
finding its electron there weighted by the probability that the state is
occupied.]
Summing over the states,
$
  c(avec(r)) = sum_(avec(k) in "BZ") P_avec(k) (avec(r)) thin f(E(avec(k))).
$ <carrier-density>
It counts carriers, the charge density proper being $q_s c$
#unit($C slash m^3$).#note[The lectures call $c$ itself the charge density.]
Neither factor alone would do.
Dropping $f$ would count every state as full, dropping $P_avec(k)$ would give a
number of electrons and not a density.
Slide 15 shows @carrier-density evaluated for a resonant tunneling diode and for
a double-gate transistor, the internal quantities of the previous chapter that
no measurement reaches.

=== Density of states

#exam("L2.9")
@carrier-density is a sum over the Brillouin zone, and $avec(k)$ is an
inconvenient variable to work in.
It can be traded for energy at no cost. Insert a delta function and an integral
that undoes it,
$
  c(avec(r))
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
$ <dos>
carrying #unit($J^(-1) m^(-3)$), states per unit energy per unit volume.
The delta function is what selects, out of all of $avec(k)$-space, the states
whose energy is $E$, and $P_avec(k)$ distributes each of them over position.
#key[The sum over $avec(k)$ has not disappeared, but it has moved: it is now
performed once, in the definition of $g$, rather than every time a carrier
density is wanted.]
The carrier density is then
$
  c(avec(r)) = integral dif E thin g(E, avec(r)) f(E).
$ <c-from-g>

#exam("L2.10")
#key[The two factors of @c-from-g separate cleanly, the density of states being
a property of the structure alone and the distribution a property of the
reservoir the structure is in equilibrium with.]
The density of states belongs to the geometry and the materials and is fixed
once the structure is:
it says how many states exist at energy $E$ and position $avec(r)$ and would say
so at any temperature and any bias.
The distribution enters through $E_F$ and $T$ alone and knows nothing about the
structure.
Their product $g(E, avec(r)) f(E)$ is therefore the #term("density of occupied states"),
electrons per unit energy per unit volume,
and it is what the energy integral of @c-from-g accumulates into a carrier
density.
The same product resolved in energy, rather than integrated, is what a transport
calculation needs, since current is carried by electrons in a particular range
of energies and not by the total.

== Effective mass approximation

#exam("L2.11")
Computing $E(avec(k))$ from tight binding or density functional theory delivers
the full bandstructure, all bands across the whole Brillouin zone.
Almost none of it matters.
Electrons available for transport sit within a few $k_B T$ of the conduction
band minimum, and holes within a few $k_B T$ of the valence band maximum,
so only the immediate neighborhood of an extremum is ever sampled.

Near an extremum a smooth function is its own quadratic Taylor expansion.
The linear term vanishes there, so in one dimension
$
  E(k) = E_"CB" + 1/2 (dif^2 E) / (dif k^2) k^2 + ...,
$
and comparing with the free-particle dispersion $planck^2 k^2 slash 2 m$
identifies the coefficient as an inverse mass.
The #term("effective mass") is defined by
$
  1 / m^* = 1 / planck^2 (dif^2 E(k)) / (dif k^2),
$ <effective-mass>
evaluated at the extremum, so that
$
  E(avec(k)) = E_"CB" + (planck^2 abs(avec(k))^2) / (2 m^*).
$ <parabolic>
#key[It is a curvature and nothing else: a flat band means a heavy electron, a
sharply curved one a light electron, and the sign of the curvature is what
distinguishes the electron-like minimum of the conduction band from the
hole-like maximum of the valence band.]
Slide 18 sets @parabolic against the computed bands of silicon and indium
arsenide.
The fit is good over a wider range for silicon, whose $m^* = 0.91$ at the $X$
valley is heavy, than for indium arsenide, whose $m^* = 0.023$ at $Gamma$ is
light and whose band leaves the parabola within a few tenths of an
electronvolt.
The reason is geometric rather than material:
a light mass is a sharply curved band, a sharply curved band is one whose higher
derivatives are large, and the quadratic truncation is exactly what those
derivatives measure the error of.

The value of @effective-mass is that it removes $V_"eff"$ from the problem.
#key[The periodic potential of the crystal was what made @single-electron hard,
and its entire effect on a carrier near a band edge is to change the coefficient
of $k^2$ in the dispersion.]
Replacing $m_0$ by $m^*$ therefore reproduces that dispersion with no potential
at all,
$
  (- planck^2 / (2 m^*) lapl + V_"ext" (avec(r))) psi_avec(k) (avec(r))
    = E(avec(k)) psi_avec(k) (avec(r)),
$ <ema>
which is the #term("effective mass approximation") and the form used for the
rest of the course.
An electron in a crystal is treated as a free electron carrying a mass the
crystal has given it.

The potential that reappears in @ema is not the one that was removed.
$V_"eff"$ was the periodic potential of the lattice, and it is gone, absorbed
into $m^*$.
$V_"ext" (avec(r))$ is everything the lattice does not supply:
the electrostatic potential generated by the charges in the device, obtained
from Poisson's equation, and the #term("band offsets") where materials of
different gap meet.
The effective mass may itself depend on position, since it is a property of the
local material, and in a heterostructure it does.

Two limitations come with @ema.
It holds near a band extremum and nowhere else, so a process reaching far into a
band is outside it.
And $m^*$ need not be isotropic.

=== Anisotropy and valley degeneracy

@effective-mass is a second derivative along one direction, and a band curved
differently along different directions yields a different mass for each.
The dispersion is then
$
  E(avec(k)) = planck^2 / 2 (
    k_x^2 / m_x^* + k_y^2 / m_y^* + k_z^2 / m_z^*
  ),
$ <aniso-dispersion>
whose surfaces of constant energy are ellipsoids rather than spheres;
slide 24 shows both.
Silicon is the case that matters.
#key[Its conduction band minimum does not sit at $Gamma$ but on the six
equivalent $Delta$ directions, giving six #term("valleys"), each an ellipsoid
elongated along its own axis with a #term("longitudinal mass")
$m_L = 0.91 m_0$ along that axis and a #term("transverse mass")
$m_T = 0.19 m_0$ along the two perpendicular to it.]
The crystal as a whole is cubic and therefore isotropic;
the anisotropy belongs to the individual valley.

#key[Where a single mass is wanted, as in a density of states, the ellipsoid is
replaced by the sphere of equal volume, whose radius is the geometric mean of
the three semi-axes.]
This defines the #term("density of states effective mass")
$
  m_"DOS" = (m_L m_T^2)^(1 slash 3),
$ <m-dos>
which for silicon is $(0.91 dot 0.19^2)^(1 slash 3) m_0 = 0.32 m_0$,
the value the previous chapter used for the de Broglie wavelength.

== Bulk

#exam("L2.12")
The first geometry @ema is solved in is a #term("bulk") crystal, a chunk of one
material of volume $V = L_x L_y L_z$ with nothing done to it.
Homogeneity is the whole of the assumption: no material changes and no
electrostatics, so
$
  V_"ext" (avec(r)) = 0,
$
and the wave function is taken periodic across the chunk,
$psi_avec(k)(avec(r) + {L_x, L_y, L_z}) = psi_avec(k)(avec(r))$.
The #term("periodic boundary condition") is a device for counting states in a
finite volume and not a physical statement;
nothing below depends on it once $V$ has cancelled.

What remains of @ema is the free-particle equation
$
  - planck^2 / (2 m^*) lapl psi_avec(k) (avec(r))
    = E(avec(k)) psi_avec(k) (avec(r)),
$ <bulk-schroedinger>
solved by plane waves.
Normalizing over $V$ through @normalization, and using that $abs(e^(i avec(k)
dot avec(r))) = 1$ so the integrand is the constant $1 slash V$,
$
  psi_avec(k) (avec(r)) = 1 / sqrt(V) e^(i avec(k) dot avec(r)),
  quad
  E(avec(k)) = (planck^2 abs(avec(k))^2) / (2 m^*),
$ <bulk-solution>
with @aniso-dispersion in place of the energy when the mass is anisotropic.
#key[The dispersion is the parabola that @ema was built to reproduce, which is
the consistency check on the whole construction: the equation whose solution
defines the effective mass returns the band it was fitted to.]

#key[The periodic boundary condition quantizes $avec(k)$ on a grid of spacing
$2 pi slash L_j$, on which each allowed wave vector occupies a volume
$8 pi^3 slash V$ of $avec(k)$-space and a sum over states becomes an integral.]
Requiring $e^(i avec(k) dot {L_x, L_y, L_z}) = 1$ forces each component to
satisfy $k_j L_j in 2 pi ZZ$, so
$
  k_j = n_j (2 pi) / L_j,
  quad n_j in ZZ.
$ <k-quantization>
The conversion is
$
  sum_avec(k) arrow.r V / (8 pi^3) integral dif^3 avec(k),
$ <sum-to-integral>
exactly as a Riemann sum becomes an integral when the spacing goes to zero,
here because $L_j$ is macroscopic.

=== Bulk carrier density

#exam("L2.13")
The probability density of @bulk-solution is
$
  P_avec(k) (avec(r)) = abs(psi_avec(k) (avec(r)))^2 = 1 / V,
$
independent of position, and @carrier-density collapses to
$
  n_"bulk" = 1 / V sum_avec(k) f(E(avec(k))).
$ <n-bulk>
The position dependence is gone.
#key[This is forced rather than fortunate: the structure was assumed
homogeneous, so a carrier density varying with position would have contradicted
the assumption it was computed under.]

=== Bulk density of states

The same substitution in @dos gives
$
  g_"bulk" (E) = 1 / V sum_avec(k) delta(E - E(avec(k))),
$
and the sum is converted by @sum-to-integral, with a factor $2$ for the two spin
orientations each $avec(k)$ accommodates,
$
  g_"bulk" (E) = 2 / (8 pi^3) integral dif^3 avec(k) thin delta(E - E(avec(k))).
$
The integrand depends on $avec(k)$ only through $abs(avec(k))$, since the
dispersion is isotropic, so the angular integration contributes the area
$4 pi abs(avec(k))^2$ of a sphere and
$
  g_"bulk" (E) = 2 / (8 pi^3) integral_0^infinity dif abs(avec(k)) thin
    4 pi abs(avec(k))^2 delta(E - E(avec(k))).
$
Changing variable from $abs(avec(k))$ to $E' = planck^2 abs(avec(k))^2 slash 2
m^*$, so that $abs(avec(k))^2 dif abs(avec(k)) = 1/2 (2 m^* slash planck^2)^(3
slash 2) sqrt(E') dif E'$, leaves an integral the delta function performs,
$
  g_"bulk" (E) = (8 pi sqrt(2 m^(*3))) / h^3 sqrt(E).
$ <g-bulk>
Here the energy is measured from the band edge, and $g_"bulk"$ vanishes below
it, there being no states in the gap.

#key[Two features of @g-bulk carry the physics, growth as $sqrt(E)$ from the
band edge and growth as $m^(*3 slash 2)$ with the mass, and the prefactor
carries none.]#note[
  Luisier said in the lecture that he likes to ask for the $sqrt(E)$ behavior
  and for two curves of different effective mass to be drawn and identified,
  and that he does not expect the $m^(*3 slash 2)$ prefactor to be recalled.
]
The growth in energy is smooth from zero at the band edge, because the number of
states inside a sphere of radius $abs(avec(k))$ grows as $abs(avec(k))^3$ while
$E$ grows as $abs(avec(k))^2$.
The growth in mass means a heavy band carries more states at a given energy than
a light one:
a heavy mass is a flat band, a flat band reaches a given energy only at large
$abs(avec(k))$, and a large $abs(avec(k))$ encloses many states.
Slide 27 plots @g-bulk for the three masses $0.023 m_0$, $0.065 m_0$ and
$0.32 m_0$, of indium arsenide, gallium arsenide and silicon, and the ordering
of the three curves is the ordering of the masses.
For silicon the mass to use is $m_"DOS"$ of @m-dos.

@g-bulk is exact only for a parabolic band.
Performed against a real bandstructure the sum over $avec(k)$ has no closed form
and is evaluated numerically, with the delta function broadened into a Gaussian
or a Lorentzian.

== Quantum well

A #term("quantum well") is the first structure that is not bulk:
a thin layer of one material between two thick layers of another with a wider
gap, gallium arsenide between aluminium gallium arsenide in the case treated
here.
#key[The periodicity is broken along the growth direction $x$ and retained along
$avec(r)_t = {y, z}$, over which the structure has area $A = L_y L_z$.]
Everything below follows from that one asymmetry.

=== Band diagram

The potential $V_"QW" (x)$ that enters @ema comes from the bands of the two
materials.
Slide 30 superimposes the bandstructures of gallium arsenide and
$"Al"_(0.3)"Ga"_(0.7)"As"$ near $Gamma$.
The conduction band minimum of the alloy lies above that of gallium arsenide by
$Delta E_"CB"$, and its valence band maximum lies below by $Delta E_"VB"$;
the wider gap of the barrier material is split between the two band edges.

#key[The #term("band diagram") is then constructed by walking along $x$ and
recording, at each position, the band edge of whichever material is there.]
Taking the conduction band, since only electrons are treated, and putting its
zero at the well,
$
  V_"QW" (x) = cases(
    0 &quad "in the well",
    Delta E_"CB" &quad "in the barriers"
  ),
$ <v-qw>
which is the square well on the right of slide 30.
This is energy against position, and it is the band diagram;
the panel it was constructed from is energy against wave vector, and it is the
bandstructure.

=== Schrödinger equation in a quantum well

#exam("L2.14")
With @v-qw the equation @ema reads
$
  (- planck^2 / (2 m^*) lapl + V_"QW" (x)) psi_(avec(k)_t) (avec(r))
    = E(avec(k)_t) psi_(avec(k)_t) (avec(r)).
$ <qw-schroedinger>
#key[The potential depends on $x$ alone, so the transverse directions are still
those of a homogeneous crystal and carry plane waves, while $x$ carries an
unknown factor.]
The ansatz is
$
  psi_(avec(k)_t) (x, avec(r)_t)
    = 1 / sqrt(A) e^(i avec(k)_t dot avec(r)_t) phi(x),
  quad
  integral dif x thin abs(phi(x))^2 = 1,
$ <qw-ansatz>
in which $avec(k)_t = {k_y, k_z}$ has lost the component $k_x$, there being no
periodicity along $x$ for a wave vector to label.
The normalization splits between the two factors, $1 slash sqrt(A)$ handling the
transverse plane wave and the condition on $phi$ handling $x$, so that
@normalization holds for the product;
$phi$ therefore carries #unit($m^(-1 slash 2)$).

Substituting @qw-ansatz into @qw-schroedinger, the transverse Laplacian acts on
the plane wave and returns $-abs(avec(k)_t)^2$, while the $x$ derivative acts on
$phi$ alone.
Dividing out the common transverse factor leaves
$
  (- planck^2 / (2 m^*) (dif^2) / (dif x^2) + V_"QW" (x)) phi(x)
    = (E(avec(k)_t) - (planck^2 abs(avec(k)_t)^2) / (2 m^*)) phi(x).
$ <qw-1d>
The left side does not contain $avec(k)_t$, so neither can the right, and the
bracket is a constant of the transverse motion.
Calling it $E_n$, the eigenvalues of the one-dimensional problem, the dispersion
of the well is
$
  E_n (avec(k)_t) = E_n + (planck^2 abs(avec(k)_t)^2) / (2 m^*).
$ <subband>
#key[Each $E_n$ is the bottom of a parabolic #term("subband") in the transverse
plane, free motion along $y$ and $z$ built on a confined state along
$x$.]#note[
  The slides write the eigenvalue of @qw-1d as $cal(E)$ and reserve $E$ for the
  total. Since $cal(E)$ is already the electric field here, and since $E_n$ is
  exactly $E_n (avec(k)_t)$ at $avec(k)_t = 0$, the script writes $E_n$
  throughout, as slide 38 does.
]
A three-dimensional problem has been reduced to a one-dimensional eigenvalue
problem plus a formula.

=== Infinite barriers

#exam("L2.15")
@qw-1d has no closed-form solution for the well of @v-qw.
It has one in the limit $Delta E_"CB" arrow.r infinity$, and that limit is worth
solving because it exhibits the quantization with nothing else in the way.

Outside a barrier of infinite height the wave function vanishes identically.
The reason is worth stating, since the finite case turns on it:
below a barrier the solution is not oscillatory but exponentially decaying,
$phi prop e^(-kappa x)$ with #term("decay constant")
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
the potential being zero throughout the region where the equation is solved.

The general solution of @infinite-well is $phi(x) = a cos(k_x x) + b sin(k_x x)$
with $E = planck^2 k_x^2 slash 2 m^*$, both signs of $k_x$ giving the same
energy and so both entering.
The condition $phi(0) = 0$ kills the cosine, $a = 0$.
The condition $phi(L_"QW") = 0$ then requires $b sin(k_x L_"QW") = 0$, and
$b = 0$ returns the trivial solution $phi equiv 0$, which is no state at all.
What is left is a condition on $k_x$,
$
  k_x L_"QW" = n pi, quad n = 1, 2, 3, ...,
$
with $n = 0$ excluded for giving $phi equiv 0$ again, and negative $n$ giving
nothing new.
The wave vector along the confined direction is quantized, and through the
dispersion so is the energy:
$
  E_n = planck^2 / (2 m^*) ((n pi) / L_"QW")^2,
  quad
  phi_n (x) = sqrt(2 / L_"QW") sin((n pi) / L_"QW" x),
$ <infinite-well-solution>
the prefactor of $phi_n$ fixed by $integral dif x thin abs(phi_n)^2 = 1$.

Everything about the spectrum is in @infinite-well-solution.
#key[It is discrete, which is #term("energy quantization"), and this is the
quantized bandstructure the previous chapter showed on slide 37 without
computing.]
The levels go as $n^2$, so the spacing $E_(n+1) - E_n prop 2n + 1$ widens as one
climbs, visibly so among the four states plotted on slide 34 for a
#qty(5, $"nm"$) gallium arsenide well.
The state $phi_n$ has $n$ antinodes and $n - 1$ interior nodes, so the index can
be read off a picture of the wave function.
#key[The scale of the whole ladder is $E_1 prop 1 slash (m^* L_"QW"^2)$, so
confinement energy grows as the well narrows and falls as the carrier gets
heavier, which is why a light mass makes a device quantum mechanical at
dimensions where a heavy one does not.]

=== Finite barriers

#exam("L2.16")
#key[A real barrier is finite, $V_"QW" = Delta E_"CB"$ outside the well, and
three things change: the wave function leaks into the barrier, the eigenvalues
are no longer given in closed form, and the number of bound states is finite.]

The wave function no longer vanishes at the interface.
Below the barrier top the solution outside is the decaying exponential of
@kappa, so $phi$ leaks into the barrier over a length $1 slash kappa$ before
dying away.
Its shape inside the well is still sinusoidal but no longer fits a whole number
of half-wavelengths into $L_"QW"$, the sine being cut off before it returns to
zero.
This is the #term("wave function penetration") of slide 38 of the previous
chapter, and it has no classical counterpart.

The eigenvalues are no longer given in closed form.
Matching the interior sinusoid to the exterior exponential at both interfaces,
using continuity of $phi$ and of $(1 slash m^*) dif phi slash dif x$, gives for
a well symmetric about the origin the two conditions
$
  k_x tan((k_x L_"QW") / 2) = m_w^* / m_b^* kappa,
  quad
  - k_x cot((k_x L_"QW") / 2) = m_w^* / m_b^* kappa,
$ <finite-well-matching>
the first selecting the states even under $x arrow.r -x$ and the second the odd
ones, with $m_w^*$ and $m_b^*$ the masses in well and barrier.
These are transcendental and are solved numerically or graphically.

The number of #term("bound states") is finite.
A state requires $E < Delta E_"CB"$ for @kappa to describe a decaying solution
at all, so the ladder of @infinite-well-solution is truncated where it crosses
the barrier top;
above that the spectrum is continuous and the states are unbound.
In one dimension a symmetric well always binds at least one state however
shallow it is.

Each level lies below its infinite-barrier counterpart.
Penetration gives the wave function more room than $L_"QW"$, an effectively
wider well has a lower ground state by $E_1 prop 1 slash L_"QW"^2$, and the
shift is largest for the highest bound state, whose $kappa$ is smallest and
which therefore leaks furthest.

=== Quantum well carrier density

#exam("L2.17")
Two things change in @carrier-density.
The label $avec(k)$ becomes the pair $(avec(k)_t, n)$, a transverse wave vector
and a subband index, so the sum runs over both.
And $P$ regains a position dependence that it did not have in bulk, since the
well is inhomogeneous along $x$:
from @qw-ansatz,
$
  P_(avec(k)_t, n) (avec(r)) = 1 / A abs(phi_n (x))^2 .
$
The carrier density is therefore
$
  n_"QW" (x)
    = 1 / A sum_n sum_(avec(k)_t) abs(phi_n (x))^2
      f(E_n + (planck^2 abs(avec(k)_t)^2) / (2 m^*)),
$ <n-qw>
a function of $x$ alone, constant in the transverse plane.
#key[Its shape along $x$ is the sum of the $abs(phi_n)^2$ weighted by how
populated each subband is, so at low temperature and low filling it is
essentially $abs(phi_1)^2$, peaked at the center of the well.]

=== Quantum well density of states

The same substitution in @dos gives
$
  g_"QW" (E, x)
    = 1 / A sum_n sum_(avec(k)_t) abs(phi_n (x))^2
      delta(E - E_n - (planck^2 abs(avec(k)_t)^2) / (2 m^*)),
$
and the transverse sum is converted as in bulk, but over two dimensions rather
than three,
$
  1 / A sum_(avec(k)_t) arrow.r 1 / (4 pi^2) integral dif^2 avec(k)_t,
$
with the angular integration contributing the circumference $2 pi
abs(avec(k)_t)$ of a circle and a factor $2$ for spin.
The variable change $E' = planck^2 abs(avec(k)_t)^2 slash 2 m^*$ now gives
$abs(avec(k)_t) dif abs(avec(k)_t) = (m^* slash planck^2) dif E'$, with no
$sqrt(E')$ left over, so the remaining integral is
$integral dif E' thin delta(E - E_n - E')$, which is one for $E > E_n$ and zero
below.
That is the Heaviside step $Theta$, and
$
  g_"QW" (E, x) = m^* / (pi planck^2) sum_n abs(phi_n (x))^2 thin Theta(E - E_n).
$ <g-qw>

The difference from bulk traces to one line of the derivation.
In three dimensions the shell had area $4 pi abs(avec(k))^2$ and left a
$sqrt(E')$ behind; in two it has circumference $2 pi abs(avec(k)_t)$ and leaves
nothing.
#key[A two-dimensional parabolic band has a density of states independent of
energy, and a quantum well is a stack of them, one per subband, switched on at
$E_n$.]

Averaging @g-qw over the well removes the $x$ dependence and gives the quantity
that is plotted,
$
  g_("QW","av") (E)
    = 1 / L_"QW" integral dif x thin g_"QW" (E, x)
    = m^* / (L_"QW" pi planck^2) sum_n Theta(E - E_n),
$ <g-qw-av>
using $integral dif x thin abs(phi_n)^2 = 1$.
This is a staircase, flat between subband edges and stepping up at each one.
#key[Both features of the step depend on the effective mass, and in opposite
directions.]
The height $m^* slash (L_"QW" pi planck^2)$ is the same for every step and grows
with $m^*$.
The spacing is set by $E_n prop 1 slash m^*$, so a heavier mass puts the steps
closer together.
Slide 38 shows both effects for the three masses:
the silicon staircase has the tallest and the most closely spaced steps, the
indium arsenide staircase the shortest and the widest.

=== Bulk and quantum well density of states compared

#exam("L2.1")
The two densities of states answer the same question about the same material and
differ only in whether one direction is confined.
#key[Bulk gives the smooth $sqrt(E)$ of @g-bulk, rising continuously from the
band edge, while the well gives the staircase of @g-qw-av, identically zero
below $E_1$ and constant between steps.]
This is the difference between the classical and the quantum mechanical density
of states in a MOSFET channel of the previous chapter, computed rather than
asserted:
a drift-diffusion model uses the former in a channel thin enough to require the
latter.

The two are not merely similar in trend. They touch.
At an energy just above the $n$-th step, @g-qw-av has value $n m^* slash
(L_"QW" pi planck^2)$, and evaluating @g-bulk at that same energy $E_n$, using
$sqrt(E_n) = pi planck n slash (L_"QW" sqrt(2 m^*))$ from
@infinite-well-solution, gives
$
  g_"bulk" (E_n) = (n m^*) / (L_"QW" pi planck^2),
$
the same number.
#key[The upper corner of every step lies exactly on the bulk curve, which is
what slide 39 shows and which is stronger than the resemblance the picture
suggests.]
Widening the well then lowers all $E_n$ as $1 slash L_"QW"^2$ and lowers each
step height as $1 slash L_"QW"$, so the staircase is sampled at ever finer
intervals along a curve that does not move, and it converges to $g_"bulk"$.
The bulk result is recovered from the confined one in the limit where the
confinement is released, as it must be.

== Numerical solution

#exam("L2.18")
Outside the infinite well there is no analytical solution, and @qw-1d has to be
solved on a computer.
For a heterostructure the operator is not the one written there.
The effective mass varies with position, and the kinetic term is the
#term("BenDaniel–Duke operator")
$
  - planck^2 / 2 dif / (dif x) 1 / (m^* (x)) dif / (dif x),
$ <variable-mass-operator>
with the mass between the derivatives rather than in front of them.
The ordering is forced.
#key[Integrating @qw-1d across an interface where $m^*$ jumps, the potential and
eigenvalue terms contribute nothing in the limit of a vanishing interval, so
$(1 slash m^*) dif phi slash dif x$ must be continuous there.]
Writing $(1 slash m^*) dif^2 phi slash dif x^2$ instead would make $dif phi
slash dif x$ continuous, which is the wrong condition and does not conserve
probability current across the interface.
@variable-mass-operator is also self-adjoint, which
$(1 slash m^*) dif^2 slash dif x^2$ is not, and only a self-adjoint operator has
the real eigenvalues an energy needs.

The equation to be solved is therefore
$
  (- planck^2 / 2 dif / (dif x) 1 / (m^* (x)) dif / (dif x) + V_"QW" (x))
    phi(x) = E phi(x).
$ <qw-general>
Discretizing means sampling $phi$ on a grid $x_1, ..., x_N$ of spacing
$Delta x$ rather than representing it as a function,
$
  phi arrow.r [phi_1, phi_2, ..., phi_N], quad phi_i = phi(x_i),
$
which slide 42 shows against the continuous wave function.
#key[The grid must resolve the oscillation of the states wanted, so $Delta x$ is
chosen a small fraction of the shortest half-wavelength in play, and only the
lowest states of the resulting spectrum are trustworthy.]

=== Discretized Hamiltonian

#exam("L2.19")
@variable-mass-operator is a derivative of a flux, and it is discretized as one.
Evaluate the inner derivative on the midpoints between grid points, where the
mass is $m^*_(i plus.minus 1 slash 2) = (m^*_i + m^*_(i plus.minus 1)) slash 2$,
and the outer derivative on the grid points themselves:
$
  [dif / (dif x) 1 / m^* dif phi / (dif x)]_i approx 1 / (Delta x) (
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
so that @qw-general becomes, row by row,
$
  H_(i, i-1) phi_(i-1) + H_(i, i) phi_i + H_(i, i+1) phi_(i+1) = E phi_i .
$ <discrete-row>
For a constant mass on a uniform grid this reduces to the familiar form
$
  H_(i, i plus.minus 1) = - t,
  quad H_(i, i) = 2 t + V_i,
  quad t = planck^2 / (2 m^* Delta x^2),
$ <hopping>
in which $t$ is the only parameter, an energy set by the grid
spacing, and the same $t$ will reappear as the hopping energy of a
nearest-neighbor tight-binding chain.

@discrete-hamiltonian satisfies $H_(i,i) = V_i - H_(i,i+1) - H_(i,i-1)$, so a
constant $phi$ on a flat potential gives $H phi = V phi$:
the discrete kinetic operator annihilates constants, as the continuous one does.
A discretization failing this would assign a kinetic energy to an electron at
rest.

Assembled, @discrete-row is the eigenvalue problem
$
  H phi = E phi.
$
#key[The $N times N$ matrix $H$ is real symmetric tridiagonal, symmetric through
the midpoint mass, which is shared between rows $i$ and $i plus.minus 1$, and
tridiagonal through the second derivative, which couples each point to its two
neighbors and to nothing else.]
Symmetry guarantees real eigenvalues and orthogonal eigenvectors.
Dirichlet conditions close the system: $phi_0 = phi_(N+1) = 0$ removes the
missing neighbor from the first and last rows and leaves their diagonal entries
unchanged.
The eigenvalues are the $E_n$ and the eigenvectors the $phi_n$ sampled on the
grid, normalized by $sum_i abs(phi_i)^2 Delta x = 1$ so that they carry the
#unit($m^(-1 slash 2)$) the continuous $phi$ does.

The structure of $H$ is what the rest of the course builds on.
A closed system gives a Hermitian matrix, a discrete spectrum and bound states,
which is what has been solved here.
A device is open, and the next chapter attaches contacts to exactly this matrix.
