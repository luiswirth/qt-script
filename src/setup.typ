#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

// The equations the field names, cited by name rather than by number.
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
  "DOS",
  "BDD",
)

// A passage answering a listed exam question, tagged in the margin and left as
// metadata, so what a question is answered by can be collected without parsing
// the source.
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

// A remark on the sources rather than on the subject, which is why it leaves
// the prose.
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
  body
}
