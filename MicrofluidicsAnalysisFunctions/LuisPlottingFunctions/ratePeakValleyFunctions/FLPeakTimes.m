function [val, err, x,ind]= FLPeakTimes(range, cExperiment, cellchan, n, supress)
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





matr=cExperiment.cellInf(cellchan).mean(:, range);
%figure; plot(matr');

% if type =='rate'
%     matr= diff(matr);
% end

[srt, sortIndices]=sort(matr,2, 'descend');
arr=sortIndices(:, 1:n);
x=reshape(arr, size(arr,1)*size(arr,2),1)';
ind=round(mean(x));

x=x*5/60;

den=ksdensity(x, range*5/60);
val=mean(x);
err=std(x);

if supress~=1
figure; plot(range*5/60, den);

end

end

