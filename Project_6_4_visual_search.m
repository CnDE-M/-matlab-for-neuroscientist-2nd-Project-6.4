%% //////////////////////////// Introduction ////////////////////////////
% reference <MATLAB for neuroscientist 2nd> 6.4 Project
% (Treisman_Gelade,1980)
%
% This script contains: generating experiments, collecting response.
%
% The experiments sessions include:
%       Practice: only correctness>=0.8 can subject start the formal sessions;
%       Formal sessions: pure feature search, pure conjunction search, interleaved search
%
% Responses and data includes:
%       vision search type, stimulus number, target or not, response, response time 
% All records will be saved in one excel per subject
%
%% /////////////// ALL ASSEIGNMENT INCLUDE THIS SESSION ///////////////
%
%   Title: 
%         Feature & Conjunction Vision Search Experiment
%   Script File: 
%         Project_6_4_visual_search.m
%         Project_6_4_result_process.m
%   Function File:
%         trialGenerator.m
%
%% /////////////////////////////////////////////////////////////////////////
%   Author: Xinyue Ma
%   Email: 1653515@tongji.edu.cn
%
%   MATLAB version: R2019a
%% /////////////////////////////////////////////////////////////////


clear all;
close all
clc;
%%  ............... Parameters ...............
sti_size=[6, 12, 18, 24];

%%  ###################### Practice ###################### 
%	Feature Search: 4
%	Conjunction Search: 4
% 	If correctness >= 80%, report that subject can start formal sessions

%% >>>> Parameters
% [vs_type, sti_size, if_Target]
trial_num = 4;
ex_parameters(:,1) = repelem([1,2],[trial_num*length(sti_size),trial_num*length(sti_size)])';
ex_parameters(:,2) = repmat(repelem(sti_size,[trial_num,trial_num,trial_num,trial_num]),[1,2])';
ex_parameters(:,3) = randi(2,[trial_num*length(sti_size)*2,1])-1;

% hints:
fprintf(" ~~~~~~~~~~~~~~~ Practice ~~~~~~~~~~~~~~~` \n");
fprintf('>>>> key "1" for target present \n');
fprintf('>>>> key "0" for no target \n');
fprintf('Press Any Key to Start when ready...\n '); 
pause;

for ii = 1:size(ex_parameters,1)
    
    condition_list = ex_parameters(ii,:);
    [response]=trialGenerator(condition_list);
    
    %% Write down the condition and response
    % result = [vs_type, sti_size, if_target, rp_time, rp_target];
    result(ii,:) = [condition_list, response];    
end
correctness = [result(:,3) == result(:,5)];
result(:,6) = correctness';
correctness = sum(correctness) / length(correctness);
fprintf(">>>> You get %.1f%% correct.\n",correctness*100);
if correctness >=0.8
    fprintf(">>>> Please start formal sessions.\n");
    fprintf("-----------------------------------------\n");
    subject_name=input("Input your name:\n","s");
    output_filename="Exercise_6_result_"+subject_name+".xlsx";
    xlswrite(output_filename,result,"Practice");
else
    fprintf(">>>> Sorry, you need more practice");
end

%%  ############### Pure Feature Search ###############
%	 Trials number per condition: 10  
%% >>>> Parameters
% [vs_type, sti_size, if_Target]
trial_num = 10;
clear ex_parameters result correctness 
ex_parameters(:,1) = repelem([1],[trial_num*length(sti_size)])';
ex_parameters(:,2) = repelem(sti_size,[trial_num,trial_num,trial_num,trial_num])';
ex_parameters(:,3) = randi(2,[trial_num*length(sti_size),1])-1;

l = size(ex_parameters,1);
ex_parameters = ex_parameters(randperm(l),:);

% hints:
fprintf(" ~~~~~~~~~~~~~~~ Pure Feature Search ~~~~~~~~~~~~~~~` \n");
fprintf('>>>> key "1" for target present \n');
fprintf('>>>> key "0" for no target \n');
fprintf('Press Any Key to Start when ready...\n '); 
pause;

