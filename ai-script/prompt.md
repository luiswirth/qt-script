You are helping me create study scripts for the ETH course "Semiconductor Devices: Quantum Transport at the Nanoscale" (Luisier/Cao/Emboras). I will provide lecture slides (PDF) and auto-generated audio captions (originally VTT from video.ethz.ch; might have wrong transcriptions). You produce a Typst document that replaces the slides as his primary study material. One typst file per lecture.
Always consider the previous lectures and their typst documents, when doing the next one, so you don't rexplain any conepts, but instead reference and build on them.
You may adjust notation from the slides if something more natural or consistent across the series suggests itself.

## Notation guide (established conventions)

- `$planck$` for ℏ (not `hbar` or `planck.reduce`)
- `$m^*$` for effective mass, `$m_0$` for bare electron mass
- `avec(r)` for bold italic vectors, `amat(A)` for bold matrices
- `$E(avec(k))$` for dispersion, `$cal(E)_n$` for quantized confined energies
- `$f(E)$` for Fermi–Dirac, `$g(E)$` for DOS, `$P_avec(k)(avec(r))$` for probability density
- `$V_"ext"$` for the external potential in the EMA Schrödinger equation

## What to write

Transform the slides + transcript into a flowing narrative script. Do not merely reformat slides — rewrite the material so it is deeply understandable.

I have a decent mathematical physics background (PDE theory, functional analysis, numerics) but I'm not an expert in quantum mechanics or solid state physics. When the lecture uses a physics concept that is central to the derivation — whether from QM, solid state physics, or elsewhere — make it transparent: explain what it means, where it comes from, and connect it to intuitions he already has. Don't just state things; make them make sense.

The transcript contains off-script explanations, student Q&A, and practical advice that don't appear on the slides. Note: the captions are auto-generated and often garbled (mixed German/English, misspelled terms, unintelligible stretches). Use context and the slides to reconstruct what the lecturer meant rather than interpreting broken text literally.

The script is for studying, not for archiving the lecture. Skip organizational content (logistics, registration reminders, exercise format, industry anecdotes, simplistic analogies) and focus entirely on the physics, math, and engineering content that would appear on an exam or that's needed to understand later lectures. But be thorough with the actual study content — nothing technical should go missing. When the lecturer gives a hand-wavy analogy but the underlying point is technically interesting, replace the analogy with a proper explanation.

Write in prose with equations integrated into the flow. Follow the logical structure of the ideas, which may differ from the slide order. Keep any recap of prior lectures short — just enough context to make the current material self-contained. Use numbered equations with cross-references where it helps readability.

When a slide contains a diagram, plot, or image that carries real information (band structures, spectral current maps, device cross-sections, DOS comparisons), point the reader to look at the specific slide rather than trying to describe the visual in words.

The lecturer occasionally drops explicit exam hints in the transcript. Flag these clearly — e.g., with a parenthetical "(exam hint)" — so they stand out during review.

When there's a natural connection to mathematical physics, that he is already familiar with, mention it briefly as an anchoring remark — but don't develop it into a detour. The script should stay focused on the physics at hand.
