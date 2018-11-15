function [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdBasic(range, cExperiment, cmap, refgene, cellchan, bgchan, nms, makeplot, factor)
%%this  multiMeanPlot uses the acquisition times coming for the log file
%%per position. it averages the time for all positions in every column.


%%the Std version at the same time produces a normalisation based on an
%%internal scale of one of the genes in the experiment. the string name of
%%thatgene is refgene

%the stdBasic version has 2 normalisation references to set the scale. one
%of tem is to be set to zero and the other one is set to the value of one
%(in a particular window of time)
%will be moving this version to one with a params structure eventually.


if nargin<6 || isempty(bgchan) 
   bgchan=3; 
end

if nargin<5 || isempty(cellchan) 
   cellchan=2; 
end




drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);
%finding the strainname of each cell
cellposes=drnames(cExperiment.cellInf(1).posNum)

if nargin<7 ||isempty(nms)
nms=unique(drnames);  
end
if nargin<8 || isempty(makeplot) 
   makeplot=1; 
end


if sum(strcmp(cellposes, refgene))==0
    error(['No cells were found for reference gene ' refgene '. Make sure that such strain has been extracted appropriately or choose another strain.'] );
end


if isempty(range)
range=1:size(cExperiment.cellInf(cellchan).mean, 2);
end
        
disp(range)

if nargin<4 || isempty(refgene)
    refmax=1
    refmin=0;
else
    refcells=strcmp(cellposes, refgene); %we find the cells that are the reference
    refts=nonzeroColMean(cExperiment.cellInf(cellchan).mean(refcells,range));
    refmin=nanmin(refts);
    refmax=nanmax(refts-refmin);
    %verification block to see refmin and refmax plotted relative to the
    %refts
%     figure; plot(refts); 
%     addHLine(refmin);
%     addHLine(nanmax(refts));
    
    
end

if makeplot==true
h=figure;
else
    h=[];
end
if nargin<3 ||isempty(cmap)
cmap= lines(20);
end


matr=cExperiment.cellInf(cellchan).mean;

zerovals=matr==0;


if isfield('times', cExperiment.cellInf(1))
    times=cExperiment.cellInf(1).times;
else
    times=(range-1)*5/60;
end
    
means=[];
for j= 1:numel(nms)
    cells=strcmp(cellposes, nms{j}); 
     
    if numel(times)< range(end)
        %there is this weird bug in which the times vector is shorter than
        %the data vectors (presumably a problem in the cExp log file. we make sure to fix for this
        range= 1:numel(times);
    end
        
    %catch
        %times=(range-1)*5/60;
    %end
    
    if makeplot==true
    subplot(3,1,1)
    hold on; 
    
    plot(times, normalizeTS(nonzeroColMean(cExperiment.cellInf(bgchan).mean(cells,range))), 'Color', cmap(j,:), 'LineWidth', 2, 'DisplayName', nms{j})
    xlabel('Time (Hrs)')
    ylabel('cy5')
    
    subplot(3,1,2)
    hold on;
    end
    %thjs plot js mjnus mean(:,range)
    %plot((1:size(cExperiment.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperiment.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperiment.cellInf(2).mean(:,range))))
    %this plot js just nonzeroColmean(:,range)
    
    
    %what is happening here is that first we get the non zero mean and then
    %we center/scale. this prevents the zeros to permeate into the
    %calculation.
    means(j,:)=(nonzeroColMean(cExperiment.cellInf(cellchan).mean(cells,range))-refmin)/refmax;
    
    
    bnds.(nms{j})=prepareBound((cExperiment.cellInf(cellchan).mean(cells,range)-refmin)/refmax, @nonZeroColSEM);
    
    %if there is a factor...
    if nargin>9 || ~isempty(factor)
        means(j, :)= means(j,:)/factor
        bnds.(nms{j})=prepareBound(((cExperiment.cellInf(cellchan).mean(cells,range)-refmin)/refmax)/factor, @nonZeroColSEM);
    end
    
    if makeplot==true
    boundedline(times, means(j, :),bnds.(nms{j}), 'cmap', cmap(j,:));
    xlabel('Time (Hrs)')
    ylabel('Mean cell FL (±SEM)')
    subplot(3,1,3)
    hold on;
    
    
    o=1; 
    plot(times, zero2NaN(cExperiment.cellInf(cellchan).mean(cells,range))', ':', 'Color', cmap(j,:));  
    
    
    
    xlabel('Time (Hrs)')
    ylabel('Individual cell FL')
    
    end
end



%matr2=matr;

 %we get rid of the alues that were zeros, which became an annoying constant

cExperiment.cellInf(cellchan).mean=((matr(:,range))-refmin)/refmax;
cExperiment.cellInf(cellchan).mean(zerovals)=NaN;
if nargin>9 || ~isempty(factor)
cExperiment.cellInf(cellchan).mean=cExperiment.cellInf(cellchan).mean/factor
end
%figure; plot(cExperiment.cellInf(cellchan).mean(nmcells, range)'); title('after')
stdmch=makeMultiChamber(cExperiment);
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