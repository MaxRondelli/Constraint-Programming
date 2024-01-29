# Discussion with the professor about Second Assignment 

##### 1. Professor 
nQueens

Your decomposition is not correct. You should decompose all the three alldifferent constraints using the your approach in the allDifferentRows predicate (what you have in allDifferentDiagonals is not a decomposition of an alldifferent constraint, it is another way of expressing the fact that two queens cannot be on the same diagonal). 

Poster

Why do you introduce new variables in the global model? You can stick to the same variables and the same boundary constraints of the naive model. Just replace the naive overlapping constraint with diff. 

Your are commenting only on the time gains of the global constraints. As you can see in the tables, they reduce the search space too. This is not because of having an efficient algorithm. Efficiency improves the time. Why do they reduce the search space more?

By the way, here (in the first question) you need to comment both on nQueens & Poster  (you can give a common answer but refer to both results). 

Sequence

Why do you think the base models (even the base+implied) are too costly timewise? 

It is true that the sum constraint has now become redundant, but you are not explaining the reason.  It is not true that gcc  enforces that each value must appear exactly one in the array x. Why should it? If you look at the solution of n=5, you will see that it is not the case. You need to explain why gcc includes the reasoning provided by the sum constraint. 

##### 2. Professor
Well done with the models!

I am not sure however if you are submitting the final version of your report or some intermediate version of it. Some comments of mine do not seem to be addressed. In particular, as I said in my previous comments, the first question is common to both nQueens & Poster, so you should base your explanations on the results you observe in both tables. Also, you are still saying "the global constraint global cardinality already enforces that each value must appear exactly one in the array x." which is not true.

As for global constraints: now you talk about the propagation strength but at the same time you lost your previous descriptions regarding propagation efficiency. It would be nice if you could talk about all the advantages of global constraints with reference to the table of results (of nQueens & Poster).

As for the sequence base model: we need some more specific reasoning here. Start with analysing the number of constraints in the base model in terms of n.Then try to understand where the extra variables come from and how many of them there are in terms of n. Hopefully these numbers will give you a clue on the cost of propagation.

As for the redundant implied constraint in the gcc model: as I said above, it is not true that "the global constraint global cardinality already enforces that each value must appear exactly one in the array x." Try to understand why the sum constraint does not give extra information in the presence of the gcc constraint.

##### 3. Me
We removed the uncorrect sentence we said about the sequence problem. Looking the wiki we find out why the implied is inside the gcc. (it does exactly that thing!).
I hope it is correct now! Thank you!

##### 4. Professor
Meta-constraint:

You said "x[i] is the sum of all the j if xj =i." No, we don't sum j's. What is the sum constraint exactly summing there? Above I asked you a related question. Where do the extra variables come from? Can you quantify them in terms of n? After that, you can justify more correctly the number of constraints being propagated. The answer of these questions will tell you why this meta-constraint based model is costly.

##### 5. Me
You are right, we do not sum j's. The sum constraint calculates, for each value i, the count of how many times i appears in the array X and assigns it to the variable X[i].

Thinking about it, we say that we are defining an array x with indices ranging from 0 to n-1, and each element of the array must be inside this range. It means that for each element in the array x, we have n choices for its value, so there are a total of n times n possible combinations of values for the x array.
The extra variables inside the meta-constraint model comes from the intermediate computations of the sum and the nested loop, but the global model doesn't involve sum and nested loop lead the number of extra variables to 0 because there isn't any intermediate computations that required the creation of intermediate variable.

At the end we can say that the cost of the meta-constraint model is higher since we have an higher number of variables. Both of the constructs (summatory and the nested loop) required intermediate variable thus increasing the search space and the more complexity of the summatory and the nested loop compared to global cardinality constraint bring also leading us to have an higher execution time.

##### 6. Professor
Yes that's right but let's be more specific. To post a new constraint on another constraint c, the initial constraint c must be converted to a Boolean variable, encoding the fact that the constraint c is satisfied or not. The new constraint is posted on the generated Boolean variables. You could do this by hand, but MiniZinc does that for you automatically. So, given this expression in MiniZinc, which constraint is converted to a Boolean and how many of them are there in terms of n?

forall(i in 0..n-1)(x[i] = sum(j in 0..n-1)(x[j] = i))

With the generated Booleans, how many constraints are posted in terms of n?

##### 7. Me
The constraint "x[i] = sum(j in 0..n-1)(x[j] = i)" is the one that is converted into a boolean constraint.
For each value of i in the range 0 to n-1, a Boolean constraint is generated. These boolean constraints are checking if x[i] is equal to the count of element in the array x that have the value i.

So, for each value of i, a separate boolean constraint is generated, resulting in a total of n boolean constraints.

##### 8. Professor
There is nothing like a Boolean constraint. There is Boolean variable. We cannot convert the entire expression to a Boolean variable, otherwise we would not have any constraint. New constraints are posted on those new Boolean variables. Read my question again and think more.

PS: Just check the solution statistics, you will see that the extra Boolean variables and constraints are a lot in terms of n.

##### 9. Me
For each check x[j] = i, a Boolean variable is generated to evaluate that expression, so we can say that for all i values in the range [0, n-1] we generate n Boolean variables. Since the possibile values for i are n, there are also n Boolean variables. Hence, approximately there are n^2 variables in total.

##### 10. Professor
Yes, these are the additional Boolean variables generated. However, you didn't answer the constraints part (where do the constraints come from and how many are there interns of n)?

I am asking these questions so that with your own answer you understand why this model is very costly.

##### 11. Me
Looking again at the statistics and, after our discussion at lesson, we understood that the constraints come from the Boolean expression, whose has an implied constraint associated (e.g. x[j] = i iff b_(i, j) = 1 which give us others n^2 constraints, and the sum constraint.

##### 12. Professor
Note that these are not implied constraints (which has the specific meaning that we have been discussing). Perhaps you meant implication (->) constraints, but that's not correct either, they are indeed bi-implication (<->) constraints.

Yes, there are n^2 of them (referred to ad reified constraints in the statistics) and then we have n sum constraints for each Xi in the form of Xi = Bi1+ Bi2+ ...+ Bin. But this would give us in total n^2 +n constraints whereas in the statistics, there are many more constraints.

##### 13. Me
Looking at the sum constraint decomposition, each sum is decomposed into a ternary sum, so that's why we have more variables. We get (2 * n^2) + n constraints because we get two times the number of variables, since with the ternary sum we get something like that: Y_(n -1) + X_n = N

That's what we get from the sum constraint decomposition and why we have more variables.