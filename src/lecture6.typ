#import "setup.typ": *
#show: chapter.with("Hole density, transmission and recursion")

The previous chapter rewrote the electron density in Green's functions.
Three things are still missing before the formalism is complete, and this
chapter supplies them one after the other.

The first is the hole density.
An electron density counts occupied states, and a hole density counts empty
ones.
The counting of empty states needs an object of its own, the greater Green's
function, which stands next to the lesser one of the previous chapter.

The second is the current.
The transmission is still computed from wave function amplitudes, so the
formalism is not yet closed.
We rewrite it with Green's functions and the broadening, and then nothing in the
whole calculation refers to a wave function.

The third is the justification.
Every step so far was made by comparing two expressions and observing that they
agree.
We go back to the definition the Green's functions were given in the 1960s, in
terms of field operators on a complex time contour, and see that our equations
are the steady-state form of exact ones.
That detour also produces the identity that relates all four Green's functions,
and with it the spectral function, which tells us that most of the inverse we
compute is never read.
The chapter ends with the algorithm that computes only the entries we read.

== Hole density

=== Occupation of empty states

A state that should carry an electron and does not leaves the positive charge of
the ion uncompensated.
#key[A #term("hole") is that missing electron, counted as a positive charge.
So the hole density is built exactly like the electron density, with the
probability that a state is occupied replaced by the probability that it is
empty.]
The Fermi distribution @FD gives the first, so $1 - f$ gives the second, and the
hole density in the wave function formalism is
$
  p(x) = 1 / (L A) sum_(k_x) sum_(avec(k)_t) sum_c
    abs(phi^c_(k_x) (x))^2 thin
    (1 - f(E(k_x, avec(k)_t), E_F^c)).
$
This is the carrier density @n-noneq of the fourth chapter with one factor
changed.

The transformations of that chapter go through unchanged, because they act on
the wave functions and not on the occupation.
The sum over $k_x$ becomes an energy integral @sum-to-integral-1d and produces
the density of states @g-obc, and the transverse sum stays behind as an
occupation factor.
That factor is the counterpart of the Fermi integral @FI,
$
  macron(F)(E, E_F^c) = 1 / A sum_(avec(k)_t)
    (1 - f(E + E(avec(k)_t), E_F^c)) \
    = (m_t^* k_B T) / (pi planck^2)
      ln(1 + exp((E - E_F^c) / (k_B T))),
$ <hole-FI>
which carries #unit($m^(-2)$) like $F$ and counts empty transverse states
instead of occupied ones.#note[
  The lectures write this quantity $1\_F$ and its negative $F\_1$, and use both.
  The script keeps one symbol, so the lectures' $F\_1$ is $- macron(F)$.
]
With it the hole density is
$
  p(x) = integral dif E thin sum_c g^c (E, x) thin macron(F)(E, E_F^c).
$ <p-wf>

#key[The two occupation factors are the same function mirrored about the Fermi
level.]
Compare @hole-FI with @FI: the exponent changes sign, and nothing else does.
So $macron(F)$ grows linearly below its own argument and falls off
exponentially above it, in the opposite direction to $F$.
This mirror is the whole difference between an electron and a hole in what
follows.#note[
  The closed form of @hole-FI is the lectures'. It converges because the
  transverse energy of a valence band disperses downward, so the sum is
  $integral dif E_t (1 - f(E - E_t, E_F))$, whose antiderivative is the
  logarithm written here. Written with an upward transverse dispersion the sum
  counts empty states without bound and does not converge.
]

=== Greater Green's function

#exam("L6.1", "L6.5")
Now do to @p-wf what the previous chapter did to the electron density.
Put the wave function squared @wf-square into the density of states, and set the
injection amplitudes to $a_c = 1$,
$
  p(x_i) = integral (dif E) / (2 pi) thin
    "diag" {G^R (E) [sum_c S^c S^(c dagger)
      abs((dif E) / (dif k_c))^(-1) macron(F)(E, E_F^c)] G^A (E)}_i .
$
This is the same expression as for electrons, with $F$ replaced by
$macron(F)$, so the bracket gets a name in the same way.
#key[The #term("greater self-energy") $Sigma^(>)$ describes the empty states the
contacts offer.
The #term("greater Green's function") $G^(>)$ describes what the device does
with them,]
$
  Sigma^(>) (E) = - i sum_c S^c S^(c dagger)
    abs((dif E) / (dif k_c))^(-1) macron(F)(E, E_F^c) Delta x,
