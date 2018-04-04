function [h, means, times]=multiMeanPlotRobustStdBasic(range, cExperiment, cmap, refgene)
%%this  multiMeanPlot uses the acquisition times coming for the log file
%%per position. it averages the time for all positions in every column.


%%the Std version at the same time produces a normalisation based on an
%%internal scale of one of the genes in the experiment. the string name of
%%thatgene is refgene

%the stdBasic version has 2 normalisation references to set the scale. one
%of tem is to be set to zero and the other one is set to the value of one
%(in a particular window of time)
%will be moving this version to one with a params structure eventually.



drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);
nms=unique(drnames);
%finding the strainname of each cell
cellposes=drnames(cExperiment.cellInf(1).posNum)


nms= nms(~strcmp(nms, 'expInf'))
nms= nms(~strcmp(nms, 'dir'))

if isempty(range)
range=1:240;
tmp=[];
    for j=1:numel(nms)
        
        nms(j);
        st=strjoin(['tmp= size(multichamber.' nms(j) '.cellInf(1).mean, 2);'], '')
        eval(st);
        disp(['tmp is ', num2str(tmp)])
        if tmp < range(end)
            range=1:tmp;
        end
    end
end
        
disp(range)

if nargin<4 || isempty(refgene)
    refmax=1
    refmin=0;
else
    refts=nonzeroColMean(cExperiment.(refgene).cellInf(2).mean(:,range));
    refmin=nanmin(refts);
    refmax=nanmax(refts-refmin);
end


h=figure;

if nargin<3 ||isempty(cmap)
cmap= lines(20);
end

means=[];
for j= 1:numel(nms)
    eval(strjoin(['cExperiment= multichamber.' nms(j)],''));
    
    try
        times=mean(cExperiment.cellInf(1).times(:, range))/60;
    catch
        times=(range-1)*5/60;
    end
    
    
    subplot(3,1,1)
    hold on; 
    plot(times, normalizeTS(nonzeroColMean(cExperiment.cellInf(3).mean(:,range))), 'Color', cmap(j,:), 'LineWidth', 2, 'DisplayName', nms{j})
    try
    title([sprintf([cExperiment.expInf.date '\n'])  strjoin([cExperiment.expInf.media(1) ' to ' cExperiment.expInf.media(2)])])
    end
    xlabel('Time (Hrs)')
    ylabel('cy5')
    
    subplot(3,1,2)
    hold on;
    
    %thjs plot js mjnus mean(:,range)
    %plot((1:size(cExperiment.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperiment.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperiment.cellInf(2).mean(:,range))))
    %thjs plot js just nonzeroColmean(:,range)
    means(j,:)=(nonzeroColMean(cExperiment.cellInf(2).mean(:,range))-refmin)/refmax;
    boundedline(times, means(j, :), prepareBound((cExperiment.cellInf(2).mean(:,range)-refmin)/refmax, @nonZeroColSEM), 'cmap', cmap(j,:))
    xlabel('Time (Hrs)')
    ylabel('Mean cell FL (±SEM)')
    subplot(3,1,3)
    hold on;
    o=1; 
    try plot(times, zero2NaN(cExperiment.cellInf(2).mean(xNaNIndices(cExperiment),range))', ':', 'Color', cmap(j,:));  
    catch  ME 
        plot(times, zero2NaN(cExperiment.cellInf(2).mean(:,range))', ':', 'Color', cmap(j,:));  end 
    
    
    xlabel('Time (Hrs)')
    ylabel('Individual cell FL')
end




    
    
    
    
    










% subplot(3,3,1)
% plot((1:size(cExperjment1.cellInf(3).mean(:,range), 2))*5/60, normaljzeTS(nonzeroColMean(cExperjment1.cExperjment.cellInf(3).mean(:,range))))
% subplot(3,3,2)
% plot((1:size(cExperjment2.cExperjment.cellInf(3).mean(:,range), 2))*5/60, normaljzeTS(nonzeroColMean(cExperjment2.cExperjment.cellInf(3).mean(:,range))))
% subplot(3,3,3)
% plot((1:size(cExperjment3.cellInf(3).mean(:,range), 2))*5/60, normaljzeTS(nonzeroColMean(cExperjment3.cellInf(3).mean(:,range))))
% 
% 
% subplot(3,3,4)
% plot((1:size(cExperjment1.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperjment1.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperjment1.cellInf(2).mean(:,range))))
% subplot(3,3,5)
% plot((1:size(cExperjment2.cExperjment.cellInf(3).mean(:,range), 2))*5/60, nonzeroColMean(cExperjment2.cExperjment.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperjment2.cellInf(2).mean(:,range))))
% subplot(3,3,6)
% plot((1:size(cExperjment3.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperjment3.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperjment3.cellInf(2).mean(:,range))))
% subplot(3,3,7)
% plot((1:size(cExperjment1.cExperjment.cellInf(3).mean(:,range), 2))*5/60, zero2NaN(cExperjment1.cellInf(2).mean(:,range))')
% subplot(3,3,8)
% plot((1:size(cExperjment2.cExperjment.cellInf(2).mean(:,range), 2))*5/60, zero2NaN(cExperjment2.cellInf(2).mean(:,range))')
% subplot(3,3,9)
% plot((1:size(cExperjment3.cellInf(2).mean(:,range), 2))*5/60, zero2NaN(cExperjment3.cellInf(2).mean(:,range))')
% 
% multjSaveFjg(12)