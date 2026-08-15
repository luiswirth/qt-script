#import "setup.typ": *
#show: chapter.with("Open boundary conditions")

The previous chapter closed the discretized Schrödinger equation by setting the
two points outside the domain to zero, and then diagonalizing what was left.
That describes a box.
A device is joined to contacts through which carriers enter and leave, so those
two points are not zero but unknown.
This chapter computes them.
What comes out is the same Hamiltonian with one entry added at each corner, and
a right-hand side where there was none.
The eigenvalue problem of the closed system becomes a linear system that we
solve once per energy.

We take a detour on the way.
A single rectangular barrier can be treated by hand, and doing so shows
injection, reflection and transmission in a setting where everything is
explicit.
The detour also shows why the technique does not generalize, and that is what
forces the numerical treatment in the rest of the chapter.

== Closed boundary conditions

#exam("L3.1")
The equation we solve is the heterostructure problem @qw-general, discretized as
in the previous chapter into
$
  (E - H_(i i)) phi_i - H_(i, i+1) phi_(i+1) - H_(i, i-1) phi_(i-1) = 0
$ <discrete-se>
at every grid point $i$, which is the row equation @row rearranged.
Each point is coupled to its two neighbors and to nothing else, and that
coupling is what the second derivative leaves behind.
Write the equation at the first point of a domain running from $i = 1$ to
$i = N$ and it reaches outside the domain,
$
  (E - H_(1 1)) phi_1 - H_(1 2) phi_2 - H_(1 0) phi_0 = 0,
$
since $phi_0$ is not one of our unknowns.
#key[#term("Closed boundary conditions") remove that term by declaring
$phi_0 = phi_(N+1) = 0$.
This confines the wave function to the domain, so nothing enters and nothing
leaves.]
This is the Dirichlet condition of the previous chapter, where we imposed it
without naming it, and it is what makes $H$ a square matrix of size $N$ whose
eigenvalues are the bound states.

These are the right conditions whenever the states we want are bound.
In a quantum well, in a bandstructure, or in the subbands of a confined channel,
the wave function decays on its own before it reaches the boundary, so forcing
it to vanish there changes nothing.

#key[The condition is harmless only where the state has already decayed, and
whether it has is a property of the state, not of the domain.]
Slide 8 shows the failure next to the success.
A #qty(5, $"nm"$) well with finite barriers is solved on a domain of
#qty(45, $"nm"$).
Its ground state has died away long before the edge, so $phi(0) = 0$ costs
nothing.
Its second state has not died away.
That state is pushed to zero at the edge because the boundary demands it and not
because the physics does, so its energy depends on where we cut the domain.
The remedy is to widen the domain until the state decays without help, which is
a convergence test rather than a formula.#note[
  Luisier presented this as a question to the audience and treated the answer as
  the lesson of the slide: a numerical solution has to be checked against the
  boundary it was computed under.
]
Sometimes the physical structure puts a neighbor within that distance, a second
well nearby for instance.
Then we cannot widen the domain at will, and the closed description is simply
the wrong one.

== Transport

#exam("L3.3")
Now we send carriers in.
A wave that comes in from the left is partly reflected back to where it came
from and partly transmitted to the far side, and both the incoming and the
outgoing parts live outside the domain.
#key[Nothing forces $phi$ to vanish at either edge.
So here the closed conditions are not just inaccurate, they contradict what we
are describing.]
An incident wave that vanished at the boundary would never have entered.

#term("Quantum transport") is this situation: carriers are injected into a
domain small enough that we must describe them as waves, they are reflected and
transmitted, and a current comes out.
Transport needs a driving force, a voltage or a temperature difference, and what
we compute in the end is the current that force produces.
The system is open, in the sense that it exchanges carriers with its
surroundings.
It is out of equilibrium, in the sense that the two sides are held at different
potentials.

#key[So our task is to find expressions for $phi_0$ and $phi_(N+1)$ instead of
declaring them zero.
These expressions are the #term("open boundary conditions").]
They cannot be free unknowns.
Writing the discretized equation @discrete-se at $i = 0$ introduces $phi_(-1)$,
writing it at $i = -1$ introduces $phi_(-2)$, and the hierarchy runs to
$-infinity$.
We need an expression that closes it.

== Transmission through a potential barrier

Before the general construction, we do one case in closed form.
The structure is the inverse of the quantum well of the previous chapter, a
layer of the wider-gap material between two layers of the narrower one.
The conduction band then carries a #term("potential barrier") instead of a well.

