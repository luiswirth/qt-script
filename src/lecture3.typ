#import "setup.typ": *
#show: chapter.with("Open boundary conditions")

The previous chapter closed the discretized Schrödinger equation by setting the
two points outside the domain to zero and diagonalizing what remained.
That describes a box.
A device is joined to contacts through which carriers enter and leave, and those
two points are then not zero but unknown.
This chapter computes them.
What comes out is the same Hamiltonian with one entry added at each corner and a
right-hand side where there was none, so that the eigenvalue problem of the
closed system becomes a linear system solved once per energy.

The route runs through a detour.
A single rectangular barrier can be treated by hand, and doing so exhibits
injection, reflection and transmission in a setting where everything is
explicit.
The detour also shows why the technique does not generalize, which is what
forces the numerical treatment that occupies the rest of the chapter.

== Closed boundary conditions

#exam("L3.1")
The equation being solved is the heterostructure problem @qw-general,
discretized as in the previous chapter into
$
  (E - H_(i i)) phi_i - H_(i, i+1) phi_(i+1) - H_(i, i-1) phi_(i-1) = 0
$ <discrete-se>
at every grid point $i$, which is the row equation @row rearranged.
Each point is coupled to its two neighbors and to nothing else, the coupling
being what the second derivative leaves behind.
Written at the first point of a domain running from $i = 1$ to $i = N$, the
equation reaches outside it,
$
  (E - H_(1 1)) phi_1 - H_(1 2) phi_2 - H_(1 0) phi_0 = 0,
$
and $phi_0$ is not among the unknowns.
#key[#term("Closed boundary conditions") remove the term by declaring
$phi_0 = phi_(N+1) = 0$, which confines the wave function to the domain: nothing
enters and nothing leaves.]
This is the Dirichlet condition of the previous chapter, where it was imposed
without being named, and it is what makes $H$ a square matrix of size $N$ whose
eigenvalues are the bound states.

They are the right conditions whenever the states sought are bound.
A quantum well, a bandstructure, the subbands of a confined channel: in each the
wave function decays on its own before the boundary is reached, and forcing it
to vanish there changes nothing.

#key[The condition is only harmless where the state has already decayed, and
whether it has is a property of the state and not of the domain.]
Slide 8 shows the failure beside the success.
A #qty(5, $"nm"$) well with finite barriers is solved on a domain of
#qty(45, $"nm"$), and its ground state has died away long before the edge, so
$phi(0) = 0$ costs nothing.
Its second state has not.
That state is pushed to zero at the edge because the boundary demands it, not
because the physics does, and its energy therefore depends on where the domain
was cut.
The remedy is to widen the domain until the state decays without help, which is
a convergence test and not a formula.#note[
  Luisier presented this as a question to the audience and treated the answer as
  the lesson of the slide: a numerical solution has to be checked against the
  boundary it was computed under.
]
Where the physical structure supplies a neighbor within that distance, a second
well nearby, the domain cannot be widened at will and the closed description is
simply the wrong one.

== Transport

#exam("L3.3")
Now let carriers be sent in.
A wave incident from the left is partly reflected back to where it came from and
partly transmitted to the far side, and both the incident and the outgoing parts
live outside the domain.
#key[Nothing forces $phi$ to vanish at either edge, so the closed conditions are
not merely inaccurate here but inconsistent with what is being described.]
An incident wave that vanished at the boundary would never have entered.

#term("Quantum transport") is this situation: carriers injected into a domain
small enough that they must be described as waves, reflected and transmitted,
with a current as the result.
Transport requires a driving force, a voltage or a temperature difference, and
what is computed in the end is the current that force produces.
The system is open in the sense that it exchanges carriers with its
surroundings, and it is out of equilibrium in the sense that the two sides are
held at different potentials.

