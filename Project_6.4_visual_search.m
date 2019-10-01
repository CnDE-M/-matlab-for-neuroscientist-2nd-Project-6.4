%%%% reference <MATLAB for neuroscientist 2nd> 6.4 Project
%%%% (Treisman_Gelade,1980)

%% --------------------------------------------------------
%%%%                       MAIN
%% --------------------------------------------------------
clear all;
close all
clc;
%%%% ............... CONDITION 1: pop-out search ............... 
%%%% ....... parameter setting
trial_num=10;  %%%% 10 trial per condition
setSize=[10,16,22,28];

%%%% "experiment_setting": experiment process parameters
eprt_setting_con_1(:,1)= repelem(setSize,[trial_num*2])'; %%%% four level of setSize
eprt_setting_con_1(:,2)= repelem([1],[trial_num*2*4])'; %%%% condition 1
eprt_setting_con_1(:,3)= repmat(repelem([1,0],[trial_num]),[1,4])'; %%%% with target or not
%%%% rearrange sequence for each level
eprt_setting_con_1_level(1:trial_num*2,:,1)=eprt_setting_con_1(randperm(trial_num*2),:);
eprt_setting_con_1_level(1:trial_num*2,:,2)=eprt_setting_con_1(trial_num*2+randperm(trial_num*2),:);
eprt_setting_con_1_level(1:trial_num*2,:,3)=eprt_setting_con_1(trial_num*4+randperm(trial_num*2),:);
eprt_setting_con_1_level(1:trial_num*2,:,4)=eprt_setting_con_1(trial_num*6+randperm(trial_num*2),:);

%%%% generate each trial
fprintf(" ~~~~~~~~~~~~~~~ MODE: EASY ~~~~~~~~~~~~~~~` \n");
for ii=1:4
    fprintf(" ------ Level %f: %d items in total ------ \n",ii,setSize(ii));
    fprintf('>>>> key "1" for target present \n');
    fprintf('>>>> key "0" for no target \n');
    fprintf('Press Any Key to Start when ready!!!...\n '); 
    pause;
    for jj=1:trial_num*2
        [rp_time(jj), correctness(jj)]=trialGenerator(eprt_setting_con_1_level(jj,1,ii),eprt_setting_con_1_level(jj,2,ii),eprt_setting_con_1_level(jj,3,ii));
    end
    result_record(:,:,ii)=[rp_time',correctness',eprt_setting_con_1_level(:,3,ii)];
    corr_rate=sum(correctness)/trial_num/2*100;
    fprintf(">>>> You get %.1f%% correct.\n",corr_rate);
end

level=repelem(setSize,trial_num*2);
output_result_1(:,1)=level;
output_result_1(:,2:4)=[ result_record(:,:,1);result_record(:,:,2);result_record(:,:,3);result_record(:,:,4)];

%%%% ............... CONDITION 2: conjuction search ............... 
%%%% ....... parameter setting
%%%% "experiment_setting": experiment process parameters
eprt_setting_con_2(:,1)= repelem(setSize,[trial_num*2])'; %%%% four level of setSize
eprt_setting_con_2(:,2)= repelem([2],[trial_num*2*4])'; %%%% condition 2
eprt_setting_con_2(:,3)= repmat(repelem([1,0],[trial_num]),[1,4])'; %%%% with target or not
%%%% rearrange sequence for each level
eprt_setting_con_2_level(1:trial_num*2,:,1)=eprt_setting_con_2(randperm(trial_num*2),:);
eprt_setting_con_2_level(1:trial_num*2,:,2)=eprt_setting_con_2(trial_num*2+randperm(trial_num*2),:);
eprt_setting_con_2_level(1:trial_num*2,:,3)=eprt_setting_con_2(trial_num*4+randperm(trial_num*2),:);
eprt_setting_con_2_level(1:trial_num*2,:,4)=eprt_setting_con_2(trial_num*6+randperm(trial_num*2),:);

%%%% generate each trial
clc;
fprintf(" ~~~~~~~~~~~~~~~ MODE: HARD ~~~~~~~~~~~~~~~` \n");
for ii=1:4
    fprintf(" ------ Level %f: %d items in total ------ \n",ii,setSize(ii));
    fprintf('>>>> key "1" for target present \n');
    fprintf('>>>> key "0" for no target \n');
    fprintf('Press Any Key to Start when ready!!!...\n'); 
    pause;
    for jj=1:trial_num*2
        [rp_time(jj), correctness(jj)]=trialGenerator(eprt_setting_con_2_level(jj,1,ii),eprt_setting_con_2_level(jj,2,ii),eprt_setting_con_2_level(jj,3,ii));
    end
    result_record(:,:,ii)=[rp_time',correctness',eprt_setting_con_2_level(:,3,ii)];
    corr_rate=sum(correctness)/trial_num/2*100;
    fprintf(">>>> You get %.1f%% correct.\n",corr_rate);
end

level=repelem(setSize,trial_num*2);
output_result_2(:,1)=level;
output_result_2(:,2:4)=[ result_record(:,:,1);result_record(:,:,2);result_record(:,:,3);result_record(:,:,4)];

