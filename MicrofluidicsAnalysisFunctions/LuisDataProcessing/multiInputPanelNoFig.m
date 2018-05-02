function out=multiInputPanelNoFig(varargin)
%%argument 1 is the range of timepoints to take from all the timelapses
%%(timelapses may be different lengths). This function doesn't print any
%%plots, just collects the cy5 and of all the expts.
%figure;
range=varargin{1}; 
c=1;
out=struct;
for i= 2:nargin
    
    %subplot(3,nargin-1,c)
    try
    out.cy5{i-1}=normalizeTS(nonzeroColMean(varargin{i}.cellInf(3).imBackground(:,range)));
    %plot((1:size(varargin{i}.cellInf(3).imBackground(:,range), 2))*5/60, normalizeTS(nonzeroColMean(varargin{i}.cellInf(3).imBackground(:,range))), 'Color', [0 0 0]);
    xlabel('Time (Hrs)');
    ylabel('scaled cy5');
    %subplot(3,nargin-1,c+nargin-1);
    %centered mean
    %plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range))-mean(nonzeroColMean(varargin{i}.cellInf(2).mean(:,range))))
    %normal mean
   % plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)))
   %SEM
   out.mean{i-1}=nonzeroColMean(varargin{i}.cellInf(2).mean(:,range));
   xrange=(1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60;
   %errorbar(xrange, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)), nonZeroColStd(varargin{i}.cellInf(2).mean(:,range))/sqrt(size(varargin{i}.cellInf(2).mean(:, range), 1)));
   
   %xlim([0, xrange(end)]);
   %xlabel('Time (Hrs)');
   %ylabel('Mean cell FL (±SEM)');
   %STD
   %errorbar((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)), nonZeroColStd(varargin{i}.cellInf(2).mean(:,range)))

    %subplot(3,nargin-1,c+((nargin-1)*2));
    %plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, zero2NaN(varargin{i}.cellInf(2).mean(:,range)'));
    %xlabel('Time (Hrs)');
    %ylabel('raw cell FL');
    
    catch ME
          out.cy5{i-1}=normalizeTS(nonzeroColMean(varargin{i}.cellInf(3).imBackground));
    %plot((1:size(varargin{i}.cellInf(3).imBackground, 2))*5/60, normalizeTS(nonzeroColMean(varargin{i}.cellInf(3).imBackground)), 'Color', [0 0 0]);
    %xlabel('Time (Hrs)');
    %ylabel('scaled cy5');
    %subplot(3,nargin-1,c+nargin-1);
    %centered mean
    %plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range))-mean(nonzeroColMean(varargin{i}.cellInf(2).mean(:,range))))
    %normal mean
   % plot((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)))
   %SEM
   out.mean{i-1}=nonzeroColMean(varargin{i}.cellInf(2).mean);
   xrange=(1:size(varargin{i}.cellInf(2).mean, 2))*5/60;
   %errorbar(xrange, nonzeroColMean(varargin{i}.cellInf(2).mean), nonZeroColStd(varargin{i}.cellInf(2).mean)/sqrt(size(varargin{i}.cellInf(2).mean, 1)));
   
   %xlim([0, xrange(end)]);
   %xlabel('Time (Hrs)');
   %ylabel('Mean cell FL (±SEM)');
   %STD
   %errorbar((1:size(varargin{i}.cellInf(2).mean(:,range), 2))*5/60, nonzeroColMean(varargin{i}.cellInf(2).mean(:,range)), nonZeroColStd(varargin{i}.cellInf(2).mean(:,range)))

    %subplot(3,nargin-1,c+((nargin-1)*2));
    %plot((1:size(varargin{i}.cellInf(2).mean, 2))*5/60, zero2NaN(varargin{i}.cellInf(2).mean'));
    %xlabel('Time (Hrs)');
    %ylabel('raw cell FL');  
    end
    c=c+1;
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