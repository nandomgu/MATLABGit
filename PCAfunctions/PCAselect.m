function ind=PCAselect(matr, pcaAxisHandle, finalfig)
if(nargin<3)
    
    finalfig=figure;
end


x=get(pcaAxisHandle, 'children');

g=x(find(strcmp(get(x, 'tag'), 'obsmarker')));

ind=size(matr,1)- find(strcmp(get(g, 'selected'), 'on'))+1;

colors= rand(1,3);
set(g(find(strcmp(get(g, 'selected'), 'on'))), 'Color', colors);
set(g(find(strcmp(get(g, 'selected'), 'on'))), 'MarkerSize', 20);
figure(finalfig);hold on; plot( matr(ind, :)', 'Color', colors);

end