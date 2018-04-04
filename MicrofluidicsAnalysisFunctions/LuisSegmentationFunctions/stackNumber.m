function final=maxConsecutive(channelvector)
%%provides the max number of consecutive positive elements in a vector.
%%context used toretrieve the number of stacks from a vector that has 1 if the position contains the channel name and 0 if it doesn't. 
m=0;
c=1;
for j=1: numel(channelvector)          
if channelvector(j)>1
    m=m+1;
else
    maxTogether(c)=m;
    m=0;
    c=c+1;
end
end
final=max(maxTogether);

    