#key[The task is therefore to find expressions for $phi_0$ and $phi_(N+1)$ rather
than to declare them zero, and these are the #term("open boundary conditions").]
They cannot be free unknowns.
Writing the discretized equation @discrete-se at $i = 0$ introduces $phi_(-1)$,
writing it at $i = -1$
introduces $phi_(-2)$, and the hierarchy runs to $-infinity$.
What is wanted is an expression that closes it.

== Transmission through a potential barrier

Before the general construction, one case that can be done in closed form.
The structure is the inverse of the quantum well of the previous chapter, a
layer of the wider-gap material between two of the narrower, so that the
conduction band carries a #term("potential barrier") rather than a well.

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
and the three regions are treated separately and joined afterwards.
#key[In each region the potential is constant, so the solution there is known in
closed form, and the whole method rests on that and on nothing else.]
Where $E$ exceeds the local potential the solution oscillates, where it falls
below it decays, and a carrier injected from the left with $E < Delta V$ meets
one of each,
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
The decay constant $kappa_C$ is @kappa of the previous chapter, met there in a
well and here in a barrier.
Under the barrier the wave vector is imaginary, $k_C = i kappa_C$, which is the
whole of the difference between the two cases.

Each term is a direction of travel.
On the left $a_L$ is the injected wave and $b_L$ the reflected one, in the
barrier $a_C$ decays to the right and $b_C$ to the left, and on the right
$b_R$ leaves.
#key[There is no term incident from the right, and its absence is the statement
that injection is from the left alone.]
Nothing forbids adding one; the calculation would then describe a different
experiment.

=== Interface conditions

#exam("L3.6")
The ansatz carries five unknowns, and each interface supplies two conditions,
which is four.
At an interface the wave function is continuous,
$
  phi(x^-) = phi(x^+),
$
so that the probability density does not jump, and the current is continuous,
which in the effective mass approximation reads
$
  [1 / m^* (dif phi) / (dif x)]_(x^-) = [1 / m^* (dif phi) / (dif x)]_(x^+).
$
#key[It is the derivative divided by the mass that is continuous and not the
derivative itself, which is the condition the BenDaniel–Duke operator @BDD was
constructed to satisfy and the reason the mass sits between the two derivatives
there.]
The two are the same statement met twice, once as a matching rule for analytic
solutions and once as an operator ordering for a discretization.

At the left interface the two conditions give
$
  a_L + b_L = a_C + b_C,
  quad
  (i k_L) / m_L^* (a_L - b_L) = kappa_C / m_C^* (b_C - a_C),
$
and the right interface gives two more of the same construction, coupling
$a_C$, $b_C$ and $b_R$.

Four equations do not determine five unknowns, and they are not meant to.
#key[The injection amplitude $a_L$ is not an unknown but a choice, since it says
how hard the wave is driven at the boundary, and every other amplitude comes out
proportional to it.]
Setting $abs(a_L)^2 = 1$ normalizes to unit injected probability, and the
transmission, being a ratio, does not depend on the choice at all.

=== Transmission probability

The quantity wanted is the probability that a carrier injected from the left
appears on the right,
$
  T_(L R) = abs(b_R)^2 / abs(a_L)^2,
$ <transmission>
the transmitted probability density over the injected one, with the reflected
part of the left-hand wave deliberately excluded from the denominator.
The two sides carry the same potential and the same mass here, so the carrier
leaves with the speed it arrived with and no velocity factor is needed;
where they differ, the ratio of currents rather than of densities is what
transmission means, and the transmission @transmission acquires a factor
$(k_R slash m_R^*) slash (k_L slash m_L^*)$.

Solving the four equations for $b_R$ in terms of $a_L$ is elimination and
nothing more.#note[
  Slide 16 gives the result as $b_R = 1 slash F$ with $F$ assembled from four
  terms $F_1$ to $F_4$. Luisier introduced them as a device for fitting the
  expression onto one slide and said they carry no physical meaning.
]
#key[What is worth retaining is the method rather than the expression: an ansatz
per region, two conditions per interface, everything referred to the injection
amplitude.]
The energy has changed role in the process.
In the closed problem it was the output, an eigenvalue to be found.
Here it is an input, chosen before the calculation starts, and the transmission
@transmission is evaluated by scanning it over a range.

