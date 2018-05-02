function deselectAxes(fighandle, axnum)

if isempty(fighandle)
    fighandle=gcf;
end


allaxes= get(fighandle, 'children')

if nargin<2 || isempty(axnum)
   axnum= 1:numel(allaxes) ;
end


for j= axnum
    set(allaxes(j), 'Selected', 'off')
end




