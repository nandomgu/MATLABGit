function result=nonZeroColSEM(matrix)

matrix(matrix==0)=NaN; %we replace the zeros by nans.


%we get the no nan standard deviation, and divide it
%by the square root of the total of non nan elements per column.

result=nanstd(matrix)./ sqrt(sum(~isnan(matrix)));


end