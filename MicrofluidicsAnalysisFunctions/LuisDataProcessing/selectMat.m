function final=selectMat(matr, gv, selector)
if ~iscell(gv)
ind=gv==selector;
else
    ind=strcmp(gv, selector);
end

final=matr(ind, :);

end