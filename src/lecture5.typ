#import "setup.typ": *
#show: chapter.with("Electrostatics and Green's functions")

This chapter has two parts, and they are independent of each other.

The first part computes the potential $V(x)$ instead of assuming it.
So far $V(x)$ was given to us.
We put it into the Hamiltonian, solved the Schrödinger equation, and got the
electron density @n-obc out.
But electrons are charged, and charges create an electric potential.
So $V(x)$ is not ours to choose.
It has to be the potential that the electrons themselves produce.
The equation that says this is Poisson's equation.
We have to solve it together with the Schrödinger equation.
Then the band diagram is a result of the calculation instead of an input to it.

The second part rewrites equations we already have in a new language.
The open system @OBC has the form $(E - H - Sigma) phi = S$.
So far we solved it for $phi$.
Now we invert the matrix $E - H - Sigma$ instead.
The inverse is called the Green's function.
Every quantity of the previous chapter can then be written with Green's
functions.
No new physics comes out of this.
The reason to do it is that the new formulas contain no injection vector $S$ and
no band derivative $dif E slash dif k$.
Those two are hard to generalize.
When we add scattering in a later chapter, only the Green's function version
still works.

== Electrostatics

=== Charge density

#exam("L5.1")
The charge density $rho(avec(r))$ tells us how much charge sits at each point of
the device.
Electrons are not the only charge in a semiconductor.
There are four contributions.
#key[A semiconductor contains mobile electrons and mobile holes.
It also contains the ionized dopant atoms, which sit fixed in the lattice and
are charged,]
$
  rho(avec(r)) = q (p(avec(r)) - n(avec(r))
    + N_D (avec(r)) - N_A (avec(r))),
$ <charge-density>
with $q$ the elementary charge, $n$ and $p$ the electron and hole densities and
$N_D$ and $N_A$ the #term("donor") and #term("acceptor") concentrations.
All four numbers are positive, and the signs are written out in the formula.

A donor is an atom that we substitute into the crystal and that gives away one
electron.
It stays behind with a positive charge.
An acceptor takes up one electron instead and stays behind with a negative
charge.
Neither of them can move, because they are part of the lattice.
The doping profile is therefore a fixed charge, and the mobile electrons and
holes arrange themselves around it.

Far away from any junction the four terms cancel each other,
$
  rho = 0.
$
We call this charge neutrality.
In an $n$-doped region it means $n = N_D$, and in a $p$-doped region it means
$p = N_A$.
We do not put this in by hand.
It comes out of the calculation, and the boundary conditions below are what make
it come out.

=== Poisson's equation

#exam("L5.1")
Charges create an electric field, and the electric field is minus the gradient
of a potential,
$
  avec(cal(E))(avec(r)) = - nabla Phi(avec(r)),
  quad
  nabla dot (epsilon(avec(r)) avec(cal(E))(avec(r))) = rho(avec(r)).
$
The second equation is Gauss's law in matter.
Here $epsilon = epsilon_0 epsilon_r$ is the #term("dielectric permittivity"),
and $epsilon_r$ is its relative value, which is about $10$ in a semiconductor.

Now put the first equation into the second one and the field drops out.
#key[What is left is #term("Poisson's equation"), which gives us the
#term("electrostatic potential") that a charge density produces,]
$
  nabla dot (epsilon(avec(r)) nabla Phi(avec(r))) = - rho(avec(r)).
$ <Poisson>
If $epsilon$ is the same everywhere, we can pull it out of the derivative and
write $nabla^2 Phi = - rho slash epsilon$.
A device is made of several materials, so $epsilon$ depends on position and has
to stay between the two derivatives.
The section on discretization explains why that placement matters.

In one dimension Poisson's equation is just two integrations.
First integrate the charge to get the field,
$cal(E)(x) = epsilon^(-1) integral dif x thin rho(x)$.
Then integrate the field to get the potential,
$Phi(x) = - integral dif x thin cal(E)(x)$.
We also use the two steps in the other direction.
Differentiating a computed potential twice gives back the charge, and comparing
it with the charge we started from is a good check of the numerics.

=== Charge, field and potential of a p-n junction

#exam("L5.4")
The step from charge to field to potential is easiest to see in a
#term("p-n junction").
That is a $p$-doped region grown against an $n$-doped region.
Slide 7 shows the three plots.

There are many electrons on the $n$ side and few on the $p$ side.
For holes it is the other way round.
So electrons diffuse to the $p$ side, holes diffuse to the $n$ side, and they
recombine with each other.
#key[Near the junction this leaves a #term("depletion region"), which has no
mobile carriers left in it and contains only the ionized dopants.]

Inside the depletion region the charge density @charge-density is $- q N_A$ on
the $p$ side and $+ q N_D$ on the $n$ side.
Two boxes of opposite sign, in other words.
Outside the depletion region both sides are neutral.
The two boxes must contain the same amount of charge, because the region as a
whole is neutral.
With $x_p$ and $x_n$ the widths of the two boxes this reads
$N_A x_p = N_D x_n$.
So the side with the stronger doping is depleted over the shorter distance.

