
%% 

timess={};
ctimess={};
j=1
dat=struct;

%46 1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190611_results/cExperiment_001.mat')

media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [1:30], 2, 3, {'hxt4', 'hxt6', 'mig1g', 'wt'}, true)
timess{j}=times
f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))))
[mx, argmx]= max(f)
ctimes=times- times(argmx);

j=j+1;
dat.gluc1.hxt4.rep1.data=stdmch.hxt4
dat.gluc1.hxt4.rep1.times=ctimes
dat.gluc1.hxt4.rep1.bnds=bnds.hxt4
dat.gluc1.hxt6.rep1.data=stdmch.hxt6
dat.gluc1.hxt6.rep1.times=ctimes
dat.gluc1.hxt6.rep1.bnds=bnds.hxt6
%467 1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190705_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);
[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [1:30], 2, 3, {'hxt4', 'hxt6', 'hxt7', 'mig1g', 'wt'}, true)
timess{j}=times
f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))))
[mx, argmx]= max(f)
ctimes=times- times(argmx);

j=j+1;
dat.gluc1.hxt4.rep2.data=stdmch.hxt4
dat.gluc1.hxt4.rep2.times=ctimes
dat.gluc1.hxt4.rep2.bnds=bnds.hxt4
dat.gluc1.hxt6.rep2.data=stdmch.hxt6
dat.gluc1.hxt6.rep2.times=ctimes
dat.gluc1.hxt6.rep2.bnds=bnds.hxt6
dat.gluc1.hxt7.rep1.data=stdmch.hxt7
dat.gluc1.hxt7.rep1.times=ctimes
dat.gluc1.hxt7.rep1.bnds=bnds.hxt7
%467 0.1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190612_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [5:30], 2, 3, {'hxt4', 'hxt6', 'hxt7', 'mig1g', 'wt'}, true)
timess{j}=times
f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))))
[mx, argmx]= max(f)
ctimes=times- times(argmx);

j=j+1;
dat.glucp1.hxt4.rep1.data=stdmch.hxt4
dat.glucp1.hxt4.rep1.times=ctimes
dat.glucp1.hxt4.rep1.bnds=bnds.hxt4
dat.glucp1.hxt6.rep1.data=stdmch.hxt6
dat.glucp1.hxt6.rep1.times=ctimes
dat.glucp1.hxt6.rep1.bnds=bnds.hxt6
dat.glucp1.hxt7.rep1.data=stdmch.hxt7
dat.glucp1.hxt7.rep1.times=ctimes
dat.glucp1.hxt7.rep1.bnds=bnds.hxt7
%467 0.05% 
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190622_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [4:30], 2, 3, {'hxt4', 'hxt6', 'hxt7', 'mig1g', 'wt'}, true)
timess{j}=times

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))))
[mx, argmx]= max(f)
ctimes=times- times(argmx);

j=j+1;
dat.glucp05.hxt4.rep1.data=stdmch.hxt4
dat.glucp05.hxt4.rep1.times=ctimes
dat.glucp05.hxt4.rep1.bnds=bnds.hxt4
dat.glucp05.hxt6.rep1.data=stdmch.hxt6
dat.glucp05.hxt6.rep1.times=ctimes
dat.glucp05.hxt6.rep1.bnds=bnds.hxt6
dat.glucp05.hxt7.rep1.data=stdmch.hxt7
dat.glucp05.hxt7.rep1.times=ctimes
dat.glucp05.hxt7.rep1.bnds=bnds.hxt7
%123  1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190531_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);
%500 as a reference
[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'hxt2', [10:30], 2, 3, {'hxt1', 'hxt2', 'hxt3', 'mig1g', 'wt'}, true, 500)
timess{j}=times

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))))
[mx, argmx]= max(f)
ctimes=times- times(argmx);

