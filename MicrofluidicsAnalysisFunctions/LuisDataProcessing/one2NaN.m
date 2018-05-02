function matrix= one2NaN(matrix)

matrix(find(matrix==1))=NaN;

end