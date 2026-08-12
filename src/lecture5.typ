#import "setup.typ": *
#show: chapter.with("Electrostatics and Green's functions")

Two developments meet in this chapter, and they meet only in the device they
describe.

The first closes the loop the wave function formalism left open.
The potential $V(x)$ entering the Hamiltonian has been given since the second
chapter, while the carrier density @n-obc computed from it is one of the charges
that produce it.
Poisson's equation is the statement of that dependence, and solving the two
equations together is what turns a band diagram from an assumption into a
result.

The second reformulates what has already been derived.
The open system @OBC applies the operator $E - H - Sigma$ to an unknown and
matches it against a source;
inverting that operator instead gives the Green's function, and every quantity
the previous chapter built out of wave functions can be rewritten in terms of it.
Nothing physical is added.
What is gained is a formalism whose objects are Green's functions and
self-energies alone, with no injection vector and no band derivative left in
it, which is the form scattering enters in a later chapter.

== Electrostatics

=== Charge density

#exam("L5.1")
The electron density is one contribution to the charge density and not the whole
of it.
#key[A semiconductor carries mobile electrons and holes and, fixed in the
lattice, the ionized dopants that supplied them,]
$
  rho(avec(r)) = q (p(avec(r)) - n(avec(r))
    + N_D (avec(r)) - N_A (avec(r))),
$ <charge-density>
with $q$ the elementary charge, $n$ and $p$ the electron and hole densities and
$N_D$ and $N_A$ the #term("donor") and #term("acceptor") concentrations, all
four counted as positive numbers and their signs written out.
A donor is an atom substituted into the crystal that gives one electron away and
is left positively charged, an acceptor one that takes one up and is left
negatively charged, and both are immobile.
A doping profile is therefore a fixed charge that the mobile carriers arrange
themselves around.

Charge neutrality is the balance of the four terms, $rho = 0$, and it is what a
region far from any junction settles into: an $n$-doped region has
$n = N_D$ and a $p$-doped one $p = N_A$.
It is a condition on the solution and not an assumption, and the boundary
conditions below are how it is obtained at the ends of a device.

=== Poisson's equation

#exam("L5.1")
A charge density sources an electric field, and the field is the gradient of a
potential,
$
  avec(cal(E))(avec(r)) = - nabla Phi(avec(r)),
  quad
  nabla dot (epsilon(avec(r)) avec(cal(E))(avec(r))) = rho(avec(r)),
$
the second being Gauss's law in matter, with $epsilon = epsilon_0 epsilon_r$ the
#term("dielectric permittivity") and $epsilon_r$ its relative value, of order
$10$ in a semiconductor.
#key[Eliminating the field between the two gives #term("Poisson's equation"),
which determines the #term("electrostatic potential") produced by a charge
density,]
$
  nabla dot (epsilon(avec(r)) nabla Phi(avec(r))) = - rho(avec(r)).
$ <Poisson>
Where the permittivity is uniform it comes out of the derivative and leaves
$nabla^2 Phi = - rho slash epsilon$, and the form @Poisson with $epsilon$
between the two derivatives is the one that survives a material interface.

In one dimension the equation is two integrations.
The field is the running integral of the charge,
$cal(E)(x) = epsilon^(-1) integral dif x thin rho(x)$, and the potential the
running integral of the field with a sign,
$Phi(x) = - integral dif x thin cal(E)(x)$.
Both directions are used: differentiating a potential twice returns the charge
that produced it, which is how a converged calculation is checked.

=== Charge, field and potential of a p-n junction

#exam("L5.4")
The chain from charge to potential is worth following once where all three can
be drawn, which is a #term("p-n junction"), a $p$-doped region grown against an
$n$-doped one.
Slide 7 carries the three plots.

Electrons are abundant on the $n$ side and scarce on the $p$ side, and holes the
other way round, so each species diffuses across the junction and recombines
with the other.
#key[What is left behind near the junction is a #term("depletion region"),
emptied of mobile carriers and carrying the ionized dopants alone.]
The charge density @charge-density in it is $- q N_A$ on the $p$ side and
$+ q N_D$ on the $n$ side, two boxes of opposite sign, while outside it both
sides are neutral.
The widths $x_p$ and $x_n$ of the two boxes are not independent: the region as a
whole is neutral, so $N_A x_p = N_D x_n$, and the more heavily doped side
depletes over the shorter distance.