Now integrate.
A charge that is piecewise constant gives a field that is piecewise linear.
The field is zero at the outer edge of the depletion region on the $p$ side.
It then falls linearly, reaches its most negative value at the junction, and
rises linearly back to zero at the other edge.
That is the triangle on slide 7.
It comes back to zero exactly because the two boxes carry equal and opposite
charge.

Integrating once more gives the potential.
It is flat outside the depletion region and rises from the $p$ side to the $n$
side.
#key[The total rise is called the #term("built-in potential"), and it is present
even though no voltage is applied to the device.]
The built-in potential is what bends the bands.
The conduction band edge sits at $- q Phi$ relative to the neutral material, so
the bands are pulled down on the $n$ side.
They are pulled down by exactly the amount that puts the two sides at the same
Fermi level.
Equal Fermi levels on both sides is what equilibrium means.

=== Boundary conditions

#exam("L5.5")
Poisson's equation is of second order, so we need one condition at each end of
the device.
There are two kinds.
#key[A #term("Dirichlet") condition fixes the value of the potential at the
boundary.
A #term("Neumann") condition fixes its derivative instead,]#note[
  The slides and the lectures both say von Neumann. The condition is named after
  Carl Neumann, and John von Neumann has nothing to do with it.
]
$
  Phi(0) = F_0, quad Phi(L) = F_L,
  quad "or" quad
  (dif Phi) / (dif x) |_(x = 0) = B_0,
  quad (dif Phi) / (dif x) |_(x = L) = B_L.
$
Use a Dirichlet condition when something outside the device sets the potential
at the boundary.
A gate contact held at a fixed voltage by a battery is the standard example.
The closed boundary conditions of the second chapter were also Dirichlet
conditions, applied to the wave function with $F_0 = F_L = 0$.

For a transport calculation we use the other kind, with zero derivative,
$
  B_0 = B_L = 0.
$
The reason is the contact of the third chapter.
#key[A contact is a region of constant potential, and that is what makes the
plane wave ansatz @contact-ansatz exact there.
A Poisson solver that produced a sloping potential at the ends of the device
would contradict the Schrödinger equation we solve on the same grid.]
Setting $dif Phi slash dif x = 0$ at both ends forces the potential to be flat
where the contacts are, so the two equations agree with each other.

=== Charge neutrality at the contacts

#exam("L5.6")
The zero derivative has two consequences, one after the other.
The field is the derivative of the potential, so $cal(E) = 0$ at the boundary.
Gauss's law gets the charge from the derivative of the field, and the field is
zero across the whole contact region, so its derivative is zero there too.
Therefore $rho = 0$ in the contact region.
#key[Fixing the derivative of the potential to zero at the boundary makes the
contact region neutral.
The electron density there goes to the donor concentration, and the hole
density to the acceptor concentration.]

We never tell the solver what the carrier density should be.
Here is how it happens instead.
The boundary row of the discretized equation below says that no electric flux
enters the first cell from outside.
If there were charge left in that cell, it would have to produce a field
somewhere inside the device.
A flat potential has no room for such a field.
So the solver shifts the potential in the contact region up or down until the
electron density it produces cancels the doping.
Charge neutrality is the fixed point of that adjustment.
It is reached as accurately as we run the iteration.

A real device behaves the same way.
Source and drain of a transistor are heavily doped and neutral, and they screen
an applied field over a distance much shorter than their own length.
So a flat contact is a good description of them, not an idealization we invented
to make the math work.

=== Discretization

#exam("L5.3")
We discretize Poisson's equation on the same grid that the Schrödinger equation
already uses.
This turns it into a linear system
$
  M Phi = - rho,
$ <discrete-poisson>
where $Phi$ and $rho$ are the vectors of the values at the grid points, and $M$
is the matrix that represents the operator $nabla epsilon nabla$.
That operator connects each grid point only to its two neighbors, so $M$ is
tridiagonal, just like $H$.

What we discretize is $nabla epsilon nabla Phi$, not $epsilon nabla^2 Phi$.
The reason is what happens at an interface between two materials.
The quantity that is continuous across such an interface is the electric
displacement $D = epsilon cal(E) = - epsilon dif Phi slash dif x$.
#key[Keeping the permittivity between the two derivatives makes the discrete
equation pass $epsilon dif Phi slash dif x$ from one grid point to the next.
So the discretization respects that continuity by construction.]

We have done this before.
It is the BenDaniel-Duke ordering @BDD of the third chapter, with the mass
replaced by the permittivity.
There the operator was $nabla (1 slash m^*) nabla$, so that
$(1 slash m^*) dif psi slash dif x$ was continuous across an interface and the
probability current was conserved.
Both cases discretize the divergence of a flux instead of a plain second
derivative.

