# Feature/Conjunction Search experiment

The project is to briefly reproduce "feature search and conjuection search" based on the study of Treisman and Gelade (1980)<sub>[1]</sub>. Results are collected from 2 subjects (one is the author), and then analyzed. The goal is to check if the conclusion could be reproduced.

## Introduction

In the experiment, subjects were asked to report the presense or absense of a target stimulus among various numbers of distracter stimulus.
Acoording to number of stimulus dimension included to distinguish the target stimulus, search types could be divided into:
> + "Feature Search":
	The target stimulus differ from distractor stimuli by one unique visual features, such as color, shape, orientation, or size.
	i.e.： identify one [white square] (target) among [black squares] (distractors)
> + "Conjunction Search":
	Distractors may not be the same from each other, but each will possess one or more common visual features with target.
	i.e.: identify [red X] among [red O]s and [black X]s

According to result from Treisman and Gelade (1980) study, in feature search condition, subject response time is independent of the number of distractors; while in conjunction search condition, there is a positive linear relation ship between reaction time and the number of distractors.

## Design

1. Experiment Process:
[1] Practice Session
	This is to help subjects familiar with the experiment.
	+ Feature Search: 4
	+ Conjunction Search: 4
	
	If response correctness >= 80%, the subject are allowed to start the following sessions

[2] Pure Feature Search
	Trial number: 10

[3] Pure Conjunction Search
	Trial number: 10

[4] Interleaved Search
	+ Feature Search: 10
	+ Conjunction Search: 10
	Trials of both conditions are in random sequence

2. Elements Settings in trial:

	- **Conditions:**
		(1) Search Type:
			+ Feature Search
			+ Conjunction Search
		(2) Stimulus Number:
			[]
		(3) Target or not:
			In Feature Search
			- Is target, [target, distractor] = [1, n-1];
			- No target, [target, distractor] = [n/2, n/2];
			In Conjunction Search
			- Is target, [target, distractor] = [1, n/2, n/2];
			- No target, [target, distractor] = [n/3, n/3, n/3];
	- **Parameters:**
		+ stimulus number: 
			[6, 12, 18, 24] in total;
			In conjunction search, distractors' number are equal in all types. 
		+ features: 
			shape[o/x], color[red/blue]
			Feature are randomly choosed in each trial.
		+ stimulus coordinates: 
			Randomly generated in a 6×6 grid
		+ Target or not:
			Whether the trial has target or not is randomly determined.


3. Subject and Response Collection:

Subjects are required to judge whether there is a target stimulus or not. Response should be as quick as possible while making sure that is correct.

Experiment will collect 
(1) Condition[Vision Search Type & stimulus number]  
(2) Response time 
(3) Correctness, only response time of correct response will be analysed.

For each vision search type, plot out 【Response time ~ Stimulus number]
Then analyze by linear regression and Pearson correlation.

## Result

As is reported from subject, feature search are easier to do than conjunction search, and this pre-thought would either faster or slower their response. In case that subject's response get influenced by their awareness of the vision search type, 2 vision search type are either blocked(Session 2&3) or interleaved(Session 1&4) presented during formal session, and we analyzed both situations.

For blocked session of feature search and conjunction search:

![image]("")


For interleaved session of feature search and conjunction search:

![image]("")

From both results, conjunction search showed are higher positive linear correlation with stimulus size compared to feature search, and this result is consistent to previous research.



## Discussion

1. Subjects report that "Conjunction Search" are harder to perform. However, **tricks** could be found. For instance, to determine whether one of 3 types of stimulus is target, subject can simply find whether there are more than one stimulus for each type. Apparently, this trick could weaken effect from increasing stimulus numbers.  

Besides, subjects report that if stimulus number is small, thus too sparse distributed in the screen, they also feel difficult to see all stimulus quickly, which either leads to wrong response or longer response time.

2. Importance laid on color: In the post-interview of subjects, feature color are reported to be more saliently recognizable compared to shape difference. Besides, the thicker the edge is, the more salient the shape difference is. 

What if we analyse data seperated by basic-feature? Does it indicate basic-feature recognition priority? Does it indicate processing levels in primitive features?

3. When using color as feature, be careful of color blind among subjects (red/green, blue/red, ....)


*Reference*

[1] Treisman A M, Gelade G. A feature-integration theory of attention[J]. Cognitive psychology, 1980, 12(1): 97-136.

[2]Wallisch P, Lusignan M E, Benayoun M D, et al. MATLAB for neuroscientists: an introduction to scientific computing in MATLAB[M]. Academic Press, 2014: 151-164.