=== Transmission below and above the barrier

#exam("L3.5")
Slide 17 shows the outcome for a #qty(5, $"nm"$) barrier of height
#qty(0.3, $"eV"$), with $m_C^* = 0.1 m_0$ in the barrier and
$m^* = 0.065 m_0$ outside.
#key[Below the top of the barrier the transmission rises from zero roughly
exponentially, reaching about $0.1$ at the top, and this is tunneling: the
source-to-drain leakage of the first chapter computed rather than asserted.]
The wave functions on the left of the same slide show what carries it: a
standing wave before the barrier, from the interference of the incident and
reflected parts, an exponential decay inside it, and a small surviving
oscillation beyond it whose amplitude is the transmission.

Above the barrier the transmission does not simply saturate.#note[
  Slide 19 carries only its title, this being one of the passages Luisier
  developed on the board after putting the question to the audience.
]
#key[It rises to exactly one at a discrete set of energies and dips between
them, because for $E > Delta V$ the barrier region carries a real wave vector
and the waves reflected from its two faces interfere.]
Writing $k_C = sqrt(2 m_C^* (E - Delta V)) slash planck$ for that wave vector,
the round trip is in phase when the barrier holds a whole number of half
wavelengths,
$
  L = n lambda / 2,
  quad
  k_C L = n pi,
  quad n = 1, 2, 3, ...,
$
and the interference is then fully constructive.
The energies at which this happens are
$
  E_n = Delta V + planck^2 / (2 m_C^*) ((n pi) / L)^2,
$
which is the infinite-well ladder @infinite-well-solution of the previous
chapter, measured from the top of the barrier rather than from the bottom of a
well.
A barrier is therefore perfectly transparent at exactly the energies at which the
region above it would hold a standing wave, the two faces then sitting at nodes
so that the carrier does not see the barrier at all.
For the example the first of them is $E_1 approx #qty(0.45, $"eV"$)$.
Between two resonances the interference is least favorable and the transmission
dips, but the minima climb toward one as the energy grows, so the barrier
becomes transparent in the mean and the oscillations fade.

=== Scope of the analytical solution

#exam("L3.7")
#key[The construction needs a potential that is piecewise constant, since that
is what makes the solution in each piece a plane wave or an exponential with a
known wave vector, and there is nothing to glue otherwise.]
Slide 20 puts the case that breaks it: the same barrier with a voltage applied
across it, so that the potential is a ramp everywhere and the flat regions are
gone.
A linear ramp does still have closed-form solutions, in Airy functions rather
than exponentials, but an arbitrary $V(x)$ has none, and a device potential is
whatever Poisson's equation returns.
The barrier calculation is therefore an illustration and not a method.

What survives the failure is the idea of injecting from a region where the
solution is known.
The rest of the chapter keeps that and gives up on knowing the solution inside
the device.

== Contacts

=== Semi-infinite reservoirs

#exam("L3.2", "L3.8")
#key[The device is extended on each side by a semi-infinite region of constant
potential, called a #term("contact") or #term("reservoir") or #term("lead"),
whose value is the potential at the adjacent end of the device.]
The device between $x = 0$ and $x = L$ is left as it is, an arbitrary $V(x)$ on
an arbitrary grid, and no attempt is made to solve it in closed form.
Slides 22 and 23 show the arrangement, and it is the answer to what a system
with open boundary conditions looks like: a black box with a flat-band region
attached at either end.

The flatness is the entire point.
It is what makes the contact a region where the solution of the Schrödinger
equation is known, exactly as the outer regions of the barrier were, so that
the amplitudes there can be manipulated by hand.
Contacts are not a physical addition to the device.
They are the part of the problem that has been made solvable so that the rest
need not be.

