function result=nonZeroColMedian(matrix)

matrix=arrayfun(@na2zero, full(matrix));
for i= 1:size(matrix,2)
    
    result(i)= median(matrix(find(matrix(:,i)~=0), i));
    
end

end