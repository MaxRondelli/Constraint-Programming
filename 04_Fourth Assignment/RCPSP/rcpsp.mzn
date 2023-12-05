include "globals.mzn";

%---------------- MODEL PARAMETERS -----------------------

% A set of tasks with durations and resource requirements. 
int: n_tasks;   % Number of tasks
set of int: TASKS = 1..n_tasks;  
array[TASKS] of int: duration; % Task durations

% A set of cumulative resources
int: n_res;                         % Number of resources
set of int: RESOURCES = 1..n_res; 
array[RESOURCES] of int: L;         % Resource capacities
array[RESOURCES,TASKS] of int: req; %Resource requirements of tasks

% Precendence constraints between some tasks
int: p;                             % Number of precedence relations
set of int: PREC = 1..p;

array[PREC,1..2] of TASKS: pre;     % Precedence relations


int: available_time = 165;

int: t_max= sum (i in TASKS)(duration[i]);

% --------- MODEL VARIABLES ---------
array[TASKS] of var 0..t_max: start;  %starting time
var 0..available_time: end;           %makespan (end of the last activities)  


% --------- CONSTRAINTS ---------

constraint forall(j in PREC)(start[pre[j,2]] >= start[pre[j,1]]+duration[pre[j,1]])::domain; 

constraint forall(i in RESOURCES)(cumulative(start,duration,req[i,TASKS],L[i]))::domain;  
var 0..t_max: start_last = max(start);




% --------- PRECEDENCE CONSTRAINT ---------
constraint forall(r in RESOURCES)
(

      let {
        set of int: RTasks = 
                    {i | i in TASKS where req[r,i]>0 /\ duration[i]>0},
                    int: sum_rr= sum(i in RTasks)(req[r,i])
      }
      in(
        if (RTasks !={} /\ sum_rr> L[r]) then
        (
            cumulative(
              [start[i] | i in TASKS],     % starting time
              [duration[i] | i in TASKS],  % duration time of the task
              [req[r,i]| i in TASKS],      % resource requirements of the task
              L[r]      % resource capacities of the specific resource
           )
        )
        else
          true
        endif
      )
    
);

% --------- CONSTRAINT OF THE MAKESPAN ---------
%check tasks are inside the maximum time

constraint forall(i in TASKS)
(
  start[i] + duration[i] < end
);
%cumulative(starting time, duration, resource requirements, capacity)


solve minimize start_last;
% solve :: int_search(start_time, first_fail, indomain_min) satisfy;


output [
    "Start times = ", show(start), "\n",
    "Duration = ", show(duration), "\n",
    "L =", show(L),"\n",
    "makespan = ", show(end), "\n"
];