=== Ansatz in each region

#exam("L3.4")
The barrier occupies $0 <= x <= L$ and has height $Delta V$,
$
  V(x) = cases(
    0 &quad x < 0,
    Delta V &quad 0 <= x <= L,
    0 &quad x > L,
  ),
$
and we treat the three regions separately and join them afterwards.
#key[In each region the potential is constant, so we know the solution there in
closed form.
The whole method rests on that and on nothing else.]
Where $E$ is above the local potential the solution oscillates, and where $E$ is
below it the solution decays.
A carrier injected from the left with $E < Delta V$ meets one of each,
$
  phi(x) = cases(
    a_L e^(i k_L x) + b_L e^(-i k_L x) &quad x < 0,
    a_C e^(-kappa_C x) + b_C e^(kappa_C x) &quad 0 <= x <= L,
    b_R e^(i k_R (x - L)) &quad x > L,
  ),
$ <barrier-ansatz>
with the wave vectors fixed by the dispersion in each region,
$
  k_L = sqrt(2 m_L^* E) / planck,
  quad
  kappa_C = sqrt(2 m_C^* (Delta V - E)) / planck,
  quad
  k_R = sqrt(2 m_R^* E) / planck.
$
The decay constant $kappa_C$ is @kappa of the previous chapter, which we met
there in a well and meet here in a barrier.
Under the barrier the wave vector is imaginary, $k_C = i kappa_C$, and that is
the whole difference between the two cases.

Each term is a direction of travel.
On the left $a_L$ is the injected wave and $b_L$ is the reflected one.
In the barrier $a_C$ decays to the right and $b_C$ decays to the left.
On the right $b_R$ leaves.
#key[There is no term coming in from the right, and that absence is what says we
inject from the left alone.]
Nothing forbids us from adding one, and the calculation would then describe a
different experiment.

=== Interface conditions

#exam("L3.6")
The ansatz carries five unknowns, and each interface supplies two conditions,
which is four in total.
At an interface the wave function is continuous,
$
  phi(x^-) = phi(x^+),
$
so that the probability density does not jump.
The current is continuous too, which in the effective mass approximation reads
$
  [1 / m^* (dif phi) / (dif x)]_(x^-) = [1 / m^* (dif phi) / (dif x)]_(x^+).
$
#key[What is continuous is the derivative divided by the mass, not the
derivative itself.
This is the condition the BenDaniel-Duke operator @BDD was built to satisfy, and
it is why the mass sits between the two derivatives there.]
We have now met the same statement twice, once as a matching rule for analytic
solutions and once as an operator ordering for a discretization.

At the left interface the two conditions give
$
  a_L + b_L = a_C + b_C,
  quad
  (i k_L) / m_L^* (a_L - b_L) = kappa_C / m_C^* (b_C - a_C),
$
and the right interface gives two more of the same kind, coupling $a_C$, $b_C$
and $b_R$.

Four equations do not determine five unknowns, and they do not have to.
#key[The injection amplitude $a_L$ is not an unknown but a choice, since it says
how hard we drive the wave at the boundary.
Every other amplitude comes out proportional to it.]
Setting $abs(a_L)^2 = 1$ normalizes to unit injected probability, and the
transmission is a ratio, so it does not depend on the choice at all.

=== Transmission probability

The quantity we want is the probability that a carrier injected from the left
appears on the right,
$
  T_(L R) = abs(b_R)^2 / abs(a_L)^2,
$ <transmission>
which is the transmitted probability density over the injected one.
The reflected part of the left-hand wave is deliberately left out of the
denominator.
Here the two sides carry the same potential and the same mass, so the carrier
leaves with the speed it arrived with and we need no velocity factor.
Where the two sides differ, transmission means a ratio of currents rather than
of densities, and the transmission @transmission picks up a factor
$(k_R slash m_R^*) slash (k_L slash m_L^*)$.

Solving the four equations for $b_R$ in terms of $a_L$ is elimination and
nothing more.#note[
  Slide 16 gives the result as $b_R = 1 slash F$ with $F$ assembled from four
  terms $F_1$ to $F_4$. Luisier introduced them as a device for fitting the
  expression onto one slide and said they carry no physical meaning.
]
#key[What is worth keeping is the method rather than the expression: one ansatz
per region, two conditions per interface, and everything referred to the
injection amplitude.]
Along the way the energy has changed its role.
In the closed problem it was the output, an eigenvalue we had to find.
Here it is an input, chosen before the calculation starts, and we evaluate the
transmission @transmission by scanning it over a range of energies.