Flat bands at the ends are also what a real device has, since the heavily doped
source and drain are charge neutral and therefore field free, and the next
chapter obtains that flatness from Poisson's equation rather than assuming it.
The grid inside a contact is taken uniform with spacing $Delta x$, there being
no structure there to resolve, while the device grid stays arbitrary.

=== Plane-wave ansatz

#exam("L3.9")
Being flat, each contact carries plane waves,
$
  phi_l (x) &= a_L e^(i k_L x) + b_L e^(-i k_L x), \
  phi_r (x) &= a_R e^(-i k_R (x - L)) + b_R e^(i k_R (x - L)),
$ <contact-ansatz>
written so that the right contact is measured from $x = L$ and each amplitude
means the same thing on both sides.
#key[The terms carrying $a_L$ and $a_R$ travel toward the device and are
injected into it, and those carrying $b_L$ and $b_R$ travel away from it and
leave, whether by reflection or by transmission.]
Direction, not position, is what distinguishes them:
on the left the incoming wave moves to the right and on the right it moves to
the left, which is why the sign in the exponent flips between the two lines of
the contact ansatz @contact-ansatz.

This is the barrier ansatz @barrier-ansatz with the middle region replaced by
something unknown.
What was solvable in three pieces is now solvable in two, and the piece between
them is handed to a computer.

=== Two injection problems

#exam("L3.12")
The two injected amplitudes are not solved for together.
#key[The problem is split into one calculation per contact, $a_L = 1$ with
$a_R = 0$ and then $a_R = 1$ with $a_L = 0$, each producing a wave function of
its own.]
Injecting from the left gives a state that is partly reflected back to the left
and partly transmitted to the right; injecting from the right gives the mirror
situation.
Slide 25 draws both.

The reason for keeping them apart is not algebraic convenience.
The two contacts are separate reservoirs, and under an applied bias they sit at
different Fermi levels, so a state arriving from the left and a state arriving
from the right are occupied with different probabilities.
Adding them before those weights are known would destroy exactly the information
a non-equilibrium calculation needs.
The weighting is the subject of the next chapter.

== Coupling the contacts to the device

#exam("L3.10")
The contacts are described and the device is discretized, and what remains is to
join them.
The join is where the infinite hierarchy is cut.
The contact holds infinitely many unknown values, but not infinitely much
information: being uniform it carries plane waves, so every value in it follows
from the two amplitudes of the contact ansatz @contact-ansatz once the wave
vector is known.
Of the three, $a_L$ is chosen, and two rows of the discretized equation
@discrete-se suffice to dispose of the other two.
A third row then receives the result.#note[
  Luisier named the answer he most often gets and does not want, that the
  contacts are joined by imposing continuity of the wave function and of the
  current. Those hold, but they are contained in the discretization, which is
  one difference equation on one grid with no interface in it, and they connect
  nothing to a contact.
]

#key[The discretized equation @discrete-se holds everywhere, inside the device
and inside the contacts alike, and the contacts are treated as discretized as
well even though their solution is known.]
Two abbreviations shorten what follows,
$
  D_i = E - H_(i i), quad T_(i, i plus.minus 1) = - H_(i, i plus.minus 1),
$
so that the discretized equation @discrete-se reads
$D_i phi_i + T_(i, i+1) phi_(i+1) + T_(i, i-1) phi_(i-1) = 0$.
Inside the left contact the material and the potential do not vary and the grid
is uniform, so both are constant there and, by the hopping energy @hopping,
$
  T_L = t_L = planck^2 / (2 m_L^* Delta x^2),
  quad
  D_L = E - V_L - 2 t_L.
$ <contact-entries>
The first device point is assumed to carry the same material as the contact, so
that $D_L$ serves for $i = 1, 0, -1$ alike.

=== Equations outside the domain

