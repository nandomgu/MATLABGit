function addHLine(y)
%% just adds a horizontal line to the current plot. x denotes the x coordinate.
hold(gca, 'on'); plot(get(gca, 'xlim'), [y,y])

end

