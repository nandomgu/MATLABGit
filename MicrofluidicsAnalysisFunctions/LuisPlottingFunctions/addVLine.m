function addVLine(x)
%% just adds a vertical line to the current plot. x denotes the x coordinate.
hold(gca, 'on'); plot([x,x], get(gca, 'ylim'))

end