Write the discretized equation @discrete-se at the first point inside the device
and at the first two outside it,
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
Three unknown wave function values have been traded for three unknowns
$a_L$, $b_L$ and $k_L$, which is no gain until each is disposed of.
#key[The row at $i = -1$ is the first whose three points all lie in the uniform
region, so it is the generic contact row and every row below it is the same row
shifted, while the device enters only through $phi_1$, which appears at $i = 1$
and $i = 0$ and nowhere below.]

=== Contact dispersion

Substituting the sampled ansatz @sampled-ansatz into the $i = -1$ row of
@three-rows and collecting the factors of $a_L$ and $b_L$,
$
  a_L e^(-i k_L Delta x) (D_L + 2 T_L cos(k_L Delta x))
  + b_L e^(i k_L Delta x) (D_L + 2 T_L cos(k_L Delta x)) = 0,
$
in which the same bracket multiplies both amplitudes, so that the row is the
single product
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
satisfies the difference equation in the contact at all, and imposing it makes
every row below the domain hold identically, which is what terminates the
hierarchy.]
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
parabolic band the effective mass approximation was built to reproduce.
#key[Away from the band bottom the grid asserts itself: the discrete band
@discrete-band is periodic in $k_L$ and bounded by $V_L + 4 t_L$,
so the discretization has
replaced the parabola by a band of finite width, with a Brillouin zone set by
the grid spacing rather than by a lattice constant.]
The parabola is recovered as $Delta x arrow.r 0$, which sends the bandwidth to
infinity.
A carrier can be injected only at an energy inside that band; outside it the
arccosine of the dispersion relation @contact-dispersion has no real value,
$k_L$ is imaginary, and the
contact carries an evanescent solution that transports nothing.

=== Reflection amplitude

The $i = 0$ row is where the device is first felt.
Substituting the sampled ansatz @sampled-ansatz into it and using the dispersion
condition @dispersion-row in the forms
$D_L + T_L e^(minus i k_L Delta x) = - T_L e^(plus i k_L Delta x)$ reduces it to
$
  phi_1 = a_L e^(i k_L Delta x) + b_L e^(-i k_L Delta x),
$
which is the contact ansatz @contact-ansatz evaluated at $x = Delta x$.
#key[The $i = 0$ equation says that the contact ansatz, continued one point into
the device, must agree with the device solution there, and that is the entire
content of the coupling.]
Solving it for the reflected amplitude,
$
  b_L = phi_1 e^(i k_L Delta x) - a_L e^(2 i k_L Delta x).
$ <reflection>
The reflection is now expressed through the injection, which is chosen, and
through $phi_1$, which the device determines.
Unlike the relation the $i = -1$ row would have given, this one knows what it is
reflecting from.

=== Self-energy and injection

Putting the reflected amplitude @reflection into $phi_0 = a_L + b_L$ gives the
boundary relation itself,
$
  phi_0 = e^(i k_L Delta x) phi_1 + a_L (1 - e^(2 i k_L Delta x)),
$ <boundary-relation>
and its two terms carry the two roles.
With $a_L = 0$ the contact holds only the outgoing wave, and the relation then
says that stepping one point in the direction that wave travels multiplies it by
$e^(i k_L Delta x)$, which is the statement that nothing comes back.
The remaining term is there because a wave is being sent in.
Substituting the boundary relation @boundary-relation into the $i = 1$ row of
@three-rows closes the system,
$
  (D_1 + T_L e^(i k_L Delta x)) phi_1 + T_(1 2) phi_2
    = - a_L T_L (1 - e^(2 i k_L Delta x)).
$
Nothing unknown is left: $T_L$ is a material parameter, the wave vector comes
from the dispersion relation @contact-dispersion and $a_L$ is chosen.
The two new quantities are named
$
  Sigma_(1 1) = - T_L e^(i k_L Delta x),
  quad
  S_(1 1) = - a_L T_L (1 - e^(2 i k_L Delta x)),
