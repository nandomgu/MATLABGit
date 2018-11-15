function addHLine(y, linespec)
if nargin<2 ||isempty(linespec)
    linespec='b-';
end
%% just adds a horizontal line to the current plot. x denotes the x coordinate.
hold(gca, 'on'); plot(get(gca, 'xlim'), [y,y], linespec)

end

