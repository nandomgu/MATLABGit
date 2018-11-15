function result=nonZeroColStd(matrix)

matrix(matrix==0)=NaN; %deal with nans rather than zeros)


result=nanstd(matrix); %take advantage of the nanstd function


end