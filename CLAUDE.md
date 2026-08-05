# Quantum Transport study script

A Typst script for the ETH course 227-0159-00, written from the lecture slides
and recording captions, which sit in the parent directory and are not part of
this repository. `../CLAUDE.md` carries the course and exam facts, and
`prompt.md` the brief this script is written to.

## Layout

- `src/main.typ`:
  the title, the outline, and the lectures it includes.
- `src/setup.typ`:
  the only importer of dottyp, and the only place the document states how it
  departs from it.
- `src/lectureN.typ`:
  one file per lecture.
- `lib/dottyp`:
  the notation and template library, vendored as a submodule.
- `build.sh`, `watch.sh`:
  compile to `out/script.pdf`. Both export `TYPST_PACKAGE_PATH` themselves and
  cd to this directory, so a build expects nothing of the environment and runs
  from anywhere.

## Reading the sources

A deck is read as page images. Its displayed equations are graphics with no text
layer, so `pdftotext` drops every one of them while leaving the sentence that
introduces it, which is worse than useless.

What the text is for is choosing which pages to read, which costs nothing since
only page numbers come back. `../slides/lectureN.txt` holds the extraction, one
form-feed-delimited record per page, so a page is addressed by its record
number. The agenda slides are revealed progressively and repeat, a third of some
decks, and carry nothing after the first:

    awk 'BEGIN{RS="\f"} /Summary of today/{print NR}' ../slides/lectureN.txt

The captions in `../recordings/lectureN.txt` already have their timestamps
stripped, a third of the file. That directory is a repository of its own and
holds the raw WebVTT in its history.

## Conventions

- One document, not one per lecture, so a later lecture cites the derivations of
  an earlier one instead of repeating them. This is why equation numbering is
  turned on, which dottyp's `notes-style` leaves off by default.
- The reduced Planck constant is `h.bar`, since Typst reads `planck` as $h$.
  Written natively in math rather than aliased, as are $m^*$ for the effective
  mass and $m_0$ for the bare electron mass.
- Notation general enough to outlive this course belongs in dottyp, not in
  `setup.typ`. A name is promoted once the script has actually written it.
- Provenance is marked per the global guidelines.
  A lecture reaches `ai-approved` only once it has been read against the slides.
