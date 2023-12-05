include "alldifferent.mzn";
include "gecode.mzn";

% Number of Queens
int: n; 

% Variables for queens on the rows 
array[1..n] of var 1..n: q;

constraint alldifferent(q)::domain;

% Column attack constraint
constraint alldifferent([q[i] + i | i in 1..n])::domain;

% Diagonal attack constraint
constraint alldifferent([q[i]-i | i in 1..n])::domain;

solve satisfy; 