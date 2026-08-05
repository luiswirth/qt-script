# Open

Decisions that are mine to make, and gaps nothing else records.
Not a status log: what is done is in the history, what is convention is in
`CLAUDE.md`.

## Deferred by choice

- **Sans math is on trial.**
  `setup.typ` sets the document light and sans, both one word.
  Sans math is unusual in physics writing, so either confirm it or revert;
  serif math under sans prose is a third option and would need dottyp to expose
  the pair separately.
- **Whether `notes-style` stays the right base.**
  If the script grows dividers per topic block rather than per lecture,
  `area` and `section-style` come closer than notes do.
- **A topic index built from `../slides/lectureN.txt`,**
  recording where each subject is treated, to make the decks searchable.
  Wanted once enough chapters exist to know what to index.
- **Whether the exercises enter the script at all.**
  Eleven sheets with solutions and Matlab and Python code sit in
  `../exercises/` and have never been examined.
  They are the practical half of the course and the script currently ignores them.

## Upstream in dottyp

- **`notes-document` cannot reach the parameters of `notes-style`,**
  since it forwards its arguments to `article-document` alone,
  so `eq-numbering` and `heading-numbering` are exactly the two settings a caller
  cannot make.
  `setup.typ` composes the two by hand to work around it.
  The fix is to name both in the wrapper and forward them.
- **`lesser` and `greater` rename the builtins `lt` and `gt`.**
  Kept because the Keldysh functions are named that way, so the name carries the
  physics rather than the glyph, but this is the borderline case of the
  convention against redefining what Typst provides.

## Risks

- **The script repository has no remote,**
  so it exists on one disk.
- **The captions cannot be regenerated.**
  No video is kept, and `../recordings` holds the only copy outside video.ethz.ch,
  in its own repository which also has no remote.
