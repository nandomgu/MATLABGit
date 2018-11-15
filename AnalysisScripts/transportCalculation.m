%%transport functions
chan=2
[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdBasic([], loadExpt(exptList{7}), [], 'hxt4' , chan,3, [], 0, 0.22);
[h, means2, times2, stdmch, bnds]=multiMeanPlotRobustStdBasic([], loadExpt(exptList{6}), [], 'hxt4' , chan,3, [], 0, 0.22);
[h, means3, times3, stdmch, bnds]=multiMeanPlotRobustStdBasic([], loadExpt(exptList{10}), [], 'hxt4' , chan,3, [], 0, 0.22);
rampexpt='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180410_results/cExperiment.mat'

[h, means4, times4, stdmch2, bnds]=multiMeanPlotRobustStdAdvanced([], loadExpt(rampexpt), [], 'wt', 'mig1g', 1:20, 7, 3, [], false)

%%
colors(1,:)=[0,0.75, 0.75];
colors(2,:)=[0,0.45, 0.74];
colors(3,:)=[0.75,0, 0.75];
colors(4,:)=[1,0, 0];
colors(5,:)=[0.93,0.69, 0.13];
colors(6,:)=[0.47,0.67, 0.19];
colors(7,:)=[0.49,0.49, 0.49];

meanh1=means(1,:)
meanh2=means(2,:)
meanh4=means(3,:)
meanh7=means(4,:)
meanh3=means2(2,:)
meanh6=means2(4,:)
meanh5=means3(3,:)

rampmeanh2=means4(1,:);
rampmeanh4=means4(2,:);
rampmeanh7=means4(3,:);


%%convertng percent to molarity 
glucoseMol=180.155;
molarityPercent=glucoseMol/10; %18 percent is one molar

%percent in the experiment
glucosePercent=1;
%converting the percentage to grams every 1000 ml
gramsper1000= glucosePercent*10;
experimentmiliMols= gramsper1000/glucoseMol*1000;

%%Hill function to correct for cy5 saturation in the background
cy5bg= @(c) 0.03*c/(.01+c);
[cy, mean, times]=processcy5(stdmch)
ncy=normalizeTS(nanmean(cy))
saturated=arrayfun(cy5bg, ncy);
correctedcy5= normalizeTS(ncy-saturated)*experimentmiliMols
figure; plot(times, correctedcy5)



%%cy5 for the ramp experiment

cy5bg= @(c) 0.03*c/(.01+c);
[cyr, mean, times]=processcy5(stdmch2)
ncyr=normalizeTS(nanmean(cyr))
saturated=arrayfun(cy5bg, ncyr);
correctedcyr= normalizeTS(ncyr-saturated)*experimentmiliMols
figure; plot(times, correctedcy5)

%%conversion from GFP (hxt4 units) to mg transporter


%%km 5mM

km51=90
km52=1.5
km522=60
km53=55-6 
km54=9.3
km55=10
km56=2.5 
km57=1.1


%%km 100mM

km1001=110
km1002=10
km1003=65
km1004=9.4
km1005=10;
km1006=2.5;
km1007=2.1;


%%vmax nmol/min e-1 mg -1 5mM

vm51= 690;
vm52= 97;
vm522=450
vm53= 360;
vm54= 160;
vm55= 150;
vm56= 186*.3;
vm57= 186

%%vmax nmol/min -1 mg -1 100 mM

vm1001= 690;
vm1002= 176;
vm1003= 250;
vm1004= 100;
vm1005= 150;
vm1006= 186/3
vm1007= 186


transport= @(g, km, vmax) vmax*g/(g+km);

scan200= @(km, vmax) arrayfun(transport, linspace(0,200,100), repmat(km, 1,100),repmat(vmax,1,100))

transportCapacityH1= arrayfun(transport, correctedcy5, repmat(km1001, 1, numel(correctedcy5)),  repmat(vm1001, 1, numel(correctedcy5)))
transportCapacityH2= arrayfun(transport, correctedcy5, repmat(km1002, 1, numel(correctedcy5)),  repmat(vm1002, 1, numel(correctedcy5)))
transportCapacityH3= arrayfun(transport, correctedcy5, repmat(km1003, 1, numel(correctedcy5)),  repmat(vm1003, 1, numel(correctedcy5)))
transportCapacityH4= arrayfun(transport, correctedcy5, repmat(km1004, 1, numel(correctedcy5)),  repmat(vm1004, 1, numel(correctedcy5)))
transportCapacityH5= arrayfun(transport, correctedcy5, repmat(km1005, 1, numel(correctedcy5)),  repmat(vm1005, 1, numel(correctedcy5)))
transportCapacityH6= arrayfun(transport, correctedcy5, repmat(km1006, 1, numel(correctedcy5)),  repmat(vm1006, 1, numel(correctedcy5)))
transportCapacityH7= arrayfun(transport, correctedcy5, repmat(km1007, 1, numel(correctedcy5)),  repmat(vm1007, 1, numel(correctedcy5)))


tcrampH2= arrayfun(transport, correctedcyr, repmat(km1002, 1, numel(correctedcyr)),  repmat(vm1002, 1, numel(correctedcyr)))
tcrampH4= arrayfun(transport, correctedcyr, repmat(km1004, 1, numel(correctedcyr)),  repmat(vm1004, 1, numel(correctedcyr)))
tcrampH7= arrayfun(transport, correctedcyr, repmat(km1007, 1, numel(correctedcyr)),  repmat(vm1007, 1, numel(correctedcyr)))

%multiplying the theoretical transport capacity
% times the hxt1 mass 
%this does not account for vacuole loc

%% smootnhing traces with spline
smp=0.5
[t, smeanh1]= splineAllCells(meanh1,smp);
[~,smeanh2]= splineAllCells(meanh2,smp);
[~,smeanh3]= splineAllCells(meanh3,smp);
[~,smeanh4]= splineAllCells(meanh4,smp);
[~,smeanh5]= splineAllCells(meanh5,smp);
[~,smeanh6]= splineAllCells(meanh6,smp);
[~,smeanh7]= splineAllCells(meanh7,smp);

[~,smeanh7]= splineAllCells(meanh7,smp);
[~,smeanh7]= splineAllCells(meanh7,smp);

[~,srampmeanh2]= splineAllCells(rampmeanh2,smp);
[~,srampmeanh4]= splineAllCells(rampmeanh4,smp);
[~,srampmeanh7]= splineAllCells(rampmeanh7,smp);

%%

transportMassH1= transportCapacityH1.* smeanh1
transportMassH2= transportCapacityH2.* smeanh2
transportMassH3= transportCapacityH3.* smeanh3
transportMassH4= transportCapacityH4.* smeanh4
transportMassH5= transportCapacityH5.* smeanh5
transportMassH6= transportCapacityH6.* smeanh6
transportMassH7= transportCapacityH7.* smeanh7

tmassrampH2= tcrampH2.* srampmeanh2
tmassrampH4= tcrampH4.* srampmeanh4
tmassrampH7= tcrampH7.* srampmeanh7

figure; area([tmassrampH4;tmassrampH7;tmassrampH2]' )


cmap=lines(10)
figure; area(transportMassH1, 'FaceColor', cmap(1,:))
hold on; area(transportMassH2, 'FaceColor', cmap(2,:))
hold on;  area(transportMassH3, 'FaceColor', cmap(3,:))
hold on;  area(transportMassH4, 'FaceColor', cmap(4,:))
hold on;  area(transportMassH5, 'FaceColor', cmap(5,:))
hold on;  area(transportMassH6, 'FaceColor', cmap(6,:))
hold on; area(transportMassH7, 'FaceColor', cmap(7,:))

figure; area([transportMassH1;transportMassH2;transportMassH3;transportMassH4;transportMassH5;transportMassH6;transportMassH7]')

% figure; plot(transportMassH1)
% hold on; plot(transportMassH2)
% hold on;  plot(transportMassH3)
% hold on;  plot(transportMassH4)
% hold on;  plot(transportMassH5)
% hold on;  plot(transportMassH6)
% hold on; plot(transportMassH7)

% 
% figure; area(transportMassH1)
% hold on; area(transportMassH2)
% hold on; area(transportMassH3)
% hold on;  area(transportMassH4)
% hold on;  area(transportMassH5)
% hold on;  area(transportMassH6)
% hold on; area(transportMassH7)
% 
% figure; area([ transportMassH1;
%     transportMassH2;
%     transportMassH3;
%     transportMassH4;
%     transportMassH5;
%     transportMassH6;
%     transportMassH7]')

%% reordered so that the contributions are less influenced by Hxt1
figure; h= area(times, [transportMassH4;
    transportMassH2;
    transportMassH5;
    transportMassH6;
    transportMassH7;
    transportMassH3;
    transportMassH1 ]')
fc=colors([4,2,5,6,7,3,1],:)
for j=1:size(colors,1)
    h(j).FaceColor=fc(j, :)
end



%% correcting for derivative (vacuole localisation)
thresh=0
nonvacT1=transportMassH1(1:end-1) .* (diff(smeanh1)>=thresh);
nonvacT2=transportMassH2(1:end-1) .* (diff(smeanh2)>=-thresh);
nonvacT3=transportMassH3(1:end-1) .* (diff(smeanh3)>=-thresh);
nonvacT4=transportMassH4(1:end-1) .* (diff(smeanh4)>=-thresh);
nonvacT5=transportMassH5(1:end-1) .* (diff(smeanh5)>=-thresh);
nonvacT6=transportMassH6(1:end-1) .* (diff(smeanh6)>=-thresh);
nonvacT7=transportMassH7(1:end-1) .* (diff(smeanh7)>=-thresh);



rampnonvacT2=tmassrampH2(1:end-1) .* (diff(srampmeanh2)>=-thresh);
rampnonvacT4=tmassrampH4(1:end-1) .* (diff(srampmeanh4)>=-thresh);
rampnonvacT7=tmassrampH7(1:end-1) .* (diff(srampmeanh7)>=-thresh);



vacall= [nonvacT4;
nonvacT2;
nonvacT5;
nonvacT6;
nonvacT7;
nonvacT3;
nonvacT1];


rampvacall= [rampnonvacT2;rampnonvacT4;rampnonvacT7];

%%
figure; k=area(times(1:end-1), vacall')
figure; g=area(times(1:end-1), (vacall./sum(vacall))')
for j=1:size(colors,1)
    g(j).FaceColor=fc(j, :)
    k(j).FaceColor=fc(j, :)
end
%%%
%plotting MM curves for transporters
%% mm curves for hxt1

h1mm=arrayfun(scan200, linspace(km51,km1001, 20), linspace(vm51,vm1001, 20), 'uni', false)
figure; 
subplot(3,3,1)
gene='Hxt1'
for j=1:numel(h1mm)
    plot(linspace(0,200, 100), h1mm{j})
    hold on;
end
title('Hxt1')
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])
ylim([0, 500])
addVLine(experimentmiliMols)
%%mm curves for hxt2 1
h2mm=arrayfun(scan200, linspace(km52,km1002, 20), linspace(vm52,vm1002, 20), 'uni', false)
subplot(3,3,2)
gene='Hxt2'
for j=1:numel(h1mm)
    plot(linspace(0,200, 100), h2mm{j}, 'Color', 'blue')
    hold on;
end
title(gene)
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])
addVLine(experimentmiliMols)
%%mm curves for hxt2 2
h2mm=arrayfun(scan200, linspace(km522,km1002, 20), linspace(vm522,vm1002, 20), 'uni', false)
hold on;
gene='Hxt2'
for j=1:numel(h1mm)
    plot(linspace(0,200, 100), h2mm{j}, 'Color', 'magenta')
    hold on;
end
title(gene)
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])

ylim([0, 500])
addVLine(experimentmiliMols)
%%mm curves for hxt3
h3mm=arrayfun(scan200, linspace(km53,km1003, 20), linspace(vm53,vm1003, 20), 'uni', false)
subplot(3,3,3)
gene='Hxt3'
for j=1:numel(h3mm)
    plot(linspace(0,200, 100), h3mm{j})
    hold on;
end
title(gene)
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])

