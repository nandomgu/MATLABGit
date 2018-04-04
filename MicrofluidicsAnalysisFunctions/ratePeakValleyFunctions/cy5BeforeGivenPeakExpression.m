function [val, err]=cy5BeforeGivenPeakExpression(range, varargin)
%%varargin is a list of cExperiment
cellchan=2;
bgchan=3;
length=1;

pltchar= ['o', 'x', 's', '^', '+', 'd', 'v', 'p']

%% given the rate peak time of cell, this function retrieves cy5 level and derivative at the length number of timepoints before the rate peak time (for now stick to 1).

str= 'cExperiment= mergeCexperiments(range, varargin{1}';
for ii=1:numel(varargin)
    
    disp([ 'ii is ' num2str(ii)])
    if(ii> 1)
    str= [str, ', varargin{' num2str(ii), '}'] 
    end
    
end
    eval( [str, ')']);
    
    


if nargin==2
    n=10;
end

figure;

   
    
matr=cExperiment.cellInf(cellchan).mean(:, range(1:end-1));
matrcy5=smoothDeriveAllCells(cExperiment.cellInf(bgchan).imBackground(:, range));



% if type =='rate'
%     matr= diff(matr);
% end
%figure; plot(normalizeMatrixStrict(matr)');
[srt, sortIndices]=sort(normalizeStrict(matr),2, 'descend'); %normalize matrix strict normalizzes the whole matrix by its own mean and standard deviation
maxrates=srt(:,1);
arr=sortIndices(:, 1);

cy5before=repmat(normalizeTS(nonzeroColMean(cExperiment.cellInf(bgchan).imBackground)), size(cExperiment.cellInf(bgchan).imBackground,1),1 );


inds=repmat(arr, 1,length)+ repmat(-(length-1):0, size(cy5before,1),1);
vals=cy5before(find(repmat(1:size(cy5before,2), size(cy5before,1),1)==repmat(inds, 1, size(cy5before,2))));
ders=matrcy5(find(repmat(1:size(matrcy5,2), size(matrcy5,1),1)==repmat(inds, 1, size(matrcy5,2))));
val= mean(vals);
err=std(vals);


  %plot(vals, ders, 'Marker', pltchar(j),'Color', intensity2Color(maxrates, [0 0 1; 0 0 0; 1 .7 0;], 20, [-4,4]))
  
  for aa= 1:numel(varargin)
      
  scatter(vals(cExperiment.expNum==aa) , ders(cExperiment.expNum==aa) ,[],intensity2Color(maxrates(cExperiment.expNum==aa), [0 0 1; 0 0 0; 1 0 0;], 20, [-12,12]), pltchar(aa));
  hold on; 
  
  end
  %subplot(2,1,2)
%   figure;
%   plot(ksdensity(maxrates));



  
title('influence of cy5(glucose) level and derivative over production bursts');
xlabel('scaled cy5 level at rate peak time');
ylabel('scaled cy5 rate of change at rate peak time');
   
   
   
   
   
end