j=j+1;
dat.gluc1.hxt1.rep1.data=stdmch.hxt1
dat.gluc1.hxt1.rep1.times=ctimes
dat.gluc1.hxt1.rep1.bnds=bnds.hxt1
dat.gluc1.hxt2.rep1.data=stdmch.hxt2
dat.gluc1.hxt2.rep1.times=ctimes
dat.gluc1.hxt2.rep1.bnds=bnds.hxt2
%dat.gluc1.hxt3.rep1.data=stdmch.hxt3  this is very likely hxt1 as the
%traces are the same
%dat.gluc1.hxt3.rep1.times=ctimes
%dat.gluc1.hxt3.rep1.bnds=bnds.hxt3

%123 1%  hxt2 is extremely strangel, presumably because it is old.
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190709_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [5:30], 2, 3, {'hxt1', 'hxt2', 'hxt3', 'mig1g', 'wt'}, true)
timess{j}=times

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))))
[mx, argmx]= max(f)
ctimes=times- times(argmx);

j=j+1;
dat.gluc1.hxt1.rep2.data=stdmch.hxt1
dat.gluc1.hxt1.rep2.times=ctimes
dat.gluc1.hxt1.rep2.bnds=bnds.hxt1
%dat.gluc1.hxt2.rep2.data=stdmch.hxt2
%dat.gluc1.hxt2.rep2.times=ctimes
%dat.gluc1.hxt2.rep2.bnds=bnds.hxt2
%dat.gluc1.hxt3.rep2.data=stdmch.hxt3 again this is probably hxt1 as traces
%are the same
%dat.gluc1.hxt3.rep2.times=ctimes
%dat.gluc1.hxt3.rep2.bnds=bnds.hxt3
%123 1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190628_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);
[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [5:30], 2, 1, {'hxt1', 'hxt2', 'hxt3', 'mig1g', 'wt'}, true)
timess{j}=times
j=j+1;
dat.gluc1.hxt1.rep3.data=stdmch.hxt1
dat.gluc1.hxt1.rep3.times=ctimes
dat.gluc1.hxt1.rep3.bnds=bnds.hxt1
dat.gluc1.hxt2.rep3.data=stdmch.hxt2
dat.gluc1.hxt2.rep3.times=ctimes
dat.gluc1.hxt2.rep3.bnds=bnds.hxt2
% dat.gluc1.hxt3.rep3.data=stdmch.hxt3 again this looks like hxt1
% dat.gluc1.hxt3.rep3.times=ctimes
% dat.gluc1.hxt3.rep3.bnds=bnds.hxt3
%123 0.1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190713_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [1:30], 2, 3, {'hxt1', 'hxt2', 'hxt3', 'mig1g', 'wt'}, true)
timess{j}=times;

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);

j=j+1;
dat.glucp1.hxt1.rep1.data=stdmch.hxt1
dat.glucp1.hxt1.rep1.times=ctimes
dat.glucp1.hxt1.rep1.bnds=bnds.hxt1
dat.glucp1.hxt2.rep1.data=stdmch.hxt2
dat.glucp1.hxt2.rep1.times=ctimes
dat.glucp1.hxt2.rep1.bnds=bnds.hxt2
%looks like hxt1. this is because it
% doesn't look like this when thawing the strain from scratch
% dat.glucp1.hxt3.rep1.data=stdmch.hxt3 

% dat.glucp1.hxt3.rep1.times=ctimes
% dat.glucp1.hxt3.rep1.bnds=bnds.hxt3


%20190811 hxt 127  1%    %hxt1 is inconsistent
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190811_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);
[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [5:30], 2, 3, {'hxt1', 'hxt2', 'hxt7', 'mig1g', 'wt'}, true)

[a,means, times]=processcy5(makeMultiChamber(cExperiment))

timess{j}=times
j=j+1;

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);

dat.gluc1.hxt2.rep4.data=stdmch.hxt2
dat.gluc1.hxt2.rep4.times=ctimes
dat.gluc1.hxt2.rep4.bnds=bnds.hxt2
dat.gluc1.hxt7.rep2.data=stdmch.hxt7
dat.gluc1.hxt7.rep2.times=ctimes
dat.gluc1.hxt7.rep2.bnds=bnds.hxt7

