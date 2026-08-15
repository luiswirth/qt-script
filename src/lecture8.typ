#import "setup.typ": *
#show: chapter.with("Two-dimensional devices and the mode space approximation")

Every device solved so far was one-dimensional.
The two directions perpendicular to transport were periodic, so a plane wave
took care of them and they entered the transport problem only through the
transverse wave vector.
A transistor is not built that way.
Its channel is a thin semiconductor film held between two insulators, and the
wave function is confined across the film, so that direction has to be resolved
explicitly.

This chapter does that, and then pays for it.
The first part carries the machinery of the earlier chapters over to two
dimensions unchanged: the same discretization, the same open system, the same
recursion, with numbers replaced by blocks.
That is enough to simulate a transistor and too slow to do it with.
The second part expands the Green's function in the transverse direction in a
basis of its own choosing, and the right choice makes almost all of the cost go
away again.
The device we keep in mind throughout is the #term("double-gate FET") of
slide 6, with $x$ the transport direction and $y$ the direction of confinement.

== Two-dimensional device

=== Transport, confinement and periodicity

A three-dimensional device has three directions and we treat each according to
what happens along it.
#key[Transport happens along $x$, confinement along $y$, and $z$ is left
periodic, so the device is two-dimensional in the sense that two directions are
resolved on a grid.]
The film is thin along $y$ and long along $z$: a double-gate transistor of
gate width much larger than its body thickness is uniform along $z$, and the
current is quoted per unit width because of it.

Start from the Schrödinger equation @SE with an effective mass @EMA for each
direction,
$
  (- planck^2 / (2 m_0) (
      1 / m^*_x dif^2 / (dif x^2)
      + 1 / m^*_y dif^2 / (dif y^2)
      + 1 / m^*_z dif^2 / (dif z^2)
    ) + V(x, y, z)) Psi(x, y, z) = E Psi(x, y, z),
$
in which the masses are dimensionless multiples of the free electron mass
$m_0$.#note[
  The slides write the masses in front of the derivatives for lack of space.
  They vary along $x$ and along $y$, since the device is a stack of materials in
  both directions, so what is actually discretized is the BenDaniel-Duke
  operator @BDD in each direction.
]
There are no mixed derivatives here.
#key[The effective mass tensor is taken to have its axes along $x$, $y$ and $z$,
and only then is it diagonal and the kinetic operator a sum of three
independent terms.]

The potential is uniform along $z$, so $V = V(x, y)$ and the $z$ dependence
separates as it did in the earlier chapters,
$
  Psi(x, y, z) = 1 / sqrt(L_z) e^(i k_z z) phi(x, y).
$
What is left is a two-dimensional problem,
$
  (- planck^2 / (2 m_0) (
      1 / m^*_x dif^2 / (dif x^2) + 1 / m^*_y dif^2 / (dif y^2)
    ) + V(x, y)) phi(x, y) \
    = (E - (planck^2 k_z^2) / (2 m_0 m^*_z)) phi(x, y),
$ <se-2d>
solved once for each $k_z$, whose only effect is to shift the energy at which
the two-dimensional problem is evaluated.
The transverse direction $y$ cannot be treated this way, because the potential
varies along it and the electron is bound in it.

=== Grid and ordering of the points

Cover the device with a grid of $N_x$ points along $x$ and $N_y$ points along
$y$, with uniform spacings $Delta x$ and $Delta y$, as slide 8 draws it.
Discretizing @se-2d as in the second chapter gives one row per grid point, and
the second derivative in $x$ reaches the two neighbors along $x$ while the
second derivative in $y$ reaches the two neighbors along $y$.
#key[Each point is coupled to itself and to four neighbors, and to nothing
else.]
Writing $h_(i_1 i_2 j_1 j_2)$ for the matrix entry between the point
$(x_(i_1), y_(j_1))$ and the point $(x_(i_2), y_(j_2))$, the row at $(i, j)$ is
$
  h_(i, i-1, j, j) phi_(i-1, j) + h_(i, i+1, j, j) phi_(i+1, j) \
  + h_(i, i, j, j-1) phi_(i, j-1) + h_(i, i, j, j+1) phi_(i, j+1)
  + h_(i i j j) phi_(i j) = E phi_(i j),
$ <h-entries>
with $phi_(i j) = phi(x_i, y_j)$ and the on-site entry $h_(i i j j)$ collecting
the two on-site contributions, one from each direction, together with the
potential.
Slide 9 draws the five points involved.