To get the entries of $M$, integrate @Poisson over the cell around a grid point.
The left hand side then becomes the difference of the displacement at the two
faces of the cell.
Write $Delta x_(-) = x_i - x_(i-1)$ and $Delta x_(+) = x_(i+1) - x_i$ for the
two spacings, and take the permittivity at a face as the average of its two
neighbors.
The result is
$
  M_(i, i-1) = (epsilon_i + epsilon_(i-1)) /
    (Delta x_(-) (Delta x_(-) + Delta x_(+))),
  quad
  M_(i, i+1) = (epsilon_i + epsilon_(i+1)) /
    (Delta x_(+) (Delta x_(-) + Delta x_(+))),
$
together with $M_(i i) = - M_(i, i-1) - M_(i, i+1)$.
Each row sums to zero, because a constant potential produces no charge.

The first and last row use the same stencil, but with the flux through the outer
face left out.
That is exactly what $B_0 = B_L = 0$ means.
For the first row,
$
  M_(1 1) = - M_(1 2) = - (epsilon_1 + epsilon_2) / (2 Delta x^2),
$
and the last row is the mirror image of it.
The charge in that cell is driven to zero, so the row reduces to
$Phi_1 = Phi_2$, which is the discrete version of a zero derivative.

=== Newton-Raphson iteration

#exam("L5.2")
We cannot solve the linear system @discrete-poisson directly.
#key[The charge density on the right hand side depends on the potential itself.
The potential goes into the Hamiltonian, and the solutions of that Hamiltonian
give us the carrier density @n-obc.
So Poisson's equation in a device is nonlinear.]

The obvious approach is to iterate.
Take a potential, compute $rho$ from it, then compute $Phi = - M^(-1) rho$ from
that charge, and repeat.
This does not converge.
The problem is that the new charge is computed for the old potential.
The charge reacts to the potential, and that reaction is exactly what screening
is.
Ignoring it makes each step overshoot.

We can estimate how badly.
Take a potential variation with wavelength $lambda$.
It contributes a term of size $epsilon (2 pi slash lambda)^2$ to $M$, and the
reaction of the charge contributes $partial rho slash partial Phi$.
The ratio of the two is $(lambda slash 2 pi lambda_D)^2$, where $lambda_D$ is
the #term("screening length"),
$
  lambda_D^2 = - epsilon (partial rho / (partial Phi))^(-1).
$
In a doped semiconductor $lambda_D$ is about a nanometer.
Every feature of a device is longer than that.
#key[So the term we ignored is the larger one for every variation in the device.
The overshoot also flips sign at every step, because the charge always moves
against the potential that created it.]

The fix is to solve the equation as a root finding problem.
Define the residual
$
  F(Phi) = M Phi + rho(Phi),
$ <poisson-residual>
which is zero exactly when Poisson's equation is satisfied, and apply
#term("Newton-Raphson") to it.
The Jacobian of @poisson-residual is
$
  J = (dif F) / (dif Phi) = M + (dif rho) / (dif Phi),
$ <jacobian>
and each step solves the sparse linear system
$
  - J thin dif Phi_m = F(Phi_m),
  quad
  Phi_(m+1) = Phi_m + dif Phi_m,
$ <newton>
for the correction $dif Phi_m$ instead of for the potential.

Compare this with the failed iteration.
The reaction of the charge, $dif rho slash dif Phi$, now sits inside the matrix
we invert, so it is taken into account while the correction is computed.
That is what removes the overshoot.
It also makes $J$ strictly diagonally dominant, since the rows of $M$ sum to
zero and $dif rho slash dif Phi$ is negative on the diagonal.
Convergence is quadratic in the best case and linear in practice, and five to
ten steps are enough.
Stop when the correction $dif Phi$ is small, or when the residual is small.
Both say the same thing.

=== Response of the charge density

The Jacobian @jacobian needs $dif rho slash dif Phi$.
The charge density comes out of a quantum mechanical calculation, so we have no
formula to differentiate.
We use an approximation instead, and it rests on a simple observation.
#key[Raising the potential at a point by $delta Phi$ lowers every energy of the
spectrum there by $q delta Phi$.
Shifting the whole spectrum down against a fixed Fermi level looks the same as
shifting the Fermi level up.
So the density reacts as it would to $E_F arrow.r E_F + q delta Phi$.]

The density of states stays where it is in this picture, and only the occupation
changes.
Applied to the carrier density @n-obc that gives
$
  (partial n) / (partial E_F^c) (x)
    = integral dif E thin g^c (E, x) thin m_t^* / (pi planck^2)
      thin f(E, E_F^c),