%467 0.1% 20190814 
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190814_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [10:30], 2, 3, {'hxt4', 'hxt6', 'hxt7', 'mig1g', 'wt'}, true)
timess{j}=times
f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);


j=j+1;

dat.glucp1.hxt4.rep2.data=stdmch.hxt4
dat.glucp1.hxt4.rep2.times=ctimes
dat.glucp1.hxt4.rep2.bnds=bnds.hxt4
dat.glucp1.hxt6.rep2.data=stdmch.hxt6
dat.glucp1.hxt6.rep2.times=ctimes
dat.glucp1.hxt6.rep2.bnds=bnds.hxt6
dat.glucp1.hxt7.rep2.data=stdmch.hxt7
dat.glucp1.hxt7.rep2.times=ctimes
dat.glucp1.hxt7.rep2.bnds=bnds.hxt7

%124 0.1% 20190823  originally thought that hxt2 was labeled labeled as 3 
%upon reconsideration it is obvious that hxt3 is derepressed at lower
%glucose and reaches higher levels than hxt1. o labelling restored to
%original as this hxt3 and 4 were obtained from the freezer

load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190823_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [10:30], 2, 3, {'hxt1','hxt3', 'hxt4', 'mig1g', 'wt'}, true)
timess{j}=times
f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);

j=j+1;

dat.glucp1.hxt1.rep2.data=stdmch.hxt1
dat.glucp1.hxt1.rep2.times=ctimes
dat.glucp1.hxt1.rep2.bnds=bnds.hxt1
dat.glucp1.hxt4.rep3.data=stdmch.hxt4
dat.glucp1.hxt4.rep3.times=ctimes
dat.glucp1.hxt4.rep3.bnds=bnds.hxt4
dat.glucp1.hxt3.rep1.data=stdmch.hxt3
dat.glucp1.hxt3.rep1.times=ctimes
dat.glucp1.hxt3.rep1.bnds=bnds.hxt3

%124 0.1% 20190825 
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190825_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [10:30], 2, 3, {'hxt2','hxt3', 'hxt4', 'mig1g', 'wt'}, true)
timess{j}=times

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);

j=j+1;

dat.glucp1.hxt3.rep2.data=stdmch.hxt3
dat.glucp1.hxt3.rep2.times=ctimes
dat.glucp1.hxt3.rep2.bnds=bnds.hxt3
dat.glucp1.hxt4.rep4.data=stdmch.hxt4
dat.glucp1.hxt4.rep4.times=ctimes
dat.glucp1.hxt4.rep4.bnds=bnds.hxt4
dat.glucp1.hxt2.rep2.data=stdmch.hxt2 
dat.glucp1.hxt2.rep2.times=ctimes
dat.glucp1.hxt2.rep2.bnds=bnds.hxt2



%%20190906 pyr glu %
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190828_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [10:30], 2, 1, {'hxt2','hxt3', 'hxt4', 'mig1g', 'wt'}, true)
timess{j}=times

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);

j=j+1;

dat.glucp1.hxt3.rep3.data=stdmch.hxt3
dat.glucp1.hxt3.rep3.times=ctimes
dat.glucp1.hxt3.rep3.bnds=bnds.hxt3
dat.glucp1.hxt4.rep5.data=stdmch.hxt4
dat.glucp1.hxt4.rep5.times=ctimes
dat.glucp1.hxt4.rep5.bnds=bnds.hxt4
dat.glucp1.hxt2.rep3.data=stdmch.hxt2 
dat.glucp1.hxt2.rep3.times=ctimes
dat.glucp1.hxt2.rep3.bnds=bnds.hxt2

%%20190906  0.1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190906_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'hxt2', [10:30], 2, 3, {'hxt1', 'hxt2','hxt4', 'hxt6', 'wt'}, true)
timess{j}=times

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);

