include "globals.mzn";

% Parameters
int: n;  
int: w;  
int: h; 
array[1..n] of var int: ws;
array[1..n] of var int: hs;

array[1..n] of var int: X;
array[1..n] of var int: Y;
array[1..n] of var int: perimeter;

%array[1..n] of var int: ordxered_perimeter;

array[1..n] of var 0..w: shapeX; 
array[1..n] of var 0..h: shapeY; 

% Each shape must be inside the square
constraint forall(i in 1..n)(shapeX[i] >= 0 /\ shapeX[i] + ws[i] <= w /\ shapeY[i] >= 0 /\ shapeY[i] + hs[i] <= h);

% calculation of the perimeter
constraint forall (i in 1..n) (perimeter[i]=2*(ws[i]+hs[i]));

array[1..n] of var 1..n: ordered_indices=reverse(sort(perimeter));

constraint diffn([shapeX[i] | i in ordered_indices],
                 [shapeY[i] | i in ordered_indices],
                 [ws[i] | i in ordered_indices],
                 [hs[i] | i in ordered_indices]);

%ordered perimeter

%constraint ordered_perimeter= forall(i in 1..n)(index_set_reverse(sort_by(perimeter,i));
%constraint forall (i in 1..n)(order_perimeter[i]
%constraint ordered_perimeter= index_set_reverse(sort_by(perimeter,i));

% No overlap with diffn global constraint
constraint diffn(shapeX, shapeY, ws, hs);


solve satisfy;

%input order - min value
%solve:: int_search(q,input_order,indomain_min) satisfy;

%input order - random value
%solve:: int_search(q,input_order, indomain_random)