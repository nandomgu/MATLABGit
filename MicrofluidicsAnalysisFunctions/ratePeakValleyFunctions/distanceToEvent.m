function [val err arr]= distanceToEvent(range, cExperiment, eventTime, cellchan)

if nargin <4
    cellchan=2
end



[v, e, x,ind, indices, den, fig]= ratePeakTimes(range, cExperiment, 2, 2)

arr= x-eventTime;
err=std(arr);
val= mean(arr); 

end





