# matlab-for-neuroscientist-2nd-Project
MATLAB for neuroscientist 2nd projects records 

>>>> PART I: Experiement details

Task:

Find target with unique feature combination(shape+color) from all other distractors(feature combination with number>=2) and track response time(RT)
Features: shape("o" OR "x"); color("red" OR "blue");

1. Conditions:

(a) pop-out search -- one feature that makes target unique;
(b) conjunction search -- two features that makes target unique;
(c) control -- no target to be unique

For item number in each trial, set 4 level of display item number(size = 4, 8, 12,16);
For item display, target and distractors are placed randomly;
For feature distribution number, make sure the number of each type is equal
    ex. For all 16 items, there are (8 red/8 blue) & (8"o"/ 8"x"), while only one in conbination (red-"o"), which is the target.

2. Trial numbers:
(a) In each search condition(pop-out OR conjunction), the number of trials with target and trials without target(control) should be equal. 
(b) make sure the correct trials number for each condition is more than 20;

3. Response:
Set two key on keyboard, "target present" & "no target";

4. Experiment process
(a) "pop-out search" and "conjunction search" are blocked to perform;

5. Subjects
(a) When using color as one of features, be careful of color blind among subjects (red/green; blue/red; ....)
(b) Response should be as quick as possible while making sure to be right

6. Results
(a) Only consider correct trial results(RT)
(b) select target present in with-target trials / select no target present in no-target trials 
(c) Report mean RT_{target}/RT_{no} versus setsize in each condition("pop-out" & conjunction) in plot
(d) Pearson Correlation coefficiencts for testing correlation of RT vs setsize
(e) Slope in each condition;


>> PART II: Implementation

Changes and reflections from original idea[CnDE@zhihu]
(a) Item number set as [4,8,12,16] is irrational. number=4 can't perform conjunction search. To make sure the equal distribution of features, the size number should be (3n+1) and is even. Therefore, in the actual practice, item number set as [10,16,22,28]
(b) The so-called "correctness" is weak. When subject reports to find target in with-target trial, we don't know whether the subject catch the right target.
(c) Subjects should not know the result before-head, for it will influence how they perform in each condition;


....................................... Reference & extended reading ..........................................

[1] Wallisch P, Lusignan M E, Benayoun M D, et al. MATLAB for neuroscientists: an introduction to scientific computing in MATLAB[M]. Academic Press, 2014: 151-164.
[2] Shepard R N, Metzler J. Mental rotation of three-dimensional objects[J]. Science, 1971, 171(3972): 701-703.
[3] Treisman A M, Gelade G. A feature-integration theory of attention[J]. Cognitive psychology, 1980, 12(1): 97-136.
