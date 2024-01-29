# Discussion with the professor about First Assignment 

##### 1. Professor 
n-Queens

1) you explain now better the benefits of a combined model. Note that when you say "it has benefits like the facilitation of the expression of constraints, the enhanced constraint propagation and more option for search variables.", this is a general description. In this specific case, the combined model does not facilitate the expression of constraints because in both models (r and c), the constraints are expressed in the same way. We have however more options for propagation and search. To continue with your reasoning,  "while search proceeds, propagating the constraints C1 removes values from the domains of the variables in X1. The channeling constraints now may allow values to be removed from the domains of the variables in X2. ", this can lead to further domain reductions in X1 due to the channelling constraints and so on...

Regarding allDiff, I am not sure what you mean by "a single solver is attached to each constraints of the model itself". You mean a progator? Note that there is only one solver which does search and propagation. We have several propagation algorithms acting during search, and in this specific case yes, each alldifferent constraint has its own propagator activated during search. 

However, this is true for the constraints of every model (every constraint will be propagated somehow). I think here you need to refer to the advantage of a global constraint propagator. This is a model that uses only global constraints and as your results show, it is the best. Why is it important to have global constraints in a model? 

2) "Redundant constraints can be removed from the model since they only add an unnecessary overhead." 

But according to the results, they do not add unnecessary overhead, on the contrary their presence improves the model, why? You only say what the numbers in the tables say, like  "search space is getting bigger, the number of failures increase", but try and give a justification for that. 

Similarly from rc2 -> rc3. Why are the dropped constraints redundant and why their presence help? 

Sequence 
4) In the base+implied model,  we should not reason in terms of having more constraints, because in general more constraints are not necessarily beneficial, as they may become redundant. Here the additional constraints are implied constraints. Do you understand why implied constraints help reduce the search space? (I could not see this in your explanation). Note the difference I make between redundant and implied constraints. You can use his reasoning also when answering the question 2 above. 

You can answer to my questions in the comments without a new submission. 

----

Firstly, please follow my indications for the exercise submission. Use commas when presenting big numbers and use a folder per problem (not per model). 

n-Queens

- Your alldifsym model is not correct. You should combine the alldiff model and the Boolean model with which we can do symmetry breaking. Please study the combined nQueens models (in my slides and in the MiniZinc tutorial). 

- As written in the exercise description, the table of the alldiffsym model should be separate, as the number of solutions change. 

- Your comments need to be more specific. In particular:

--> Q1: We cannot explain the whole story simply in terms of adding more constraints (as you also said, this alone does not say anything). Please focus on why a combined model (like rc1) is better than an individual model (like r) forming it. Similarly, why the alldiff model is better the others. 

-> Q2: Here I cannot see any reason. Focus on which constraints are being dropped and why they worsen the models. 

-> Q3: You need to revise this after correcting the alldiffsym model. 

Sequence

- Your model is not correct. Indeed, you do not post the constraint that I showed. You could check it with n = 5 (the example I showed in class) and with n = 6 which is unsatisfiable. Work on it more. 

-> Q4: You need to revise this after correcting the alldiffsym model. 

Please resubmit in the light of my comments. 


##### 2. Me 
Regarding the first question, you are asking us why is important to have global constraints in a model. For what I understood so far, we can say, in general, that constraint programming is the sum of filtering, propagation and search.
With filtering we are going to remove from the domains the values that cannot belong to any solutions of the problem. Since constraint programming is based on filtering algorithms, it is quite important to design efficient and powerful algorithms. Using global constraints prevents us from explicitly representing all the combinations of values allowed by the constraint.
The filtering algorithm associated with a global constraint is stronger than the conjunction of the independent filtering algorithms of the local constraints corresponding to the global constraint.
Filtering is a local mechanism, because it is associated to each constraint independently. If a constraint is decomposed into some other constraints then the set of filtering are less efficient because they have less information.

So we can say that global constraints are better because:
1) they are more convenient to define one constraint corresponding to a set of constraints than to define independently each constraint of this set.
2) they have a powerful filtering algorithms can be designed because the set of constraints can be taken into account as a whole.

Regarding the 2nd and 4th question, I'm gonna explain what I understood about implied and redundant constraints, following the book you gave us.
"Implied constraints, also called redundant constraints, are constraints which are implied by the constraints defining the problem. They do not change the set of solutions, and hence
are logically redundant. The aim in adding implied constraints to the CSP is to reduce the search effort to solve the problem."

So going from rc1 -> rc2 for n = 8 and n = 9, the number of failures is better but for n = 10 and n = 12 is getting worse. I justify this because we dropped a global constraint which shouldn't be dropped regard what I said before.
The point is that I do not understant when redundant constraints must be removed from the model. Having them help us to speed up the process and find solutions more efficiently, even though they're redundant. Probably they must be removed when the statistics are becoming worst, but we can see it just by running the model.
In this case we can see that rc3 is the worst one since it doesn't have global and redundant constraints like the other two. Which means that, in this case, redundant constraints are better than not.

I can link to the 4th question saying that also in this case redundant constraints sped up the computation. But probably I am wrong since I'm considering redundant and implied constraints as synonyms. If it is possible I would like to have some clarification about it.

##### 3. Professor
As for implied and redundant constraints: you might have missed it during my lectures, but I distinguish between them, while some resources mean the same thing. For us, both implied and redundant constraints are logical implications of the main problem constraints, hence their presence is semantically redundant. It is not always clear however that their presence is computationally significant. That's why I prefer to distinguish between the two as:

- redundant: logically implied constraints with no computational advantage (like the alldifferent constraint in the model with symmetry breaking constraints in the Glomb Ruler problem)

- implied: logically implied constraints with significant computational advantage (like the alldifferent constraint in the initial model without symmetry breaking constraints in the Glomb Ruler problem).

You can now answer the second and the forth questions in the light of this clarification.

##### 4. Professor 
Regarding your comment on the global constraints: yes, what you are saying is overall ok, pay attention however to the fact that:

- filtering and propagation is the same thing (a constraint propagation algorithm of a constraint C detects and filters inconsistent values from the domains of the variables participating to C)

- Distinguish between the strength of propagation and efficiency of propagation: the former refers to the amount of inconsistent values detected and filtered, whereas the latter refers to the time it takes to do that. Global constraints bring about advantage from both perspectives (more inconsistent values filtered in a shorter time), due to the reasons I explained during my lectures (they often maintain GAC, they exploit the constraint semantics to identify inconsistent values quickly, do incremental computation etc). You will witness this better in the second group of exercises on global constraints.

##### 5. Me 
Alright, I think I understood (or I hope so!!). Then, we can say that adding implied constraint in the 4th exercise we have some computational benefits since the number of failures and the time are decreasing. So, even though they are redundant is important to keep them in order to achieve better results (computational speaking).

In the second exercise the redundant constraint are dropped since the channeling constraint and the other constraints satisfy their "job" but, as we can see from the table, the presence of these redundant constraints would be better because they help to decrease the number of failures and time. In fact rc1 is better than rc2 and rc3, and also in rc2 and rc3 we can see the same behavior.

##### 6. Professor
Yes, in other words, also in the second exercise, the semantically redundant constraints turn out to be implied constraints (according to the definition above); so we better keep them in the model.

