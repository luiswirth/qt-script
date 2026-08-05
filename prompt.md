# Writing a chapter

Given one lecture, its slides in `../slides/` and its captions in `../recordings/`,
write `src/lectureN.typ` and include it from `src/main.typ`.
Read the chapters already written first and build on them.

The chapter replaces the slides as the thing I study from.
Nothing technical may go missing, and it follows the logic of the ideas
rather than the order of the slides.
Where the slides fix a notation that a better one suggests itself for,
change it, and carry the change through the chapters that follow.

Leave out what is not the subject:
logistics, exercise mechanics, industry anecdotes.
Where an analogy stands in for an explanation, write the explanation.

The questions listed under this lecture in `../exam-questions.md` are the exam
itself, Luisier having said so, and they set what the chapter owes its reader.
Treat each as a claim the chapter must make good on: the passage it points at
has to carry the whole answer, in the depth an oral examination asks for, with
the derivation sketched rather than named and the definitions it rests on
stated. Where the slides leave a step implicit and a question asks for it, the
step is the chapter's to supply. A chapter is not finished while a question of
its lecture has nothing that answers it.

Mark such a passage with `#exam("L3.4")` at its first line, several ids where it
answers several. The mark says where the answer is and never states it as an
answer: no question is quoted, and nothing is phrased as a reply to one. The
chapter reads as an exposition, and the marks are what makes it practicable
later.

The captions carry what the slides do not,
the asides and the student questions and the occasional explicit exam hint.
Mark a hint as one.

Point at a slide by its number for a figure that carries information,
rather than describing it in words.
