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
  "Poisson",
  "GF",
)

#let symbol-equations = (
  "mfp": $lambda_"mfp"$,
  "schroedinger-k": $"SE"_avec(k)$,
  "prob-density": $P$,
  "carrier-density": $n_avec(k)$,
  "DOS": $g$,
  "n-from-g": $n_E$,
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
  "n-noneq": $n_c$,
  "obc-prob": $P^c$,
  "energy-split": $E(k_c, avec(k)_t)$,
  "sum-to-integral-1d": $(sum arrow.r integral)_"1D"$,
  "g-obc": $g^c$,
  "g-velocity": $g^c (v)$,
  "FI": $F$,
  "n-obc": $n(x)$,
  "i-tot": $I_"tot"$,
  "i-charge-velocity": $I_(L R) (E)$,
  "i-lr": $I_(L R)$,
  "i-rl": $I_(R L)$,
  "T-symmetry": $T(E)$,
  "prob-current-1d": $j(x)$,
  "charge-density": $rho$,
  "discrete-poisson": $M Phi$,
  "poisson-residual": $F(Phi)$,
  "jacobian": $J$,
  "newton": [NR],
  "potential-energy": $V(x)$,
  "source-problem": $L f$,
  "GF-solution": $f(x)$,
  "G-1D": $G_"1D"$,
  "G-ansatz": $A^plus.minus$,
  "G-jump": [jump],
  "retarded": $G^R (x, x')$,
  "advanced": $G^A (x, x')$,
  "ieta": $E + i eta$,
  "retarded-matrix": $G^R$,
  "wf-from-GF": $phi = G^R S$,
  "wf-square": $phi phi^dagger$,
  "lesser-SE": $Sigma^(<)$,
  "lesser-GF": $G^(<)$,
  "n-lesser": $n(G^(<))$,
  "lesser-contact": $Sigma^(<)_(c c)$,
  "broadening": $Gamma$,
  "broadening-contact": $Gamma_(c c)$,
  "lesser-broadening": $Sigma^(<) (Gamma)$,
  "lesser-split": $Sigma^(<) = i sum_c Gamma^c F$,
  "g-GF": $g^c (Gamma)$,
  "hole-FI": $macron(F)$,
  "p-wf": $p$,
  "greater-SE": $Sigma^(>)$,
  "greater-GF": $G^(>)$,
  "p-greater": $p(G^(>))$,
  "greater-contact": $Sigma^(>)_(c c)$,
  "phi-last": $abs(phi^L_N)^2$,
  "T-GF": $T_(L R) (G)$,
  "contour-GF": $G(1, 2)$,
  "four-GF": $G^(<), G^(>)$,
  "dyson": [Dyson],
  "keldysh": [Keldysh],
  "GF-relation": $G^(>) - G^(<)$,
  "SE-relation": $Sigma^(>) - Sigma^(<)$,
  "spectral": $A$,
  "spectral-DOS": $A(g)$,
  "rgf-right": $cal(G)^R_n$,
  "rgf-reconstruct": $G^R_(n n), G^R_(n 1)$,
  "continuity": [continuity],
  "n-time": $n(t)$,
  "eom-t": $partial_t G^(<)$,
  "eom-tprime": $partial_(t') G^(<)$,
  "charge-rate": $partial_t rho_n$,
  "conservation-raw": [collision term],
  "current-continuum": $avec(J)_n$,
  "current-discrete": $J_n (x_i)$,
  "conservation": $Sigma^(<) G^(>)$,
  "bose": $N_"ph"$,
  "eph-lesser": $Sigma^(<)_"e-ph"$,
  "eph-greater": $Sigma^(>)_"e-ph"$,
  "eph-retarded": $Sigma^R_"e-ph"$,
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
