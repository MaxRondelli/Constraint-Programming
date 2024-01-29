# Discussion with the professor about Third Assignment 

##### 1. Professor 
nQueens

Well explained. You could however comment also on the value of the use of dynamic heuristics (even without a random assignment) with respect to the use of the static input order heuristic. 

It is advisable to write down comments after you present all the data. For instance you could put all the results in one table (with one column for both min domain size and domWdeg

Small corrections to improve presentation: 

- when you formally refer to the domain size of a variable Xi, use |D(Xi)|, as dom(Xi) is understood as the domain of Xi. The cardinality of a set gives the size of a set. 

- Be consistent in your notation. You switch between w and W when you refer to a weight. 

- Table 2: minimum domain size, not just domain size

- The weighted degree formula does not define what a c is. In your sum quantification, you need to quantify over c s.t. Xi∈X(c)

Poster

If bold refers to the best result, you should make bold the results of min domain size & domWdeg on the 19x19 side (currently input order result is bold). 

Here you seem to be mixing up random variable choice and random value choice. We never choose variables randomly, but rather values randomly. However you are saying "if a random approach is used, there are cases that the first pieces inserted are the smallest within the domain". Note that the pieces are variables (never random), their positions are values (can be random). 

Also in the second part, when you talk about static vs dynamic, you put some emphasis on the cost of the heuristics. This is not relevant in our case because our dynamic heuristics are cheap to calculate anyway. I suggest that you structure better your reasoning. For instance,  first comment on the first table and discuss why dynamic variable ordering heuristics behave better than the static input order, and then comment on the second table and discuss why now the static beats every other heuristic. Then comment on the random value selection in both tables. 


QCP

Table 6: The results are the same across all the methods for each instance. Doesn't this ring a bell? sorridente Another group had the same results but then I saw in their model that they declared the start array as a variable. This is not the case in your model but could be an error  that you corrected after running the experiments? The results are suspicious. Please revisit your model, experiments and also your observations. 

##### 2. Professor
Yes, now all looks good. However you forgot to address some of my comments:

nQueens

You could comment also on the value of the use of dynamic heuristics (even without a random assignment) with respect to the use of the static input order heuristic. Currently you are only commenting on random value assignment and static input order of variables and values.

PP

Here like in nQueens, you need to comment on why dynamic heuristics work much better compared to static input order of varibles and values.

Table 2: "With both the ”min domain size” and ”domWdeg” approaches, we go to choose as variables those that have smaller domains. They are assigned their own smallest value in their domain. Using this approach, we assign the variables with the smallest domain, that is, the largest pieces, their smallest values, so, starting with the largest pieces, we begin to place them all to the left of the chessboard." -> first, domWdeg does not just consider the domain size, why do you give a common description in this way? Second, they do not necessarily choose the biggest pieces. Size of the domain (positions in the grid) is not necessarily related to the poster size. Otherwise the results would be the same as in Table 3.

Table 3: "the largest pieces are assigned first " -> you didn't oy explain why this improve the search performance?

You can answer in the comments without a new submission.

##### 3. Me
nQueens:
In general, talking about variable choice annotations, we can say that first-fail and domWdeg work better than input order for their own implementation, which is to minimize the search tree by trying variables with less branches on upper levels, and for domWdeg, we also try to maximize constraint propagation too.
Talking about the ways to constrain a variable, queens are explored in the order of Q1, Q2, ..., Qn when indomain_min is combined with input order. This leads to place queens close to each other. In the other hand, we can see good results when first fail and domWdeg are combined with indomain_min, since any two queens can be chosen from the set and indomain_min exploration does not alway place them close to one another, due the variable choice annotation.

PP:
Yes, with domWdeg we chose the variable with the smallest value of domain size divived by weighted degree. Related to table 3, since the array is sorted, a static input order heuristic works better because we want to place first the bigger posters and, since the array is already in place, it becomes easier to find a solution. Randomness, even in this case, is a bad idea as we can see from the results.
Looking at table two instead, we see improvements from the static to dynamic search heuristic. This is because they are based of first fail principle. DomWdeg may work better than min dom because of its nature. Due to its likelihood of failure, large posters will be positioned earlier in the search due to their weighted degree. So it "looks like" ordering the input, like in the third table.
