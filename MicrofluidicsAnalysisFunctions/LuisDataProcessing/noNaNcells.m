function inmatrix2=noNaNcells(inmatrix)
inmatrix2=inmatrix(find(sum(isnan(inmatrix)')==0),:);
end

