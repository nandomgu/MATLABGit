function [h, means, times]=multiMeanPlotRobustStdAdvanced(range, cExperiment, cmap, refzero, refone, normrange, cellchan, bgchan)
%%this  multiMeanPlot uses the acquisition times coming for the log file
%%per position. it averages the time for all positions in every column.


%%the Std version at the same time produces a normalisation based on an
%%internal scale of one of the genes in the experiment. the string name of
%%thatgene is refgene

%the stdBasic version has 2 normalisation references to set the scale. one
%of tem is to be set to zero and the other one is set to the value of one
%(in a particular window of time)
%will be moving this version to one with a params structure eventually.


if nargin<7 || isempty(cellchan)
    bgchan=3;
end


if nargin<6 || isempty(cellchan)
    cellchan=2;
end


drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);
nms=unique(drnames);
%finding the strainname of each cell
cellposes=drnames(cExperiment.cellInf(1).posNum)


nms= nms(~strcmp(nms, 'expInf'))
nms= nms(~strcmp(nms, 'dir'))


        
disp(range)

if nargin<4 || isempty(refzero) ||isempty(refone)
    refmax=1
    refmin=0;
else
    %as reference zero is the wild type, it is worth considering that this
    %is treated as a time series in case it changes over time.
    zerocells=find(strcmp(refzero, cellposes));
    onecells=find(strcmp(refone, cellposes));
    %%keeping the full time series
    refzerots=nonzeroColMean(cExperiment.cellInf(cellchan).mean(zerocells,:));
    refonets=nonzeroColMean(cExperiment.cellInf(cellchan).mean(onecells,:));
    %refmin=mean(refzerots);
    refmax=refonets(normrange)-refzerots(normrange); %we subtract the zero and then get the time series mean 
    refmax=mean(refmax(:));
end


h=figure;

if nargin<3 ||isempty(cmap)
cmap= lines(20);
end
matr=cExperiment.cellInf(cellchan).mean; %copying the values in cExperiment to modify at will

%now we subract the timewise refmin ts from each cell
%we replicate to match the sizes
%matr=matr-repmat(refzerots, size(matr, 1), 1);
if isempty(range)
range=1:size(matr, 2)
end



means=[];
for j= 1:numel(nms)
    %geting cell numbers corresponding to the current strain name
    nmcells=[];
    nmcells=find(strcmp(nms{j}, cellposes));
    
    try
        times=mean(cExperiment.cellInf(1).times(nmcells, range))/60;
    catch
        times=(range-1)*5/60;
    end
    
    %%
    %% plotting cy5 signal
    subplot(3,1,1)
    hold on; 
    plot(times, normalizeTS(nonzeroColMean(cExperiment.cellInf(bgchan).mean(nmcells,range))), 'Color', cmap(j,:), 'LineWidth', 2, 'DisplayName', nms{j})
    title(strrep(cExperiment.metadata.date, '_', '-'))
    xlabel('Time (Hrs)')
    ylabel('cy5')
    
    subplot(3,1,2)
    hold on;
    
    %thjs plot js mjnus mean(:,range)
    %plot((1:size(cExperiment.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperiment.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperiment.cellInf(2).mean(:,range))))
    %thjs plot js just nonzeroColmean(:,range)
    
    %we subtract the mean from the reference
    means(j,:)=(nonzeroColMean(matr(nmcells,range))-refzerots(range))/refmax;
    boundedline(times, means(j, :), prepareBound(((matr(nmcells,range))-refzerots(range))/refmax, @nonZeroColSEM), 'cmap', cmap(j,:))
    xlabel('Time (Hrs)')
    ylabel('Standardised Fluorescence Mean (±SEM)')
    subplot(3,1,3)
    hold on;
    o=1; 
    try plot(times, zero2NaN(matr(nmcells,range))', ':', 'Color', cmap(j,:));  
    catch  ME 
        plot(times, zero2NaN(matr(nmcells,range))', ':', 'Color', cmap(j,:));  end 
    
    
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