$ <greater-SE>
$
  G^(>) (E) = G^R (E) Sigma^(>) (E) G^A (E),
$ <greater-GF>
and with them the hole density is the diagonal of $G^(>)$,
$
  p(x_i) = i / (Delta x) integral (dif E) / (2 pi)
    thin "diag" {G^(>) (E)}_i .
$ <p-greater>

The conventions are those of @lesser-SE, with one sign changed.
The factor $Delta x$ again turns a quantity per grid point into one per unit
length.
The factor $- i$ where the lesser self-energy carried $+ i$ is what makes
@p-greater come out positive, since the density @n-lesser carried $- i$ in front
of the integral and this one carries $+ i$.
#key[$G^(<)$ counts electrons and $G^(>)$ counts empty states, and the two
differ by their occupation factor and by that sign.]
Between the two of them, and $G^R$ for the states themselves, we now have every
quantity a device calculation needs.

The contact entries follow as they did for $Sigma^(<)$.
Nothing in that derivation touched the occupation, so the two nonzero entries of
@greater-SE are those of @lesser-contact with the factor replaced,
$
  Sigma^(>)_(c c) (E) = - 2 i t_c sin(k_c Delta x) thin macron(F)(E, E_F^c)
    = - i Gamma_(c c) (E) thin macron(F)(E, E_F^c),
$ <greater-contact>
using the broadening @broadening-contact in the second step.
So both non-equilibrium self-energies are built from $Gamma$ and an occupation
factor,
$
  Sigma^(<) = i sum_c Gamma^c thin F(E, E_F^c),
  quad
  Sigma^(>) = - i sum_c Gamma^c thin macron(F)(E, E_F^c),
$
and $Gamma$ comes from $Sigma^R$ alone.
Neither the injection vector $S$ nor the band derivative
$dif E slash dif k_c$ appears in either of them.

=== Electron and hole density in a p-n junction

Slides 11 and 12 show the two densities in an In#sub[0.53]Ga#sub[0.47]As p-n
junction, computed with both Green's functions, with
$N_A = #qty($8 dot 10^19$, $"cm"^(-3)$)$ on the left and
$N_D = #qty($4 dot 10^19$, $"cm"^(-3)$)$ on the right.
It is the analytical picture of the fifth chapter with the quantum calculation
put next to it.

The hole density equals the acceptor concentration far to the left and the
electron density equals the donor concentration far to the right, which is the
charge neutrality that the boundary conditions produce.
Near the junction each density falls, and each one leaks a little way into the
other side.
That leak is the diffusion of carriers across the junction, and it is the reason
the calculated charge density is smooth where the analytical model @charge-density
has two sharp boxes.
#key[The depletion region of the analytical model is an approximation in which
the mobile carriers vanish abruptly.
The quantum calculation has them fall off over a few nanometers instead.]

The field and the potential are the two integrals of that charge.
#key[Integration smooths, so the two models differ less in the field than in the
charge, and less again in the potential.]
The calculated field is close to the triangle of the analytical model, which is
what justifies using the simple model for the electrostatics of a diode.
The potential rises by the built-in potential, here about
#qty(1.1, $V$), with no bias applied.

=== Single-band model of a p-n junction

That simulation used a full-band tight-binding model, which carries the
conduction and the valence band at once and therefore treats electrons and holes
in one calculation.
Our effective mass model @EMA has one band.
The question is what we can do with it.

#key[Holes are electrons in a mirrored spectrum, so we run the same solver twice
and mirror its input the second time.]
The first run is the one we already have.
It takes the conduction band, the potential $V(x)$ of @potential-energy and the
contact Fermi levels, and returns $n(x)$.
The second run takes the valence band with the hole effective mass, and flips
the sign of the electrostatic potential and of the Fermi levels.
An electron in that mirrored problem sees a well wherever a hole sees one, and
the density it returns is $p(x)$.
Both densities come out positive, and the signs enter only in the charge density
@charge-density.