Integrating a piecewise constant charge gives a piecewise linear field.
It starts at zero at the edge of the depletion region, falls linearly across the
$p$ side, reaches its most negative value at the junction, and rises linearly
back to zero at the far edge, which is the triangle of slide 7 and which closes
exactly because the two boxes carry equal and opposite charge.
Integrating once more gives a potential that rises monotonically from the $p$
side to the $n$ side and is flat outside the depletion region.
#key[The total rise is the #term("built-in potential"), a potential drop across
the junction with no voltage applied to it.]
It is what bends the bands, the conduction band edge being $- q Phi$ away from
where it would sit in a neutral material, so the bands are pulled down on the
$n$ side by exactly the amount that brings the two sides to a common Fermi
level, which is what equilibrium means.

=== Boundary conditions

#exam("L5.5")
Poisson's equation is second order and needs one condition at each end of the
domain.
#key[A #term("Dirichlet") condition fixes the value of the potential at the
boundary and a #term("von Neumann") condition fixes its derivative,]
$
  Phi(0) = F_0, quad Phi(L) = F_L,
  quad "or" quad
  (dif Phi) / (dif x) |_(x = 0) = B_0,
  quad (dif Phi) / (dif x) |_(x = L) = B_L.
$
A Dirichlet condition is the natural one where the potential at the boundary is
imposed from outside, as it is at a gate contact held at a known voltage by a
battery.
The closed boundary conditions of the second chapter were Dirichlet conditions
on the wave function with $F_0 = F_L = 0$.

A transport calculation uses the other kind, with vanishing derivative,
$B_0 = B_L = 0$.
The reason is the contact of the third chapter.
#key[A contact is a region of constant potential, which is what makes the plane
wave ansatz @contact-ansatz exact there, and a Poisson solver that returned a
sloping potential at the ends of the device would contradict the Schrödinger
equation solved on the same grid.]
Requiring $dif Phi slash dif x = 0$ at both ends is the requirement that the
potential be flat where the contacts attach, and it is the point at which the
two equations are made consistent with each other rather than merely coupled.

=== Charge neutrality at the contacts

#exam("L5.6")
A vanishing derivative of the potential propagates into two further statements.
The field is the derivative, so $cal(E) = 0$ there, and Gauss's law reads the
charge off the derivative of the field, so a field that is zero across the whole
contact region carries $rho = 0$ with it.
#key[Imposing a vanishing derivative of the electrostatic potential at the
boundary imposes charge neutrality there, so that the electron density is
driven to the donor concentration and the hole density to the acceptor
concentration.]

Nothing about the carrier density is imposed by hand to achieve this, and
neutrality is not enforced pointwise.
The boundary row of the discretized equation below says that no flux enters the
first cell from outside, so any charge left in that cell would have to be
balanced by a field inside the device, which the flat solution has nowhere to
put.
What the solver does with that is shift the potential in the contact region up
or down until the local Fermi level sits where the electron density it produces
compensates the doping.
Neutrality is the fixed point of that adjustment, and it is reached to the
accuracy the iteration is run to.

This is also what a real device does.
The source and drain of a transistor are heavily doped and neutral, and screen
an applied field over a distance short compared to their length, which is
precisely why a flat-band contact is a description of them and not an
idealization imposed for convenience.

=== Discretization

#exam("L5.3")
Poisson's equation is discretized on the grid the Schrödinger equation already
uses, giving a linear system
$
  M Phi = - rho,
$ <discrete-poisson>
with $Phi$ and $rho$ the vectors of nodal values and $M$ the matrix
representing $nabla epsilon nabla$.
The operator couples neighbors only, so $M$ is tridiagonal, exactly as $H$ is.

What is discretized is $nabla epsilon nabla Phi$ and not $epsilon nabla^2 Phi$.
#key[The permittivity sits between the two derivatives so that the discrete
equation carries the flux $epsilon dif Phi slash dif x$ from one point to the
next, which is the electric displacement $D = epsilon cal(E)$ and which is the
quantity that is continuous across a material interface.]
This is the BenDaniel-Duke ordering @BDD of the third chapter with the mass
replaced by the permittivity.
There the operator was $nabla (1 slash m^*) nabla$ so that
$(1 slash m^*) dif psi slash dif x$ passed continuously across an interface and
the probability current was conserved;
here the same construction conserves the displacement, and both are instances of
discretizing a divergence of a flux rather than a bare second derivative.

