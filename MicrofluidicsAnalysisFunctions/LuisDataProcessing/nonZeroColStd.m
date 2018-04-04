function result=nonZeroColStd(matrix)


for i= 1:size(matrix,2)
    
    result(i)= std(matrix(find(matrix(:,i)~=0), i));
    
end

end