$
the #term("boundary self-energy") and the #term("injection term"), and the row
becomes $(E - H_(1 1) - Sigma_(1 1)) phi_1 + T_(1 2) phi_2 = S_(1 1)$.
The right contact is the same construction mirrored, contributing
$Sigma_(N N) = - T_R e^(i k_R Delta x)$ and, when injection is from the right,
$S_(N N) = - a_R T_R (1 - e^(2 i k_R Delta x))$.

The two carry different roles despite arriving together.
#key[$Sigma$ modifies the operator and describes the contact's ability to
absorb whatever reaches it, while $S$ is a source and describes what the contact
sends in, so a contact that is connected but empty contributes the first and not
the second.]

#key[$Sigma_(1 1)$ is complex for a propagating state, so $E - H - Sigma$ is not
Hermitian, and that is the mathematical signature of openness: probability
leaves the domain, and an operator conserving it could not describe that.]
Its imaginary part is $-T_L sin(k_L Delta x)$, nonzero exactly when $k_L$ is
real, which is exactly when the contact has a propagating state at that energy
to carry probability away.
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
#key[The contacts touch the problem in two entries of one matrix, one per
contact, and everything else is unchanged from the closed calculation.]

#key[Closed boundary conditions are the special case $Sigma = 0$ and $S = 0$,
where the open system @OBC collapses to $(E - H) phi = 0$ and has a nontrivial
solution only at the eigenvalues of $H$.]
That is the difference between the two, stated in one line.
An open system has a solution at every energy, and the energy is supplied rather
than found;
a closed one has a solution only at its own, and they are what the calculation
delivers.
The problem has stopped being an eigenvalue problem and become a linear system
of the form $A x = b$, to be solved once for each energy of interest.
Since $A$ is sparse and tridiagonal it is factorized rather than inverted.

=== Right-hand sides

#exam("L3.12", "L3.13")
The two injection problems share their matrix and differ only in their source,
so they are solved together,
$
  (E - H - Sigma) [phi^L, phi^R] = [S^L, S^R],
$
with $S^L$ carrying $S_(1 1)$ in its first entry and zeros elsewhere and $S^R$
carrying $S_(N N)$ in its last.
The unknown is now $N times 2$: its first column is the wave function injected
from the left and its second the wave function injected from the right.
One factorization serves both, the left-hand side being common.

#key[The number of right-hand sides is the number of contacts, since each
contact is an independent way of populating the device at a given energy, and a
structure with $n$ contacts has $n$ of them.]
The interpretation is that the open system @OBC has no single solution at a
given energy.
It has one scattering state per injecting contact, and the physical state is a
superposition of them weighted by how populated each contact is.
Those weights are the Fermi distributions of the reservoirs, which under bias
are not the same, and supplying them is what turns a set of wave functions into
a carrier density and a current.

== Outlook

The construction just completed is the #term("wave function formalism"), also
called the #term("quantum transmitting boundary method").#note[
  Luisier described what he expects on this derivation: that the device is
  extended by flat semi-infinite contacts, that flatness is what makes the
  solution there analytic, and that the coupling proceeds by writing the rows at
  $i = 1$, $0$ and $-1$ and replacing $phi_0$, $phi_(-1)$ and $phi_(-2)$ by the
  ansatz, from which $k_L$, then $b_L$, then the open system @OBC follow,
  ending at the final form. He does not expect the algebra step by step.
]
It is one of the two formalisms of the course.
The other, the non-equilibrium Green's function method, solves the same physical
problem by computing the inverse of the same operator $E - H - Sigma$ instead of
its action on a source.

What the open system @OBC delivers is a wave function per contact and per
energy, which is not yet an observable.
The next chapter weights those states by the occupation of the contact they came
from and integrates over energy, giving the carrier density in the device and
the current through it, and the transmission of this chapter reappears there as
the quantity the current is an integral of.
