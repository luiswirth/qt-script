# Open

Decisions that are mine to make, and gaps nothing else records.
Not a status log: what is done is in the history, what is convention is in
`CLAUDE.md`.

## Deferred by choice

- **A topic index built from `../slides/lectureN.txt`,**
  recording where each subject is treated, to make the decks searchable.
  Wanted once enough chapters exist to know what to index.
- **Whether the exercises enter the script at all,**
  taken up once every lecture is written and not before.
  Eleven sheets with solutions and Matlab and Python code sit in
  `../exercises/` and have never been examined.
  They are the practical half of the course and the script currently ignores them.
  Against them entering: `../exam-questions.md` draws on none of them,
  so nothing in the exam depends on the script covering them.
- **Whether `notes-style` stays the right base.**
  If the script grows dividers per topic block rather than per lecture,
  `area` and `section-style` come closer than notes do.

## Upstream in dottyp

- **`lesser` and `greater` rename the builtins `lt` and `gt`.**
  Kept because the Keldysh functions are named that way, so the name carries the
  physics rather than the glyph, but this is the borderline case of the
  convention against redefining what Typst provides.
