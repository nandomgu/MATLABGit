function nseries=normalizeTS(ts)
%%this function puts the given time series in a range between 0 and 1.
nseries=[];
for j =1: size(ts, 1) 


temp=(ts(j,:)-min(min(ts(j,:))))/max(max(ts(j,:)-min(min(ts(j,:)))));
nseries(j, :)=temp;
end
end
