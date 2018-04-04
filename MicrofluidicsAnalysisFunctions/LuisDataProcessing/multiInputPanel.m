function out=multiInputPanel(varargin)
%%argument 1 is the range of timepoints to take from all the timelapses
%%(timelapses may be different lengths).
figure;
range=varargin{1}; 
c=1;
out=struct;
iterator=1;
plotTraces=0;
%if there is no range, then set the range to be the common denominator
%across experiments.
 if isempty(varargin{1})  %%clues that no range was included
    
     
     rng=size(varargin{2}.cellInf(1).mean,2)
     for j= 2:nargin
         rng2=size(varargin{j}.cellInf(1).mean,2);
         if rng2 < rng
             rng=rng2
         end
     end
     range=1:rng;
 end
startpoint =2;

for i= startpoint:nargin
%     if isempty(range) || sum(class(varargin{1})=='struct')>0
%         range=1:size(varargin{i}.cellInf(2).mean, 2)
%     end
    xrange=(1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60;
    subplot(3,numel(varargin(startpoint:end)),c)
    out.cy5(iterator,:)=normalizeTS(nonzeroColMean(full(varargin{i}.cellInf(3).imBackground(:,range))));
    plot((1:size(varargin{i}.cellInf(3).imBackground(:,range), 2))*5/60, normalizeTS(nonzeroColMean(varargin{i}.cellInf(3).imBackground(:,range))), 'Color', [0 0 0]);
    title(varname(varargin{i}))
    xlim([0, xrange(end)]);
    xlabel('Time (Hrs)');
    ylabel('scaled cy5');
    subplot(3,numel(varargin(startpoint:end)),c+numel(varargin(startpoint:end)));
    %centered mean
    %plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range))-mean(nonzeroColMean(varargin{i}.cellInf(2).mean(:,range))))
    %normal mean
   % plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)))
   %SEM
   out.mean(iterator,:)=nonzeroColMean(varargin{i}.cellInf(2).mean(:,range));
  
   errorbar(xrange, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)), nonZeroColSEM(varargin{i}.cellInf(2).mean(:,range)));
   
   xlim([0, xrange(end)]);
   xlabel('Time (Hrs)');
   ylabel('Mean cell FL (±SEM)');
   %STD
   %errorbar((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)), nonZeroColStd(varargin{i}.cellInf(2).mean(:,range)))
if plotTraces==1
    subplot(3,numel(varargin(startpoint:end)),c+((numel(varargin(startpoint:end)))*2));
    plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, zero2NaN(varargin{i}.cellInf(2).mean(:,range))');
    xlabel('Time (Hrs)');
    ylabel('raw cell FL');
end
    c=c+1;
    iterator=iterator+1;
end


    
    
    
    
    










% subplot(3,3,1)
% plot((1:size(cExperiment1.cellInf(3).mean, 2))*5/60, normalizeTS(nonzeroColMean(cExperiment1.cExperiment.cellInf(3).mean)))
% subplot(3,3,2)
% plot((1:size(cExperiment2.cExperiment.cellInf(3).mean, 2))*5/60, normalizeTS(nonzeroColMean(cExperiment2.cExperiment.cellInf(3).mean)))
% subplot(3,3,3)
% plot((1:size(cExperiment3.cellInf(3).mean, 2))*5/60, normalizeTS(nonzeroColMean(cExperiment3.cellInf(3).mean)))
% 
% 
% subplot(3,3,4)
% plot((1:size(cExperiment1.cellInf(2).mean, 2))*5/60, nonzeroColMean(cExperiment1.cellInf(2).mean)-mean(nonzeroColMean(cExperiment1.cellInf(2).mean)))
% subplot(3,3,5)
% plot((1:size(cExperiment2.cExperiment.cellInf(3).mean, 2))*5/60, nonzeroColMean(cExperiment2.cExperiment.cellInf(2).mean)-mean(nonzeroColMean(cExperiment2.cellInf(2).mean)))
% subplot(3,3,6)
% plot((1:size(cExperiment3.cellInf(2).mean, 2))*5/60, nonzeroColMean(cExperiment3.cellInf(2).mean)-mean(nonzeroColMean(cExperiment3.cellInf(2).mean)))
% subplot(3,3,7)
% plot((1:size(cExperiment1.cExperiment.cellInf(3).mean, 2))*5/60, zero2NaN(cExperiment1.cellInf(2).mean)')
% subplot(3,3,8)
% plot((1:size(cExperiment2.cExperiment.cellInf(2).mean, 2))*5/60, zero2NaN(cExperiment2.cellInf(2).mean)')
% subplot(3,3,9)
% plot((1:size(cExperiment3.cellInf(2).mean, 2))*5/60, zero2NaN(cExperiment3.cellInf(2).mean)')
% 
% multiSaveFig(12)