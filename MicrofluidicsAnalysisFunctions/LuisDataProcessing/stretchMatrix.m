function stretch=stretchMatrix(matr)


stretch= reshape(matr, size(matr, 1)*size(matr,2), 1);

end