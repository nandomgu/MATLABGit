function fractionAboveThreshold=probRateAbovePercentile(range,cExperiment, percentile)

cellchan=2;

if nargin<3
    
    percentile=90; 
    
end

%%the standard expression rate matrix, using cellswith nans in less than a
%%fraction of NANs.
try matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean(xNaNIndices(cExperiment), range));
catch ME
    matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean(:, range));
end



%we arbitrarily define a threshold as  the percentile 90 of all the rates
%in the experiment
threshold= prctile(stretchMatrix(matr), percentile);



numRealEntries=repmat(size(matr,1), 1, size(matr,2)) - sum(~matr);
fractionAboveThreshold=sum(matr>threshold)./numRealEntries;








