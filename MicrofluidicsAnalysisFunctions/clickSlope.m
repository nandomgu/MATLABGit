function [slope, intercept, rsquare]=clickSlope(num, linespecnum)
%% click on a graph, and retrieve and plot a slope based on the points clicked.
leg=0;
polytype='poly1';
if nargin<1||isempty(num)
   num=3;
    
end
pts=ginput(num)


[fitobject, gof]=fit(pts(:,1), pts(:,2), polytype);

slope=fitobject.p1;
intercept=fitobject.p2;
rsquare= gof.rsquare;
yl= get(gca, 'ylim');
xl=get(gca, 'xlim');

if leg==1
str= legend(gca);
str= str.String;
end


%%default linespec settings per number
linespecs{1}='-r'
linespecs{2}='-m'
linespecs{3}='-b'
linespecs{4}='-y'
linespecs{5}='-c'
linespecs{6}='-k'

if nargin<2 || isempty(linespecnum)
   linespec=linespecs{1};
else
    linespec=linespecs{linespecnum};
end

hold on; plot(fitobject, linespec)
xlim(xl);
ylim(yl);

if leg==1

legend({str{:}, ['y= ' num2str(slope), 'x ', sign2Symbol(sign(intercept)), num2str(abs(intercept))]}) 
end


end





