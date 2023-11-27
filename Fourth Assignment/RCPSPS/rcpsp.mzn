include "globals.mzn";

%---------------- MODEL PARAMETERS -----------------------

% A set of tasks with durations and resource requirements. 
int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

% A set of cumulative resources
int: n_res;   % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L; % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

% Precendence constraints between some tasks
int: p;       % Number of precedence relations
int: available_res;
set of int: PREC = 1..p;
array[PREC,1..2] of TASKS: pre; % Precedence relations


int: available_time = 165;
int: tempo_max= sum (i in TASKS)(duration[i]);

%---------------------MODEL VARIABLES---------------------------------

array[TASKS] of var 0..available_time: start;  %starting time
var 0..available_time: end; %makespan (end of the last activities)  


%------------------ CONSTRAINTS--------------------
constraint forall(t in TASKS,r in 0..pre[t,2])
(
    start[t]+duration[t]<=start[r]
);

%---------------NON-OVERLAPPING CONSTRAINT---------------------
constraint forall(i,j in TASKS where i<j)(
    if exists(r in RESOURCES)(req[r,i]+req[r,j]>L[r]) 
      then(start[i]+duration[i]<=start[j] \/start[j]+duration[j]<= start[i])
      else
        true
    endif
);

%array[TASKS] of var 0..available_time: end;

% Precedence constraints for each a_i -> a_j
%constraint forall(t in TASKS) %number of predicate relations
%(
%    start[t]+duration[t]<=end
    %end[pre[2,i]]<=start[pre[1,i]]
%);


% Cumulative constraints for each resource
constraint forall(i in TASKS where req[i,2]=={})
(
    start[i]+duration[i]<=end
);

output [
    "Start times = ", show(start), "\n",
    "makespan = ", show(end), "\n"
];