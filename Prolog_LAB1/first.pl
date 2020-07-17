go:-
hypothesis(medium),
write('medium is'),
write(Disease).

/*Hypothesis that should be tested*/
hypothesis(workshop) :- workshop, !.
hypothesis(lecture_tutorial) :- lecture_tutorial, !.
hypothesis(videocassette) :- videocassette, !.
hypothesis(role_play):- role_play, !.
hypothesis(unknown).

workshop:-
    physicalobject->stimulus_situation,
    hands_on->stimulus_response,
    required->feedback.

lecture_tutorial:-
     (   symbolic->stimulus_situation,analytical->stimulus_response, required->feedback);




verbal :-
verify(papers);
verify(manuals);
verify(documents);
verify(textbooks).

visual :-
verify(pictures);
verify(illustrations);
verify(photographs);
verify(diagrams).

physicalobject:-
verify(machines);
verify(buildings);
verify(tools).

symbolic :-
verify(numbers),
verify(formulas),
verify(computer_programs).

malaria :-
verify(fever),
verify(sweating),
verify(headache),
verify(nausea),
verify(vomiting),
verify(diarrhea),
write('Advices and Sugestions:'),
nl,
write('1: Aralen/tab'),
nl,
write('2: Qualaquin/tab'),
nl,
write('3: Plaquenil/tab'),
nl,
write('4: Mefloquine'),
nl,
write('Please do not sleep in open air and cover your full skin Because'),
nl.

/* how to ask questions */
ask(Question) :-
write('Does the patient have following symptom:'),
write(Question),
write('? '),
read(Response),
nl,
( (Response == yes ; Response == y)
->
assert(yes(Question)) ;
assert(no(Question)), fail).

:- dynamic yes/1,no/1.
/*How to verify something */
verify(S) :-
(yes(S)
->
true ;
(no(S)
->
fail ;
ask(S))).
/* undo all yes/no assertions*/
undo :- retract(yes(_)),fail.
undo :- retract(no(_)),fail.
undo.











