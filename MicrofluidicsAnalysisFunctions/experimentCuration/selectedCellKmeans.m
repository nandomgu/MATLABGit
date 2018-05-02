function [centroids, kmeansvector, handles]=selectedCellKmeans(cExperiment, plothandle, cellchan, bgchan, range )
%%computes K means clustering on cell traces selected from a plot


distance='correlation';
%distance='correlation';
disp(['distance used is', distance, '\n']);
centroids=[];
selectedCells= find(onOff2bin(get(get(get(plothandle, 'children'), 'children'), 'selected')));

if(bgchan==0)
    
    bgchan=cellchan;
    
end

    
x=get(get(get(plothandle, 'children'), 'children'), 'Ydata');


for i= 1: length(selectedCells)
    
    centroids(i,:)= x{selectedCells(i)};
    


end

if (nargin>=5)
centroids=centroids(:, range);

else
    range= 1:size(cExperiment.cellInf(cellchan).mean,2)
end

kmeansvector= kmeans(full(cExperiment.cellInf(cellchan).mean(:,range)),[], 'start', centroids, 'Distance', distance);

handles=plotByGroup(cExperiment, kmeansvector, cellchan, bgchan);



end