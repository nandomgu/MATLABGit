function addVLine(x, col, style)
%% just adds a vertical line to the current plot. x denotes the x coordinate.

if nargin<3||isempty(style)
    style='-';
end


if nargin<2 || isempty(col)
for j=1:numel(x)
hold(gca, 'on'); plot([x(j),x(j)], get(gca, 'ylim'), style)
end

else
    for j=1:numel(x)
hold(gca, 'on'); plot([x(j),x(j)], get(gca, 'ylim'), style, 'Color', col)
end
    
end
end