The grid points have to be numbered before they can be the indices of a matrix,
and there is a choice in that.
#key[We number the points column by column: down the first column of constant
$x_1$, from $j = 1$ to $j = N_y$, then down the column at $x_2$, and so on.]
Numbering row by row would also produce a banded matrix, of $N_y$ blocks of size
$N_x$ instead of $N_x$ blocks of size $N_y$, and would work just as well for a
real space calculation.
#key[The column ordering is chosen because it makes the transverse problem
appear as a diagonal block, and the whole of this chapter rests on the
eigenvectors of that block.]

=== Real-space Hamiltonian matrix

#exam("L8.2")
With the points ordered by columns, the rows @h-entries assemble into the
#term("real-space Hamiltonian") $H_"RS"$, of size $N_x N_y$,
$
  H_"RS" = mat(
    alpha_1, beta_(1 2), 0, dots, dots;
    beta_(2 1), alpha_2, beta_(2 3), 0, dots;
    0, dots.down, dots.down, dots.down, 0;
    dots.v, dots.down, beta_(N_x - 1, N_x - 2), alpha_(N_x - 1), beta_(N_x - 1, N_x);
    0, dots, 0, beta_(N_x, N_x - 1), alpha_(N_x);
  ),
$ <H-RS>
whose blocks are of size $N_y$.
#key[It is block tridiagonal, with $N_x$ diagonal blocks $alpha_i$, one per
column of the grid, and off-diagonal blocks $beta_(i_1 i_2)$ coupling a column
to its two neighbors.]
This is the same shape the one-dimensional Hamiltonian had, with each number
replaced by a block, and it is block tridiagonal for the same reason: the
coupling reaches nearest neighbors only.

The two kinds of block have entries
$
  (alpha_i)_(j_1 j_2) = h_(i i j_1 j_2),
  quad
  (beta_(i_1 i_2))_(j_1 j_2) = h_(i_1 i_2 j_1 j_1) delta_(j_1 j_2),
$ <alpha-beta>
and their structure follows from which points the stencil @h-entries connects.
#key[$alpha_i$ is the coupling among the points of one column, so it is
tridiagonal in $j$, and it is exactly the discretized one-dimensional problem
along $y$ at $x = x_i$.]
#key[$beta_(i_1 i_2)$ is the coupling between two adjacent columns, and it is
diagonal, because a point couples only to the point at the same $y$ in the
neighboring column.]
Slide 12 shades one column and one pair of adjacent columns on the grid.#note[
  Luisier said what he expects here: that $alpha$ is the coupling within a
  column and $beta$ the coupling between two columns, that $alpha$ is
  tridiagonal, $beta$ diagonal and $H_"RS"$ block tridiagonal. Confusing $N_x$
  with $N_y$ in the indices is not what the question is about, and he made that
  slip himself.
]

That $alpha_i$ is a one-dimensional problem along $y$ is the observation the
rest of the chapter is built on.
It is the problem of the second chapter rotated by ninety degrees, and the
physical situation it describes is a #term("quantum well"): oxide, semiconductor,
oxide along the cut line of slide 21.

=== Open system and the cost of solving it

Ballistic transport needs the retarded Green's function alone, and the equation
for it is the one of the sixth chapter with nothing changed,
$
  (E - H_"RS" - Sigma^(R,B)) G^R (E) = I,
$ <GF-2d>
now of size $N_x N_y$.
#key[The boundary self-energy is no longer a single entry in each corner but a
block of size $N_y$, because every point of the first column couples to its
counterpart in the left lead, and likewise on the right.]
Each entry of $G^R$ is a correlation function between two points of the grid,
$G^R (x_(i_1) y_(j_1); x_(i_2) y_(j_2); E)$.

#exam("L8.3")
Inverting @GF-2d directly costs $O(N^3)$ in the size $N = N_x N_y$ of the
matrix, that is $O(N_x^3 N_y^3)$, and this has to be paid at every energy, every
bias and every self-consistent iteration.
The recursion of the sixth chapter applies unchanged, since the matrix is block
tridiagonal, with the scalars of @rgf-right replaced by blocks,
$
  cal(G)^R_n = (E - alpha_n - beta_(n, n+1) cal(G)^R_(n+1) beta_(n+1, n))^(-1).
$ <rgf-2d>
#key[Each of the $N_x$ steps inverts and multiplies matrices of size $N_y$, so
the two-dimensional recursion costs $O(N_x N_y^3)$, against $O(N_x)$ in one
dimension.]