ylim([0, 500])
addVLine(experimentmiliMols)
%%mm curves for hxt4
h4mm=arrayfun(scan200, linspace(km54,km1004, 20), linspace(vm54,vm1004, 20), 'uni', false)
subplot(3,3,4) 
gene='Hxt4'
for j=1:numel(h4mm)
    plot(linspace(0,200, 100), h4mm{j})
    hold on;
end
title(gene)
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])
ylim([0, 500])
addVLine(experimentmiliMols)
%%mm curves for hxt5
h5mm=arrayfun(scan200, linspace(km55,km1005, 20), linspace(vm55,vm1005, 20), 'uni', false)
subplot(3,3,5)
gene='Hxt5'
for j=1:numel(h5mm)
    plot(linspace(0,200, 100), h5mm{j})
    hold on;
end
title(gene)
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])
ylim([0, 500])
addVLine(experimentmiliMols)
%%mm curves for hxt6
h6mm=arrayfun(scan200, linspace(km56,km1006, 20), linspace(vm56,vm1006, 20), 'uni', false)
subplot(3,3,6)
gene='Hxt6'
for j=1:numel(h6mm)
    plot(linspace(0,200, 100), h6mm{j})
    hold on;
end
title(gene)
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])
ylim([0, 500])
addVLine(experimentmiliMols)
%%mm curves for hxt7
h7mm=arrayfun(scan200, linspace(km57,km1007, 20), linspace(vm57,vm1007, 20), 'uni', false)
subplot(3,3,7)
gene='Hxt7'
for j=1:numel(h7mm)
    plot(linspace(0,200, 100), h7mm{j})
    hold on;
end
title(gene)
ylabel(['V_{' gene '}'])
xlabel(['mM Glucose'])
ylim([0, 500])
addVLine(experimentmiliMols)
%% 






