function out=removeLegends(fig)
%%for now hides all legends in a figure.
if nargin<1 ||isempty(fig)
    fig=gcf;
end

xs= get(fig, 'children');

whichAreAxes=find(cellfun(@strcmp, get(xs, 'type'), repmat({'axes'}, numel(xs), 1)));
    
    xs2= xs(whichAreAxes)
 
    
    for j=1:numel(whichAreAxes)
        legend(xs(whichAreAxes(j)), 'off')
    end
end
    