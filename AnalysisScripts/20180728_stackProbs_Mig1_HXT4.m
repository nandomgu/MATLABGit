%% getting the glucose appearance times for each replicate
%this script depends on experimentQueryPlottingMutants.
[a,b]=max(smoothDeriveAllCells(cy5),[],2)
centeredtimes=repmat(times, 18,1) -repmat(times(b)', 1, size(times,2));

figure;
n=false
r1=stackProbs(celldata.hxt4.gp2percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.hxt4.gp2percent.rep2.num
t0=times(find(diff(cy5(num,:))==max(diff(cy5(num,:)))))
area(times-t0, r1', 'FaceAlpha', 0.7)
addVLine(0)
yyaxis right
plot((times-t0)', selectMat(nl2, [currentfolders{:, 2}], 0.2)', 'r-')

axes;
r1=stackProbs(celldata.hxt4.g1percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.hxt4.g1percent.rep2.num
t0=times(find(diff(cy5(num,:))==max(diff(cy5(num,:)))))
area(times-t0, r1', 'FaceAlpha', 0.7)
addVLine(0);
yyaxis right
plot((times-t0)', selectMat(nl2, [currentfolders{:, 2}], 1)', 'r-')

axes;
r1=stackProbs(celldata.mig1ko.gp2percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.mig1ko.gp2percent.rep2.num
t0=times(find(diff(cy5(num,:))==max(diff(cy5(num,:)))))
area(times-t0, r1', 'FaceAlpha', 0.7)
addVLine(0)

axes;
r1=stackProbs(celldata.mig1ko.g1percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.mig1ko.g1percent.rep2.num
t0=times(find(diff(cy5(num,:))==max(diff(cy5(num,:)))))
area(times-t0, r1', 'FaceAlpha', 0.7)
addVLine(0)
stackPlots(gcf)
uniformAxes(gcf,[], [-2,15], [],[.95], [] )