The entries follow from integrating @Poisson over the cell around a grid point,
which turns the left-hand side into the difference of the displacement at the
two faces of the cell.
With $Delta x_(-) = x_i - x_(i-1)$ and $Delta x_(+) = x_(i+1) - x_i$ the two
spacings and the permittivity at a face taken as the average of its two
neighbors,
$
  M_(i, i-1) = (epsilon_i + epsilon_(i-1)) /
    (Delta x_(-) (Delta x_(-) + Delta x_(+))),
  quad
  M_(i, i+1) = (epsilon_i + epsilon_(i+1)) /
    (Delta x_(+) (Delta x_(-) + Delta x_(+))),
$
and $M_(i i) = - M_(i, i-1) - M_(i, i+1)$, the row summing to zero because a
constant potential carries no charge.
The boundary rows are the same stencil with the flux through the outer face
dropped, which is what $B_0 = B_L = 0$ says,
$
  M_(1 1) = - M_(1 2) = - (epsilon_1 + epsilon_2) / (2 Delta x^2),
$
and the mirror statement at $i = N$.
With the charge in the boundary cell driven to zero, that row reads
$Phi_1 = Phi_2$, the discrete form of a vanishing derivative.

=== Newton-Raphson iteration

#exam("L5.2")
The linear system @discrete-poisson is not solved as it stands.
#key[The charge density on its right-hand side is itself a function of the
potential, since the potential enters the Hamiltonian whose solutions the
carrier density @n-obc is built from, so Poisson's equation in a device is
nonlinear.]

Solving it by substitution, computing $rho$ from a potential and then
$Phi = - M^(-1) rho$ from that charge, does not converge.
The map ignores the response of the charge to the potential it is about to
produce, which is the mechanism that screens, and the size of what is ignored is
read off the two terms.
A potential variation of wavelength $lambda$ contributes to $M$ an amount of
order $epsilon (2 pi slash lambda)^2$, while the response contributes
$partial rho slash partial Phi$, and their ratio is
$(lambda slash 2 pi lambda_D)^2$ with the #term("screening length")
$
  lambda_D^2 = - epsilon (partial rho / (partial Phi))^(-1).
$
#key[The neglected term dominates for every variation longer than the screening
length, which in a doped semiconductor is around a nanometer and so is shorter
than any feature of the device, and the resulting overshoot alternates in sign
because the charge opposes the potential that produced it.]

The remedy is to treat @discrete-poisson as a root-finding problem for the
residual
$
  F(Phi) = M Phi + rho(Phi),
$ <poisson-residual>
which vanishes exactly when Poisson's equation is satisfied, and to apply
#term("Newton-Raphson") to it.
The Jacobian of the residual @poisson-residual is
$
  J = (dif F) / (dif Phi) = M + (dif rho) / (dif Phi),
$ <jacobian>
and each iteration solves the sparse linear system
$
  - J thin dif Phi_m = F(Phi_m),
  quad
  Phi_(m+1) = Phi_m + dif Phi_m,
$ <newton>
for the correction rather than for the potential itself.
The response now sits inside the operator being inverted instead of being
re-evaluated after the fact, which is what removes the overshoot;
it also makes $J$ strictly diagonally dominant, $M$ having zero row sums and
$dif rho slash dif Phi$ being negative on the diagonal.
Convergence is quadratic at best and linear in practice, and five to ten
iterations suffice.
The correction $dif Phi$ going to zero is the same statement as the residual
going to zero, so either serves as a convergence criterion.

=== Response of the charge density

The Jacobian @jacobian needs $dif rho slash dif Phi$, and the charge density is
the output of a quantum mechanical calculation, so the derivative is not
available in closed form.
What is used is the response of the occupation at frozen density of states.
#key[Raising the electrostatic potential at a point by $delta Phi$ lowers every
energy of the spectrum there by $q delta Phi$, and a rigid shift of the spectrum
against a fixed Fermi level is indistinguishable from a shift of the Fermi level
in the opposite direction, so the density responds as it would to
$E_F arrow.r E_F + q delta Phi$.]

Applied to the carrier density @n-obc this gives a derivative that costs nothing
beyond the quantities the current iteration already holds,
$
  (partial n) / (partial E_F^c) (x)
    = integral dif E thin g^c (E, x) thin m_t^* / (pi planck^2)
      thin f(E, E_F^c),
$
the derivative of the Fermi integral @FI with respect to its Fermi level being
the Fermi distribution @FD again, times the prefactor of the transverse density
of states.
The entry of the Jacobian is then
$
  (dif rho_i) / (dif Phi_i)
    = - q^2 sum_c (partial n) / (partial E_F^c) (x_i),
$
negative, as the screening argument required, and diagonal.#note[
  The lectures do not say what is used for this derivative. The fourth exercise
  computes it as written, by evaluating the density a second time with the two
  Fermi levels displaced and differencing, with the density of states held at
  its current value.
]

