include "alldifferent.mzn";

int: N;
array[1..N, 1..N] of var int: start;
array[1..N, 1..N] of var int: square;


% If the value is different from 0, it means that it already has a color, so 
% the final square will have the same values of start's square.
constraint forall(i in 1..N, j in 1..N where start[i, j] > 0)(square[i, j] = start[i, j]);

constraint forall(i in 1..N)(
            alldifferent([square[i, j] | j in 1..N])::domain );
                        
constraint forall(j in 1..N)(
            alldifferent([square[i, j] | i in 1..N])::domain
);


solve satisfy;