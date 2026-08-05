#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

// The dimension of a quantity. Takes a math identifier, a string only where
// none exists, such as "nm": a string beside a slash is spaced as a text
// operand and comes out wrong.
#let unit(u) = $lr([#math.upright(u)])$

// A value with its unit, which states this many of these rather than a
// dimension.
#let qty(value, u) = $value thin #math.upright(u)$

// The defining occurrence of a term, left queryable. The name is a string and
// never markup, so the collected vocabulary needs no conversion.
#let term(name) = {
  metadata((kind: "term", name: name))
  emph(name)
}

// Marks the passage answering questions of ../exam-questions.md by their ids,
// in the margin and as queryable metadata.
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

// One lecture, applied as a show rule by each src/lectureN.typ. Its sections
// are found by location rather than by walking the body, which is the only
// description that survives a section being wrapped in anything.
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
