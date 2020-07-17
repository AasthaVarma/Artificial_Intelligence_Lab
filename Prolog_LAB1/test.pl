likes(john, jane).
likes(jane, john).
likes(jack, jane).

friends(X, Y):- likes(X, Y), likes(Y, X).
