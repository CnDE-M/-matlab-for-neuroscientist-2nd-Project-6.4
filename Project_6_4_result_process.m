filename=["Exercise_7_result_mxy_10_1_1.xlsx","Exercise_7_result_mxy_10_1_2.xlsx","Exercise_7_result_mxy_10_1_3.xlsx"];
raw_po=[];
raw_con=[];
for ii=1:length(filename)
	a=xlsread(filename(ii),"pop-out_search");
	b=xlsread(filename(ii),"conjuction_search");
	raw_po(size(raw_po,1)+1:size(raw_po,1)+size(a,1),:)=a;
	raw_con(size(raw_con,1)+1:size(raw_con,1)+size(b,1),:)=b;
end

%%%% >>>> result structure
%%%% variable: "raw_con" "raw_po"
%%%% Column 1: item number
%%%% Column 2: response time
%%%% Column 3: correctness
%%%% Column 4: ifTarget

setSize=[10,16,22,28];
% ifTarget=[0,1];

%%%% rearrange data
%%%% variable: "rt_po" "rt_con"
%%%% column(D-2): item number
%%%% (D-3): with target(1) or not(2)
for jj=1:length(setSize)
	rt_con_wt(:,:,jj)=raw_con(find(raw_con(:,1)==setSize(jj) & raw_con(:,4)==1 ),[2,3]);
	rt_po_wt(:,:,jj)=raw_po(find(raw_po(:,1)==setSize(jj) & raw_po(:,4)==1 ),[2,3]);
	meanRT_con_wt(jj)=mean(rt_con_wt(rt_con_wt(:,2,jj)==1,1,jj));
	meanRT_po_wt(jj)=mean(rt_po_wt(rt_po_wt(:,2,jj)==1,1,jj));
    semRT_con_wt(jj) = std(rt_con_wt(rt_con_wt(:,2,jj)==1,1,jj))/2;
    semRT_po_wt(jj) = std(rt_po_wt(rt_po_wt(:,2,jj)==1,1,jj))/2;

	rt_con_nt(:,:,jj)=raw_con(find(raw_con(:,1)==setSize(jj) & raw_con(:,4)==0 ),[2,3]);
	rt_po_nt(:,:,jj)=raw_po(find(raw_po(:,1)==setSize(jj) & raw_po(:,4)==0 ),[2,3]);
	meanRT_con_nt(jj)=mean(rt_con_nt(rt_con_nt(:,2,jj)==1,1,jj));
	meanRT_po_nt(jj)=mean(rt_po_nt(rt_po_nt(:,2,jj)==1,1,jj));
    semRT_con_nt(jj) = std(rt_con_nt(rt_con_nt(:,2,jj)==1,1,jj))/2;
    semRT_po_nt(jj) = std(rt_po_nt(rt_po_nt(:,2,jj)==1,1,jj))/2;
end

%%%% ......................... Pearson correlation result ......................
%%%% "magnitude" "p_value": column[1:2]=[pop-out,conjunction];
%%%%              row[1:3] = [with target, no target, with&no]
[m,p]=corrcoef(meanRT_po_wt,setSize);
magnitude(1,1)=m(1,2);
p_value(1,1)= p(1,2);
[m,p]=corrcoef(meanRT_po_nt,setSize);
magnitude(1,2)=m(1,2);
p_value(1,2)= p(1,2);
[m,p]=corrcoef( (meanRT_po_nt+meanRT_po_wt)./2,setSize);
magnitude(1,3)=m(1,2);
p_value(1,3)= p(1,2);

[m,p]=corrcoef(meanRT_con_wt,setSize);
magnitude(2,1)=m(1,2);
p_value(2,1)= p(1,2);
[m,p]=corrcoef(meanRT_con_nt,setSize);
magnitude(2,2)=m(1,2);
p_value(2,2)= p(1,2);
[m,p]=corrcoef( (meanRT_con_nt+meanRT_con_wt)./2,setSize);
magnitude(2,3)=m(1,2);
p_value(2,3)= p(1,2);

%%%% ......................... figure result ......................
figure("Position",[200,50,700,500]);

%%%% plot_1: "with target"
subplot(3,1,1);
hold on;
errorbar([1:4],meanRT_con_wt,semRT_con_wt,"-.r");
text("String","magnitude: "+string(magnitude(2,1))+" p-value: "+string(p_value(2,1)),"Color","r","Position",[0.05,2.7],"FontSize",7);
errorbar([1:4],meanRT_po_wt,semRT_po_wt,"-.b");
text("String","magnitude: "+string(magnitude(1,1))+" p-value: "+string(p_value(1,1)),"Color","b","Position",[0.05,0.7],"FontSize",7);
title("response time in with-target trials(only correct)");
xlim([0,5]);
ylim([0,3]);
xticks([0:5]);
xlabel("item number");
ylabel("response time(s)");
xticklabels(["",string(setSize),""]);
hold off;

%%%% plot_2: "no target"
subplot(3,1,2);
hold on;
errorbar([1:4],meanRT_con_nt,semRT_con_nt,"-.r");
text("String","magnitude: "+string(magnitude(2,2))+" p-value: "+string(p_value(2,2)),"Color","r","Position",[0.05,2.7],"FontSize",7);
errorbar([1:4],meanRT_po_nt,semRT_po_nt,"-.b");
text("String","magnitude: "+string(magnitude(1,2))+" p-value: "+string(p_value(1,2)),"Color","b","Position",[0.05,0.7],"FontSize",7);
title("response time in no-target trials(only correct)");
xlim([0,5]);
ylim([0,3]);
xticks([0:5]);
xlabel("item number");
ylabel("response time(s)");
xticklabels(["",string(setSize),""]);

%%%% plot_1: "with and no target"
subplot(3,1,3);
hold on;
plot([1:4],(meanRT_con_wt+meanRT_con_nt)./2,"o-.r");
text("String","magnitude: "+string(magnitude(2,3))+" p-value: "+string(p_value(2,3)),"Color","r","Position",[0.05,2.7],"FontSize",7);
plot([1:4],(meanRT_po_wt+meanRT_po_nt)./2,"o-.b");
text("String","magnitude: "+string(magnitude(1,3))+" p-value: "+string(p_value(1,3)),"Color","b","Position",[0.05,0.7],"FontSize",7);
title("response time in all trials(only correct)");
xlim([0,5]);
ylim([0,3]);
xticks([0:5]);
xlabel("item number");
ylabel("response time(s)");
xticklabels(["",string(setSize),""]);
hold off;
legend(["conjunction search","pop out search"],"Location","northeastoutside");