The two runs are coupled through Poisson's equation and nowhere else.
Each iteration of the self-consistent loop of the fifth chapter runs the
transport solver twice, once per carrier, and hands both densities to the
charge.
#key[Splitting the problem by carrier rather than by position is what keeps it
right.
A cut at the junction would remove exactly the two tails that make the junction
what it is, the electrons spilling into the $p$ side and the holes into the $n$
side.
The split by carrier keeps both tails, since each solver sees the whole
device.]

The model has one failure, and it is a physical one.
#key[Separating the bands removes the transitions between them.]
Raise the doping far enough and the valence band of the $p$ side comes to lie
above the conduction band of the $n$ side.
An electron in the valence band on one side then faces an empty conduction band
state at the same energy on the other, with a thin barrier between them, and it
tunnels.
That is the band-to-band tunneling a tunnel diode and a tunneling transistor
work on.
Two decoupled single-band calculations cannot produce it, since neither one has
a state at both ends of the tunneling path.
A WKB estimate of the barrier could patch the tunneling current on, but not the
carrier populations it moves between the bands, and those enter Poisson's
equation.
So a device that lives on interband tunneling needs a full-band model.

== Current

=== Transmission in the Green's function formalism

#exam("L6.6")
The current is the Landauer-Büttiker integral @LB, and it is valid as it
stands.
What we still compute from wave functions is its transmission, defined in the
fourth chapter as the ratio of transmitted to injected flux,
$
  T_(L R) (E) = abs(b_R^L (E))^2 / abs(a_L)^2 thin
    abs(v_R (E)) / abs(v_L (E)),
$
with $a_L$ the amplitude injected from the left, $b_R^L$ the amplitude leaving
into the right contact, and the two velocities those of the contact bands.
We set $a_L = 1$.

The transmitted amplitude is a value of the wave function.
#key[An electron injected from the left and observed at the far end of the
device is what has been transmitted,]
$
  abs(b_R^L (E))^2 = abs(phi^L_N (E))^2,
$
where $phi^L$ is the wave function injected from the left contact and $N$ is the
last grid point.#note[
  The lectures write this point as $x = L$, which collides with the left contact
  index $L$. The script indexes it by $N$ as everywhere else.
]

Now write that value with Green's functions.
The wave function is $phi^L = G^R S^L$ by @wf-from-GF, and $S^L$ has its single
nonzero entry at the first grid point.
A matrix times a vector with one nonzero entry picks out one column, so the last
component of $phi^L$ is one entry of $G^R$ times one number,
$
  phi^L_N = G^R_(N 1) S^L_(1 1),
  quad
  abs(phi^L_N)^2 = G^R_(N 1) S^L_(1 1) S^(L dagger)_(1 1) G^A_(1 N).
$ <phi-last>
#key[The amplitude that reaches the far contact is the corner entry of the
retarded Green's function.]
That entry is the propagator from one end of the device to the other, which is
what a transmission asks for.

Two velocities are left, and each one turns into a broadening.
Write them as band derivatives, $planck v_c = abs(dif E slash dif k_c)$, so that
$
  T_(L R) (E) = G^R_(N 1) abs(S^L_(1 1))^2 G^A_(1 N)
    abs((dif E) / (dif k_L))^(-1) abs((dif E) / (dif k_R)).
$
The injected velocity sits next to the injection term, and the two together are
the combination that already collapsed in @lesser-SE,
$
  abs(S^L_(1 1))^2 abs((dif E) / (dif k_L))^(-1)
    = (4 t_L^2 sin^2 (k_L Delta x)) / (2 t_L Delta x sin(k_L Delta x))
    = Gamma_(1 1) / (Delta x).
$
The velocity of the outgoing contact has no injection term next to it, and for
it we use the broadening @broadening-contact directly,
$abs(dif E slash dif k_R) = Delta x thin Gamma_(N N)$.
The two factors of $Delta x$ cancel, and what is left is
$
  T_(L R) (E) = G^R_(N 1) (E) thin Gamma_(1 1) (E) thin G^A_(1 N) (E)
    thin Gamma_(N N) (E),
$ <T-GF>
with the right-to-left transmission the same expression with the two ends
exchanged,
$T_(R L) = G^R_(1 N) Gamma_(N N) G^A_(N 1) Gamma_(1 1)$.
The fourth chapter showed that the two are equal @T-symmetry, so either one may
be used.

