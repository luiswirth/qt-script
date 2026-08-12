#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

#let named-equations = (
  "DD",
  "BTE",
  "SE",
  "dB",
  "MBSE",
  "SPSE",
  "Bloch",
  "FD",
  "EMA",
  "BDD",
  "norm",
  "phase",
  "parabola",
  "aniso",
  "row",
  "OBC",
  "LB",
)

#let symbol-equations = (
  "mfp": $lambda_"mfp"$,
  "schroedinger-k": $"SE"_avec(k)$,
  "prob-density": $P$,
  "carrier-density": $c_avec(k)$,
  "DOS": $g$,
  "c-from-g": $c_E$,
  "effective-mass": $m^*$,
  "m-dos": $m_"DOS"$,
  "bulk-solution": $psi_"bulk"$,
  "sum-to-integral": $sum arrow.r integral$,
  "g-bulk": $g_"bulk"$,
  "v-qw": $V_"QW"$,
  "qw-schroedinger": [QW],
  "qw-ansatz": $psi_"QW"$,
  "qw-1d": $"QW"_"1D"$,
  "infinite-well": $"QW"_infinity$,
  "infinite-well-solution": $E_n$,
  "kappa": $kappa$,
  "g-qw": $g_"QW"$,
  "g-qw-av": $g_("QW,av")$,
  "qw-general": $"QW"_"het"$,
  "discrete-hamiltonian": $H_(i j)$,
  "hopping": $t$,
  "discrete-se": $"SE"_i$,
  "barrier-ansatz": $phi_"barrier"$,
  "transmission": $T_(L R)$,
  "contact-ansatz": $phi_"contact"$,
  "contact-entries": $D_L, T_L$,
  "three-rows": $i = 1, 0, -1$,
  "sampled-ansatz": $phi_(-n)$,
  "dispersion-row": [contact row],
  "contact-dispersion": $k_L$,
  "discrete-band": $E(k_L)$,
  "reflection": $b_L$,
  "boundary-relation": $phi_0$,
  "bias": $E_F^R$,
  "c-noneq": $c_alpha$,
  "obc-prob": $P^alpha$,
  "energy-split": $E(k_alpha, avec(k)_t)$,
  "sum-to-integral-1d": $(sum arrow.r integral)_"1D"$,
  "g-obc": $g^alpha$,
  "g-velocity": $g^alpha (v)$,
  "FI": $F$,
  "c-obc": $c(x)$,
  "i-tot": $I_"tot"$,
  "i-charge-velocity": $I_(L R) (E)$,
  "i-lr": $I_(L R)$,
  "i-rl": $I_(R L)$,
  "T-symmetry": $T(E)$,
  "prob-current-1d": $j(x)$,
)

// The metadata leaves what a question is answered by collectable without
// parsing the source.
#let exam(..ids) = {
  let ids = ids.pos()
  metadata((kind: "exam", ids: ids))
  context place(
    left,
    dx: -3cm,
    box(width: 2.6cm)[
      #set align(right)
      #set text(size: 7pt, fill: palette.get().accent, weight: "medium")
      #ids.join(sym.space.thin)
    ],
  )
}

#let note(body) = {
  metadata((kind: "note"))
  footnote(body)
}

#let setup(body) = {
  show: notes-document.with(
    title: title,
    author: author,
    colors: light-theme,
    fonts: sans-fonts,
  )
  show: tag-equations.with(named-equations)
  show: tag-symbols.with(symbol-equations)
  body
}