That factor $N_y^3$ is what makes the two-dimensional problem impractical.
A body resolved with $N_y = 20$ points, which is the least that resolves it,
costs $8000$ times a one-dimensional device: a second per iteration becomes two
hours per iteration, and one exercise session buys a single self-consistent
step.
The rest of the chapter is about removing this factor.

== Basis expansion of the Green's function

=== Expansion along the transverse direction

A function of one variable can be expanded in a basis, and if the basis is
orthonormal the coefficients are inner products.
The Green's function is a function of two grid points rather than one, and it is
expanded in the transverse variable alone, at each of its two arguments,
$
  G^R (x_(i_1) y_(j_1); x_(i_2) y_(j_2); E)
    = sum_(n m) tilde(G)^R_(n m) (x_(i_1); x_(i_2); E)
      phi.alt^(i_1)_n (y_(j_1)) phi.alt^(i_2 *)_m (y_(j_2)).
$ <basis-expansion>
#key[The transverse index $j$ is traded for a basis index $n$, and what is left,
$tilde(G)^R_(n m)$, carries one position argument and one basis index at each
end.]
The basis functions carry the column index as a superscript: the expansion uses
its own basis at each $x_i$, and nothing relates the basis at one column to the
basis at the next.

The expansion is exact under two conditions on the basis at each column,
$
  sum_j phi.alt^(i *)_n (y_j) phi.alt^i_m (y_j) = delta_(n m), \
  sum_n phi.alt^i_n (y_(j_1)) phi.alt^(i *)_n (y_(j_2)) = delta_(j_1 j_2),
$ <basis-conditions>
orthonormality on the left and completeness on the right.#note[
  The slides state both in the continuum, as an integral over $y$ and a Dirac
  delta. On the grid they are the two statements that the matrix of basis
  vectors has orthonormal columns and orthonormal rows.
]
#key[Completeness forces the number of basis elements $N_M$ to equal $N_y$, so
an exact expansion is a change of variables and nothing more.]
No approximation has been made yet, and no cost has been saved yet.

=== Matrix form

Collect the $N_M$ basis vectors at column $i$ as the columns of a matrix $u^i$
of size $N_y times N_M$, and the $u^i$ as the diagonal blocks of
$
  U = mat(
    u^1, 0, dots, 0;
    0, u^2, 0, dots.v;
    dots.v, dots.down, dots.down, dots.v;
    0, dots, 0, u^(N_x);
  ),
$
of size $N_x N_y times N_x N_M$.#note[
  The lectures call this matrix $V$, which is the potential energy everywhere
  else in the script. The script writes $U$.
]
Then the expansion @basis-expansion is a similarity transformation,
$
  G^R (E) = U tilde(G)^R (E) U^T,
$ <GF-transform>
and orthonormality @basis-conditions is $u^(i T) u^i = I$ block by block, hence
$U^T U = I$.

=== Transformed equation

Substituting @GF-transform into the Green's function equation @GF-2d and
multiplying by $U^T$ from the left and $U$ from the right turns the two factors
$U U^T$ that appear into identities, and leaves
$
  (E - U^T H_"RS" U - tilde(Sigma)^(R,B)) tilde(G)^R (E) = I,
$ <GF-MS>
a system of size $N_x N_M$.
The boundary self-energy is written $tilde(Sigma)^(R,B)$ because it is never
built in real space and transformed; it is computed directly in the new basis.

The transformed Hamiltonian $U^T H_"RS" U$ is still block tridiagonal, since
$U$ is block diagonal and multiplying by it does not move any block.
Its blocks are
$
  lambda_i = u^(i T) alpha_i u^i,
  quad
  gamma_(i_1 i_2) = u^(i_1 T) beta_(i_1 i_2) u^(i_2),
$ <lambda-gamma>
of size $N_M$.
#key[Nothing has been gained so far.
The problem has been rewritten in another basis, and as long as $N_M = N_y$ it
is the same problem in the same size.]
The gain has to come from choosing the basis so that few of its elements
suffice.

== Mode space approximation

=== Transverse modes

Look at the device along a cut line at fixed $x$, as on slide 21.
The electron sees a quantum well: a silicon film between two oxides whose
barriers are high, chosen so that the wave function decays inside them and
little current leaks to the gate.
#key[A quantum well has discrete bound states, the #term("transverse modes"),
with one maximum, two maxima and so on, and their spacing grows with the mode
index.]
Slide 22 shows the first four for a #qty(3, $"nm"$) body.

