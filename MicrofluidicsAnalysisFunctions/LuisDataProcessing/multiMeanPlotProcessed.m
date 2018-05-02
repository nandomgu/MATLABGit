function h=multiMeanPlotProcessed(range, multichamber, cmap)
%%Essentially this multiplot is the same as aligned and robust but
%%subtracts the fluorescence value at 0,1,2...tsub.


tsub=-5
nms= fieldnames(multichamber);
nms= nms(~strcmp(nms, 'expInf'))

if isempty(range)
range=240;
tmp=[];
    for j=1:numel(nms)
        
        nms(j);
        st=strjoin(['tmp= size(multichamber.' nms(j) '.cellInf(1).mean, 2);'], '')
        eval(st);
        
        if tmp <= range
            range=1:tmp;
        end
    end
end
        




h=figure;


if nargin<3
cmap= lines(20);
end


for j= 1:numel(nms)
    eval(strjoin(['cExperiment= multichamber.' nms(j)],''));
    subplot(3,1,1)
    hold on; 
    plot(aligntoUpshift(range,cExperiment)*5/60, normalizeTS(nonzeroColMean(cExperiment.cellInf(3).mean(:,range))), 'Color', cmap(j,:), 'LineWidth', 2, 'DisplayName', nms{j})
    title([sprintf([multichamber.expInf.date '\n'])  strjoin([multichamber.expInf.media(1) ' to ' multichamber.expInf.media(2)])])
    xlabel('Time (Hrs)')
    ylabel('cy5')
    
    subplot(3,1,2)
    hold on;
    
    %thjs plot js mjnus mean(:,range)
    %plot((1:size(cExperiment.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(cExperiment.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(cExperiment.cellInf(2).mean(:,range))))
    %thjs plot js just nonzeroColmean(:,range)
    
   alignedRange=aligntoUpshift(range,cExperiment);
   
     subwindow=range(ismember(alignedRange, tsub:0)); %% finding the original indices for the preshift window
    
    flmatr=cExperiment.cellInf(2).mean(:,range);
    flmatr=flmatr- nanmean(nanmean(flmatr(:,subwindow)));
    
    boundedline(alignedRange*5/60, nonzeroColMean(flmatr), prepareBound(flmatr, @nonZeroColSEM), 'cmap', cmap(j,:))
    xlabel('Time (Hrs)')
    ylabel('Mean cell FL (±SEM) aligned and centered')
    subplot(3,1,3)
    hold on;
    plot(alignedRange*5/60, zero2NaN(cExperiment.cellInf(2).mean(:,range))', ':', 'Color', cmap(j,:))
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