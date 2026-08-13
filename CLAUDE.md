# Quantum Transport study script

A Typst script for the ETH course 227-0159-00, written from the lecture slides
and recording captions, which sit in the parent directory and are not part of
this repository. `../CLAUDE.md` carries the course and exam facts, and
`prompt.md` the brief this script is written to, read before writing a chapter.

The script is a reference for grounding explanations, not a study text.
It is written from the sources ahead of a session and read back during one.
The studying happens in conversation, and the framings that come out of it go
to `atlas` rather than here.

## Layout

- `src/main.typ`:
  the title, the outline, and the lectures it includes.
- `src/setup.typ`:
  the only importer of dottyp, and the only place the document states how it
  departs from it.
- `src/lectureN.typ`:
  one file per lecture.
- `lib/dottyp`:
  the notation and template library, vendored as a submodule and never edited
  here. It carries the Typst conventions this script is written to.
- `flake.nix`:
  the Typst toolchain, entered by direnv interactively and by the build scripts
  themselves otherwise, a non-interactive shell loading no direnv.
- `build.sh`, `watch.sh`:
  compile to `out/script.pdf`. Both export `TYPST_PACKAGE_PATH` themselves and
  cd to this directory, so a build expects nothing of the environment and runs
  from anywhere.
- `.github/workflows/typst-deploy.yml`:
  a push to main publishes the PDF at <https://lwirth.com/quantum-transport-script/>.
  The repository is private and that page is not.

## Reading the sources

A deck is read as page images. Its displayed equations are graphics with no text
layer, so `pdftotext` drops every one of them while leaving the sentence that
introduces it, which is worse than useless.

What the text is for is choosing which pages to read, which costs nothing since
only page numbers come back. `../slides/lectureN.txt` holds the extraction, one
form-feed-delimited record per page, so a page is addressed by its record number.
The whole deck fits in one map of a line per page, which is what the choice is
made from:

    awk 'BEGIN{RS="\f"} {t=$0; gsub(/\n/," ",t); gsub(/ +/," ",t);
      printf "%d| %.70s\n", NR, t}' ../slides/lectureN.txt

The agenda slides are revealed progressively and repeat, a third of some decks,
and carry nothing after the first.
They are the ones matching `Summary of today`.
A page carrying no text at all is a figure slide and has to be looked at.
A page carrying its title alone was developed on the board, and the captions are
its only record.

Note that a range is the only thing the reader accepts, never a list of pages,
so a deck with the boilerplate cut out is read in several goes.

The captions in `../recordings/lectureN.txt` already have their timestamps
stripped, a third of the file. That directory is a repository of its own and
holds the raw WebVTT in its history.

## Conventions

- One document, not one per lecture, so a later lecture cites the derivations of
  an earlier one instead of repeating them.
- Each lecture applies `chapter` as a show rule, which starts it on a fresh page
  and opens it with an outline of its own sections. The outline in `main.typ`
  reaches the chapters and their sections.
- Headings are noun phrases and take no article. The script is read to find a
  subject again, not from front to back.
- Every labelled equation is named in `setup.typ`, by its own label through
  dottyp's `named-equations` or by a symbol through the local `symbol-equations`,
  which the library cannot carry because a label cannot spell a symbol.
- Figures stay in the slides and are pointed at by slide number.
  They carry other people's copyright, and embedding them would make the script
  unpublishable.
  A schematic may be redrawn instead, but only one simple enough to come out
  right in plain Typst at the first attempt;
  anything whose appearance would have to be iterated on is referenced.
- A quantity is introduced with its name and with its definition wherever that
  is short enough to be worth having.
  Of its units, a length, a time, a velocity or an energy carries none, a
  mobility does.
  A unit stated in prose rather than through `unit` is reserved for the rare
  case where the dimension is itself the point, as it is for the wave function.
  Where the course overloads a letter, the script gives each meaning its own
  symbol and says nothing further about it, as the electric field is `cal(E)`
  because `E` is an energy.
  Everywhere else the symbols are the lectures', a symbol of the script's own
  being one more thing to carry and one more collision to inherit downstream.
- A term earns the `#term` mark by being load-bearing, the theory being
  unstatable without it, and takes it where it is properly introduced rather
  than where it is first mentioned. It is marked again wherever it carries a
  later section, never twice in one passage.
  What the script defines can then be checked against the lectures rather than
  reread.
- A passage answering a listed exam question is marked with `#exam`, which tags
  the margin and leaves queryable metadata, so what a question is answered by
  can be collected without parsing the source. The mark sits on the narrowest
  passage that carries the whole answer, never on a section that merely contains
  one. Its id names the question and not the chapter, so a question listed under
  a later lecture is marked where the derivation it asks for is actually made.
  The script holds no answer written as one, since it is the material the
  answers are practiced from.
- A `#key` marks the statement a section exists for, and takes as many sentences
  as that statement needs. A section carries one, two where it states two
  things, and none where it states none. Never compress several ideas into one
  sentence to fit a mark.
- A remark about the sources rather than about the subject is a `#note`, which
  sets it as a footnote, and prose that would carry it is deleted instead.
- Provenance is marked per the global guidelines.
- The script speaks as we, never as you.

### Deviations from the lectures

Where the lectures' notation is inconsistent or forces a special case, the
script replaces it rather than inherits it, and marks the replacement at its
defining occurrence with a `#note` naming the lectures' form, since the exam is
answered in their vocabulary. Listed here are only the deviations that change
how something is stated, never a symbol chosen differently.

- The carrier charge is signed, and every quantity derived from it carries that
  sign, the mobility included. The lectures leave it unsigned and carry
  magnitudes, which is what forces them to split drift-diffusion into one
  equation per species where the script keeps a single one with the species as
  a parameter.