These modes are already in our hands.
#key[The transverse modes at $x_i$ are the eigenvectors of $alpha_i$,]
$
  alpha_i phi.alt^i_n = E^i_n phi.alt^i_n,
$ <mode-problem>
because $alpha_i$ is the discretized one-dimensional problem along $y$ at that
column, with the wave function forced to vanish at the two edges of the domain.
This is why the grid was ordered by columns: any other ordering hides this
problem instead of exposing it as a block.

Take the eigenvectors as the basis, $u^i = [phi.alt^i_1, ..., phi.alt^i_(N_M)]$.
Then the diagonal blocks @lambda-gamma are diagonalized by construction,
$
  lambda_i = u^(i T) alpha_i u^i = epsilon_i,
$ <epsilon-i>
with the mode energies $E^i_n$ on the diagonal of $epsilon_i$, and the
transformed Hamiltonian becomes
$
  H_"MS" = mat(
    epsilon_1, gamma_(1 2), 0, dots, dots;
    gamma_(2 1), epsilon_2, gamma_(2 3), 0, dots;
    0, dots.down, dots.down, dots.down, 0;
    dots.v, dots.down, gamma_(N_x - 1, N_x - 2), epsilon_(N_x - 1), gamma_(N_x - 1, N_x);
    0, dots, 0, gamma_(N_x, N_x - 1), epsilon_(N_x);
  ).
$ <H-MS>
The off-diagonal blocks $gamma_(i_1 i_2)$ are full matrices.

=== Truncation

#exam("L8.4")
The basis is now physical, and physics says which of its elements matter.
#key[Only the lowest modes are occupied: the Fermi level sits near the
conduction band edge even in a heavily doped source, so the first mode is
occupied, the second partly, the third barely.]
In a transport calculation the spectrum is continuous rather than discrete, and
the statement takes a second form there.
#key[Each mode that opens raises the transmission by one, so keeping $N_M$ modes
reproduces the first $N_M$ steps of the transmission function and nothing
above.]
Enough modes have been kept when the steps that carry current are all there.

#key[The #term("mode space approximation") is the truncation of the transverse
basis to the lowest $N_M$ modes, with $N_M << N_y$.]
For a body of #qty(3, $"nm"$) to #qty(6, $"nm"$), $N_M$ is between $3$ and $10$
where $N_y$ is $20$ or more.
The number need not be the same everywhere along the device: a wide section has
its modes closer together and more of them occupied, and takes more of them than
a narrow one.

This is the only approximation in the chapter.
Everything before it was a change of basis, and everything after it is
bookkeeping.

=== Coupled mode space

#exam("L8.5")
Solve @GF-MS with the truncated basis and the recursion @rgf-2d, whose blocks
are now of size $N_M$,
$
  cal(G)^R_n = (E - epsilon_n - gamma_(n, n+1) cal(G)^R_(n+1) gamma_(n+1, n))^(-1).
$ <cms-recursion>
#key[Since the $gamma$ are full, mode $n$ at one column couples to every mode
$m$ at the next, and the blocks have to be inverted as matrices.
This is the #term("coupled mode space approximation").]

Its cost is $O(N_x N_M^3)$, which for $N_M$ between $3$ and $10$ is between $27$
and $1000$ times a one-dimensional device.
Against the $8000$ of the real space recursion this is already a different
regime, and it is still $1000$ where the body is wide.

The next section removes the cube.
#key[If the $gamma$ were diagonal, mode $n$ at one column would couple only to
mode $n$ at the next, the mode space Hamiltonian @H-MS would fall apart into
$N_M$ tridiagonal problems of size $N_x$, and each mode could be solved on its
own.]
That is the difference between the two approximations, and the question is when
it holds.

== Uncoupled mode space approximation

=== Separable wave function

Return to the two-dimensional problem @se-2d and suppose there are transverse
modes that do not depend on $x$ at all,
$
  (- planck^2 / (2 m_0 m^*_y) dif^2 / (dif y^2) + V(x, y))
    phi.alt_n (y) = E_n (x) phi.alt_n (y),
$ <ums-modes>
holding at every $x$ with one and the same $phi.alt_n$.
#key[The eigenvalues are allowed to depend on $x$ and do; it is the modes that
must not.]

Under that assumption the wave function separates,
$
  phi(x, y) = sum_n theta.alt_n (x) phi.alt_n (y),
$ <ums-ansatz>
and substituting into @se-2d, using @ums-modes and projecting on $phi.alt_n$
leaves one equation per mode,
$
  (- planck^2 / (2 m_0 m^*_x) dif^2 / (dif x^2) + E_n (x)) theta.alt_n (x)
    = E theta.alt_n (x).