for ii = 1:size(ex_parameters,1)
    
    condition_list = ex_parameters(ii,:);
    [response]=trialGenerator(condition_list);
    
    %% Write down the condition and response
    % result = [vs_type, sti_size, if_target, rp_time, rp_target];
    result(ii,:) = [condition_list, response];    
end
correctness = [result(:,3) == result(:,5)];
result(:,6) = correctness';
correctness = sum(correctness) / length(correctness);
fprintf(">>>> You get %.1f%% correct.\n",correctness*100);
fprintf("-----------------------------------------\n");
xlswrite(output_filename,result,"Pure Feature Search");

%%  ############### Pure Conjunction Search ###############
%	 Trials number per condition: 10  
%% >>>> Parameters
% [vs_type, sti_size, if_Target]
trial_num = 10;
clear ex_parameters result correctness 
ex_parameters(:,1) = repelem([2],[trial_num*length(sti_size)])';
ex_parameters(:,2) = repelem(sti_size,[trial_num,trial_num,trial_num,trial_num])';
ex_parameters(:,3) = randi(2,[trial_num*length(sti_size),1])-1;

l = size(ex_parameters,1);
ex_parameters = ex_parameters(randperm(l),:);

% hints:
fprintf(" ~~~~~~~~~~~~~~~ Pure Conjunction Search ~~~~~~~~~~~~~~~` \n");
fprintf('>>>> key "1" for target present \n');
fprintf('>>>> key "0" for no target \n');
fprintf('Press Any Key to Start when ready...\n '); 
pause;

for ii = 1:size(ex_parameters,1)
    
    condition_list = ex_parameters(ii,:);
    [response]=trialGenerator(condition_list);
    
    %% Write down the condition and response
    % result = [vs_type, sti_size, if_target, rp_time, rp_target];
    result(ii,:) = [condition_list, response];    
end
correctness = [result(:,3) == result(:,5)];
result(:,6) = correctness';
correctness = sum(correctness) / length(correctness);
fprintf(">>>> You get %.1f%% correct.\n",correctness*100);
fprintf("-----------------------------------------\n");
xlswrite(output_filename,result,"Pure Conjunction Search");

%%  ############### Interleaved Search ###############
% 	+ Feature Search: 5
% 	+ Conjunction Search: 5
% 	Trials of both conditions are in random sequence
%% >>>> Parameters
% [vs_type, sti_size, if_Target]
trial_num = 5;
clear ex_parameters result correctness 
ex_parameters(:,1) = repelem([1,2],[trial_num*length(sti_size),trial_num*length(sti_size)])';
ex_parameters(:,2) = repmat(repelem(sti_size,[trial_num,trial_num,trial_num,trial_num]),[1,2])';
ex_parameters(:,3) = randi(2,[trial_num*length(sti_size)*2,1])-1;

l = size(ex_parameters,1);
ex_parameters = ex_parameters(randperm(l),:);

% hints:
fprintf(" ~~~~~~~~~~~~~~~ Pure Conjunction Search ~~~~~~~~~~~~~~~` \n");
fprintf('>>>> key "1" for target present \n');
fprintf('>>>> key "0" for no target \n');
fprintf('Press Any Key to Start when ready...\n '); 
pause;

for ii = 1:size(ex_parameters,1)
    
    condition_list = ex_parameters(ii,:);
    [response]=trialGenerator(condition_list);
    
    %% Write down the condition and response
    % result = [vs_type, sti_size, if_target, rp_time, rp_target];
    result(ii,:) = [condition_list, response];    
end
correctness = [result(:,3) == result(:,5)];
result(:,6) = correctness';
correctness = sum(correctness) / length(correctness);
fprintf(">>>> You get %.1f%% correct.\n",correctness*100); 
fprintf("-----------------------------------------\n");
xlswrite(output_filename,result,"Interleaved Search");
