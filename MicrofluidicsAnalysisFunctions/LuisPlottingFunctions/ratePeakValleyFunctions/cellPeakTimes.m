function [arr, den]= cellPeakTimes(cExperiment, cellchan, n)
%% the function takes finds the times at which the max n values of the mean cell value occur, and returns them, as well as their density
if nargin==2
    n=10
end
if nargin <= 3
    type= 'value'
end

matr=full(cExperiment.cellInf(cellchan).mean);
% if type =='rate'
%     matr= diff(matr);
% end

[srt, sortIndices]=sort(matr,2, 'descend');
arr=sortIndices(:, 1:n)
x=reshape(arr, size(arr,1)*size(arr,2),1)'

den=ksdensity(x)

figure; plot(den)

end