$
because differentiating the Fermi integral @FI with respect to its Fermi level
gives back the Fermi distribution @FD, times the prefactor of the transverse
density of states.
Everything on the right hand side is already available in the current iteration,
so this costs us nothing.
The Jacobian entry is then
$
  (dif rho_i) / (dif Phi_i)
    = - q^2 sum_c (partial n) / (partial E_F^c) (x_i),
$
which is diagonal and negative, as the screening argument above needs it to
be.#note[
  The lectures do not say what is used for this derivative. The fourth exercise
  computes it as written, by evaluating the density a second time with the two
  Fermi levels displaced and differencing, with the density of states held at
  its current value.
]

Two things are wrong with this derivative.
The density of states $g^c$ is held fixed, although it was computed from the
very potential that we are changing.
And the derivative is taken to be diagonal, although changing the potential at
one point changes the density everywhere a wave function reaches.
#key[Both errors sit in the Jacobian only, and the Jacobian does not determine
the answer.
The converged solution is where the residual @poisson-residual vanishes, and
that residual is computed from the full quantum solve.
So a bad Jacobian costs extra iterations and nothing else.]

=== Self-consistent Schrödinger-Poisson solver

#exam("L5.2", "L5.3")
Now we put the two equations together.
They are coupled through one substitution in each direction.
#key[The electrostatic potential enters the Schrödinger equation as a potential
energy.
The charge density that comes out of the Schrödinger equation enters Poisson's
equation as its source,]
$
  V(x) = V_"band" (x) - q Phi(x),
$ <potential-energy>
where $V_"band"$ is the band offset that $V$ stood for so far, fixed by the
choice of materials, and $- q Phi$ is the new electrostatic part.
The minus sign is there because the potential energy of an electron is its
charge $- q$ times the potential.
This potential energy is added to the diagonal of the Hamiltonian.
Slide 13 draws the loop, with one box per equation and one arrow per direction.

Neither of the two equations can be solved first, since each one needs the
output of the other.
This is what #term("self-consistency") means.
So we alternate between them:

+ Choose an initial guess $Phi_0$.
  A potential that drops linearly across the device from zero to $V_"ext"$ works
  fine.
  A better guess saves iterations but changes no result.
+ Place the Fermi levels.
  Each contact is neutral and in equilibrium.
  So its Fermi level is the one at which the equilibrium density @n-from-g
  equals the local doping.
  The applied bias then splits the two Fermi levels by @bias.
+ Build $V(x)$ from @potential-energy and solve the open system @OBC at every
  energy of the grid.
  This gives the densities of states @g-obc and the carrier density @n-obc.
+ Solve Poisson's equation for the correction with @newton, which gives
  $Phi_(m+1) = Phi_m + dif Phi_m$.
+ Go back to step 3 with the new potential.
  Stop when $sum_i abs(dif Phi_i)$ falls below a chosen threshold.
+ Compute the current @LB.
  Its transmission is already part of the converged solution.

A full current-voltage characteristic repeats all of this at every bias point.
#key[We use the converged potential of one bias point as the initial guess of
the next one.
Once we have two points, we extrapolate them linearly to get the third guess.
This is the cheapest way to cut down the number of Schrödinger solves.]

=== Barrier under bias

Slide 15 shows a converged solution.
The structure is the barrier of the previous two chapters, doped on both sides
and undoped in the middle, at one applied bias.
There are four plots: the carrier density, the charge density, the field and the
potential.

They show the chain of this part on a real example.
The electron density equals the donor concentration at both ends.
Inside it departs from it, depleted where the barrier is and piled up against
it.
The charge density is the difference between the two, and it is zero at both
ends, which is the charge neutrality that the boundary conditions produced.
The field is the integral of the charge, nonzero only where the charge is, and
zero at both ends.
The potential is the integral of the field, flat over both contact regions, and
the difference between the two flat values is the applied bias.
#key[The band diagram that the previous chapter took from the slides is this
potential.
So the sloping band edge and the triangular well next to the barrier came out of
the charge.
We never put them in.]

== Green's functions

=== Green's function of a linear operator

#exam("L5.7")
Start with a general linear differential equation that has a source term,
$
  L(x) f(x) = S(x),
$ <source-problem>
where $L$ is a linear operator, meaning some combination of derivatives and
functions of $x$, and $S$ is a given source.
We want $f$.

#key[The #term("Green's function") of $L$ is the solution we get when the source
is a single spike at the position $x'$,]
$
  L(x) G(x, x') = delta(x - x').
$ <GF>
So $G$ is one function of two arguments.
The first argument is where we look, and the second one is where the spike sits.

