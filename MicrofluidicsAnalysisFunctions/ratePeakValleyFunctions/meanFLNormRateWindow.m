function [val, err, valpercell]= meanFLNormRateWindow(range, cExperiment, extractionRange, cellchan)
%% this function computes an operatin for cExperiment in the whole range, but then computes only using extractionrange. this allows to keep consistency 
%%of values when working on range sensitive operations such as maxima, times, or time dependent operators.

if nargin < 3
extractionRange=range;

end
if(nargin<4)

cellchan=2;

end

matr=normalizeStrict(smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean));
%figure; plot(matr');

submatr=matr(:, extractionRange); 
valpercell= nanmean(submatr,2)';
valpercell=valpercell(~isnan(valpercell))
val= nanmean(nanmean(submatr));
err= nanstd(reshape(submatr, 1, numel(submatr)) );

%figure; plot(matr');

% if type =='rate'
%     matr= diff(matr);
% end

% [srt, sortIndices]=sort(matr,2, 'descend');
% arr=sortIndices(:, 1:n)
% x=reshape(arr, size(arr,1)*size(arr,2),1)'
% x=x*5/60;

%den=ksdensity(x, range*5/60)
%val=mean(x);
%err=std(x); 
%figure; plot(range*5/60, den);




end