=== Transmission below and above the barrier

#exam("L3.5")
Slide 17 shows the outcome for a #qty(5, $"nm"$) barrier of height
#qty(0.3, $"eV"$), with $m_C^* = 0.1 m_0$ in the barrier and
$m^* = 0.065 m_0$ outside.
#key[Below the top of the barrier the transmission rises from zero roughly
exponentially and reaches about $0.1$ at the top.
This is tunneling, so it is the source-to-drain leakage of the first chapter,
now computed instead of asserted.]
The wave functions on the left of the same slide show what carries it.
There is a standing wave before the barrier, formed by the interference of the
incident and the reflected part, an exponential decay inside the barrier, and a
small surviving oscillation beyond it whose amplitude is the transmission.

Above the barrier the transmission does not simply saturate.#note[
  Slide 19 carries only its title, this being one of the passages Luisier
  developed on the board after putting the question to the audience.
]
#key[It rises to exactly one at a discrete set of energies and dips between
them.
The reason is that for $E > Delta V$ the barrier region carries a real wave
vector, so the waves reflected from its two faces interfere.]
Write $k_C = sqrt(2 m_C^* (E - Delta V)) slash planck$ for that wave vector.
The round trip is in phase when the barrier holds a whole number of half
wavelengths,
$
  L = n lambda / 2,
  quad
  k_C L = n pi,
  quad n = 1, 2, 3, ...,
$
and then the interference is fully constructive.
The energies at which this happens are
$
  E_n = Delta V + planck^2 / (2 m_C^*) ((n pi) / L)^2,
$
which is the infinite-well ladder @infinite-well-solution of the previous
chapter, measured from the top of the barrier instead of from the bottom of a
well.
So a barrier is perfectly transparent at exactly those energies at which the
region above it would hold a standing wave.
The two faces then sit at nodes, and the carrier does not see the barrier at
all.
For our example the first of these energies is
$E_1 approx #qty(0.45, $"eV"$)$.
Between two resonances the interference is least favorable and the transmission
dips.
The minima climb toward one as the energy grows, so the barrier becomes
transparent on average and the oscillations fade.

=== Scope of the analytical solution

#exam("L3.7")
#key[The construction needs a potential that is piecewise constant.
That is what makes the solution in each piece a plane wave or an exponential
with a known wave vector, and without it we have nothing to glue.]
Slide 20 puts the case that breaks it, which is the same barrier with a voltage
applied across it.
The potential is then a ramp everywhere and the flat regions are gone.
A linear ramp does still have closed-form solutions, in Airy functions instead
of exponentials.
But an arbitrary $V(x)$ has none, and a device potential is whatever Poisson's
equation returns.
So the barrier calculation is an illustration and not a method.

One idea does survive the failure, and that is injecting from a region where we
know the solution.
The rest of the chapter keeps that idea and gives up on knowing the solution
inside the device.

== Contacts

=== Semi-infinite reservoirs

#exam("L3.2", "L3.8")
#key[We extend the device on each side by a semi-infinite region of constant
potential, called a #term("contact") or #term("reservoir") or #term("lead").
Its potential is the potential at the adjacent end of the device.]
The device between $x = 0$ and $x = L$ is left as it is, an arbitrary $V(x)$ on
an arbitrary grid, and we make no attempt to solve it in closed form.
Slides 22 and 23 show the arrangement.
This is what a system with open boundary conditions looks like: a black box with
a flat-band region attached at either end.

The flatness is what we are after.
It makes the contact a region where we know the solution of the Schrödinger
equation, exactly as the outer regions of the barrier were, so we can manipulate
the amplitudes there by hand.
Contacts are not a physical addition to the device.
They are the part of the problem that we have made solvable, so that we do not
have to solve the rest.

A real device also has flat bands at its ends, since the heavily doped source
and drain are charge neutral and therefore field free.
The next chapter obtains that flatness from Poisson's equation instead of
assuming it.
We take the grid inside a contact to be uniform with spacing $Delta x$, since
there is no structure there to resolve, while the device grid stays arbitrary.

=== Plane-wave ansatz

#exam("L3.9")
A contact is flat, so it carries plane waves,
$
  phi_l (x) &= a_L e^(i k_L x) + b_L e^(-i k_L x), \
  phi_r (x) &= a_R e^(-i k_R (x - L)) + b_R e^(i k_R (x - L)),
