function h = ShowGatedData(Data, Gate, x, y, xscale, yscale, fignum)
% ShowGatedData(Data, Gate, x, y, xscale, yscale, fignum)
% Data is a nxm  matrix of n events with m parameters
% Gate is an array with the coordenates for a polygon that sorounds the gated region
% x is the number of the column of parameter you want in x-axis (same for y)
% xscale is if you want this parameter in scale 'log', 'linear' etc (same for y)
% fignum is if you prefer to stablish what figure will contain your plot



if nargin<7
    %figure()
else
    figure(fignum)
end

h(1)=plot( Data(:,x), Data(:,y), 'ok', 'markersize',1 )
hold on
h(2)=plot( Gate(:,1),Gate(:,2), '-r' )
set(gca, 'xscale',xscale, 'yscale', yscale)


end