%%20190908  0.1%
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20190908_results/cExperiment_001.mat')
media{j}= cExperiment.metadata.acq.pumpInit.contents(1);

[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'hxt2', [10:30], 2, 3, {'hxt1', 'hxt2','hxt3', 'hxt7', 'wt'}, true)
timess{j}=times

f=diff(diff(nanmean(processcy5(makeMultiChamber(cExperiment)))));
[mx, argmx]= max(f);
ctimes=times- times(argmx);


j=j+1;

dat.glucp1.hxt3.rep3.data=stdmch.hxt3
dat.glucp1.hxt3.rep3.times=ctimes
dat.glucp1.hxt3.rep3.bnds=bnds.hxt3
dat.glucp1.hxt4.rep5.data=stdmch.hxt4
dat.glucp1.hxt4.rep5.times=ctimes
dat.glucp1.hxt4.rep5.bnds=bnds.hxt4
dat.glucp1.hxt2.rep3.data=stdmch.hxt2 
dat.glucp1.hxt2.rep3.times=ctimes
dat.glucp1.hxt2.rep3.bnds=bnds.hxt2


%%

genes= {'hxt1', 'hxt2', 'hxt3', 'hxt4', 'hxt6', 'hxt7'}
sugar='gluc1'
data= @(gene, num) dat.(sugar).(gene).(['rep' num2str(num)]).data.cellInf(2).mean
times= @(gene, num) dat.(sugar).(gene).(['rep' num2str(num)]).times
bounds= @(gene, num) dat.(sugar).(gene).(['rep' num2str(num)]).bnds
figure()
for j= 1:numel(genes)
axes()
plot(times(genes{j}, 1), nonzeroColMean(data(genes{j}, 1)), bounds(genes{j}, 1))
try
hold on; 
plot(times(genes{j}, 2),nonzeroColMean(data(genes{j}, 2)), bounds(genes{j}, 1))
end 
try
hold on;
plot(times(genes{j}, 3),nonzeroColMean(data(genes{j}, 3)), bounds(genes{j}, 1))
end 
end
stackPlots(gcf)




%% set the extraction time for gfp values
extractiontime=10
levels=struct;
attach= @(element, array) [array, element]

yl=[0, 25]
genes= {'hxt1', 'hxt2', 'hxt3', 'hxt4', 'hxt6', 'hxt7'}
fig1=figure; 
fig2=figure;
axx={axes(), axes(), axes(), axes(), axes(), axes(), axes()}
sugars={'gluc1', 'Glucose 1%'; 'glucp1', 'Glucose 0.1%'}
figcell={1, fig1; 0.1, fig2};
concolors=[0 0.8 .8; 0 0 .8; 0.6 0 0.6 ];


sugarchoice= @(sugar)  sugars{strcmp(sugars(:, 1), sugar), 2}
%figcell={1, fig1; 0.1, fig2};
figchoice= @(fi)  figcell{find([figcell{:,1}]==fi), 2}

%figure;


allsugars= {sugars{:, 1}}
cc=concolors([3 1], :)
for s= 1:2
    sugar=allsugars{s}
    col=cc(s, :);
    data= @(gene, num) dat.(sugar).(gene).(['rep' num2str(num)]).data.cellInf(2).mean
times= @(gene, num) dat.(sugar).(gene).(['rep' num2str(num)]).times
bounds= @(gene, num) dat.(sugar).(gene).(['rep' num2str(num)]).bnds
for j= 1:numel(genes)
hold on;
    axes(axx{j})
hold on;
title([genes{j} ])%sugarchoice(sugar)])
try
interpol= @(point) interp1( times(genes{j}, 1), nonzeroColMean(data(genes{j}, 1)), point );
try
levels.(sugar).(genes{j})= [levels.(sugar).(genes{j}), interpol(extractiontime)] 
catch
levels.(sugar).(genes{j})= interpol(extractiontime)
end