$ <contact-ansatz>
written so that we measure the right contact from $x = L$ and so that each
amplitude means the same thing on both sides.
#key[The terms carrying $a_L$ and $a_R$ travel toward the device and are
injected into it.
The terms carrying $b_L$ and $b_R$ travel away from it and leave, whether by
reflection or by transmission.]
What distinguishes them is direction and not position.
On the left the incoming wave moves to the right, and on the right it moves to
the left, which is why the sign in the exponent flips between the two lines of
the contact ansatz @contact-ansatz.

This is the barrier ansatz @barrier-ansatz with the middle region replaced by
something unknown.
What was solvable in three pieces is now solvable in two, and we hand the piece
between them to a computer.

=== Two injection problems

#exam("L3.12")
We do not solve for the two injected amplitudes together.
#key[We split the problem into one calculation per contact, first $a_L = 1$ with
$a_R = 0$ and then $a_R = 1$ with $a_L = 0$, and each one produces a wave
function of its own.]
Injecting from the left gives a state that is partly reflected back to the left
and partly transmitted to the right, and injecting from the right gives the
mirror situation.
Slide 25 draws both.

The reason for keeping them apart is physical.
The two contacts are separate reservoirs, and under an applied bias they sit at
different Fermi levels.
So a state arriving from the left and a state arriving from the right are
occupied with different probabilities.
Adding them before we know those weights would destroy exactly the information
that a non-equilibrium calculation needs.
The next chapter supplies the weights.

== Coupling the contacts to the device

#exam("L3.10")
We have described the contacts and discretized the device, and what is left is
to join them.
The join is where we cut the infinite hierarchy.
A contact holds infinitely many unknown values, but it does not hold infinitely
much information.
It is uniform, so it carries plane waves, and every value in it follows from the
two amplitudes of the contact ansatz @contact-ansatz once we know the wave
vector.
Of those three quantities we choose $a_L$, and two rows of the discretized
equation @discrete-se are enough to dispose of the other two.
A third row then receives the result.#note[
  Luisier named the answer he most often gets and does not want, that the
  contacts are joined by imposing continuity of the wave function and of the
  current. Those hold, but they are contained in the discretization, which is
  one difference equation on one grid with no interface in it, and they connect
  nothing to a contact.
]

#key[The discretized equation @discrete-se holds everywhere, inside the device
and inside the contacts alike.
So we treat the contacts as discretized too, even though we know their
solution.]
Two abbreviations shorten what follows,
$
  D_i = E - H_(i i), quad T_(i, i plus.minus 1) = - H_(i, i plus.minus 1),
$
so that the discretized equation @discrete-se reads
$D_i phi_i + T_(i, i+1) phi_(i+1) + T_(i, i-1) phi_(i-1) = 0$.
Inside the left contact the material and the potential do not vary and the grid
is uniform, so both quantities are constant there, and by the hopping energy
@hopping,
$
  T_L = t_L = planck^2 / (2 m_L^* Delta x^2),
  quad
  D_L = E - V_L - 2 t_L.
$ <contact-entries>
We assume the first device point carries the same material as the contact, so
$D_L$ serves for $i = 1, 0, -1$ alike.

=== Equations outside the domain

Write the discretized equation @discrete-se at the first point inside the device
and at the first two points outside it,
$
  i = 1 &: quad D_1 phi_1 + T_(1 2) phi_2 + T_L phi_0 = 0, \
  i = 0 &: quad D_L phi_0 + T_L phi_1 + T_L phi_(-1) = 0, \
  i = -1 &: quad D_L phi_(-1) + T_L phi_0 + T_L phi_(-2) = 0,
$ <three-rows>
and sample the ansatz @contact-ansatz at the three points outside, which sit at
$x = 0$, $-Delta x$ and $-2 Delta x$,
$
  phi_0 &= a_L + b_L, \
  phi_(-1) &= a_L e^(-i k_L Delta x) + b_L e^(i k_L Delta x), \
  phi_(-2) &= a_L e^(-2 i k_L Delta x) + b_L e^(2 i k_L Delta x).
$ <sampled-ansatz>
We have traded three unknown wave function values for the three unknowns $a_L$,
$b_L$ and $k_L$, which is no gain until we dispose of each one.
#key[The row at $i = -1$ is the first whose three points all lie in the uniform
region, so it is the generic contact row, and every row below it is the same row
shifted.
The device enters only through $phi_1$, which appears at $i = 1$ and $i = 0$ and
nowhere below.]