Read @T-GF from right to left as a path.
#key[$Gamma_(1 1)$ is the rate at which the left contact injects at the first
grid point, $G^R_(N 1)$ propagates that amplitude to the last one, $Gamma_(N N)$
is the rate at which the right contact absorbs there, and $G^A_(1 N)$ propagates
back.]
The same reading applied to the density of states @g-GF, with the two ends of
the path at the same point.
In matrix form, with $Gamma^c$ the broadening of one contact,
$
  T(E) = "tr" {Gamma^L (E) G^R (E) Gamma^R (E) G^A (E)},
$
and the trace reduces to @T-GF because each $Gamma^c$ has a single nonzero
entry.

The elimination is now complete.
#key[Neither the injection vector nor the band derivative appears in any
quantity we compute.
Everything follows from $H$, from $Sigma^R$ and from the Fermi levels.]

=== Solution procedure

#exam("L6.6")
The whole calculation fits in three nested loops.
The outer one runs over the bias points, the middle one is the self-consistent
Schrödinger-Poisson iteration of the fifth chapter, and the inner one runs over
the energy grid.
At one energy $E$ the steps are these:

+ Solve the contact dispersion @contact-dispersion for $k_L$ and $k_R$.
+ Form the retarded self-energies $Sigma^R_(c c) = - t_c e^(i k_c Delta x)$ and
  place them in the two corners of $Sigma^R$.
+ Form the broadenings $Gamma_(c c) = i (Sigma^R_(c c) - Sigma^(R *)_(c c))$ by
  @broadening, and place each in its own matrix $Gamma^L$ or $Gamma^R$.
+ Invert @retarded-matrix to get $G^R = (E - H - Sigma^R)^(-1)$, and take
  $G^A = (G^R)^dagger$.
+ Get the densities, by either of the two routes below.
+ Evaluate the transmission @T-GF from the corner entry of $G^R$.

The two routes of the fifth step give the same numbers.
#key[One route stores the states and weights them afterwards.
The other puts the weights in before the propagation.]
Through the densities of states, the first route evaluates @g-GF and then
$
  n(E, x) = sum_c g^c (E, x) thin F(E, E_F^c),
  quad
  p(E, x) = sum_c g^c (E, x) thin macron(F)(E, E_F^c).
$
Through the correlation functions, the second route assembles $Sigma^(<)$ and
$Sigma^(>)$ from the broadenings and the occupations, propagates them by
@lesser-GF and @greater-GF, and reads the diagonals @n-lesser and @p-greater.
They agree because the occupation factors enter linearly and the propagation
$G^R dot G^A$ is the same in both.
The second route is the one that survives when scattering is added, since a
scattering self-energy does not factor into a broadening times an occupation.

The energy loop accumulates the densities, each contribution weighted by the
spacing of the energy grid, and the transmission accumulates into the current
@LB.#note[
  Luisier named the two expressions to remember for this procedure, the contact
  dispersion for $k_c$ and the retarded self-energy
  $Sigma^R_(c c) = - t_c e^(i k_c Delta x)$. Everything else in the list follows
  from those two.
]

== Origin of the formalism

=== Green's functions of field operators

#exam("L6.1")
Every Green's function so far was obtained by rewriting a wave function
expression.
The historical route is the other way round.
#key[The Green's functions were introduced by Kadanoff and Baym in the 1960s as
expectation values of a field operator and its adjoint at two points of space
and time,]
$
  G(avec(r), t; avec(r)', t') = - i / planck
    angled(T thin hat(Psi)(avec(r), t) hat(Psi)^dagger (avec(r)', t')),
$ <contour-GF>
where $hat(Psi)(avec(r), t)$ annihilates a particle at $avec(r)$ at time $t$ and
$hat(Psi)^dagger (avec(r)', t')$ creates one at $avec(r)'$ at time $t'$, both in
the Heisenberg picture.
The operator $T$ orders the two factors.

Ordering by real time is not enough out of equilibrium.
The two times are therefore placed on a #term("complex time contour"), which
runs forward along the real axis just above it and back just below it, and $T$
orders by position along that contour.
Slide 23 draws it.
Two times that sit in the same order in real time can sit in either order on the
contour, depending on which branch each one is on.
Expanding the ordering gives the two possibilities,
$
  G = - i / planck (
    theta(t, t') angled(hat(Psi)(avec(r), t)
      hat(Psi)^dagger (avec(r)', t'))
    - theta(t', t) angled(hat(Psi)^dagger (avec(r)', t')
      hat(Psi)(avec(r), t))
  ),
