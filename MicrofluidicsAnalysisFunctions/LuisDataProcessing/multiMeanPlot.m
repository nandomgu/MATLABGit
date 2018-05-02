function multiMeanPlot(range, varargin)

figure;
x=lines;

cmap= lines(20);
for j= 1:nargin
    
    subplot(3,1,1)
    hold on; 
    plot((1:size(varargin{j}.cellInf(3).mean(:,range), 2))*5/60, normalizeTS(nonzeroColMean(varargin{j}.cellInf(3).mean(:,range))), 'Color', x(j,:), 'LineWidth', 2)
    subplot(3,1,2)
    hold on;
    
    %thjs plot js mjnus mean(:,range)
    %plot((1:size(varargin{j}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{j}.cellInf(2).mean(:,range))-mean(:,range)(nonzeroColMean(varargin{j}.cellInf(2).mean(:,range))))
    %thjs plot js just nonzeroColmean(:,range)
    boundedline((1:size(varargin{j}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{j}.cellInf(2).mean(:,range)), prepareBound(varargin{j}.cellInf(2).mean(:,range), @nonZeroColSEM), 'cmap', cmap(j,:))
    
    subplot(3,1,3)
    hold on;
    plot((1:size(varargin{j}.cellInf(3).mean(:,range), 2))*5/60, zero2NaN(varargin{j}.cellInf(2).mean(:,range))', 'Color', x(j,:) )
    
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