=== Contact dispersion

Substitute the sampled ansatz @sampled-ansatz into the $i = -1$ row of
@three-rows and collect the factors of $a_L$ and $b_L$,
$
  a_L e^(-i k_L Delta x) (D_L + 2 T_L cos(k_L Delta x))
  + b_L e^(i k_L Delta x) (D_L + 2 T_L cos(k_L Delta x)) = 0.
$
The same bracket multiplies both amplitudes, so the row is a single product,
$
  phi_(-1) (D_L + 2 T_L cos(k_L Delta x)) = 0.
$ <dispersion-row>
The first factor is not zero in general.#note[
  The lectures reach the same conclusion by writing the two brackets separately
  and arguing that each must vanish, since a relation between $a_L$ and $b_L$
  involving contact quantities alone would fix the reflection without reference
  to the device. The factorization says it in one step.
]
#key[The second factor is the condition that a plane wave of wave vector $k_L$
satisfies the difference equation in the contact at all.
Imposing it makes every row below the domain hold identically, and that is what
terminates the hierarchy.]
It is the #term("discrete dispersion relation"), and solving it for the wave
vector gives
$
  k_L = 1 / (Delta x) arccos(- D_L / (2 T_L)),
$ <contact-dispersion>
or, written as an energy through the contact entries @contact-entries,
$
  E = V_L + 4 t_L sin^2 ((k_L Delta x) / 2).
$ <discrete-band>
For $k_L Delta x << 1$ this is $E = V_L + planck^2 k_L^2 slash 2 m_L^*$, the
parabolic band that the effective mass approximation was built to reproduce.
#key[Away from the band bottom the grid asserts itself.
The discrete band @discrete-band is periodic in $k_L$ and bounded above by
$V_L + 4 t_L$, so the discretization has replaced the parabola by a band of
finite width, with a Brillouin zone set by the grid spacing rather than by a
lattice constant.]
We recover the parabola as $Delta x arrow.r 0$, which sends the bandwidth to
infinity.
A carrier can only be injected at an energy inside that band.
Outside it the arccosine of the dispersion relation @contact-dispersion has no
real value, $k_L$ is imaginary, and the contact carries an evanescent solution
that transports nothing.

=== Reflection amplitude

The $i = 0$ row is where the device is first felt.
Substitute the sampled ansatz @sampled-ansatz into it and use the dispersion
condition @dispersion-row in the form
$D_L + T_L e^(minus i k_L Delta x) = - T_L e^(plus i k_L Delta x)$.
The row reduces to
$
  phi_1 = a_L e^(i k_L Delta x) + b_L e^(-i k_L Delta x),
$
which is the contact ansatz @contact-ansatz evaluated at $x = Delta x$.
#key[The $i = 0$ equation says that the contact ansatz, continued one point into
the device, has to agree with the device solution there.
That is the entire content of the coupling.]
Solve it for the reflected amplitude,
$
  b_L = phi_1 e^(i k_L Delta x) - a_L e^(2 i k_L Delta x).
$ <reflection>
The reflection is now expressed through the injection, which we choose, and
through $phi_1$, which the device determines.
Unlike the relation the $i = -1$ row would have given us, this one knows what it
is reflecting from.

=== Self-energy and injection

Put the reflected amplitude @reflection into $phi_0 = a_L + b_L$ and we get the
boundary relation itself,
$
  phi_0 = e^(i k_L Delta x) phi_1 + a_L (1 - e^(2 i k_L Delta x)),
$ <boundary-relation>
whose two terms carry the two roles.
With $a_L = 0$ the contact holds only the outgoing wave.
The relation then says that stepping one point in the direction that wave
travels multiplies it by $e^(i k_L Delta x)$, which says that nothing comes
back.
The remaining term is there because we are sending a wave in.
Substitute the boundary relation @boundary-relation into the $i = 1$ row of
@three-rows and the system closes,
$
  (D_1 + T_L e^(i k_L Delta x)) phi_1 + T_(1 2) phi_2
    = - a_L T_L (1 - e^(2 i k_L Delta x)).
$
Nothing unknown is left.
$T_L$ is a material parameter, the wave vector comes from the dispersion
relation @contact-dispersion, and $a_L$ is our choice.
We name the two new quantities
$
  Sigma_(1 1) = - T_L e^(i k_L Delta x),
  quad
  S_(1 1) = - a_L T_L (1 - e^(2 i k_L Delta x)),