$ <ums-1d>
#key[This is a one-dimensional Schrödinger equation along the transport
direction, in which the mode energy $E_n (x)$ plays the part of the potential.]
An electron in mode $n$ travels along a device whose band edge is the variation
of that mode's energy from source to drain, and the modes never mix.

Discretized and opened at the two contacts, @ums-1d is the problem of the third
and sixth chapters verbatim,
$
  (E - H_n - Sigma_n^(R,B)) tilde(G)^R_n (E) = I,
$ <ums-GF>
with $H_n$ tridiagonal of size $N_x$ carrying $E_n (x_i)$ on its diagonal.
#key[The #term("uncoupled mode space approximation") is the replacement of one
two-dimensional problem by $N_M$ one-dimensional problems of this kind.]

=== Conditions

#exam("L8.6")
The two formulations agree exactly when the off-diagonal blocks
$gamma_(i_1 i_2) = u^(i_1 T) beta_(i_1 i_2) u^(i_2)$ are diagonal, and reading
that expression gives two conditions, one on each factor.

#key[First, all the entries of $beta_(i_1 i_2)$ must be equal, so that
$beta_(i_1 i_2) = beta I$ and the coupling drops out of the product.]
The entries @alpha-beta are the hopping energies along $x$ evaluated at each
$y_j$, so they are equal when the grid spacing along $y$ is homogeneous and no
material boundary crosses the transverse direction.

#key[Second, the modes must be the same at every column,
$u^(i_1 T) u^(i_2) = I$, which leaves $gamma_(i_1 i_2) = beta I$.]
This is the discrete form of the assumption @ums-modes, and it holds exactly
when the potential separates,
$
  V(x, y) = V_1 (x) + V_2 (y).
$ <separable-potential>
#key[A separable potential makes $alpha_(i+1) = alpha_i + (V_1 (x_(i+1)) -
V_1 (x_i)) I$, and adding a multiple of the identity leaves the eigenvectors
alone and shifts every eigenvalue by the same amount.]
So the modes are common to all columns and the mode energies $E_n (x)$ differ
from column to column by the shift of the electrostatic potential, which is
exactly the picture behind @ums-1d.

Neither condition survives contact with a real device, and they fail
differently.
#key[The first is violated by any transistor whose channel is held between
insulators, since that is a material variation along $y$ and the hopping
energies inside the oxide differ from those inside the semiconductor.
It is violated harmlessly: the wave function penetrates the oxide very little,
so the entries of $beta$ that are wrong are multiplied by mode amplitudes that
are nearly zero.]
#key[The second is violated wherever the device changes shape along the
transport direction, and that is not harmless, because the modes of a wide
section and of a narrow one are genuinely different functions.]
Such devices need the coupled approximation.

=== Cost and computational flow

#exam("L8.7")
The three steps of the mode space calculation are the same in both variants, and
in the uncoupled one each of them is cheaper.

The modes are computed once rather than once per column, since they do not
depend on $x$.
The mode energies are still needed everywhere, and they follow without a second
eigenvalue problem: with $phi.alt$ the modes of any one column,
$phi.alt^T alpha_i phi.alt$ is diagonal at every $i$ and carries the $E_n (x_i)$
on its diagonal.#note[
  Numerically the off-diagonal entries of $phi.alt^T alpha_i phi.alt$ are not
  exactly zero. That they are small compared with the diagonal is the practical
  test of whether the uncoupled approximation is admissible for the structure at
  hand.
]
Only the lowest $N_M$ eigenpairs of $alpha$ are wanted, so the diagonalization
is partial, which is what the ARPACK library and the routines built on it in
Matlab and Python provide.

The transport step solves $N_M$ tridiagonal problems @ums-GF of size $N_x$
instead of one block problem.
#key[The cost is $O(N_x N_M)$: a two-dimensional device costs $N_M$
one-dimensional devices, three to ten times a single one.]
Against the $O(N_x N_y^3)$ of the real space recursion, the factor $8000$ has
become a factor $10$.