Two things are neglected in it.
The density of states $g^c$ is held fixed although the potential it was computed
from is what changes, and the response is taken to be diagonal although a
potential change at one point moves the density at every point a wave function
reaches.
#key[Both are approximations of the Jacobian and not of the answer: the
converged solution is where the residual @poisson-residual vanishes, and the
residual is computed from the full quantum solve, so an inexact Jacobian costs
iterations and nothing else.]

=== Self-consistent Schrödinger-Poisson solver

#exam("L5.2", "L5.3")
The two equations are coupled through one substitution.
#key[The electrostatic potential enters the Schrödinger equation as a potential
energy, and the charge density that the Schrödinger equation produces enters
Poisson's equation as its source,]
$
  V(x) = V_"band" (x) - q Phi(x),
$ <potential-energy>
with $V_"band"$ the band offsets that $V$ has carried so far, fixed by the
materials, and $- q Phi$ the electrostatics, which is not.
The potential energy of an electron is the negative of its charge times the
potential, and it is added to the diagonal of the Hamiltonian.
Slide 13 draws the loop, one box per equation and one arrow per direction.

Neither equation can be solved first, which is what #term("self-consistency")
means here, and the calculation alternates between them:

+ Choose an initial guess $Phi_0$.
  A potential dropping linearly across the device from zero to $V_"ext"$ will
  do, and a better one costs fewer iterations but changes no result.
+ Place the Fermi levels.
  Each contact is neutral and in equilibrium, so its Fermi level is the one at
  which the equilibrium density @n-from-g equals the local doping, and the
  applied bias then splits the two by @bias.
+ Assemble $V(x)$ from @potential-energy and solve the open system @OBC at every
  energy of the grid, giving the densities of states @g-obc and the carrier
  density @n-obc.
+ Solve Poisson's equation for the correction by @newton, giving
  $Phi_(m+1) = Phi_m + dif Phi_m$.
+ Return to step 3 with the new potential, until $sum_i abs(dif Phi_i)$ falls
  below a chosen criterion.
+ Evaluate the current @LB, whose transmission the converged solution already
  carries.

A current-voltage characteristic repeats this per bias point.
#key[The converged potential of one bias point is the initial guess of the next,
and once two points are available their linear extrapolation is a better one,
which is the cheapest way to reduce the number of Schrödinger solves.]

=== Barrier under bias

Slide 15 shows the converged solution for the barrier structure of the previous
two chapters, doped on both sides and undoped in the middle, at one applied
bias, as the carrier density, the charge density, the field and the potential.

The four plots are the chain of this part read off a computed example.
The electron density equals the donor concentration at both ends and departs
from it inside, depleted where the barrier is and accumulated against it.
The charge density is the difference of the two and vanishes at both ends, which
is the charge neutrality the boundary conditions produced.
The field is its integral, nonzero only where the charge is, and zero at both
ends.
The potential is the integral of that, flat over both contact regions, and the
difference between its two flat values is the applied bias.
#key[The band diagram that the previous chapter read off the slides is this
potential, so the sloping band edge and the triangular well that accumulated
carriers against the barrier were consequences of the charge and not inputs to
the calculation.]

== Green's functions

=== Green's function of a linear operator

#exam("L5.7")
Consider a linear differential equation with a source,
$
  L(x) f(x) = S(x),
$ <source-problem>
with $L$ a linear operator, a combination of derivatives and functions of $x$,
and $S$ a given source.
#key[The #term("Green's function") of $L$ is its response to a point source,]
$
  L(x) G(x, x') = delta(x - x'),
$ <GF>
one function of two arguments, the second naming where the point source sits.
Solving @GF looks like more work than solving @source-problem, since it is a
whole family of problems rather than one, but it is solved once and then serves
every source.