$
the #term("boundary self-energy") and the #term("injection term"), and the row
becomes $(E - H_(1 1) - Sigma_(1 1)) phi_1 + T_(1 2) phi_2 = S_(1 1)$.
The right contact is the same construction mirrored.
It contributes $Sigma_(N N) = - T_R e^(i k_R Delta x)$ and, when we inject from
the right, $S_(N N) = - a_R T_R (1 - e^(2 i k_R Delta x))$.

The two quantities arrive together but do different jobs.
#key[$Sigma$ modifies the operator and describes how well the contact absorbs
whatever reaches it.
$S$ is a source and describes what the contact sends in.
So a contact that is connected but empty contributes the first and not the
second.]

#key[$Sigma_(1 1)$ is complex for a propagating state, so $E - H - Sigma$ is not
Hermitian.
That is the mathematical signature of an open system: probability leaves the
domain, and an operator that conserved it could not describe that.]
Its imaginary part is $-T_L sin(k_L Delta x)$, which is nonzero exactly when
$k_L$ is real, and that is exactly when the contact has a propagating state at
that energy to carry probability away.
Where $k_L$ is imaginary the self-energy is real, the operator is Hermitian
again, and nothing is exchanged.

== Schrödinger equation with open boundary conditions

#exam("L3.11")
Assembling the rows gives the equation this chapter was written to reach,
$
  (E - H - Sigma) phi = S.
$ <OBC>
Here $E$ multiplies the identity, $H$ is the tridiagonal Hamiltonian of the
previous chapter with no entry altered, and $Sigma$ is a matrix of the same size
whose only nonzero entries are $Sigma_(1 1)$ and $Sigma_(N N)$.
#key[The contacts touch the problem in two entries of one matrix, one entry per
contact, and everything else is unchanged from the closed calculation.]

#key[Closed boundary conditions are the special case $Sigma = 0$ and $S = 0$.
The open system @OBC then collapses to $(E - H) phi = 0$, which has a nontrivial
solution only at the eigenvalues of $H$.]
That is the difference between the two, in one line.
An open system has a solution at every energy, and we supply the energy instead
of finding it.
A closed system has a solution only at its own energies, and those are what the
calculation delivers.
The problem has stopped being an eigenvalue problem and has become a linear
system of the form $A x = b$, which we solve once for each energy of interest.
Since $A$ is sparse and tridiagonal we factorize it rather than invert it.

=== Right-hand sides

#exam("L3.12", "L3.13")
The two injection problems share their matrix and differ only in their source,
so we solve them together,
$
  (E - H - Sigma) [phi^L, phi^R] = [S^L, S^R],
$
where $S^L$ carries $S_(1 1)$ in its first entry and zeros elsewhere, and $S^R$
carries $S_(N N)$ in its last entry.
The unknown is now $N times 2$.
Its first column is the wave function injected from the left, and its second
column is the wave function injected from the right.
One factorization serves both, since the left-hand side is common.

#key[The number of right-hand sides is the number of contacts, since each
contact is an independent way of populating the device at a given energy.
A structure with $n$ contacts has $n$ of them.]
So the open system @OBC has no single solution at a given energy.
It has one scattering state per injecting contact, and the physical state is a
superposition of them, weighted by how populated each contact is.
Those weights are the Fermi distributions of the reservoirs, which under bias
are not the same.
Supplying them is what turns a set of wave functions into a carrier density and
a current.

== Outlook

The construction we have just completed is the #term("wave function formalism"),
also called the #term("quantum transmitting boundary method").#note[
  Luisier described what he expects on this derivation: that the device is
  extended by flat semi-infinite contacts, that flatness is what makes the
  solution there analytic, and that the coupling proceeds by writing the rows at
  $i = 1$, $0$ and $-1$ and replacing $phi_0$, $phi_(-1)$ and $phi_(-2)$ by the
  ansatz, from which $k_L$, then $b_L$, then the open system @OBC follow,
  ending at the final form. He does not expect the algebra step by step.
]
It is one of the two formalisms of the course.
The other one is the non-equilibrium Green's function method, which solves the
same physical problem by computing the inverse of the same operator
$E - H - Sigma$ instead of its action on a source.

What the open system @OBC delivers is a wave function per contact and per
energy, and that is not yet an observable.
The next chapter weights those states by the occupation of the contact they came
from and integrates over energy.
This gives the carrier density in the device and the current through it, and the
transmission of this chapter reappears there as the quantity the current is an
integral of.
