function addVLine(x, linespec)
if nargin<2 ||isempty(linespec)
    linespec='b-';
end
%% just adds a vertical line to the current plot. x denotes the x coordinate.
hold(gca, 'on'); plot([x,x], get(gca, 'ylim'), linespec)

end

