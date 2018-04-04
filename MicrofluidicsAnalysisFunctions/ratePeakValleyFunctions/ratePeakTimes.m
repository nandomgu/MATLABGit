function [val, err, x,ind, indices, den, fig]= ratePeakTimes(range, cExperiment, cellchan, n, supress)
%%val= the mean value of the peak time, in hours
%%err= the stanard deviation of the peak time, in hours. 
%% x= peak times per cell, in hours. 
%% ind= column index of the mean peak time in the matrix
%% indices= the column indices at which each cell peaked.
%% the function takes finds the times at which the max n values of the mean cell value occur, and returns them, as well as their density

if(nargin<3)
cellchan=2;


end
if nargin <4 
    n=2;
end
if nargin<5
    supress=1;
end



try matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean(xNaNIndices(cExperiment), range));
catch ME
    matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean(:, range));
end
%figure; plot(matr');

% if type =='rate'
%     matr= diff(matr);
% end

[srt, sortIndices]=sort(matr,2, 'descend');
arr=sortIndices(:, 1:n);
x=reshape(arr, size(arr,1)*size(arr,2),1)';
ind=round(mean(x));
indices=x;
x=x*5/60;

den=ksdensity(x, range*5/60);
val=mean(x);
err=std(x);

if supress~=1
 fig=plot(range*5/60, den);
 else
    fig=[];
end

end

