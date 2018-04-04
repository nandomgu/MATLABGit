function matrix= zero2NaN(matrix)

matrix(find(matrix==0))=NaN;

end