#key[The solution of @source-problem for an arbitrary source is the
superposition of the responses to the point sources it is made of,]
$
  f(x) = integral dif x' thin G(x, x') S(x').
$ <GF-solution>
Applying $L(x)$ verifies it: $L$ does not act on $x'$, so it passes through the
integral onto $G$, where the definition @GF turns it into $delta(x - x')$, and
the integral of a delta against $S$ returns $S(x)$.
Linearity of $L$ is the only property used, which is the whole reason the
construction exists and also the limit of it.

Two readings of $G$ are useful and both are used later.
#key[As a #term("propagator") it carries the influence of a disturbance at $x'$
to the point $x$, and as a #term("correlation function") it measures how
strongly the two points are tied to each other, a large $G(x, x')$ meaning that
what happens at $x'$ is felt at $x$ and a small one that it is not.]

=== Green's function of the Schrödinger equation

#exam("L5.9")
The Schrödinger equation with open boundary conditions is of the form
@source-problem, with $L = E - H - Sigma$ and $S$ the injection.
Before discretizing, it is worth solving one case in closed form, obtained by
taking the potential constant at $V_0$ and dropping the self-energy, which
leaves an equation that can be integrated by hand,
$
  (E + planck^2 / (2 m^*) (dif^2) / (dif x^2) - V_0) G(x, x')
    = delta(x - x').
$ <G-1D>
The point of it is not the device, whose potential is not constant, but what the
resulting $G$ looks like.

Away from $x'$ the right-hand side vanishes and @G-1D is the Schrödinger
equation in a flat region, whose solutions are the plane waves
$e^(plus.minus i k x)$ of the second chapter with
$
  k = sqrt(2 m^* (E - V_0)) / planck.
$
Two conditions fix which combination appears.
The delta function depends on $x$ and $x'$ only through $x - x'$, so $G$ does
too.
And the two sides of $x'$ must carry different solutions, since a $G$ that is
the same function on both sides is a solution of the homogeneous equation and
knows nothing of the source.
#key[One plane wave is therefore taken on each side,]
$
  G(x, x') = cases(
    A^+ e^(i k (x - x')) & quad x > x',
    A^- e^(-i k (x - x')) & quad x < x'.
  )
$ <G-ansatz>

The two amplitudes are fixed by reintroducing the singularity, which is done by
integrating @G-1D across it, from $x' - delta$ to $x' + delta$ with
$delta arrow.r 0$.
The Green's function is continuous, a jump in it making its second derivative
worse than a delta function, so the term $(E - V_0) G$ integrates to zero over a
vanishing interval and the term $A^+ = A^-$ follows from continuity alone.
The second derivative integrates to the jump in the first derivative, and the
delta function on the right integrates to one,
$
  (dif G) / (dif x) |_(x' + delta) - (dif G) / (dif x) |_(x' - delta)
    = (2 m^*) / planck^2.
$ <G-jump>
#key[The Green's function is continuous at the source and its derivative jumps
there, and the size of the jump is what fixes the amplitude.]
Substituting the ansatz @G-ansatz gives $2 i k A = 2 m^* slash planck^2$, so
that
$
  A^+ = A^- = - i m^* / (k planck^2) = - i / (planck v),
$
the last form using the band velocity $planck v = planck^2 k slash m^*$ of the
previous chapter.
The amplitude of the response to a point source is the inverse of the speed at
which the response travels away from it, which is the same weighting that put a
velocity in the denominator of the density of states @g-velocity.

=== Retarded and advanced Green's functions

#exam("L5.11")
Assembling the two branches with the absolute value that reproduces the sign of
the exponent on either side,
$
  G^R (x, x') = - i / (planck v) e^(i k abs(x - x')),
$ <retarded>
the #term("retarded Green's function").
Exchanging the two exponentials in the ansatz @G-ansatz satisfies the same jump
condition @G-jump with the opposite sign of the amplitude and gives a second
solution,
$
  G^A (x, x') = + i / (planck v) e^(-i k abs(x - x')),
$ <advanced>
the #term("advanced Green's function"), which is the conjugate transpose of the
retarded one, $G^A (x, x') = G^R (x', x)^*$.

#key[Both solve the defining equation @G-1D, since they differ by a solution of
the homogeneous equation, so the equation alone does not select one and a
condition at infinity does.]#note[
  Luisier presented the assignment of the two exponentials to the two sides as
  an arbitrary choice, the only requirement being that the two sides differ.
  It is arbitrary as far as @G-1D is concerned, which is why the outgoing
  condition has to be supplied from outside it.
]
The condition is that the waves travel away from the source.
Restoring the time dependence $e^(- i E t slash planck)$, the retarded solution
@retarded carries phase fronts $k abs(x - x') - E t slash planck$ that move
outward, so a disturbance at $x'$ produces a response that spreads and never
arrives before it, while the advanced solution @advanced carries fronts
converging on $x'$, describing the time reverse.

The same selection is made in one line by displacing the energy,
$
  G^R = lim_(eta arrow.r 0^+) (E + i eta - H)^(-1),
  quad
  G^A = lim_(eta arrow.r 0^+) (E - i eta - H)^(-1).
$ <ieta>
#key[A positive imaginary part gives $k$ a positive imaginary part as well, so
$e^(i k abs(x - x'))$ decays at large separation and $e^(-i k abs(x-x'))$
diverges, which selects the retarded solution and leaves it the only one that is
analytic in the upper half of the complex energy plane, the Fourier statement
that a response follows its cause.]
The two formulations are the same condition: outgoing in space, causal in time,
analytic above the real axis.

The choice has already been made once, in the third chapter.
The contact self-energy $Sigma_(1 1) = - t_L e^(i k_L Delta x)$ was derived by
keeping the wave leaving the device and discarding the one arriving, so it is
the retarded self-energy and is written $Sigma^R$ from here on.#note[
  The third and fourth chapters wrote $Sigma$ without a superscript, there being
  only one self-energy in them, as the lectures also do.
]
Its imaginary part is negative, which is the same statement as the $+ i eta$ of
@ieta.

=== Discrete Green's function

#exam("L5.8", "L6.2")
Returning to the discretized problem, the open system @OBC and the definition
@GF of a Green's function differ in one place: the source of the Green's
function is a point source at each grid point in turn, and the discrete form of
$delta(x - x')$ is the identity matrix.
#key[The retarded Green's function of a discretized device is the inverse of the
operator the wave function formalism applies,]
$
  (E - H - Sigma^R) G^R = I,
  quad
  G^R = (E - H - Sigma^R)^(-1),
$ <retarded-matrix>
a full $N times N$ matrix at each energy, and the advanced Green's function is
$G^A = (G^R)^dagger$.

The two formalisms are then two ways of using one operator.
Solving $(E - H - Sigma^R) phi = S$ for $phi$ and multiplying the inverse onto
$S$ give the same wave function,
$
  phi = G^R S,
$ <wf-from-GF>
which is the reconstruction @GF-solution with the integral over $x'$ replaced by
a matrix-vector product.
The entry $G^R_(i j)$ is the amplitude at point $i$ of the response to a unit
source at point $j$, so a column of $G^R$ is a wave function and the whole
matrix is the response to every source at once.
#key[Since the injection vector $S$ has one nonzero entry per contact, only the
first and last columns of $G^R$ enter the wave functions, and computing all $N$
of them is work that a device calculation does not need.]

=== Wave function squared

#exam("L6.3")
Every observable of the previous chapter was built from $abs(phi_i)^2$ rather
than from $phi_i$.
#key[The outer product of the wave function with itself is a matrix whose
diagonal carries the squared magnitudes, and expressing it through
@wf-from-GF removes the wave function from the formalism,]
$
  phi phi^dagger = G^R S S^dagger (G^R)^dagger = G^R S S^dagger G^A,
$ <wf-square>
whose diagonal entry $i$ is $abs(phi_i)^2$.
The off-diagonal entries $phi_i phi_j^*$ are not needed for a density but are
not discarded either, and they are what the correlation reading of a Green's
function refers to.

What remains in @wf-square that the formalism should not carry is the injection
vector $S$, which is a wave function quantity, and the band derivative
$dif E slash dif k_c$ that the density of states @g-obc supplies.
The rest of this chapter eliminates both.

=== Lesser Green's function and lesser self-energy

#exam("L6.1", "L6.4", "L6.5")
Substituting the wave function squared @wf-square into the density of states
@g-obc and that into the carrier density @n-obc, with the injection amplitudes
set to $a_c = 1$,
$
  n(x_i) = integral (dif E) / (2 pi) thin
    "diag" {G^R (E) [sum_c S^c S^(c dagger)
      abs((dif E) / (dif k_c))^(-1) F(E, E_F^c)] G^A (E)}_i.
$
Everything belonging to the contacts has been collected into the bracket, and it
is given a name.
#key[The #term("lesser self-energy") is what the contacts inject, and the
#term("lesser Green's function") is what the device does with it,]
$
  Sigma^(<) (E) = i sum_c S^c S^(c dagger)
    abs((dif E) / (dif k_c))^(-1) F(E, E_F^c) Delta x,
$ <lesser-SE>
$
  G^(<) (E) = G^R (E) Sigma^(<) (E) G^A (E),
$ <lesser-GF>
in terms of which the carrier density is
$
  n(x_i) = - i / (Delta x) integral (dif E) / (2 pi)
    thin "diag" {G^(<) (E)}_i.
$ <n-lesser>
The two factors that were introduced with them cancel between @lesser-SE and
@n-lesser and are conventions rather than content.
The $Delta x$ converts a quantity defined per grid point into one per unit
length, which is what a density is;
the $i$ makes $Sigma^(<)$ and therefore $G^(<)$ anti-Hermitian, so that the
diagonal entries of $G^(<)$ are purely imaginary and the density @n-lesser comes
out real.

#key[The lesser Green's function is the object that carries the occupation:
$G^R$ says which states exist and where they reach, and $G^(<)$ says how many
electrons are in them, so the two together are what a non-equilibrium
calculation needs.]
Its diagonal is the density and its off-diagonal entries are the correlation
between two points, and the whole distinction between equilibrium and
non-equilibrium sits in the Fermi integrals inside $Sigma^(<)$.

