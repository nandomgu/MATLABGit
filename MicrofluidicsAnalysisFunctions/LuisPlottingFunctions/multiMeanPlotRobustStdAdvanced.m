function [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced(range, cExperiment, cmap, refzero, refone, normrange, cellchan, bgchan, nms, makeplot, refmax, usemedian)
%%this  multiMeanPlot uses the acquisition times coming for the log file
%%per position. it averages the time for all positions in every column.


%%the Std version at the same time produces a normalisation based on an
%%internal scale of one of the genes in the experiment. the string name of
%%thatgene is refgene

%the stdBasic version has 2 normalisation references to set the scale. one
%of tem is to be set to zero and the other one is set to the value of one
%(in a particular window of time)
%will be moving this version to one with a params structure eventually.

if nargin<10
    makeplot=1;
end

if nargin<7 || isempty(cellchan)
    bgchan=3;
end


if nargin<6 || isempty(cellchan)
    cellchan=2;
end

drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);


if nargin<9 ||isempty(nms)
nms=unique(drnames);
else
    res=iscell(nms)
    
    if res==0
        error('nms must be a cell array of strings')
    end
end
       %finding the strainname of each cell
cellposes=drnames(cExperiment.cellInf(1).posNum);



        
disp(range)

if nargin<4 || isempty(refzero) ||isempty(refone) && isempty(refmax)
    refmax=1;
    refmin=0;
else 
    %as reference zero is the wild type, it is worth considering that this
    %is treated as a time series in case it changes over time.
    zerocells=find(strcmp(refzero, cellposes));
    onecells=find(strcmp(refone, cellposes));
    if isempty(onecells) && ~isempty(refone) && refmax==1 %ref was introduced and there are no cells
        error('there are no cells for the high reference strain. please make sure the spelling is correct');
    end
        %%keeping the full time series
    refzerots=nonzeroColMean(cExperiment.cellInf(cellchan).mean(zerocells,:));
    if nargin<12 ||isempty(usemedian)|| usemedian==0
    refonets=nonzeroColMean(cExperiment.cellInf(cellchan).mean(onecells,:));
    else
       refonets=nonzeroColMedian(cExperiment.cellInf(cellchan).mean(onecells,:)); %refmin=mean(refzerots);
    end
    if nargin <11 || isempty(refmax)
    refmax=refonets(normrange)-refzerots(normrange); %we subtract the zero and then get the time series mean 
    refmax=mean(refmax(:));
    
    end
    end %if refmax is not empty then we use it. nothing is needed to declare





if nargin<3 ||isempty(cmap)
cmap= lines(20);
end
matr=cExperiment.cellInf(cellchan).mean; %copying the values in cExperiment to modify at will
zerovals=matr==0;
%now we subract the timewise refmin ts from each cell
%we replicate to match the sizes
%matr=matr-repmat(refzerots, size(matr, 1), 1);
if isempty(range)
range=1:size(matr, 2)
end

if makeplot==1
    h=figure;
else
    h=[];
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
    
    if makeplot==1
    subplot(3,1,1)
    hold on; 
    plot(times, normalizeTS(nonzeroColMean(cExperiment.cellInf(bgchan).mean(nmcells,range))), 'Color', cmap(j,:), 'LineWidth', 2, 'DisplayName', nms{j})
    xlabel('Time (Hrs)')
    ylabel('cy5')
    title(strrep(cExperiment.metadata.date, '_', '-'));
    subplot(3,1,2)
    hold on;
    end
    %thjs plot js mjnus mean(:,range)
    %plot((1:size(cExperiment.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperiment.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperiment.cellInf(2).mean(:,range))))
    %thjs plot js just nonzeroColmean(:,range)
    
    %we subtract the mean from the reference
    means(j,:)=(nonzeroColMean(matr(nmcells,range))-refzerots(range))/refmax;
    bnds.(nms{j})=prepareBound(((matr(nmcells,range))-refzerots(range))/refmax, @nonZeroColSEM);
    if makeplot==1
    boundedline(times, means(j, :), bnds.(nms{j}), 'cmap', cmap(j,:))
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
end

%substituting the transformed data into the cExperiment object to output a
%standardized multichamber
%nmcells=find(strcmp('hxt4', cellposes));
%figure; plot(cExperiment.cellInf(cellchan).mean(nmcells, range)'); title('before')
%temporarily transform the data for the purpose of making a standardized
%multichamber


cExperiment.cellInf(cellchan).mean=((matr(:,range))-refzerots(range))/refmax;
cExperiment.cellInf(cellchan).mean(zerovals)=NaN; %we get rid of zeros, which become an undesirable constant in our processing. 
%figure; plot(cExperiment.cellInf(cellchan).mean(nmcells, range)'); title('after')
stdmch=makeMultiChamber(cExperiment)
%replace the transformed data with the original unaltered data
cExperiment.cellInf(cellchan).mean=matr;

%figure; plot(cExperiment.cellInf(cellchan).mean(nmcells, range)'); title('back to normal')
debug=1;




    
    
    
    
    










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