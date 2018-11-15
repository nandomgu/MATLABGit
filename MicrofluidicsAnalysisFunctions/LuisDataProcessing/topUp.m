function vec= topUp(vec, limit, fillval)
%%top up a vector till index LIMIT with value fillval
if nargin <3 || isempty(fillval) 
fillval=NaN;
end

if numel(vec)< limit
    vec(end+1:limit)= fillval;
end

if numel(vec)>limit
    vec=vec(1:limit);
end

end