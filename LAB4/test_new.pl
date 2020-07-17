parent(sam, mark).
parent(mark, jim).

grandparent(GP, CHILD):- parent(GP, PARENT), parent(PARENT, CHILD).

