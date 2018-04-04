function shiftBoxPlot(range,cExperiment, funcwindow, func )


if nargin<4
[upval, uperr, uparr]=upShiftFunction(range,cExperiment, funcwindow  );
[downval, downerr, downarr]=downShiftFunction(range,cExperiment, funcwindow );

else
 [upval, uperr, uparr]=upShiftFunction(range,cExperiment, funcwindow, func  );
[downval, downerr, downarr]=downShiftFunction(range,cExperiment, funcwindow, func );   
end

figure; 
g= [ones( numel(uparr), 1)' [ones( numel(downarr), 1)*2]' ];
boxplot([uparr downarr],g);

end