The sparsity of $Sigma^(<)$ is that of $Sigma^R$.
Each $S^c$ has a single nonzero entry, at the first point for the left contact
and the last for the right, so each $S^c S^(c dagger)$ has a single nonzero
entry on the diagonal and $Sigma^(<)$ has two, $Sigma^(<)_(1 1)$ and
$Sigma^(<)_(N N)$.
Evaluating them with the injection term $S_(c c) = - t_c (1 - e^(2 i k_c
Delta x))$ of the third chapter and the discrete band @discrete-band,
$
  abs(S_(c c))^2 = 4 t_c^2 sin^2 (k_c Delta x),
  quad
  (dif E) / (dif k_c) = 2 t_c Delta x sin(k_c Delta x),
$
so that the two surviving entries are
$
  Sigma^(<)_(c c) (E) = 2 i t_c sin(k_c Delta x) thin F(E, E_F^c).
$ <lesser-contact>

=== Broadening

#exam("L6.4")
The combination appearing in @lesser-contact has a name and an independent
definition.
#key[The #term("broadening") is twice the negative imaginary part of the
retarded self-energy,]
$
  Gamma = i (Sigma^R - Sigma^A) = - 2 "Im" Sigma^R,
$ <broadening>
using $Sigma^A = (Sigma^R)^dagger$.
It inherits the sparsity of $Sigma^R$ and has one nonzero entry per contact,
$
  Gamma_(c c) (E) = 2 t_c sin(k_c Delta x) = (planck v_c (E)) / (Delta x),
