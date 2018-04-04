function b=prepareBound(matr, func, symmetrical)

%%this function prepares the bounds bject for bounded line, which would
%%otherwise be tedious to compute.
if nargin< 2
    
    func= @nonZeroColStd
end 
    
if nargin<3
    symmetrical=1;
end



b= repmat(func(full(matr)),1,1,1);