$
where $theta(t, t')$ is one when $t$ lies later than $t'$ along the contour.
The contour is a construction and not a physical object.
Its shape may be deformed as long as each branch is compensated by another, and
a branch running into the imaginary direction encodes correlations present when
the system was prepared.

Each ordering of the two operators is a Green's function of its own, and the
four we use are read off the two orderings,
$
  G^(>) (avec(r), t; avec(r)', t')
    = - i / planck angled(hat(Psi)(avec(r), t)
      hat(Psi)^dagger (avec(r)', t')), \
  G^(<) (avec(r), t; avec(r)', t')
    = i / planck angled(hat(Psi)^dagger (avec(r)', t')
      hat(Psi)(avec(r), t)),
$ <four-GF>
$
  G^R = theta(t - t')(G^(>) - G^(<)),
  quad
  G^A = - theta(t' - t)(G^(>) - G^(<)),
$
the last two now with the ordinary step function of real time.

#key[The lesser function counts particles and the greater one counts empty
states.]
Read the operators in $G^(<)$ from right to left: it annihilates a particle at
one point and creates one at the other, and at equal points this is nonzero only
if there was a particle there to remove.
$G^(>)$ does the two in the other order, so it is nonzero only if there was room
to add one.
That is why the electron density came out of one and the hole density out of the
other, and it is the same statement as $f$ against $1 - f$.

=== Steady state

Our Green's functions carry an energy and not two times.
That is a restriction and not a definition.
#key[In steady state nothing depends on when we start the clock, so a Green's
function depends on the two times only through their difference, and the
Fourier transform of that difference is the energy.]
Everything we compute is therefore stationary.
A time-dependent problem keeps both times, and the equations below stay
integrals over the contour rather than products at one energy.

=== Equations of motion

The rigorous derivation writes the equations of motion of the two field
operators in the Heisenberg picture and puts them into the definitions
@four-GF.
Abbreviate a position and a time as one argument, so that $1$ stands for
$(avec(r), t)$ and $integral dif 3$ for an integration over both.
What comes out is one equation for the retarded function,
$
  (i planck partial / (partial t_1) - H(1)) G^R (1, 2)
    - integral dif 3 thin Sigma^R (1, 3) G^R (3, 2) = delta(1, 2),
$ <dyson>
and one for the lesser function,
$
  (i planck partial / (partial t_1) - H(1)) G^(<) (1, 2)
    - integral dif 3 thin Sigma^R (1, 3) G^(<) (3, 2)
    = integral dif 3 thin Sigma^(<) (1, 3) G^A (3, 2).
$
Solving the second with the first gives
$
  G^(<) (1, 2) = integral dif 3 integral dif 4 thin
    G^R (1, 3) Sigma^(<) (3, 4) G^A (4, 2).
$ <keldysh>

#key[These are the equations we have been using.]
In steady state each of them depends on the difference of its two times, and
each convolution becomes a product under the Fourier transform.
Then @dyson is $(E - H - Sigma^R) G^R = I$, which is @retarded-matrix, and
@keldysh is $G^(<) = G^R Sigma^(<) G^A$, which is @lesser-GF.
So the two equations the previous chapter arrived at by comparing expressions
are the steady-state form of exact ones.
The empirical route reached the right answer, and this is why.

=== Relations between the Green's functions

Subtract the two step functions in the definition of $G^R$ and $G^A$.
Whichever of the two times is later, exactly one of the step functions is one,
so
$
  G^(>) - G^(<) = G^R - G^A,
$ <GF-relation>
and the same relation holds for the self-energies,
$
  Sigma^(>) - Sigma^(<) = Sigma^R - Sigma^A .
$ <SE-relation>
Both survive the Fourier transform, so they hold at each energy.#note[
  Luisier said that @GF-relation is the one thing to retain from this section,
  the definitions being there to make it derivable.
]

#key[The relation separates the states from their occupation.
On the left stand the two functions that know how many carriers there are, and
on the right the two that know only which states exist.
The difference of the first pair does not depend on the occupation at all.]
The reason is that a state either holds a carrier or does not.
In operator language it is the anticommutator
${hat(Psi), hat(Psi)^dagger}$, which is a delta function whatever the state of
the system.
So counting the occupied states and the empty ones and adding the two gives all
of them.

