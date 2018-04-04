function [val,err,arr]=responseStrength(range, cExperiment, eventTime,k)

    try matr= smoothDeriveAllCells(cExperiment.cellInf(2).mean(xNaNIndices(cExperiment), range));
    catch ME
       matr= smoothDeriveAllCells(cExperiment.cellInf(2).mean(:, range));
    end
    
    if nargin < 4
        
        k=4;
        
    end
    
    


%matr=matr- repmat(nanmean(matr(:, eventTime-5:eventTime),2), 1,size(matr,2));
matr= matr(:, eventTime+1:end);
arr=zeros(size(matr,1),1);

for t=1: size(matr,2)
 arr= arr+(matr(:,t)/(k*t));
    
    
    
    
end


val= mean(arr);
err= std(arr);

end
