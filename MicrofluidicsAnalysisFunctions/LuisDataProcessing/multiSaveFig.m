function rootdir= multiSaveFig(figurehandles)

rootdir=uigetdir( pwd, 'Please select the folder where you want to save the figures');

for j=1:numel(figurehandles)
saveas(figurehandles(j),[rootdir '/'  figurehandles(j) get(figurehandles(j), 'Name') date], 'eps2c')
saveas(figurehandles(j),[rootdir '/'  figurehandles(j) get(figurehandles(j), 'Name') date], 'fig')
saveas(figurehandles(j),[rootdir '/'  figurehandles(j) get(figurehandles(j), 'Name') date], 'jpg')
saveas(figurehandles(j),[rootdir '/'  figurehandles(j) get(figurehandles(j), 'Name') date], 'pdf')


end
end