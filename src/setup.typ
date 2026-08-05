// The one place the library is imported, and the one place this document says
// how it departs from it. Everything else in script/ imports this file.

#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

// The dimension of a quantity, upright and bracketed. A quantity is introduced
// with its name and its units, since the lectures state neither and the symbols
// alone do not say what kind of object is meant.
#let unit(u) = $lr([#math.upright(u)])$

// Equations are numbered because the script cross-references its own
// derivations, which notes-style does not do by default.
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
