function [val, err, valpercell]= meanFLRateWindow(range, cExperiment, extractionRange, cellchan)
%% this function computes an operatin for cExperiment in the whole range, but then computes only using extractionrange. this allows to keep consistency 
%%of values when working on range sensitive operations such as maxima, times, or time dependent operators.

if nargin < 3 || isempty(extractionRange)
extractionRange=range;

end

disp(['matr has ' num2str(size(cExperiment.cellInf(cellchan).mean,2)) 'timepoints. range: ' num2str(extractionRange(1)),  ' ', num2str(extractionRange(end))])

if(nargin<4)

cellchan=2;

end
                                                              %xNaNIndices(cExperiment) to treat cells with less than 5 nans                          
matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean(:, range));
%figure; plot(matr');

 


valpercell= mean(matr,2)
val= mean(mean(matr));
err= std(stretchMatrix(matr) );

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

