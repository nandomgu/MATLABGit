function [NewData xmin xmax ymin ymax GatingIndex] = GATING(Data, x, y,xlab,ylab,xmin,xmax,ymin,ymax)
% [NewData xmin y]min GatingIndex] = GATING(Data,x,y,xlab,ylab)
% input
% 1)Datos 
% 2) ColumnaDatosX
% 3) ColumnaDatosY
% que se vean hist para X, para Y y un Scatter, 
% te pregunte donde quieres el corte
% para x
% para y
% que te ponga una raya y te pregunte si quedaste contento o quieres volver a poner un corte
% hasta que quedes contento
% 
% Output
% 1)Datos Cortados
% 2)Indices que tienen esos datos en la estructura original

figure(23)
clf
subplot(2,2,1)
temp=find(~isnan(Data(:,x)));
hist((Data(temp,x)),10)
title(xlab)
subplot(2,2,3)
temp=find(~isnan(Data(:,y)));
hist((Data(temp,y)),10)
title(ylab)
subplot(1,2,2)
plot((Data(:,x)), (Data(:,y)),'.')
xlabel(xlab); ylabel(ylab)

i=0;
if nargin<6
while i==0
    subplot(1,2,2)
    hold off
    plot((Data(:,x)), (Data(:,y)),'.')
    xlabel(xlab); ylabel(ylab)
    hold on
    xmin=input('¡Buen Día! Cuál gate para min(x)?');
	plot([xmin xmin], [min(Data(:,y)) max(Data(:,y))],'r')
    ymin=input('Cuál gate para min(y)?');
	plot([min(Data(:,x)) max(Data(:,x))], [ymin ymin],'r')
    xmax=input('Cuál gate para max(x)?');
    plot([xmax xmax], [min(Data(:,y)) max(Data(:,y))],'r')
    ymax=input('Cuál gate para max(y)?');
    plot([min(Data(:,y)) max(Data(:,y))],[ymax ymax],'r')
    xlabel('x'); ylabel('y')
    %xlim([-1 6]);ylim([-1 6])
    i=input('Te gustaron los gates? (0=no o 1=si)');
end
end

GatingIndex=find(Data(:,x)<xmax & Data(:,x)>xmin & Data(:,y)>ymin & Data(:,y)<ymax );
NewData=Data(GatingIndex,:);
if nargin<6
plot((Data(:,x)), (Data(:,y)),'.','MarkerSize', 0.1)
hold on
plot((Data(GatingIndex,x)), (Data(GatingIndex,y)),'.g','MarkerSize', 0.1)
end


end