$ <broadening-contact>
the second form being the band velocity @g-velocity of the previous chapter,
which appeared there as the Jacobian of the contact band and here as the rate at
which the contact drains the boundary point.

Comparing @lesser-contact with @broadening-contact,
$
  Sigma^(<)_(c c) (E) = i Gamma_(c c) (E) thin F(E, E_F^c),
$ <lesser-broadening>
which is an identity and not a fit.
The injection term and the broadening are the same quantity,
$abs(S_(c c)) = Gamma_(c c)$, and the band derivative is
$dif E slash dif k_c = planck v_c = Gamma_(c c) Delta x$, so the definition
@lesser-SE collapses to
$i Gamma_(c c)^2 F slash Gamma_(c c)$.#note[
  Luisier obtained @lesser-broadening by comparing the two expressions and
  called the step empirical, saying a derivation exists but is beyond the
  lecture. The comparison is exact for the contact self-energies derived in the
  third chapter, since both sides are the same function of $t_c$ and
  $k_c Delta x$.
]
Nothing that was to be eliminated survives: $S$ and $dif E slash dif k_c$ have
both turned into $Gamma$, which is built from $Sigma^R$ alone.

#key[$Gamma$ is called a broadening because coupling a level to a contact gives
it a finite lifetime, and a state that does not last forever does not have a
sharp energy.]
A device closed at both ends has discrete eigenvalues, and its spectrum at a
resonance is a delta function at $E_0$.
Opening it replaces $E - H$ by $E - H - Sigma^R$, which moves the pole off the
real axis to $E_0 - i Gamma slash 2$, and the retarded Green's function near it
behaves as $(E - E_0 + i Gamma slash 2)^(-1)$.
Two statements follow from the displaced pole.
The spectral weight is a Lorentzian of full width $Gamma$ at half maximum
instead of a delta function, which is the broadened resonance the third
exercise computed as a peak in the transmission.
And the time dependence $e^(- i E_0 t slash planck - Gamma t slash 2 planck)$
decays, so the probability of still finding the electron in the device falls as
$e^(- Gamma t slash planck)$ and the state has the lifetime
$
  tau = planck / Gamma.
$
The two are the same fact in conjugate variables, a level of finite lifetime
having an energy uncertain by $planck slash tau$.