One caution about where the relation is applied.
For a contact self-energy it reads
$- i Gamma (F + macron(F)) = - i Gamma$, which asks the two occupation factors
to add to one.
That is $f + (1 - f) = 1$, so it holds for a single transverse mode.
#key[Our $F$ and $macron(F)$ already contain the sum over the transverse modes
and $Gamma$ does not, so the identity is read mode by mode, and the transverse
sum is put back afterwards.]

=== Spectral function

#exam("L6.6")
The right hand side of @GF-relation is a quantity we have already met.
#key[The #term("spectral function") is the diagonal of the difference of the
retarded and advanced Green's functions,]
$
  A(E, x_i) = "diag" {i (G^R (E) - G^A (E))}_i
    = i (G^R_(i i) - G^(R *)_(i i)) = - 2 "Im" G^R_(i i),
$ <spectral>
using $G^A = (G^R)^dagger$.
Now walk it through the identities.
By @GF-relation it is $i(G^(>) - G^(<))$, which by @lesser-GF and @greater-GF is
$i G^R (Sigma^(>) - Sigma^(<)) G^A$, which by @SE-relation is
$G^R thin i (Sigma^R - Sigma^A) G^A$, and the middle factor is the broadening
@broadening.
Split it by contact and compare with the densities of states @g-GF,
$
  A(E, x_i) = "diag" {G^R (E) (Gamma^L (E) + Gamma^R (E)) G^A (E)}_i \
    = 2 pi Delta x thin (g^L (E, x_i) + g^R (E, x_i)).
$ <spectral-DOS>

#key[The local density of states of the open device is the diagonal of $G^R$
alone.]
The chain took us from an object built out of two contacts to one that does not
mention them.
That is the same conclusion the fifth chapter drew by inverting the definitions,
reached here from the field operators instead, and it says that the split of the
states between the contacts is bookkeeping for the occupation.
The name is now justified too: a spectrum is what a density of states is.

=== Boundary and scattering self-energies

Every self-energy so far describes the contacts.
#key[A #term("boundary self-energy") connects the simulation domain to what
surrounds it, and that is all $Sigma^R$, $Sigma^(<)$ and $Sigma^(>)$ have done.]
It is what made the open boundary conditions @OBC possible, and it is why the
retarded self-energy has entries only in the two corners.

The formalism is not limited to that.
#key[A scattering mechanism enters as a self-energy as well, and then the same
equations @dyson and @keldysh hold with $Sigma$ carrying both parts.]
Electron-phonon interaction, impurities and disorder are all written this way,
and a later chapter derives one of them.
A scattering self-energy fills the matrix rather than only its corners, and it
does not factor into a broadening times a Fermi integral, so $Sigma^(<)$ has to
be carried in its own right.
This is what the wave function formalism cannot do, and it is the reason for
this whole change of language.

== Recursive Green's function algorithm

=== Entries needed

#exam("L6.9")
Look at what the calculation actually reads out of $G^R$.
The density of states from the left contact is
$g^L (E, x_i) = G^R_(i 1) Gamma_(1 1) G^A_(1 i) slash 2 pi Delta x$, because
$Gamma^L$ has one nonzero entry.
So it needs the first column of $G^R$ and nothing else, and $g^R$ needs the last
column in the same way.
The transmission @T-GF needs the corner entry, which sits in both.
#key[Two columns out of $N$ carry everything a ballistic calculation reads,
and the inversion computes all $N$.]

The spectral function gives two more ways to get the same information.
By @spectral-DOS the diagonal of $G^R$ gives the sum $g^L + g^R$.
#key[So the diagonal together with either one of the two columns is enough:
the column gives one density of states and the diagonal gives the sum, and the
other follows by subtraction.]
Any one of the three sets does the job, which matters because the algorithm
below returns the third one.

=== Computational complexity

#exam("L6.8")
Inverting a matrix of size $N$ costs $O(N^3)$ operations and $O(N^2)$ memory.
#key[The cost of the Green's function formalism, taken naively, is $O(N^3)$ per
energy point, and the energy points and the bias points and the self-consistent
iterations all multiply that.]
A hundred grid points already means of order $10^6$ operations for one energy,
and a three-dimensional device with $10^4$ to $10^5$ points is out of reach
entirely.
The wave function formalism did not have this problem: its matrix is
tridiagonal, and solving one tridiagonal system for one right hand side costs
$O(N)$.