This looks like more work than the original problem, because we now solve a
whole family of problems instead of one.
But we solve it only once, and afterwards it works for every source.
#key[The solution of @source-problem for any source is the sum of the responses
to all the spikes that make up the source,]
$
  f(x) = integral dif x' thin G(x, x') S(x').
$ <GF-solution>
Check it by applying $L(x)$ to both sides.
The operator acts on $x$ and not on $x'$, so it goes through the integral and
hits $G$.
By the definition @GF it turns $G$ into $delta(x - x')$.
The integral of a delta function against $S$ gives $S(x)$, which is what we
wanted.
The only property we used is that $L$ is linear.
That is why the construction works, and also why it works only for linear
problems.

There are two ways to read $G$, and we use both later.
#key[As a #term("propagator") it tells us how a disturbance at $x'$ reaches the
point $x$.
As a #term("correlation function") it tells us how strongly the two points are
connected.
A large $G(x, x')$ means that what happens at $x'$ is felt at $x$, and a small
one means that it is not.]

=== Green's function of the Schrödinger equation

#exam("L5.9")
Our open system @OBC has the form @source-problem, with $L = E - H - Sigma$ and
$S$ the injection from the contacts.
Before we discretize anything, it helps to solve one case by hand.
Take the potential constant at $V_0$ and drop the self-energy.
What is left can be integrated on paper,
$
  (E + planck^2 / (2 m^*) (dif^2) / (dif x^2) - V_0) G(x, x')
    = delta(x - x').
$ <G-1D>
This is not a device, since a device has no constant potential.
We do it to see what a Green's function looks like.

Away from the point $x'$ the right hand side is zero.
There @G-1D is just the Schrödinger equation in a flat region, and we know its
solutions.
They are the plane waves $e^(plus.minus i k x)$ of the second chapter, with
$
  k = sqrt(2 m^* (E - V_0)) / planck.
$
Two conditions tell us which combination of them to take.
First, the delta function depends only on the difference $x - x'$, so $G$ does
too.
Second, the solution to the left of $x'$ and the solution to the right of it
must be different.
If they were the same function, that function would solve the equation without
the delta, and it would not know about the source at all.
#key[So we take one plane wave on each side,]
$
  G(x, x') = cases(
    A^+ e^(i k (x - x')) & quad x > x',
    A^- e^(-i k (x - x')) & quad x < x'.
  )
$ <G-ansatz>

Now we fix the two amplitudes.
Integrate @G-1D across the spike, from $x' - delta$ to $x' + delta$, and let
$delta arrow.r 0$.
Take the terms one by one.
The Green's function itself is continuous, since a jump in $G$ would make its
second derivative worse than a delta function.
So the term $(E - V_0) G$ integrates to zero over an interval of vanishing
width, and continuity alone gives $A^+ = A^-$.
The second derivative integrates to the jump of the first derivative.
The delta function on the right integrates to one.
What is left is
$
  (dif G) / (dif x) |_(x' + delta) - (dif G) / (dif x) |_(x' - delta)
    = (2 m^*) / planck^2.
$ <G-jump>
#key[The Green's function is continuous at the source, but its derivative jumps
there.
The size of that jump is what fixes the amplitude.]
Putting the ansatz @G-ansatz into @G-jump gives
$2 i k A = 2 m^* slash planck^2$, so that
$
  A^+ = A^- = - i m^* / (k planck^2) = - i / (planck v),
$
where the last form uses the band velocity $planck v = planck^2 k slash m^*$ of
the previous chapter.
So the response to a point source is inversely proportional to the speed at
which the response runs away from the source.
The same weighting by a velocity appeared in the density of states
@g-velocity.

=== Retarded and advanced Green's functions

#exam("L5.11")
We can now write both branches of @G-ansatz as one formula.
An absolute value in the exponent reproduces the sign on either side,
$
  G^R (x, x') = - i / (planck v) e^(i k abs(x - x')),
$ <retarded>
and this is called the #term("retarded Green's function").
There is a second solution.
Swap the two exponentials in the ansatz @G-ansatz.
This satisfies the same jump condition @G-jump with the opposite sign of the
amplitude, and gives
$
  G^A (x, x') = + i / (planck v) e^(-i k abs(x - x')),
$ <advanced>
the #term("advanced Green's function").
It is the conjugate transpose of the retarded one,
$G^A (x, x') = G^R (x', x)^*$.

#key[Both functions solve the defining equation @G-1D, because they differ by a
solution of the equation without the source.
So the equation alone does not tell us which one to take, and we need an extra
condition.]#note[
  Luisier presented the assignment of the two exponentials to the two sides as
  an arbitrary choice, the only requirement being that the two sides differ.
  It is arbitrary as far as @G-1D is concerned, which is why the outgoing
  condition has to be supplied from outside it.
]
The extra condition is that the waves must travel away from the source.
To see which one does, put the time dependence $e^(- i E t slash planck)$ back
in.
The retarded solution @retarded then has phase fronts
$k abs(x - x') - E t slash planck$ that move outward.
A disturbance at $x'$ spreads from there, and it never arrives before it
happened.
The advanced solution @advanced has fronts that run inward and converge on
$x'$, which is the time reverse of that.
We want the retarded one.

There is a shorter way to make the same choice.
Give the energy a small imaginary part,
$
  G^R = lim_(eta arrow.r 0^+) (E + i eta - H)^(-1),
  quad
  G^A = lim_(eta arrow.r 0^+) (E - i eta - H)^(-1).
$ <ieta>
#key[A positive imaginary part of $E$ gives $k$ a positive imaginary part too.
Then $e^(i k abs(x - x'))$ decays at large distance and $e^(-i k abs(x - x'))$
blows up.
So the retarded solution is the only one that stays finite.]
It is then also the only one that is analytic in the upper half of the complex
energy plane.
By Fourier that is the statement that a response comes after its cause.
Outgoing in space, causal in time, analytic above the real axis: these are three
ways of saying the same thing.

We have already made this choice once, in the third chapter.
The contact self-energy $Sigma_(1 1) = - t_L e^(i k_L Delta x)$ was derived by
keeping the wave that leaves the device and throwing away the one that arrives.
So it is the retarded self-energy, and from here on we write it
$Sigma^R$.#note[
  The third and fourth chapters wrote $Sigma$ without a superscript, there being
  only one self-energy in them, as the lectures also do.
]
Its imaginary part is negative, which says the same thing as the $+ i eta$ in
@ieta.

=== Discrete Green's function

#exam("L5.8", "L6.2")
Back to the discretized device.
Our open system @OBC and the definition @GF of a Green's function differ in one
place only.
The source of the Green's function is a spike at one grid point, and we want
that for every grid point in turn.
The discrete version of $delta(x - x')$ is therefore the identity matrix.
#key[The retarded Green's function of a discretized device is the inverse of the
matrix that the wave function formalism applies to $phi$,]
$
  (E - H - Sigma^R) G^R = I,
  quad
  G^R = (E - H - Sigma^R)^(-1),
$ <retarded-matrix>
which is a full $N times N$ matrix at every energy.
The advanced Green's function is $G^A = (G^R)^dagger$.

The two formalisms use the same matrix in two ways.
Solving $(E - H - Sigma^R) phi = S$ for $phi$ and multiplying the inverse onto
$S$ give the same wave function,
$
  phi = G^R S,
$ <wf-from-GF>
and this is the reconstruction @GF-solution with the integral over $x'$ replaced
by a matrix-vector product.
Read the entries of $G^R$ like this.
The entry $G^R_(i j)$ is the amplitude at grid point $i$ of the response to a
unit source at grid point $j$.
So one column of $G^R$ is one wave function, and the full matrix holds the
response to every possible source at once.
#key[Our injection vector $S$ has only one nonzero entry per contact.
So only the first and the last column of $G^R$ are ever used, and computing the
other $N - 2$ columns is wasted work.]

=== Wave function squared

#exam("L6.3")
Look back at the previous chapter.
Every observable there was built from $abs(phi_i)^2$, never from $phi_i$ alone.
#key[The outer product of the wave function with itself is a matrix whose
diagonal holds these squared magnitudes,]
$
  phi phi^dagger = G^R S S^dagger (G^R)^dagger = G^R S S^dagger G^A,
