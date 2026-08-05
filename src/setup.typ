#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

// A unit symbol is spelled in letters, k g rather than the string "kg", which
// is a text run and takes a space before a slash.
#let unit(u) = $lr([#math.upright(u)])$

#let qty(value, u) = $value thin #math.upright(u)$

// The name is a string and never markup, so the collected vocabulary needs no
// conversion.
#let term(name) = {
  metadata((kind: "term", name: name))
  emph(name)
}

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

// The sections are found by location rather than by walking the body, which is
// the only description that survives a section being wrapped in anything.
#let chapter(title, body) = {
  pagebreak(weak: true)
  heading(level: 1, title)

  context {
    let start = here()
    let sections = selector(heading).after(start)
    let following = query(heading.where(level: 1).after(start))
    if following.len() > 0 {
      sections = sections.before(following.first().location())
    }
    outline(title: none, target: sections, depth: 3)
  }

  body
}

// Composed by hand rather than through notes-document, which cannot reach
// eq-numbering. Collapsing the two turns the numbering off and takes every
// cross-reference with it.
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
