// The one place the library is imported, and the one place this document says
// how it departs from it. Everything else in script/ imports this file.

#import "@local/dottyp:0.1.0": *

#let title = "Quantum Transport at the Nanoscale"
#let author = "Luis Wirth"

// The dimension of a quantity, upright and bracketed. A quantity is introduced
// with its name and its units, since the lectures state neither and the symbols
// alone do not say what kind of object is meant.
//
// A unit symbol is written as a math identifier, and as a string only where no
// identifier exists, which is the multi-letter names such as "nm" and "eV".
// A string beside a slash is spaced as a text operand and comes out wrong.
#let unit(u) = $lr([#math.upright(u)])$

// A value carried with its unit, which is a different statement from the one
// unit makes: this many of these, rather than this symbol has this dimension.
// Hence no brackets, and hence never a bare number beside a unit in prose.
#let qty(value, u) = $value thin #math.upright(u)$

// The defining occurrence of a term. Renders as the emphasis it would carry
// anyway, and leaves the name queryable, so that what the script defines can be
// collected and checked against the lectures rather than reread.
//
// The name is a string and not content, a term being a name and never markup,
// which is what keeps the collected vocabulary readable without a conversion.
#let term(name) = {
  metadata((kind: "term", name: name))
  emph(name)
}

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

// One lecture. Each src/lectureN.typ applies this as a show rule, so that a
// chapter starts on a fresh page and opens with an outline of its own sections.
// The outline in main.typ lists the chapters alone, the sections being reached
// through the chapter they belong to.
//
// The sections are found by location rather than by walking the body: they are
// the headings between this chapter's heading and the next one, which is the
// only description that survives a section being wrapped in anything.
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
