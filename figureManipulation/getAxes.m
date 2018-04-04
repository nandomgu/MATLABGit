function xs=getAllAxes(fig)
%%useful when the figure has many elements, like buttons and legends, etc
if isempty(fig)
    fig=gcf;
end

xs= get(fig, 'children'); %%getting all the axes in the figure
whichAreAxes=find(cellfun(@strcmp, get(xs, 'type'), repmat({'axes'}, numel(xs), 1)));
xs=xs(whichAreAxes);

end