subject_name=input("* v * 让我知道知道是哪个小可爱做完了呀！！！(PINXIN)\n","s");
output_filename="Exercise_7_result_"+subject_name+".xlsx";

xlswrite(output_filename,output_result_1,"pop-out_search");
xlswrite(output_filename,output_result_2,"conjuction_search");

fprintf(">>>> 啵！！！\n");
fprintf(">>>> 快去运行路径下找一个刚生成的excel，然后发给我呀~~~\n");

%% --------------------------------------------------------
%%%%                       FUNCTION
%% --------------------------------------------------------
function [rp_time, correctness]=trialGenerator(setSize,condition,ifTarget)
% >>>> Description:
% Generate items display as defined by condition
% Need subject click to determine whether there is target
% Record response time
% >>>> Input Parameters
% setSize: EVEN number of displayed items(4,8,12,16)
% condition: 1 for "pop-out"; 2 for "conjunction"
% ifTarget: 1 for target present, 0 for no target
% >>>> Output Parameters
% rp_time: response time( Display of picture - Subject response)

%%%% ...................... Generate items set ...........................
%%%% >> "item_feature": features of items represented by matrix
%%%% column 1 for shape: 1-"o" 0-"x";
%%%% column 2 for color: 1-red 0-blue;
%%%% each row means each item
if condition == 1 %%%% "pop-out search"
 
    item_feature=[ones([setSize/2,2]);zeros([setSize/2,2])]; 
    tg_featureType=randi(2,1); 
    %%%% "tg_feature": determine which feature to distinct target. 
    %%%% 1 for shape; 2 for color
    tg_featureDisplay=randi(2,1)-1;
    item_feature(:,tg_featureType)= tg_featureDisplay;
    if ifTarget == 1
        tg_row=randi(setSize,1);
        if item_feature(tg_row,tg_featureType)==1
            item_feature(tg_row,tg_featureType)=0;
        else
            item_feature(tg_row,tg_featureType)=1; 
        end
    end
        
elseif condition == 2 %%%% "conjunction search"
    
    featureType=[0,0;1,0;1,1;0,1];
    if ifTarget==1
        tg_featureType=randi(4,1);
        dis_featureType=[1,2,3,4].*[[1,2,3,4]~=tg_featureType];
        dis_featureType(find(dis_featureType==0))=[];
        rep_time=(setSize-1)/3;
        item_feature=repmat(featureType(dis_featureType,:),[rep_time,1]);
        item_feature(size(item_feature,1)+1,:)=featureType(tg_featureType,:);
    else
        eq_number=floor(setSize/4);
        re_number=setSize-3*eq_number;
        rd_featureType=randi(4,1);
        dis_featureType=[1,2,3,4].*[[1,2,3,4]~=rd_featureType];
        dis_featureType(find(dis_featureType==0))=[];
        item_feature=[repmat(featureType(dis_featureType,:),[eq_number,1]);repmat(featureType(rd_featureType,:),[re_number,1])];
        
    end  
    
else
    print("Wrong input[condition(1/2)]\n")
    return
end

%%%% .............. Generate random position coordinate ..................
%%%% due to the size of item number, set both x,y with 6 position site, 36
%%%% potential site in total, distance between each site is 0.2
pos_num=6;
pos_total=pos_num*pos_num;
distance_between=0.01;

pos_coor_all=fullfact([pos_num,pos_num]); %%% whole combination;
row_sele=[repmat(1,[1,setSize]),repmat(0,[1,pos_total-setSize])];
row_sele=row_sele(randperm(pos_total)); %%%% rearrange sequence
row_sele=[1:pos_total] .* row_sele;
row_sele(find(row_sele==0))=[];
pos_coor_sele=pos_coor_all(row_sele,:) *distance_between;
pos_coor_sele = pos_coor_sele(randperm(setSize),:); %%%% rearrange sequence


%%%% .............. Generate Plot ..................
% for ii=1:size(item_feature,1)
%     if item_feature(ii,1)==1
%         a="o";
%     else
%         a="x";
%     end
%     if item_feature(ii,2)==1
%         b="r";
%     else
%         b="b";
%     end
%     c=strcat(b,a);
%     item_feature_str(ii,:)=c;
% end
    
item_feature_str=string(item_feature);
item_feature_str=strcat(item_feature_str(:,1),item_feature_str(:,2));
feature_code=["00","10","01","11"];
feature_type=["bx","bo","rx","ro"];
for ii=1:4
    item_feature_str=replace(item_feature_str,feature_code(ii),feature_type(ii));
end

fg=figure();
set(fg,"Color","w");
set(fg,"visible","off");
hold on;
for ii=1:setSize
    plot(pos_coor_sele(ii,1),pos_coor_sele(ii,2),item_feature_str(ii),"MarkerSize",12);
end
xlim([0,distance_between*(pos_num+1)]);
ylim([0,distance_between*(pos_num+1)]);
hold off;
axis off;
set(fg,"visible","on");

tic;
pause; 
response_key=get(fg,"CurrentCharacter");
rp_time=toc;
close(gcf);

if response_key==string(ifTarget)
    correctness=1;
else
    correctness=0;

end
end