The waste is exactly what the previous section identified.
We compute $N$ columns and read two.
An algorithm that returns only the entries we read would recover the linear
cost, and the recursion below is one.

=== Recursion

#exam("L6.7", "L6.9")
Take the device apart along the transport direction.
Write $H_(n n)$ for the diagonal block at slice $n$ and $T_(n, n+1)$ for the
coupling to the next one, which for our tridiagonal Hamiltonian
@discrete-hamiltonian are single numbers, $H_(n n)$ on the diagonal and
$T_(n, n+1) = H_(n, n+1)$ next to it.

The first sweep runs from the far end back and builds Green's functions of
partial devices.
#key[Let $cal(G)^R_n$ be the retarded Green's function of slice $n$ when it is
connected to everything on its right and to nothing on its left.
Each one is obtained from its right neighbor,]
$
  cal(G)^R_N = (E - H_(N N) - Sigma^R_(N N))^(-1), \
  cal(G)^R_n = (E - H_(n n) - T_(n, n+1) cal(G)^R_(n+1) T_(n+1, n))^(-1),
$ <rgf-right>
for $2 <= n < N$, starting at $n = N$ where the only thing to the right is the
contact.#note[
  The lectures write these $g^R_n$, where the superscript is retarded and
  collides with the right-injected density of states $g^R$. The script writes
  $cal(G)^R_n$.
]
The term $T_(n, n+1) cal(G)^R_(n+1) T_(n+1, n)$ is a self-energy, of the same
shape as the contact self-energy of the third chapter and with the same meaning.
#key[Everything to the right of a slice is replaced by its effect on that slice,
one slice at a time.]
In linear algebra this is the elimination of the trailing blocks of
$E - H - Sigma^R$, and $cal(G)^R_n$ is the inverse of the Schur complement that
elimination leaves behind.
The recursion is Gaussian elimination on blocks, arranged so that only the
inverses we want are formed.

The second sweep runs forward and puts the left side back in.
The first slice has nothing to its left except its own contact, so
$cal(G)^R_1$ is already the full Green's function there,
$
  G^R_(1 1) = (E - H_(1 1) - Sigma^R_(1 1) - T_(1 2) cal(G)^R_2 T_(2 1))^(-1),
$
and from it the diagonal and the first column are built one slice at a time,
$
  G^R_(n n) = cal(G)^R_n
    + cal(G)^R_n T_(n, n-1) G^R_(n-1, n-1) T_(n-1, n) cal(G)^R_n, \
  G^R_(n 1) = - cal(G)^R_n T_(n, n-1) G^R_(n-1, 1),
$ <rgf-reconstruct>
for $2 <= n <= N$.
The first of these corrects the partial Green's function by the path that leaves
the slice to the left, propagates in the part already assembled, and comes back.
The second propagates the first column one slice further along.
Slide 31 draws the two sweeps as arrows on the matrix, up the diagonal and then
down the diagonal and the first column.

#key[Both sweeps visit each slice once and do a bounded amount of work there, so
the recursion costs $O(N)$ operations and $O(N)$ memory instead of $O(N^3)$ and
$O(N^2)$.]
What it returns is the diagonal and the first column, which is one of the three
sufficient sets: the column gives $g^L$, the diagonal gives $g^L + g^R$ and
therefore $g^R$, and the corner entry $G^R_(N 1)$ gives the transmission.
Running the recursion from the other end returns the last column instead.
#note[
  The eighth exercise asks for an NEGF solver at least four times faster than
  the wave function solver of the earlier exercises. Luisier said that the
  recursion alone does not get there, and that a further optimization is needed.
]

== Outlook

The formalism is complete and it is affordable.
It computes the electron density, the hole density, the density of states and
the current, at a cost linear in the size of the device, and it rests on
equations of motion rather than on comparisons of expressions.
What it still describes is ballistic transport, where a carrier crosses the
device without exchanging energy with anything.
The self-energies that lift that restriction are the subject of a later
chapter.
The next chapters put the machinery to work on transistors.
