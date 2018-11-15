function [NewData GatingIndex] = FnctnGATING(Data,x,y,xlab,ylab,mx,bx,difx,my,by,dify);
%Hace gate min y max usando una linea mx+b
figure(50)
clf

xline = [min(Data(:,x)) max(Data(:,x)) ];
yline = mx*xline+bx;
hold on
plot((Data(:,x)), (Data(:,y)),'.','MarkerSize',.01)
hold on
plot (xline,yline,'.--k')
plot (xline,yline+difx,'o--k')
xlabel(xlab); ylabel(ylab)

GatingIndex = find( (mx*Data(:,x)+bx)<Data(:,y) & (mx*Data(:,x)+bx+difx)>Data(:,y) );

xline = [min(Data(:,x)) max(Data(:,x)) ];
yline = my*xline+by;
plot (xline,yline,'.--k')
plot (xline,yline+dify,'o--k')
xlabel(xlab); ylabel(ylab)

xlim(xline+10000)
ylim([min(Data(:,y)) max(Data(:,y)) ]+10000)

GatingIndex2 = find( (my*Data(:,x)+by)<Data(:,y) & (my*Data(:,x)+by+dify)>Data(:,y) );
GI=intersect(GatingIndex2,GatingIndex)
plot((Data(GI,x)), (Data(GI,y)),'og','MarkerSize',.1)

GatingIndex=GI;
NewData=Data(GI,:);

end