= Quantum Transport at the Nanoscale

Study repository for the ETH course 227-0159-00, Spring Semester 2026,
lectured by M. Luisier, J. Cao and A. Emboras.
The full course description is in `vvz.txt`.

## Exam

- Oral, 30 minutes, in English, examined by M. Luisier.
- Tue 18.08.2026, 09:00-09:30, ETZ J 82.
- Everything must be sayable out loud: derivations sketched on paper, no lookup.
- Lectures 11 and 13 are not exam relevant.

## Layout

- `slides/lectureN.pdf`:
  the official slides, 13 lectures, the primary source.
- `recordings/lectureN.vtt`:
  auto-generated captions from video.ethz.ch.
- `exercises/exerciseN/`, `exercises/solutionN/`:
  problem sheets with Matlab and Python code, 11 sets.
- `ai-script/`:
  a per-lecture Typst study script generated from slides plus captions,
  and `prompt.md`, the instructions that produced it.

## Sources

- Recommended textbook is Datta, *Electronic Transport in Mesoscopic Systems*, 1997.
- The captions are good enough to study from: punctuation and sentence structure
  are intact and technical terms survive, so re-transcribing is not worth it.
  What they get wrong is names, casing and the odd homophone, reconstructed from
  the slides rather than read literally.
- `recordings/*.mp4` are zero-byte, so nothing can be regenerated from video.

## Conventions

- Notation and templates come from `@local/dottyp`, vendored as `lib/dottyp`,
  never a path in the environment.
- Provenance is marked per the global guidelines.
  `ai-script/` currently carries `ai-unchecked`, and a lecture moves to
  `ai-approved` only once it has been read against the slides.
