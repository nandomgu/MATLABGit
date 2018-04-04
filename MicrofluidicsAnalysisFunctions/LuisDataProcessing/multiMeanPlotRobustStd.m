function [h, params]=multiMeanPlotRobustStd(range, multichamber, cmap, refgene, params)
%%this  multiMeanPlot uses the acquisition times coming for the log file
%%per position. it averages the time for all positions in every column.

%%the Std version at the same time produces a normalisation based on an
%%internal scale of one of the genes in the experiment. the string name of
%%thatgene is refgene
if nargin<5 || isempty(params)
    params.cellchan=2;
    params.bgchan=3;
    params.bfchan=1;
end

%% getting the names of each strain
nms= fieldnames(multichamber);


nms= nms(~strcmp(nms, 'expInf'))
nms= nms(~strcmp(nms, 'dir'))

if isempty(range)
range=1:240;
tmp=[];
    for j=1:numel(nms)
        
        nms(j);
        st=strjoin(['tmp= size(multichamber.' nms(j) '.cellInf(params.bfchan).mean, 2);'], '')
        eval(st);
        
        if tmp <= range
            range=1:tmp;
        end
    end
end
        

if nargin<4 || isempty(refgene)
    refmax=1
    refmin=0;
else
    refts=nonzeroColMean(multichamber.(refgene).cellInf(params.cellchan).mean(:,range));
    refmin=nanmin(refts);
    refmax=nanmax(refts-refmin);
end


h=figure;

if nargin<3 ||isempty(cmap)
cmap= lines(20);
end


for j= 1:numel(nms)
    eval(strjoin(['cExperiment= multichamber.' nms(j)],''));
    try
        times=mean(cExperiment.cellInf(1).times(:, range))/60;
    catch
        times=(range-1)*5/60
    end
    
    subplot(3,1,1)
    hold on; 
    plot(times, normalizeTS(nonzeroColMean(cExperiment.cellInf(params.bgchan).mean(:,range))), 'Color', cmap(j,:), 'LineWidth', 2, 'DisplayName', nms{j})
    try
        title([sprintf([multichamber.expInf.date '\n'])  strjoin([multichamber.expInf.media(1) ' to ' multichamber.expInf.media(2)])])
    end
    xlabel('Time (Hrs)')
    ylabel('cy5')
    
    subplot(3,1,2)
    hold on;
    
    %thjs plot js mjnus mean(:,range)
    %plot((1:size(cExperiment.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperiment.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperiment.cellInf(2).mean(:,range))))
    %thjs plot js just nonzeroColmean(:,range)
    
    boundedline(times, (nonzeroColMean(cExperiment.cellInf(params.cellchan).mean(:,range))-refmin)/refmax, prepareBound((cExperiment.cellInf(params.cellchan).mean(:,range)-refmin)/refmax, @nonZeroColSEM), 'cmap', cmap(j,:))
    xlabel('Time (Hrs)')
    ylabel('Mean cell FL (±SEM)')
    subplot(3,1,3)
    hold on;
    o=1; 
    try plot(times, zero2NaN(cExperiment.cellInf(params.cellchan).mean(xNaNIndices(cExperiment),range))', ':', 'Color', cmap(j,:));  
    catch  ME 
        plot(times, zero2NaN(cExperiment.cellInf(params.cellchan).mean(:,range))', ':', 'Color', cmap(j,:));  end 
    
    
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