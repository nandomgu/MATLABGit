function setTicks(ax, dim, setval)
if nargin<2 || isempty(dim)
    dim==1;
end

if nargin<2 || isempty(setval)
    setval='on';
end


if dim==1
nr= get(ax, 'XAxis');set(nr, 'Visible', setval)
else
    if dim==2
    nr= get(ax, 'YAxis');set(nr, 'Visible', setval)
    end
end