$ <wf-square>
where the second step used @wf-from-GF, so no wave function is left in the
expression.
The diagonal entry $i$ is $abs(phi_i)^2$.
The off-diagonal entries $phi_i phi_j^*$ are not needed for a density.
We keep them anyway, and they are what the correlation reading of a Green's
function refers to.

Two things in @wf-square still do not belong to the new formalism.
One is the injection vector $S$, which is a wave function quantity.
The other is the band derivative $dif E slash dif k_c$, which the density of
states @g-obc needs.
The rest of this chapter gets rid of both.

=== Lesser Green's function and lesser self-energy

#exam("L6.1", "L6.4", "L6.5")
Put the wave function squared @wf-square into the density of states @g-obc, and
that into the carrier density @n-obc.
Set the injection amplitudes to $a_c = 1$.
The result is
$
  n(x_i) = integral (dif E) / (2 pi) thin
    "diag" {G^R (E) [sum_c S^c S^(c dagger)
      abs((dif E) / (dif k_c))^(-1) F(E, E_F^c)] G^A (E)}_i.
$
Everything that belongs to the contacts now sits inside the bracket, and
everything that belongs to the device sits outside it.
The bracket gets a name of its own.
#key[The #term("lesser self-energy") describes what the contacts inject.
The #term("lesser Green's function") describes what the device does with it,]
$
  Sigma^(<) (E) = i sum_c S^c S^(c dagger)
    abs((dif E) / (dif k_c))^(-1) F(E, E_F^c) Delta x,
$ <lesser-SE>
$
  G^(<) (E) = G^R (E) Sigma^(<) (E) G^A (E),
$ <lesser-GF>
and with them the carrier density is
$
  n(x_i) = - i / (Delta x) integral (dif E) / (2 pi)
    thin "diag" {G^(<) (E)}_i.
$ <n-lesser>

