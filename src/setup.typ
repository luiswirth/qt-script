// The one place the library is imported, and the one place this document says
// how it departs from it. Everything else in script/ imports this file.

#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

// The dimension of a quantity, upright and bracketed. A quantity is introduced
// with its name and its units, since the lectures state neither and the symbols
// alone do not say what kind of object is meant.
#let unit(u) = $lr([#math.upright(u)])$

// Marks the passage answering a question of ../exam-questions.md by its id,
// several ids where it answers several. The tag goes in the margin, and the
// metadata carries the same ids, so the marks can be collected by query without
// parsing the source.
//
// The mark says where a question is answered and never what the answer is:
// the script is what the answers are practiced from, so writing them out here
// would spend the only material there is to be tested on.
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

// Equations are numbered because the script cross-references its own
// derivations, which notes-style does not do by default.
//
// Composed from article-document and notes-style by hand rather than through
// notes-document, which forwards its arguments only to the former and so cannot
// reach eq-numbering at all. Collapsing the two back into notes-document turns
// the numbering off and takes every cross-reference with it.
#let setup(body) = {
  show: article-document.with(
    title: title,
    author: author,
    colors: light-theme,
    fonts: sans-fonts,
  )
  show: notes-style.with(eq-numbering: "(1)")
  body
}
