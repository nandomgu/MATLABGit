function result=nonZeroColSEM(matrix)

matrix=full(matrix);

for i= 1:size(matrix,2)
    
    result(i)= std(matrix(find(matrix(:,i)~=0), i))/sqrt(numel(matrix(find(matrix(:,i)~=0),i)));
    
end

end