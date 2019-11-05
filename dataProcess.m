function [result]=dataProcess(sub_filename, sheetpages)
%% description:
%   select specific vision search type data and calculate the average and
%   SEM for each stimulus number.
%% Input Args
%   "subject_filename": all excels to retrieve data
%   "sheetpage": condition that to analyse
%       "Practice", "Feature Search", "Conjunction Search", "Interleaved Search"
%
%
%% Output Args
%   "result": statistical result of input data
%   result(:,:,i) - the "i" vision search type. 1 for feature search; 2 for conjunction search
%   result(:,1): stimulus size
%   result(:,2): average response time
%   result(:,3): SEM response time
%
%
    %% Read Data
    sbj_data=[];
    for ii=1:length(sub_filename)
        for jj = 1:length(sheetpages)
            data=xlsread(sub_filename(ii),sheetpages(jj));
            % clear off the wrong response record
            data((data(:,6)==0),:) = [];
            sbj_data( size(sbj_data,1)+1:size(sbj_data,1)+size(data,1),:) = data;       
        end
    end
   
    %% Conditions
    vs_type = unique(sbj_data(:,1));
    sti_size = unique(sbj_data(:,2));
    for ii = 1:length(vs_type)
        for jj = 1:length(sti_size)
            result(jj,1,ii) = sti_size(jj);
            sbData = sbj_data(sbj_data(:,1) == vs_type(ii) & sbj_data(:,2) == sti_size(jj),:);
            result(jj,2,ii) = mean(sbData(:,4));
            result(jj,3,ii) = std(sbData(:,4)) / sqrt(length(sbData(:,4)));           
        end
    end
    
end