function [val, err, arr]= maxExpressionRate(range, cExperiment)
%Provides the max expression rate for each cell present at window range


cellchan=2;
if isempty(range)
    
    range= 1:(size(cExperiment.cellInf(1).mean, 2)-1);
    
end
try matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean(xNaNIndices(cExperiment), :));
catch ME
    matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean);
end



arr= max(matr(:, range),[],2); 

val= mean(arr);

err= std(arr);




end