#exam("L8.1")
Set beside a one-dimensional solver, the two-dimensional one needs the
following and nothing else.
The domain is discretized in two directions and the points are ordered column by
column, which turns the Hamiltonian into the block tridiagonal matrix @H-RS.
The boundary self-energies become blocks of size $N_y$, one per contact.
The transverse modes are obtained by diagonalizing the diagonal blocks
$alpha_i$, and the lowest $N_M$ of them define the mode space Hamiltonian
@H-MS.
The transport problem is then solved per energy, either as a block recursion
over $N_M times N_M$ blocks or as $N_M$ independent one-dimensional problems.
The resulting charge density is transformed back to real space, and Poisson's
equation @Poisson is solved in two dimensions, which no approximation touches.
The self-consistent loop around all of this is the one of the earlier chapters.

=== Back to real space

The mode space Green's function is not the quantity a device engineer wants, and
the expansion @basis-expansion runs backwards to recover the real space one.
In the uncoupled case it carries a single sum,
$
  G^R (x_(i_1) y_(j_1); x_(i_2) y_(j_2); E)
    = sum_n tilde(G)^R_n (x_(i_1); x_(i_2); E)
      phi.alt_n (y_(j_1)) phi.alt^*_n (y_(j_2)),
$ <ums-reconstruct>
since the modes no longer mix.

In practice the Green's function is not transformed at all.
#key[The charge density is computed mode by mode in mode space, giving a
one-dimensional density $n^m (x_i)$ per mode, and the two-dimensional density is
assembled from those,]
$
  n(x_i, y_j) = sum_m n^m (x_i) abs(phi.alt_m (y_j))^2,
$ <n-reconstruct>
each mode spreading its charge across the body according to its own probability
density.
This is what feeds the two-dimensional Poisson equation.

The current needs no transformation whatsoever.
#key[The transmission of a mode is the same quantity in both representations,
between $0$ and $1$ per mode, and the total transmission is their sum, between
$0$ and $N_M$.]
A one-dimensional solver, run once per mode, is therefore the whole engine of a
two-dimensional simulation.

== Scope of the approximation

=== Two open contacts

#key[The mode space approximation demands that exactly two contacts be open, and
they must be the two ends of the transport direction.]
The reason is in the transverse problem @mode-problem.
Diagonalizing $alpha_i$ solves the confined problem along $y$, and that problem
carries closed boundary conditions: the wave function is forced to vanish at the
top and the bottom of the domain.
A contact there would have to inject a wave function into a place where the
basis has none, so nothing can be injected from the gate.

Gate leakage is therefore outside the reach of the method, and slide 34 draws
what is being given up: a transfer characteristic whose subthreshold branch
saturates at the leakage floor instead of continuing down.
A hybrid solver treats the leaky region in real space and the rest in mode
space, and recovers it.#note[
  Luisier named this hybrid as work done in his own group.
]

=== Basis beyond effective mass

The second limitation is the basis itself.
#key[The approximation works well within the effective mass approximation, where
the modes of a well are few, ordered and easy to identify.]
With a multiband model, k·p, tight-binding or density functional theory, the
transverse problem produces spurious states among the physical ones, and
selecting the basis becomes a manual affair of filtering and refining.
The models that need the acceleration most are the ones that resist it.

Against those two, the advantages are speed, and an implementation that never
has to face two-dimensional open boundary conditions at all.

=== Examples

Slides 34 and 35 ask, of four structures, whether mode space applies and which
variant.
The rule to apply is the two conditions above, and the answer is read off the
geometry.

#key[A device whose cross-section widens toward the contacts, the dog bone of
slide 35, admits mode space, because the only open contacts are at the two ends
of the transport direction.
It needs the coupled variant, because the modes of the wide region are not the
modes of the narrow one.]
The mode count follows the geometry too: fifteen modes in the wide region and
three to five in the channel is a reasonable choice.
An asymmetric version of the same device answers the same way; symmetry is not
what the conditions ask about.

#key[A device contacted from the top and the bottom does not admit mode space in
the transverse expansion, for the reason gate leakage does not: the modes vanish
where the injection happens.]
Expanding along $x$ instead, with the modes running across the transport
direction, is legitimate and would need the coupled variant, but the direction
being expanded is now tens of nanometers wide and would need so many modes that
nothing is saved.
Both answers are defensible, and which one is given matters less than the
reason.

Nothing in the derivation is two-dimensional in an essential way.
#key[In a three-dimensional device the modes become functions $phi.alt_n (y, z)$
of the two confined directions, obtained from the same diagonal blocks, and
everything else stands.]

== Outlook

The chapter has taken a two-dimensional device down to the cost of a
one-dimensional one, by resolving the confined direction in a basis that a
handful of elements exhaust.
The next chapter goes further and asks what survives when the transport
direction is reduced to a single point, at the top of the potential barrier that
separates source from drain.
