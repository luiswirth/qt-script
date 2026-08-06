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
  strong(name)
}

// An equation whose name is what it is cited by carries that name in place of
// its number, wherever it is set and wherever it is referenced.
#let eq-tags = (
  "drift-diffusion": "DD",
  "bte": "BTE",
  "schroedinger": "SE",
  "de-broglie": "dB",
  "many-body": "MBSE",
  "single-electron": "SPSE",
  "bloch": "Bloch",
  "fermi": "FD",
  "ema": "EMA",
  "dos": "DOS",
  "variable-mass-operator": "BDD",
)

// The tag is set on the equation rather than drawn onto it, which is what
// leaves the reference to Typst. It is a function and never a pattern, in which
// the letters that count would be counted. One rule reaches one label, so the
// dictionary is folded over the body.
#let tag-equations(names, body) = {
  if names.len() == 0 { return body }
  [
    #show label(names.first()): set math.equation(
      numbering: _ => "(" + eq-tags.at(names.first()) + ")",
    )
    #tag-equations(names.slice(1), body)
  ]
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

// The sentence the section has to be able to state out loud, marked so that a
// script already read once can be skimmed. The brackets hug the text, a line
// break next to one being painted along with it.
#let key(body) = {
  metadata((kind: "key", body: body))
  // Typst's highlight is a text decoration and leaves inline math unpainted.
  context highlight(fill: palette.get().marker, body)
}

// A remark on the sources rather than on the subject, which is why it leaves
// the prose.
#let note(body) = {
  metadata((kind: "note"))
  footnote(body)
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

  show: tag-equations.with(eq-tags.keys())

  // An equation earns a number by being referenced, and a label is what a
  // reference needs, so the labelled ones are exactly the numbered ones.
  // A tagged equation steps the counter like any other, and a tag is what a
  // number is instead of, so both it and an unreferenced display take their
  // step back.
  show math.equation.where(block: true): it => {
    if it.numbering == none {
      it
    } else if type(it.numbering) == function {
      it
      counter(math.equation).update(n => n - 1)
    } else if it.has("label") {
      it
    } else {
      math.equation(block: true, numbering: none, it.body)
      counter(math.equation).update(n => n - 1)
    }
  }

  // A tag names a label that lives in another file, which is the one thing that
  // can silently fall apart.
  context {
    for name in eq-tags.keys() {
      assert(
        query(label(name)).len() > 0,
        message: "eq-tags names no equation: " + name,
      )
    }
  }

  body
}
