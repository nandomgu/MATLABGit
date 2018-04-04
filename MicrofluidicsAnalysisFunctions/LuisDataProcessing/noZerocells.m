function indices=noZeroCells(inmatrix)
indices=find(sum(inmatrix==0')==0);
end

