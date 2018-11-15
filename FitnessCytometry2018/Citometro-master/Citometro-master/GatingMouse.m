function [NewData GatingIndex, GateArray] = GatingMouse(Data, x, y, namex, namey, xscale, yscale, ver, GateArray)
% Te deja hacer un gate con el mouse y te regresa los indices, el gate que hiciste y los
% datos que quedaron dentro del gate 
% Data es la matriz de NxM con N eventos y M parametros medidos
% x y - son las dos columnas en las que estan los parametros de los que
% quieres hacer el gate
% x/yname y x/yscale son para que aparezcan en el plot
% GateArray-por si ya hay otro gate dibujado que quieras aplicar a estos datos
% ver-si quieres ver c�mo qued� el gate en tus datos sin que avance el for
error(nargchk(0,10,nargin))

clf
plot((Data(:,x)), (Data(:,y)),'o','MarkerSize',.1 )
hold on
set(gca, 'yscale',yscale,'xscale',xscale)
xlabel(namex)
ylabel(namey)

    if nargin < 9
        %from BW del SpringerLab
        ginputArray = ginput();
        GateArray = [ginputArray; ginputArray(1,:)];
    end
    if nargin<8
        ver=0;
    end
    GI = find(inpolygon((Data(:,x)), (Data(:,y)), GateArray(:,1), GateArray(:,2)));

plot((Data(GI,x)), (Data(GI,y)),'og','MarkerSize',1 )
plot(GateArray(:,1), GateArray(:,2), 'r-', 'linewidth', 1)

NewData=Data(GI,:);
GatingIndex=GI;
if ver
	pause
end
end