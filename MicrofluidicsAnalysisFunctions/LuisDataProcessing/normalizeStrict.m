function out = normalizeStrict(TS)
%this function takes a time series, subtracts the mean and divides by the
%standard deviation.
out=[];
TS=zero2NaN(TS);
if (size(TS,1)>1)
    
    for j= 1: size(TS, 1)
        out(j,:)= (TS(j,:)-nanmean(TS(j,:)))/nanstd(TS(j,:));
    end
else
    
out=(TS-nanmean(TS))/nanstd(TS);
end


end

