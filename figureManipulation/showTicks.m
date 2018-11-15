function showTicks(ax, dim)
if nargin<2 || isempty(dim)
    dim=1;
end

if dim==1
nr= get(ax, 'XAxis');set(nr, 'Visible', 'on')
else
    if dim==2
    nr= get(ax, 'YAxis');set(nr, 'Visible', 'on')
    end
end