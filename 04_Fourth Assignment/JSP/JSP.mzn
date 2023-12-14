include "globals.mzn";

int: M;                                                    % Number of machines = number of tasks
int: J;                                                    % Number of jobs

set of int: MACH = 1..M;
set of int: TASK = 1..M; 
set of int: JOB = 1..J;

array[JOB, TASK] of MACH: machine;                         % machines for tasks
array[JOB, MACH] of int: duration;                         % task durations on machines

int: maximum_duration= sum(duration);                      % maximum duration of tasks
array[JOB, MACH] of var 0..maximum_duration: start;

% ------ Makespan ------
var int: makespan = max(job in JOB, machines in MACH)(start[job, machines] + duration[job, machines]); 

% ------ Precedence constraint ------
constraint forall(i in 1..J, j in 1..(M-1))(start[i, machine[i, j + 1]] >= start[i, machine[i, j]] + duration[i, machine[i, j]])::domain;

% ------ Disjunctive constraint ------
constraint forall(mach in MACH)(disjunctive(start[JOB, mach], duration[JOB, mach]))::domain;

% ------ Default Search ------
% solve minimize makespan; 

% ------ Indomain Min ------
solve :: int_search(start, smallest, indomain_min) minimize makespan;

% Output makespan
output ["Makespan: \(makespan)"] ++ ["\nStart times:\n"] ++ [show(start)];