The definition @lesser-SE contains two extra factors that were not in the line
above it.
They cancel again in @n-lesser, so they are conventions and change nothing.
The factor $Delta x$ turns a quantity defined per grid point into one per unit
length.
A density is a quantity per unit length.
The factor $i$ makes $Sigma^(<)$ and therefore $G^(<)$ anti-Hermitian, so that
the diagonal entries of $G^(<)$ are purely imaginary and the density @n-lesser
comes out real.

#key[The lesser Green's function is the object that holds the occupation.
$G^R$ says which states exist and where they reach.
$G^(<)$ says how many electrons are in them.]
That is why a non-equilibrium calculation needs both.
The diagonal of $G^(<)$ is the density, and its off-diagonal entries are the
correlation between two points.
The difference between equilibrium and non-equilibrium sits entirely in the
Fermi integrals inside $Sigma^(<)$.

Next, the shape of $Sigma^(<)$.
Each injection vector $S^c$ has a single nonzero entry, at the first grid point
for the left contact and at the last one for the right contact.
So each outer product $S^c S^(c dagger)$ has a single nonzero entry on the
diagonal, and $Sigma^(<)$ has two of them, $Sigma^(<)_(1 1)$ and
$Sigma^(<)_(N N)$.
It has the same sparsity as $Sigma^R$.
To evaluate them, take the injection term
$S_(c c) = - t_c (1 - e^(2 i k_c Delta x))$ and the discrete band
@discrete-band of the third chapter,
$
  abs(S_(c c))^2 = 4 t_c^2 sin^2 (k_c Delta x),
  quad
  (dif E) / (dif k_c) = 2 t_c Delta x sin(k_c Delta x),
$
and put them into @lesser-SE.
The two surviving entries are
$
  Sigma^(<)_(c c) (E) = 2 i t_c sin(k_c Delta x) thin F(E, E_F^c).
$ <lesser-contact>

=== Broadening

#exam("L6.4")
The factor $2 t_c sin(k_c Delta x)$ in @lesser-contact has a name, and it can be
defined without ever mentioning the injection.
#key[The #term("broadening") is twice the negative imaginary part of the
retarded self-energy,]
$
  Gamma = i (Sigma^R - Sigma^A) = - 2 "Im" Sigma^R,
$ <broadening>
where we used $Sigma^A = (Sigma^R)^dagger$.
It has the same sparsity as $Sigma^R$, so one nonzero entry per contact,
$
  Gamma_(c c) (E) = 2 t_c sin(k_c Delta x) = (planck v_c (E)) / (Delta x),
$ <broadening-contact>
The second form uses the band velocity @g-velocity of the previous chapter.
There the velocity appeared as the Jacobian of the contact band, and here the
same quantity is the rate at which the contact drains the boundary point.

Now compare @lesser-contact with @broadening-contact.
The two expressions are the same, so
$
  Sigma^(<)_(c c) (E) = i Gamma_(c c) (E) thin F(E, E_F^c).
$ <lesser-broadening>
This is exact and not a guess.
The injection term equals the broadening, $abs(S_(c c)) = Gamma_(c c)$, and the
band derivative is $dif E slash dif k_c = planck v_c = Gamma_(c c) Delta x$.
Put both into @lesser-SE and it collapses to
$i Gamma_(c c)^2 F slash Gamma_(c c)$.#note[
  Luisier obtained @lesser-broadening by comparing the two expressions and
  called the step empirical, saying a derivation exists but is beyond the
  lecture. The comparison is exact for the contact self-energies derived in the
  third chapter, since both sides are the same function of $t_c$ and
  $k_c Delta x$.
]
So both quantities we wanted to get rid of, $S$ and $dif E slash dif k_c$, have
turned into $Gamma$, and $Gamma$ is built from $Sigma^R$ alone.

Why is $Gamma$ called a broadening?
#key[Connecting a level to a contact gives the electron a chance to escape, so
the state has a finite lifetime.
A state that does not last forever does not have a sharp energy.]
Here is the same statement in formulas.
A device that is closed at both ends has discrete eigenvalues, so its spectrum
at a resonance is a delta function at $E_0$.
Opening it replaces $E - H$ by $E - H - Sigma^R$.
This moves the pole off the real axis to $E_0 - i Gamma slash 2$, and near it
the retarded Green's function behaves as $(E - E_0 + i Gamma slash 2)^(-1)$.

Two things follow from the displaced pole.
In energy, the delta peak becomes a Lorentzian whose full width at half maximum
is $Gamma$.
That is the broadened resonance that the third exercise found as a peak in the
transmission.
In time, the factor $e^(- i E_0 t slash planck - Gamma t slash 2 planck)$
decays, so the probability of still finding the electron in the device falls as
$e^(- Gamma t slash planck)$, and the lifetime is
$
  tau = planck / Gamma.
$
Energy and time are conjugate variables, so a state with lifetime $tau$ has an
energy uncertain by $planck slash tau$.
The two statements are one fact.

