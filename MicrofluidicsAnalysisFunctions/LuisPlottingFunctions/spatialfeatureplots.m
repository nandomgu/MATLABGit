function [x y]=spatialfeatureplots(massdev, inertia, cellnum)

figure
nnc=noNaNcells(massdev);
x=smooth(massdev(nnc(cellnum),:)')
plot(x, 'Color', [1 0 0]);
hold on
y=smooth(inertia(nnc(cellnum),:)/max(inertia(nnc(cellnum),:)));
plot(y, 'Color', [0 0 1]);figure(gcf);

end