The velocity form @broadening-contact says what the lifetime is here.
An electron at the boundary point moves into the contact at $v_c$ and clears the
cell of width $Delta x$ in $Delta x slash v_c$, which is exactly
$planck slash Gamma_(c c)$.
#key[The broadening is an escape rate in energy units, so a state at the bottom
of the contact band, where the velocity vanishes, is long-lived and sharp, and
one in the middle of the band, where the velocity is largest, is short-lived and
broad.]
The imaginary part of the self-energy of the third chapter, $- t_c sin(k_c Delta
x)$, is $- Gamma_(c c) slash 2$ and was already this quantity.

=== Density of states in the Green's function formalism

#exam("L6.5")
The broadening matrix splits by contact, $Gamma = Gamma^L + Gamma^R$, with
$Gamma^c$ carrying the entry of contact $c$ and zeros elsewhere, and the lesser
self-energy @lesser-broadening splits with it,
$
  Sigma^(<) (E) = i sum_c Gamma^c (E) thin F(E, E_F^c).
$ <lesser-split>
The split is what keeps the two contacts apart, which the previous chapter
showed is mandatory out of equilibrium, and it is possible because each contact
occupies its own entry.

Putting @lesser-split into the carrier density @n-lesser recovers the form the
previous chapter derived,
$
  n(x) = integral dif E thin sum_c g^c (E, x) thin F(E, E_F^c),
  quad
  g^c (E, x_i) = 1 / (2 pi Delta x)
    "diag" {G^R (E) Gamma^c (E) G^A (E)}_i.
$ <g-GF>
#key[The density of states @g-obc has a closed form in terms of the Green's
function and the broadening, with no wave function, no injection vector and no
band derivative in it, and everything built on it in the previous chapter
carries over unchanged.]
The reading is direct: $Gamma^c$ injects at the contact, $G^R$ propagates from
there to $x_i$, $G^A$ propagates back, and the product is the weight the contact
puts on that point at that energy.

The name is earned rather than assigned.
Inverting the definitions gives $G^R - G^A = G^R (Sigma^R - Sigma^A) G^A$, so
$
  i (G^R - G^A) = G^R Gamma G^A,
$
whose diagonal, divided by $2 pi Delta x$, is $sum_c g^c$.
The left-hand side is the #term("spectral function"), the local density of
states of the device, which is a property of the open system alone;
the right-hand side decomposes it into the contributions of the contacts.
#key[Summing @g-GF over contacts gives a quantity that does not know which
contact anything came from, so the decomposition is a bookkeeping device for the
occupation and not a splitting of the states themselves.]

=== Solution procedure

The whole calculation at one energy is short, and every step is an expression
already derived.
The wave function solver of the third chapter is replaced module for module,
the quantities it delivers being the same:

+ Solve the contact dispersion @contact-dispersion for $k_L$ and $k_R$ at the
  energy $E$.
+ Form the two self-energies $Sigma^R_(c c) = - t_c e^(i k_c Delta x)$ and
  assemble $Sigma^R$.
+ Form $Gamma_(c c) = i (Sigma^R_(c c) - Sigma^(R *)_(c c))$ by @broadening and
  place them in $Gamma^L$ and $Gamma^R$.
+ Invert to get $G^R = (E - H - Sigma^R)^(-1)$ by @retarded-matrix, and take
  $G^A = (G^R)^dagger$.
+ Evaluate the two densities of states @g-GF.

The energy integral for the carrier density @n-obc, the Fermi integrals and the
current @LB are then what they were.#note[
  Luisier said what he expects to be remembered of this: the retarded
  self-energy $Sigma^R_(c c) = - t_c e^(i k_c Delta x)$, from which $Gamma$ and
  $Sigma^(<)$ follow. The expression for the injection term $S$, which the wave
  function formalism had to carry, is not needed at all.
]

#key[One line of the procedure is more expensive than everything the wave
function formalism did, namely the inversion, which produces $N^2$ entries where
a tridiagonal solve produced $N$.]
The density of states @g-GF uses the diagonal of $G^R Gamma^c G^A$, and
$Gamma^c$ has one nonzero entry, so only one column of $G^R$ per contact is
ever read.
Computing the rest is the price of having written the formalism as an inverse,
and the next chapter recovers it.

== Outlook

The formalism is not yet complete.
The electron density has a Green's function expression and the current does not,
the transmission still being computed from wave function amplitudes, and the
hole density needs a counterpart of $G^(<)$ that counts empty states rather than
occupied ones.
The next chapter supplies both, closes the set of Green's functions with the
identities relating them, and replaces the full inversion by a recursion that
computes only the entries that are read.