The velocity form @broadening-contact tells us what the lifetime is in our case.
An electron at the boundary point moves into the contact with velocity $v_c$ and
leaves the cell of width $Delta x$ after a time $Delta x slash v_c$.
That time is exactly $planck slash Gamma_(c c)$.
#key[So $Gamma$ is an escape rate written in units of energy.
At the bottom of the contact band the velocity is zero, so a state there is long
lived and sharp.
In the middle of the band the velocity is largest, so a state there is short
lived and broad.]
The imaginary part of the self-energy of the third chapter,
$- t_c sin(k_c Delta x)$, is $- Gamma_(c c) slash 2$, so it was this quantity
all along.

=== Density of states in the Green's function formalism

#exam("L6.5")
The broadening matrix splits into one part per contact,
$Gamma = Gamma^L + Gamma^R$, where $Gamma^c$ holds the entry of contact $c$ and
zeros everywhere else.
The lesser self-energy @lesser-broadening splits the same way,
$
  Sigma^(<) (E) = i sum_c Gamma^c (E) thin F(E, E_F^c).
$ <lesser-split>
The split is possible because each contact occupies its own entry.
We need it because the previous chapter showed that the two contacts have to be
kept apart out of equilibrium.

Put @lesser-split into the carrier density @n-lesser.
This gives back the form of the previous chapter,
$
  n(x) = integral dif E thin sum_c g^c (E, x) thin F(E, E_F^c),
  quad
  g^c (E, x_i) = 1 / (2 pi Delta x)
    "diag" {G^R (E) Gamma^c (E) G^A (E)}_i.
$ <g-GF>
#key[This is the density of states @g-obc written with Green's functions and the
broadening only, with no wave function, no injection vector and no band
derivative left in it.]
Everything the previous chapter built on top of the density of states works
unchanged.
The formula also reads nicely from left to right: $Gamma^c$ injects at the
contact, $G^R$ propagates from there to the point $x_i$, $G^A$ propagates back,
and the product is the weight that this contact puts on that point at that
energy.

We should check that the name is justified.
Invert the definitions to get $G^R - G^A = G^R (Sigma^R - Sigma^A) G^A$, so that
$
  i (G^R - G^A) = G^R Gamma G^A,
$
and the diagonal of this, divided by $2 pi Delta x$, is $sum_c g^c$.
The left hand side is called the #term("spectral function"), and it is the local
density of states of the open device.
It does not mention the contacts at all.
The right hand side splits the same quantity into contributions of the
contacts.
#key[Summing @g-GF over the contacts gives a quantity that no longer knows which
contact anything came from.
So the split by contact is bookkeeping for the occupation.
The states themselves are not divided between the two contacts.]

=== Solution procedure

The whole calculation at one energy is short, and every step uses a formula we
have already derived.
The wave function solver of the third chapter is replaced module by module, and
it delivers the same quantities:

+ Solve the contact dispersion @contact-dispersion for $k_L$ and $k_R$ at the
  energy $E$.
+ Form the two self-energies $Sigma^R_(c c) = - t_c e^(i k_c Delta x)$ and
  assemble $Sigma^R$.
+ Form $Gamma_(c c) = i (Sigma^R_(c c) - Sigma^(R *)_(c c))$ with @broadening,
  and place the entries in $Gamma^L$ and $Gamma^R$.
+ Invert to get $G^R = (E - H - Sigma^R)^(-1)$ by @retarded-matrix, and take
  $G^A = (G^R)^dagger$.
+ Evaluate the two densities of states @g-GF.

The energy integral for the carrier density @n-obc, the Fermi integrals and the
current @LB are the same as before.#note[
  Luisier said what he expects to be remembered of this: the retarded
  self-energy $Sigma^R_(c c) = - t_c e^(i k_c Delta x)$, from which $Gamma$ and
  $Sigma^(<)$ follow. The expression for the injection term $S$, which the wave
  function formalism had to carry, is not needed at all.
]

One step in this list is expensive.
#key[The inversion costs more than everything the wave function formalism did,
because it produces $N^2$ entries where a tridiagonal solve produced $N$.
And most of those entries are never looked at.]
The density of states @g-GF uses the diagonal of $G^R Gamma^c G^A$, and
$Gamma^c$ has a single nonzero entry, so we only ever read one column of $G^R$
per contact.
Computing the rest is the price we pay for writing the formalism as an inverse.
The next chapter gets that price back.

== Outlook

The formalism is not finished yet.
The electron density has a Green's function expression, but the current does
not, since the transmission is still computed from wave function amplitudes.
The hole density needs its own object, a counterpart of $G^(<)$ that counts
empty states instead of occupied ones.
The next chapter supplies both, collects the identities that relate all the
Green's functions to each other, and replaces the full inversion by a recursion
that computes only the entries we actually read.
