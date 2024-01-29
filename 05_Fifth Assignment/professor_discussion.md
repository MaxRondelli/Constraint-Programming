# Discussion with the professor about Fifth Assignment 

##### 1. Professor 
Well done! 

A short comment on dWd-rand having more failures than default search: here you need to focus on that fact that both methods timed out, within the time limit they resulted in different sub-optimal solutions,  dWd-rand gave a better result with more failures. How can we explain that? Note that the default search could as well be (and most probably) applying fail-first principle, so your answer should be independent on that argument.  

##### 2. Me 
The "dWd - rand" method introduces randomness in the selection of variables, leading to a more diverse exploration of the solution space. It allows the algorithm to escape local minima and explore different regions of the solution space. In other words, the method is exploring a broader range of possibilities, even if some of them lead to failures.

With default search method, might be more deterministic in the exploration. It may be getting stuck in certain regions of the search space, possibly converging to a sub-optimal solution.

That's what we think could be the main reasons to your answer.

##### 3. Professor 
There is no restarting here and randomness is just in the value order. So it is not true that dWd - rand" leads to a more diverse exploration.

Assume you don't know how the two search heuristics work and call them S1 and S2. How can we explain that S2 finds a better solution than S1 while having more failures than S1? Note that both have timed-out which means that they did not explore the entire tree.

There is no restarting here and randomness is just in the value order. So it is not true that dWd - rand" leads to a more diverse exploration.

##### 4. Me 
The addition of random allows us to explore a tree in its entirety, but going about exploring its subtrees in a completely different way, so we will never find two subtrees being explored in the same way. Precisely because of the addition of random.

This leads us to have a higher number of failures however, as shown by the reduced number of the obj, it can lead us to find an "optimal solution" than the default search, despite the fact that the number of failures is higher.

##### 5. Professor 
Please read again my question. Assume that you don't know how the two heuristics work (because the answer is independent of the heuristic strategies).

##### 6. Me 
If I just think about S1 and S2 where S2 gets a better obj in the same time interval but with more failures, could be that S2 works and moves faster than S1. This may be why it makes more failures and finds a better solution.
Since both go into timeout, S2 may find a better solution than S1 because, being faster in searching, it explores the tree more than S1. And that is also why it has more failures.