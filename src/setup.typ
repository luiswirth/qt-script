// The one place the library is imported, and the one place this document says
// how it departs from it. Everything else in script/ imports this file.

#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

// Equations are numbered because the script cross-references its own
// derivations, which notes-style does not do by default.
#let setup(body) = {
  show: article-document.with(
    title: title,
    author: author,
    colors: dark-theme,
    fonts: serif-fonts,
  )
  show: notes-style.with(eq-numbering: "(1)")
  body
}
