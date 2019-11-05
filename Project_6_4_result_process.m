%% //////////////////////////// Introduction ////////////////////////////
% reference <MATLAB for neuroscientist 2nd> 6.4 Project
% (Treisman_Gelade,1980)
%
% The script is to do statistic analysis on the correct response data;
% To correlate response time and stimulus time.
% The goal is to see whether there is a difference on correlation
% relationship between feature search and conjunction search
%
%% /////////////////////////////////////////////////////////////////////////
%   Author: Xinyue Ma
%   Email: 1653515@tongji.edu.cn
%
%   MATLAB version: R2019a
%% /////////////////////////////////////////////////////////////////

sub_filename=["Exercise_6_result_Subject_1.xlsx","Exercise_6_result_Subject_2.xlsx","Exercise_6_result_Subject_3.xlsx"];
sheet_page = ["Practice", "Pure Feature Search", "Pure Conjunction Search", "Interleaved Search"];

%% >>>> Pure Vision Search
% Feature Search
sheetpages = ["Pure Feature Search"];
[fea_result]=dataProcess(sub_filename, sheetpages);

[m,p]=corrcoef(fea_result(:,1),fea_result(:,2));
magnitude(1)=m(1,2);
p_value(1)= p(1,2);

% Conjunction Search
sheetpages = ["Pure Conjunction Search"];
[con_result]=dataProcess(sub_filename, sheetpages);

[m,p]=corrcoef(con_result(:,1),con_result(:,2));
magnitude(2)=m(1,2);
p_value(2)= p(1,2);

% Plot out
figure("Position",[200,50,700,500]);
hold on;
errorbar([1:4],fea_result(:,2)',fea_result(:,3)',"-.r");
text("String","magnitude: "+string(magnitude(1))+" p-value: "+string(p_value(1)),"Color","r","Position",[0.3,1],"FontSize",9);
errorbar([1:4],con_result(:,2)',con_result(:,3)',"-.b");
text("String","magnitude: "+string(magnitude(2))+" p-value: "+string(p_value(2)),"Color","b","Position",[0.3,2.6],"FontSize",9);
title("RT~stimulus number of separate 2 vision search (only correct response)");
xlim([0,5]);
ylim([0.5,3.5]);
xticks([0:5]);
xlabel("stimulus number");
ylabel("response time(s)");
xticklabels(["",string(sti_size),""]);
legend(["Feature Search","Conjunction Search"],"Location","northeast");
hold off;


%% >>>> Interleaved Search and Practice
sheetpages = ["Practice","Interleaved Search"];
[result]=dataProcess(sub_filename, sheetpages);

for ii = 1: size(result,3)
    [m,p]=corrcoef(result(:,1,ii),result(:,2,ii));
    magnitude(ii)=m(1,2);
    p_value(ii)= p(1,2);
end

% Plot out
figure("Position",[200,50,700,500]);
hold on;
errorbar([1:4],result(:,2,1)', result(:,3,1)',"-.r");
text("String","magnitude: "+string(magnitude(1))+" p-value: "+string(p_value(1)),"Color","r","Position",[0.3,1.7],"FontSize",9);
errorbar([1:4],result(:,2,2)',result(:,3,2)',"-.b");
text("String","magnitude: "+string(magnitude(2))+" p-value: "+string(p_value(2)),"Color","b","Position",[0.3,3],"FontSize",9);
title("RT~stimulus number of interleaved 2 vision search (only correct response)");
xlim([0,5]);
ylim([0.5,3.5]);
xticks([0:5]);
xlabel("stimulus number");
ylabel("response time(s)");
xticklabels(["",string(sti_size),""]);
legend(["Feature Search","Conjunction Search"],"Location","northeast");
hold off;