boundedline(times(genes{j}, 1), nonzeroColMean(data(genes{j}, 1)), bounds(genes{j}, 1), 'cmap', col)
end
try
hold on; 
interpol= @(point) interp1( times(genes{j}, 2), nonzeroColMean(data(genes{j}, 2)), point );
try
levels.(sugar).(genes{j})= [levels.(sugar).(genes{j}), interpol(extractiontime)] 
catch
levels.(sugar).(genes{j})= interpol(extractiontime)
end


boundedline(times(genes{j}, 2),nonzeroColMean(data(genes{j}, 2)), bounds(genes{j}, 2), 'cmap', col)
end 
try
hold on;
interpol= @(point) interp1( times(genes{j}, 3), nonzeroColMean(data(genes{j}, 3)), point );
try
levels.(sugar).(genes{j})= [levels.(sugar).(genes{j}), interpol(extractiontime)] 
catch
levels.(sugar).(genes{j})= interpol(extractiontime)
end


boundedline(times(genes{j}, 3),nonzeroColMean(data(genes{j}, 3)), bounds(genes{j}, 3), 'cmap', col)
end 
try
hold on;
interpol= @(point) interp1( times(genes{j}, 4), nonzeroColMean(data(genes{j}, 4)), point );
try
levels.(sugar).(genes{j})= [levels.(sugar).(genes{j}), interpol(extractiontime)] 
catch
levels.(sugar).(genes{j})= interpol(extractiontime)
end


boundedline(times(genes{j}, 4),nonzeroColMean(data(genes{j}, 4)), bounds(genes{j}, 4), 'cmap', col)
end 
try
hold on;
interpol= interp1( times(genes{j}, 5), nonzeroColMean(data(genes{j}, 5)));
try
levels.(sugar).(genes{j})= [levels.(sugar).(genes{j}), interpol(extractiontime)] 
catch
levels.(sugar).(genes{j})= interpol(extractiontime)
end


boundedline(times(genes{j}, 5),nonzeroColMean(data(genes{j}, 5)), bounds(genes{j}, 5), 'cmap', col)
end 
ylim(yl)
end
end
stackPlots(gcf)


%% plotting the bars based on the levels structure

%in the absence of hxt3...we add nans and reorder it
st=structfun(@nanstd, levels.gluc1)
st=st([1,2,6,3,4,5])
f=structfun(@nanmean, levels.gluc1)
f=f([1,2,6,3,4,5])

%make sure to include barwitherr from the fileexchange folder
figure; b=barwitherr([ structfun(@nanstd, levels.glucp1)'; st']', [structfun(@nanmean, levels.glucp1)'; f']' )
b(1).FaceColor=concolors(1, :)
b(2).FaceColor=concolors(3, :)
b(1).EdgeColor='None'
b(2).EdgeColor='None'
b(2).FaceAlpha=.7
set(gca, 'XTickLabel', genes)
title(['GFP ' num2str(extractiontime) ' hrs post induction'])


save2pdf('201910922_glucosesteps_barplot.pdf')

%% stacked bar


newcolors=[.8 0 .8; %magenta
    .08, .6, 1; % light blue
    .5, 0, .9; % purple
   0,0, .6; %dark blue
   0,0,0; % black
   .3,.8, .3;  %lighter green
   .1, .5, .1]           %darker green
    
%the stacked bar has an issue with error bars
%figure; b=barwitherr([ structfun(@nanstd, levels.glucp1)'; st'], [structfun(@nanmean, levels.glucp1)'; f'], 'stacked' )

figure; b=bar([structfun(@nanmean, levels.glucp1)'; f'], 'stacked' )
c=1
for j=[1,2,3,4,6,7]
    
if j ==5
    continue
end

b(c).FaceColor= newcolors(j, :);
b(c).EdgeColor='None'
b(c).FaceAlpha=.7

c=c+1
end
set(gca, 'XTickLabel', {'0.1% glucose', '1% glucose'})
save2pdf('20191022_glucosesteps_barplot_stacked.pdf')

