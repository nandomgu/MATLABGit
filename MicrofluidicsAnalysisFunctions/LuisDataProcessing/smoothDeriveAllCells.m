function m=smoothDeriveAllCells(matrix)
matrix=full(zero2NaN(matrix))
for k=1:size(matrix, 1)
    
    m(k,:)= diff(smooth(matrix(k,:),10));
    
end

end