function [response]=trialGenerator(condition_list)
% >>>> Description:
%   Generate items display as defined by condition
%   Need subject click to determine whether t here is target
%   Record response time
% >>>> Input Arg
%   condition_list = [vs_type, sti_size, if_Target]
%   "vs_type": 
%       1 for "feature search"; 2 for "conjunction search"
%   "sti_size": stimulus number
%   "if_target": if there is target stimulus
%       0 for no target; 1 for has target
%
% >>>> Output Arg
%   "response" = [rp_time, rp_target];
%   "rp_target": whether subject find target stimulus or not 
%   "rp_time": response time( Display of picture ~ Subject response)

%% ...................... Parameters ...........................
vs_type = condition_list(1);
sti_size = condition_list(2);
if_target = condition_list(3);
feature(1,:)= ["r","b"]; % color
feature(2,:) = ["x","o"]; % shape

%% ...................... Stimulus Generation ...........................

%% >>>> Features list
if vs_type == 1 
    %% feature search
    a = randperm(2); % a(1) to be common, a(2) to be diff feature
    f_same = feature(a(1),randi(2));
    f_type = strcat(repelem(f_same,2),feature(a(2),:));
    if if_target == 0
        %% no target
        feature_list = [repelem(f_type(1), sti_size/2), repelem(f_type(2), sti_size/2)]; 
    else
        %% has target
        feature_list = [repelem(f_type(1), 1), repelem(f_type(2), sti_size-1)];
    end
        
else
    %% conjunction search
    % feature_list(1) - possible to be target stimulus feature
    for ii = 1:2
        for jj = 1:2
            feature_comp(2*ii+jj-2) = strcat(feature(1,ii),feature(2,jj));
        end
    end
    f_target = [randi(2), randi(2)];
    f_type(1) = strcat(feature(1,f_target(1)),feature(2,f_target(2)));
    f_mix = [strcat(feature(1,f_target(1)),feature(2,1:2)), strcat(feature(1,1:2),feature(2,f_target(2)))];
    f_mix = unique(f_mix);
    f_mix(f_mix ==f_type(1))=[];
    f_type(2:3) = f_mix;
    
    if if_target == 0
        %% no target
        feature_list = [repelem(f_type(1), sti_size/3), repelem(f_type(2), sti_size/3), repelem(f_type(3), sti_size/3)]; 
    else
        %% has target
        feature_list = [repelem(f_type(1), 1), repelem(f_type(2), sti_size/2), repelem(f_type(3), sti_size/2)];
    end
    
end
 
    
%% >>>> Coordinate coordinate ..................
%%%% due to the size of item number, set both x,y with 6 position site, 36
%%%% potential site in total, distance between each site is 0.2
pos_num = 6;
pos_total = pos_num * pos_num;
distance_between = 0.01;

pos_coor_all=fullfact([pos_num,pos_num]); %%% whole combination;
row_sele=[repmat(1,[1,sti_size]),repmat(0,[1,pos_total-sti_size])];
row_sele=row_sele(randperm(pos_total)); %%%% rearrange sequence
row_sele=[1:pos_total] .* row_sele;
row_sele(find(row_sele==0))=[];
pos_coor_sele=pos_coor_all(row_sele,:) *distance_between;
pos_coor_sele = pos_coor_sele(randperm(sti_size),:); %%%% rearrange sequence


%% .............. Generate Plot ..................

fg=figure("Position",[100 10 1000 650]);
set(fg,"Color","w");
set(fg,"visible","off");
hold on;
for ii=1:sti_size
    plot(pos_coor_sele(ii,1),pos_coor_sele(ii,2),feature_list(ii),"MarkerSize",12);
end
xlim([0,distance_between*(pos_num+1)]);
ylim([0,distance_between*(pos_num+1)]);
hold off;
axis off;
set(fg,"visible","on");

%% .............. Subject Response ..................
tic;
pause; 
rp_target = get(fg,"CurrentCharacter");
rp_target = convertCharsToStrings(rp_target);
rp_target = double(rp_target);
rp_time=toc;
close(gcf);
response = [rp_time,rp_target];

end