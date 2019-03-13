%% good parameter combinations
goodparams=struct;
goodparams.model1.hxt1(1,:)=[100 ,1.39,7,.5, .1, 4, 0.05 ]; %hill factor of 7 is kinda brutal but recovers the upshift delay
goodparams.model1.hxt1(2,:)=[20.9342    1.1402    6.7640    0.2577   -6.1175   -4.3011   -5.0207]% fit using fminsearch
goodparams.model2.hxt1(1,:)=[100 ,1.39,7,.5, .7, 4, 0.05 ]; %good induction dynamics but no downshift bump
goodparams.model2.hxt1(2,:)=[10 ,1.39,7,.5, .7, 7, 0.3 ]; %model showing downshift bumps but not quite the upshift. 

%% run specific params
modelName='mechModel1'
%pars=[100 ,1.39,7,.5, .7, 4, 0.05 ]
pars=[20, 100, .1, 5, .9, 6, .3, 4, .02, 4, .02, 4, .5, 4, .3, 9];
num=[2];
modelFeatures=extractModelFeatures(modelName)
span1=exp(linspace(0,2,80));
span2=[1,2,3,4,5];
span=span1;
grid1= repmat(span1, numel(span2), 1);
grid2=repmat(span2', 1, numel(span1));
%span=1:numel(grid1);

cols=colorRamp([0 .8 .8; 1 0 1], numel(span)+1);
figure;
c=1;
n=2 ; 
argsim=struct;
        argsim.input=cy5(n,:);
        %ramp6h=locdataramps.cy5(7,:);
        %argsim.input=ramp6h;
        argsim.data=meandata.hxt1.g1percent;
        argsim.lsq=lsq;
        %mig1 localisation trace
        %mat=locdata.mig1g.g1percent.rep1.data;
        %ramp 6 hrs
        mat=locdataramps.mig1g.ramp6h.rep1;
        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); 
        argsim.outvar=1;
        argsim.mig1=smooth(zmedian);%making negatives zero
simulator=makesimulator2('mechModel1', argsim);
opts.MaxIter=1000;
%[x1(k, :), arr(k)]=fminsearch(simulator, log(pars), opts); %we run fit twice just in case we run out of steps.

sim=mechModel1(pars,argsim);
[tf, yf]=ode23(sim, times, [0,3.3,0], modelFeatures.options);
d=nanmean(argsim.data);
d=d(1:numel(tf));
plot(tf, yf(:,argsim.outvar), 'Color', cols(c,:), 'LineWidth', 1.5, 'DisplayName', num2str(pars)); 
hold on

plot(tf', d')
yyaxis right; plot(tf, argsim.input(1:numel(tf)))
title(strjoin([modelName, ': ' ,modelFeatures.paramNames(num)]))



%% single param span simulation, or equal change in a certain parameterdownshft
downshiftareas=[];
upshiftareas=[];
modelName='mechModel1'
num=[15];
modelFeatures=extractModelFeatures(modelName)
%for the discontinuity of hxt4, try model 6,  param 2 in span1=exp(linspace(-.75,1,30));
span1=exp(linspace(-3,4,30));
span2=[1,2,3,4,5];
span=span1;
grid1= repmat(span1, numel(span2), 1);
grid2=repmat(span1', 1, numel(span1));
%span=1:numel(grid1);

cols=colorRamp([0 .8 .8; 1 0 1], numel(span)+1);
figure;
c=1;
for j=span
n=2 ; 
%1-6
% 'VHXT'    'Vloc'    'basaldeg'    'maxdegMT'    'KdegMT'    'hilldegMT'
%7-16
% 'basaldegMT'    'deloc'    'KrepMT' 'hillrepMT'    'KrepHMG'    'hillHMG'    'KrepHMT'    'hillHMT'    'KMG'    'hillMG'
testparams=[20, 100, .1, 5, .9, 6, .3, 4, .02, 4, .02, 4, .5, 4, .05, 9];
%testparams=fitparams.hxt1.mechModel1.fminsearch

pars=testparams
%pars=[10 ,1.39,9,.5, .7, 4, 0.3 ]
pars(num)=j;
argsim=struct;
        argsim.input=glucose;

        argsim.data=data;
        argsim.lsq=lsq;
        %mig1 localisation trace
        %mat=locdata.mig1g.g1percent.rep1.data;
        %ramp 6 hrs
        %ramp6h=locdataramps.cy5(7,:);
        %argsim.input=ramp6h;
        mat=locdataramps.mig1g.ramp6h.rep1;
        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); 
        
        
        argsim.mig1=zmedian;%making negatives zero
        argsim.outvar=2;
sim=mechModel1(pars,argsim);
[tf, yf]=ode23(sim, times, [0,3.3,0], modelFeatures.options);

plot(tf, yf(:, argsim.outvar), 'Color', cols(c,:), 'LineWidth', 1.5, 'DisplayName', [modelFeatures.paramNames{num},'=', num2str(j)]); 
der=diff(glucose);
[maxval, maxind]=max(der);
[minval, minind]=min(der);
%addVLine(tf(minind));addVLine(tf(maxind));
downshiftareas(c)=trapz(yf(minind:minind+40)- mean(yf(minind-2:minind-1)));
upshiftareas(c)=trapz(yf(maxind:maxind+40)- mean(yf(maxind-2:maxind-1)));



hold on
c=c+1;
end
plot(repmat(ntimes, size(meandata.hxt1.g1percent,1), 1)', meandata.hxt1.g1percent')
yyaxis right; plot(ntimes, cy5(n,:))
title(strjoin([modelName, ': ' ,modelFeatures.paramNames(num)]))
figure;
for q=1:numel(upshiftareas)
scatter(upshiftareas(q), downshiftareas(q), 200,cols(q,:)); hold on;% grid1(:),'.')
xlabel('upshift area')
ylabel('downshift area')
end
%% independent change in two params
modelName='mechModel1'
num=[15];
modelFeatures=extractModelFeatures(modelName)
%span1=linspace(.1,.8,10);
span1=exp(linspace(-4,1,14));
span2=exp(linspace(-4,-2,14));
%span2=span1
%span2=[1,2,3,4];
%span2=span1;
grid1= repmat(span1, numel(span2), 1);
grid2=repmat(span2', 1, numel(span1));
span=1:numel(grid1);

cols=colorRamp([0 .8 .8; 1 0 1], numel(span)+1);
figure;
c=1;
upshiftareas=[];
downshiftareas=[];
for j=span
n=2 ; 
%pars=[8,1.39,7,.23, .7, 2, 0.32 ];
%1-6
% 'VHXT'    'Vloc'    'basaldeg'    'maxdegMT'    'KdegMT'    'hilldegMT'
%7-16
% 'basaldegMT'    'deloc'    'KrepMT' 'hillrepMT'    'KrepHMG'    'hillHMG'    'KrepHMT'    'hillHMT'    'KMG'    'hillMG'

testparams=[20, 100, .1, 5, .01, 6, .1, .5, .02, 4, .02, 4, .5, 4, .05, 9];

pars=exp(testparams)
pars(num(1))=grid1(j);
pars(num(2))=grid2(j);

argsim=struct;
        %argsim.input=glu(j)cose;
        ramp6h=locdataramps.cy5(7,:);
        argsim.input=ramp6h;
        argsim.data=data;
        argsim.lsq=lsq;
        %mig1 localisation trace
        %mat=locdata.mig1g.g1percent.rep1.data;
        %ramp 6 hrs
        mat=locdataramps.mig1g.ramp6h.rep1;
        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); 
        
        argsim.mig1=zmedian;%making negatives zero

sim=simpleModel6(pars,argsim);
[tf, yf]=ode23(sim, times, 0, modelFeatures.options);
plot(tf, yf, 'Color', cols(c,:), 'LineWidth', 1.5, 'DisplayName', [modelFeatures.paramNames{num(1)},'=', num2str(grid1(j)), ' ',  modelFeatures.paramNames{num(2)},'= ' num2str(grid2(j))]); 
hold on
c=c+1;
der=diff(cy5(n,:));
[maxval, maxind]=max(der);
[minval, minind]=min(der);
downshiftareas(j)=trapz(yf(minind:minind+40)- mean(yf(minind-2:minind-1)));
upshiftareas(j)=trapz(yf(maxind:maxind+40)- mean(yf(maxind-2:maxind-1)));
end
plot(repmat(ntimes, size(meandata.hxt1.g1percent,1), 1)', meandata.hxt1.g1percent')
yyaxis right; plot(ntimes, argsim.input)
title(strjoin([modelName, ': ' ,modelFeatures.paramNames(num)]))
figure; scatter(grid1(:), grid2(:), 200, downshiftareas, '.')
xlabel(modelFeatures.paramNames{num(1)})
ylabel(modelFeatures.paramNames{num(2)})
title('downshift area')
figure; scatter(grid1(:), grid2(:), [], downshiftareas./upshiftareas)
xlabel(modelFeatures.paramNames{num(1)})
ylabel(modelFeatures.paramNames{num(2)})
title('downshift area/upshift area')
figure; scatter(grid1(:), grid2(:), [], upshiftareas)
xlabel(modelFeatures.paramNames{num(1)})
ylabel(modelFeatures.paramNames{num(2)})
title('upshift area')
figure; scatter(upshiftareas, downshiftareas, 200, grid1(:),'.')
xlabel('upshift area')
ylabel('downshift area')


%% more elegant parameter exploration
%%the order does not matter

%%
%these parameters nail the mth1 mig1 behaviour
hxt2params=[2 0.0846749835348286 -0.22314355131421 3.91202300542815 -1.20397280432594 2.30258509299405 0.405465108108164 1.09861228866811 -0.693147180559945 -0.196063997334818 2.63905732961526 5 -2.30258509299405 -30 1.79175946922805 -2.30258509299405 0 -1.20397280432594 0.542301272315275 -1.20397280432594 2.07944154167984 -1.20397280432594 2.07944154167984 -1.20397280432594]
gene='hxt2';
model='mechModel8';
mf=extractModelFeatures(model);
%we take a parameter list
ps=paramstruct('mechModel6', hxt2params); 
%tempars= defaultparams('mechModel7', ps);
%argsim.outvar=7;
%figure; plotsim('hxt2', argsim, tempars)
argsim.input=glucose*20
data=argsim.meandata.(gene).g1percent;
argsim.data=data;
argsim.datastart=nanmean(data(:,1));
%mth1 contro parameters
ps.KdegMT= log(.1); 
ps.maxdegMT= log(20); 
ps.hilldegMT= log(10); 
ps.basaldegMT= log(1); 
ps.KrepHMT=log(.3); 


%std1 control parameters
ps.maxdegST=log(5);
ps.KdegST=log(1);
ps.hilldegST=log(2);
ps.basaldegST=log(.1);
ps.KrepMTST=log(.1595); 
ps.hillrepMTST=log(10); 

%mig1 control parameters
ps.KMG=log(0.3);
ps.deloc=log(6);
ps.hillMG=log(8);
ps.KinhSMG=log(5000);

%mig2 control parameters
ps.KrepSTM2=log(.2);
ps.KinhSM2=log(1);
ps.hillrepSTM2=log(3);
ps.basaldegM2=log(.5);

%hxt control parameters
ps.KrepHM2=log(1);
ps.KhillrepHM2=log(1);
ps.KrepHMG=log(0.003);
ps.hillrepHMG=log(1);
ps.threshdegHXT=log(.1);


ps.hillrepHST=log(1);
ps.KrepHST=log(1);

ps.VHXT=3; %default value
ps.basaldeg= log(1.5);
pars= defaultparams(model, ps);
argsim.onlyparams= 1:numel(mf.paramNames);
argsim.model=model;
argsim.outvar=7;
figure; plotsim('hxt2', argsim, pars)
argsim.outvar=2;
axes()
plotsim('hxt2', argsim, pars)
argsim.outvar=3;
axes()
plotsim('hxt2', argsim, pars)
text(1, 5, 'mig1')
if strcmp(model, 'mechModel8')
    
argsim.outvar=8;
axes()
plotsim('hxt2', argsim, pars)
text(1, 5, 'mig2')
end

argsim.outvar=1;
axes()
plotsim('hxt2', argsim, pars)

uniformAxes(gcf, [], [0,20], [],[], [] )
stackPlots(gcf)
uniformAxes(gcf, [], [0,20], [],[.8], [] )
%hxt2params=pars;

%%
x2=exploreparamFMS(gene, argsim, pars)
for o=1:10
x2=exploreparamFMS(gene, argsim, x2)

end
%%
%good parameters for
%model7 hxt2, mth1 has been warped because std1 just does not come on for
%some reason. 
hxt2goodparams=[2.84304155737661 0.0887703545406884 -0.212865579106449 4.94294563272519 -1.79125879287819 1.48373248575318 0.432227210770848 -1.65906414978075e-05 -0.682531357381142 -0.194040128972889 3.14010133267242 1.78784343960864 -2.37350623892124 -2.83893645653613 1.88247121352695 -2.53603398714164 6.91126297871964e-05 -0.921365992290436 0.50688677448701 1.0117852201365 1.0325880581477 -1.14823409221521 2.14401941852047 -1.14421918034718 2.15841262004125 -1.14185370719255]

%%% explore many concentrations of glu(j)cose

%% highly nonlinear mth1 dynamics. yields trouble but parameters well adjusted
%more elegant parameter exploration
%%the order does not matter


%these parameters nail the mth1 mig1 behaviour
hxt2params=[2 0.0846749835348286 -0.22314355131421 3.91202300542815 -1.20397280432594 2.30258509299405 0.405465108108164 1.09861228866811 -0.693147180559945 -0.196063997334818 2.63905732961526 5 -2.30258509299405 -30 1.79175946922805 -2.30258509299405 0 -1.20397280432594 0.542301272315275 -1.20397280432594 2.07944154167984 -1.20397280432594 2.07944154167984 -1.20397280432594]
gene='hxt4';
model='mechModel8';
mf=extractModelFeatures(model);
%we take a parameter list
ps=paramstruct('mechModel6', hxt2params); 
%tempars= defaultparams('mechModel7', ps);
%argsim.outvar=7;
%figure; plotsim('hxt2', argsim, tempars)
c=1;
glu=[.2, .4, 1, 2]
for j=1:4
argsim.input=[zeros(1, 38) ones(1, 137-38+1), zeros(1, 92)]*glu(j); %artificial
%glu(j)cose signal
%argsim.input=glu(j)cose*glu(j);
data=argsim.meandata.(gene).g1percent;
argsim.data=data;
argsim.datastart=nanmean(data(:,1));
%mth1 contro parameters
ps.KdegMT= log(.15); 
ps.maxdegMT= log(20); 
ps.hilldegMT= log(1); 
ps.basaldegMT= log(1); 



%std1 control parameters
ps.maxdegST=log(5);
ps.KdegST=log(.5);
ps.hilldegST=log(1);
ps.basaldegST=log(.1);
ps.KrepMTST=log(.3); 
ps.hillrepMTST=log(10); 

%mig1 control parameters
ps.KMG=log(0.1);
ps.deloc=log(3);
ps.hillMG=log(8);
ps.KinhSMG=log(30);

%mig2 control parameters
ps.KrepSTM2=log(.2);
ps.KinhSM2=log(2);
ps.hillrepSTM2=log(1);
ps.basaldegM2=log(1.5);

%hxt control parameters
ps.KrepHMT=log(.1); 
ps.hillrepHMT=log(2); 
ps.KrepHM2=log(.1);
ps.hillrepHM2=log(1);
ps.KrepHMG=log(0.003);
ps.hillrepHMG=log(2);
ps.threshdegHXT=log(.1);
ps.hilldegHXT=log(4);

ps.hillrepHST=log(1);
ps.KrepHST=log(3.5); % 4 is pretty good

ps.VHXT=3; %default value
ps.basaldeg= log(3.5);
pars= defaultparams(model, ps);
argsim.onlyparams= 1:numel(mf.paramNames);
argsim.model=model;
argsim.outvar=7;
argsim.initialconditions=[]; %giving plotsim prioirity to assign initial conditions
if c==1
    figure;
ax1=axes()
else
    hold on; axes(ax1);

end
plotsim(gene, argsim, pars)
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);

argsim.outvar=2;
if c==1
ax2=axes()
else
   hold on;  axes(ax2);

end

plotsim(gene, argsim, pars)
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
argsim.outvar=3;
if c==1
ax3=axes()
else
    hold on; axes(ax3);

end
plotsim(gene, argsim, pars)
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
text(1, 5, 'mig1')
if strcmp(model, 'mechModel8')
    
argsim.outvar=8;
if c==1
ax4=axes()
else
    hold on; axes(ax4);

end
plotsim(gene, argsim, pars)
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
text(1, 5, 'mig2')
end

argsim.outvar=1;
if c==1
ax5=axes()
else
   hold on;  axes(ax5);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
    
    

    
uniformAxes(gcf, [], [0,20], [],[], [] )
stackPlots(gcf)
uniformAxes(gcf, [], [0,20], [],[.8], [.2] )

    if c==1
        figure; 
    end
    
    %%%%%%%%mutants
    
    %simulating and plotting mutants
savedp=ps; %above params saved
%WT

if c==1
axWT=axes()
else
   hold on;  axes(axWT);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
    title('WT') 
    
%mig1
ps.KrepHMG=log(1000); % Mig1 loses the ability to bind
pars= defaultparams(model, ps);

if c==1
axMG=axes()
else
   hold on;  axes(axMG);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
    title('mig1?') 
  ps=savedp;  
%mth1
ps.KrepHMT=log(1000); % MTH1 loses the ability to bind HXT
ps.KrepSTM2=log(1000); % MTH1 loses the ability to bind MIG2
ps.KrepMTST=log(1000); % MTH1 loses the ability to bind STD1
%changing initial conditions of MTH1 (number 2)  to 0
argsim.initialconditions= [argsim.mth1ko(1)   0         0    9.1621         0    1.0000         0 0]
pars= defaultparams(model, ps);

if c==1
axMT=axes()
else
   hold on;  axes(axMT);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
    title('mth1?') 
  ps=savedp;  
 % changing back the initial conditions
argsim.initialconditions= [ datastart   1         0    9.1621         0    1.0000         0 0]

  
  
 %rgt2
 ps.KdegST=log(1000); % Std1 can no longer be degraded
pars= defaultparams(model, ps);

if c==1
axR=axes()
else
   hold on;  axes(axR);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);   
    title('rgt2?') 
ps=savedp; 
 %std1
 
  ps.KinhSMG=-40; % Std1 can no longer be degraded
  ps.KinhSM2=-40;
  ps.KrepST=log(1000);
pars= defaultparams(model, ps);
if c==1
axST=axes()
else
   hold on;  axes(axST);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);  
    title('std1?') 
ps=savedp;     
    
stackPlots(gcf)    
uniformAxes(gcf, [], [0,20], [],[.8], [.12] )    
    


c=c+1;
end

%% matrix of means of all strains

  allfitmeans=[nanmean(meandatamutants.hxt4.gp2percent); ...
nanmean(meandatamutants.hxt4.gp4percent); ...
nanmean(meandatamutants.hxt4.g1percent); ...
nanmean(meandatamutants.mig1ko.gp2percent); ...
nanmean(meandatamutants.mig1ko.gp4percent); ...
nanmean(meandatamutants.mig1ko.g1percent);...

nanmean(celldatamutants.mth1ko.gp2percent.rep2);...
nanmean(meandatamutants.mth1ko.gp4percent);...
nanmean(celldatamutants.mth1ko.g1percent.rep2);...

nanmean(meandatamutants.std1ko.gp2percent);...
nanmean(celldatamutants.std1ko.gp4percent.rep2);...
nanmean(meandatamutants.std1ko.g1percent);...

nanmean(meandatamutants.rgt2ko.gp2percent);...
nanmean(meandatamutants.rgt2ko.gp4percent);...
nanmean(meandatamutants.rgt2ko.g1percent)...

nanmean(meandatamutants.snf3ko.gp2percent);...
nanmean(meandatamutants.snf3ko.gp4percent);...
nanmean(meandatamutants.snf3ko.g1percent)...
]'      
 allfitmeans=allfitmeans(1:230, :);

 
  allfitstd=[nanstd(meandatamutants.hxt4.gp2percent); ...
nanstd(meandatamutants.hxt4.gp4percent); ...
nanstd(meandatamutants.hxt4.g1percent); ...
nanstd(meandatamutants.mig1ko.gp2percent); ...
nanstd(meandatamutants.mig1ko.gp4percent); ...
nanstd(meandatamutants.mig1ko.g1percent);...

nanstd(celldatamutants.mth1ko.gp2percent.rep2);...
nanstd(meandatamutants.mth1ko.gp4percent);...
nanstd(celldatamutants.mth1ko.g1percent.rep2);...

nanstd(meandatamutants.std1ko.gp2percent);...
nanstd(meandatamutants.std1ko.gp4percent);...
nanstd(meandatamutants.std1ko.g1percent);...

nanstd(meandatamutants.rgt2ko.gp2percent);...
nanstd(meandatamutants.rgt2ko.gp4percent);...
nanstd(meandatamutants.rgt2ko.g1percent)...

nanstd(meandatamutants.snf3ko.gp2percent);...
nanstd(meandatamutants.snf3ko.gp4percent);...
nanstd(meandatamutants.snf3ko.g1percent)...
]'      
 allfitstd=allfitstd(1:230, :); 
 
%% curated data removing bad technical outliers
 allfitmeanscurated=[nanmean(meandatamutants.hxt4.gp2percent); ...%1
nanmean(meandatamutants.hxt4.gp4percent([1 3:end], :)); ...%2
nanmean(meandatamutants.hxt4.g1percent); ...%3
nanmean(meandatamutants.mig1ko.gp2percent); ...%4
nanmean(meandatamutants.mig1ko.gp4percent); ...%5
nanmean(meandatamutants.mig1ko.g1percent);...%6

nanmean(celldatamutants.mth1ko.gp2percent.rep2);...%7
nanmean(meandatamutants.mth1ko.gp4percent);...%8
nanmean(celldatamutants.mth1ko.g1percent.rep2);...%9

nanmean(meandatamutants.std1ko.gp2percent);...%10
nanmean(meandatamutants.std1ko.gp4percent);...%11 one replicate screwed up
nanmean(meandatamutants.std1ko.g1percent);...%12

nanmean(meandatamutants.rgt2ko.gp2percent);...%13
nanmean(meandatamutants.rgt2ko.gp4percent);...%14
nanmean(meandatamutants.rgt2ko.g1percent)...%15

nanmean(meandatamutants.snf3ko.gp2percent);...%16
nanmean(meandatamutants.snf3ko.gp4percent.rep2);...%17 rep 1 screwed up. usng all cells from rep 2
nanmean(meandatamutants.snf3ko.g1percent)...%18
]'      
 allfitmeanscurated=allfitmeanscurated(1:230, :);
   
 

  allfitstdcurated=[nanstd(meandatamutants.hxt4.gp2percent); ...%1
nanstd(meandatamutants.hxt4.gp4percent([1 3:end], :)); ...%2
nanstd(meandatamutants.hxt4.g1percent); ...%3
nanstd(meandatamutants.mig1ko.gp2percent); ...%4
nanstd(meandatamutants.mig1ko.gp4percent); ...%5
nanstd(meandatamutants.mig1ko.g1percent);...%6

nanstd(celldatamutants.mth1ko.gp2percent.rep2);...%7
nanstd(meandatamutants.mth1ko.gp4percent);...%8
nanstd(celldatamutants.mth1ko.g1percent.rep2);...%9

nanstd(meandatamutants.std1ko.gp2percent);...%10
nanstd(meandatamutants.std1ko.gp4percent);...%11 one replicate screwed up
nanstd(meandatamutants.std1ko.g1percent);...%12

nanstd(meandatamutants.rgt2ko.gp2percent);...%13
nanstd(meandatamutants.rgt2ko.gp4percent);...%14
nanstd(meandatamutants.rgt2ko.g1percent)...%15

nanstd(meandatamutants.snf3ko.gp2percent);...%16
nanstd(meandatamutants.snf3ko.gp4percent);...%17 rep 1 screwed up. usng all cells from rep 2
nanstd(meandatamutants.snf3ko.g1percent)...%18
]'      
 allfitstdcurated=allfitstdcurated(1:230, :);
   
 
 
 %% plotting all means and stds
 figure;
 j=1;
 while(j<19)
 axes()
 errorbar(allfitmeans(:, j), allfitstd(:, j))
 hold on
 j=j+1;
 errorbar(allfitmeans(:, j), allfitstd(:, j))
 hold on
 j=j+1;
 errorbar(allfitmeans(:, j), allfitstd(:, j))
 j=j+1;
 end
 
 stackPlots(gcf)
 
 
%% plotting all curated means and stds
 figure;
 j=1;
 while(j<19)
 axes()
 errorbar(allfitmeanscurated(:, j), allfitstdcurated(:, j))
 hold on
 j=j+1;
 errorbar(allfitmeanscurated(:, j), allfitstdcurated(:, j))
 hold on
 j=j+1;
 errorbar(allfitmeanscurated(:, j), allfitstdcurated(:, j))
 j=j+1;
 end
 
 stackPlots(gcf)

 
 %% assigning this to argsim
 
 argsim.datameans=allfitmeans;
 argsim.datastd=allfitstd
 
 
 %% less extreme mth1 dynamics. simulates nicely
%more elegant parameter exploration
%%the order does not matter

colors= [0 0.8 0.8; 0 0 0.8; 0.6 0 0.8; 1 0 0.8 ; 1 0 1; 1 .3 1]
%these parameters nail the mth1 mig1 behaviour in model 6
%hxt2params=[2 0.0846749835348286 -0.22314355131421 3.91202300542815 -1.20397280432594 2.30258509299405 0.405465108108164 1.09861228866811 -0.693147180559945 -0.196063997334818 2.63905732961526 5 -2.30258509299405 -30 1.79175946922805 -2.30258509299405 0 -1.20397280432594 0.542301272315275 -1.20397280432594 2.07944154167984 -1.20397280432594 2.07944154167984 -1.20397280432594]
pars=[6.90775527898214 0.0846749835348286 0.182321556793955 1.38629436111989 -4.60517018598809 1.38629436111989 0 1.38629436111989 -0.510825623765991 1.38629436111989 -0.693147180559945 0 -2.99573227355399 3.91202300542815 1.09861228866811 -9.90348755253613 0 -3.91202300542815 0.542301272315275 0.405465108108164 1.09861228866811 -2.30258509299405 0 -1.20397280432594 -4.60517018598809 0 0.405465108108164 -1.6094379124341 1.38629436111989 -3.91202300542815 1.09861228866811 2.99573227355399 -2.81341071676004 0.693147180559945 2.30258509299405 -2.30258509299405 1.38629436111989]

%another great parameter set halfway through  fitting
%x2= [6.19460538677034 0.0840442222666614 0.223884965036362 1.48406941883146 -6.79260407602269 1.26881879528233 9.53414393259201e-05 0.139764784418576 -0.629999673120298 1.63928121415383 -0.57395899251726 4.89381211654727e-05 -2.6289796105351 3.8512663549067 1.32311749215374 -10.4028540890063 4.21325358675674e-05 -3.70597798624993 0.462034151298541 0.389801768965938 1.09227860101719 -2.2211121533226 7.54468953652202e-05 -1.89595574416551 -5.69151906161409 7.66776391846411e-05 0.189235578985574 -1.82182406937399 0.852146084457067 -5.00391749399678 1.08102715594993 2.56784039646063 -2.80827574906548 0.692499717314944 2.35061185602488 -2.55094443046266 1.24745898093997]
%best fit with fminsearch
%x3=[5.69977603358148 0.00737400364077265 -0.00310179574138284 0.96195652499263 -46.3744877198008 2.02183093944658 0.000211166459050653 0.031466074095644 -1.19536180637941 2.1993994083106 0.382311677865286 -2.54754959930244e-05 -2.70806678413365 4.56143037825386 2.80171353126036 -13.0694256737462 3.041782426147e-05 -3.40569598966275 0.620182774614385 0.63370838620798 0.990691105941922 0.821660639865267 4.58217797093428e-05 -5.03990931368742 4.21549381794271 0.000200952430395122 0.314816826498802 -1.82050242783446 0.695374538961804 -5.76422421114369 0.996188827786578 2.60290111517963 -5.13848522225288 -0.510024940681224 3.8655740703855 -0.684204330250501 0.0929390206015533]
%improved fit number 4 around 2600
x4=[5.44021515377106 -0.00522780112420143 -0.0109769726835313 0.749074278983391 -89.2204659363555 1.97586265440003 -0.000552011341513585 -0.143242278753373 -1.88325360480544 8.18691236047051 -0.102027033080852 1.59566837284967e-05 -2.02624395222345 4.97197600353273 2.92049534340058 -12.0408490442458 6.23915215296202e-05 -3.1981462396431 0.877055709483668 0.607705239036948 1.18370965804949 -0.314865983095324 -3.81535399007739e-05 -10.0902745079967 13.6373723494056 0.000544080536937752 0.392011956308334 -1.99549831626291 1.11792460884164 -5.61023262695599 1.17423425512609 3.01824504014555 -9.9348729960309 -1.86083029593126 3.93369643949185 -0.504768573729779 0.463817437372617]


%these params are a fairly ok starting point for hxt4 in model 8, KinhSMG
%is a bit off
%pars=[6 0.0846749835348286 1.09861228866811 0.693147180559945 -4.60517018598809 0 0 1.09861228866811 -0.22314355131421 0 0 0 -2.30258509299405 -40 1.09861228866811 -5.80914299031403 0 -2.30258509299405 0.542301272315275 1.38629436111989 0 -2.30258509299405 0 -1.20397280432594 -2.30258509299405 1.38629436111989 -1.20397280432594 -0.994252273343867 1.09861228866811 -0.393042588109607 1.38629436111989 -40]

gene='hxt4';
model='mechModel10';
mf=extractModelFeatures(model);
%we take a parameter list
ps=paramstruct('mechModel8', pars); 
%tempars= defaultparams('mechModel7', ps);
%argsim.outvar=7;
%figure; plotsim('hxt2', argsim, tempars)
c=1;
glu=  [.2, .4, 1];   %concentrations %[0 20]%ramp lengths 
for j=1:3
synthglucose=[zeros(1, 38) ones(1, 137-38+1), zeros(1, 92)]*glu(j); %artificial

totallength=230;
rampsection=[zeros(1, 38) ones(1, 50) linspace(1, 0, glu(j))];
synramp= [rampsection zeros(1, totallength-numel(rampsection))]; 
argsim.input=synthglucose; %artificial
argsim.initialconditions= [ argsim.datastart   1         0    9.1621         0    1.0000         0 0]

%glu(j)cose signal
%argsim.input=glu(j)cose*glu(j);
data=argsim.meandata.(gene).g1percent;
argsim.data=data;
argsim.datastart=nanmean(data(:,1));
%mth1 contro parameters
ps.KdegMT= log(.01); %default .01. make 0.5 for snf3 deletion
ps.maxdegMT= log(4); 
ps.hilldegMT= log(4); 
ps.basaldegMT= log(1); 

%std1 control parameters
ps.maxdegST=log(4);
ps.KdegST=log(.5);
ps.hilldegST=log(1);
ps.basaldegST=log(.05);%0.05 seems ok
ps.KrepMTST=log(.6); 
ps.hillrepMTST=log(4); 

%mig1 control parameters
ps.KMG=log(0.1);
ps.deloc=log(3);
ps.hillMG=log(1);
ps.KinhSMG=log(50); %best compromise value for mechmodel9 is 30

%mig2 control parameters
ps.KrepSTM2=log(.2); %traditional value is 0.2
ps.hillrepSTM2=log(4);
ps.KinhSM2=log(20); %BEST PARAMS ET HAD 20
ps.basaldegM2=log(1.5); %BEST PAR 1.5
ps.VinactGM2= log(10);
ps.KinactGM2=  log(.1);
ps.hillinactGM2= log(4);
%hxt control parameters

ps.VHXT=log(1000); %default value 3
ps.basaldeg= log(1.2);%1 starting to look decent. trying lower

ps.KrepHMT=log(.02); 
ps.hillrepHMT=log(1); 
ps.KrepHM2=log(.02); %best param set had .035  %0.014 and hill 3 do a good job for model 8. 
ps.hillrepHM2=log(3);
ps.KrepHMG=log(0.00005);%% %%.00025 good for model 8 and 9 where mig1 represses mig1. .00025 good perhaps too strong good .00015 but renders mig2 obsolete default 0.003
ps.hillrepHMG=log(1);
ps.VdegHXT=log(.3);
ps.threshdegHXT=log(.01);
ps.hilldegHXT=log(1);

ps.hillrepHST=log(3);
ps.KrepHST=log(1.5); %needed at around 1.5 to level out rgt2 and mth1 miutants

ps.KrepM2MT=log(.06); %.04 is good for model .04
ps.hillrepM2MT=log(2);


pars= defaultparams(model, ps);
%pars=x2; %temporary susbtitution
argsim.onlyparams= 1:numel(mf.paramNames);
argsim.model=model;
argsim.outvar=7;
%argsim.initialconditions=[]; %giving plotsim prioirity to assign initial conditions
if c==1
    figure;
ax1=axes()
logtime=datestr(datetime);
else
    hold on; axes(ax1);

end
[locpar, ya]=plotsim(gene, argsim, pars);
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
    set(f(1), 'Color', colors(j, :)  );
argsim.outvar=2;
if c==1
ax2=axes()
else
   hold on;  axes(ax2);

end


[locpar, ya]=plotsim(gene, argsim, pars);
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
     set(f(1), 'Color', colors(j, :)  );
argsim.outvar=3;
if c==1
ax3=axes()
else
    hold on; axes(ax3);

end
[locpar, ya]=plotsim(gene, argsim, pars);
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
     set(f(1), 'Color', colors(j, :)  );
text(1, 5, 'mig1')
if strcmp(model, 'mechModel8') || strcmp(model, 'mechModel9')|| strcmp(model, 'mechModel10')
    
argsim.outvar=8;
if c==1
ax4=axes()
else
    hold on; axes(ax4);

end
[locpar, ya]=plotsim(gene, argsim, pars);
        f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
     set(f(1), 'Color', colors(j, :)  );
text(1, 5, 'mig2')
end

argsim.outvar=1;
if c==1
ax5=axes()
else
   hold on;  axes(ax5);

end
[locpar, ya]=plotsim(gene, argsim, pars);
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
     set(f(1), 'Color', colors(j, :)  );
    
    

    
uniformAxes(gcf, [], [0,20], [],[], [] )
stackPlots(gcf)
uniformAxes(gcf, [], [0,20], [],[.8], [.2] )

    if c==1
        figure; 
    end
    
    %%%%%%%%mutants
    
    %simulating and plotting mutants
savedp=ps; %parameters from free testing that have been previously saved
%WT

if c==1
axWT=axes()

else
   hold on;  axes(axWT);

end
ind=1+c-1;
[locpar, ya]=plotsim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
     set(f(1), 'Color', colors(j, :)  );
    title(['WT' logtime])   
%mig1
ps.KrepHMG=log(1000); % Mig1 loses the ability to bind
pars= defaultparams(model, ps);

if c==1
axMG=axes()
else
   hold on;  axes(axMG);

end
ind=4+c-1;
[locpar, ya]=plotsim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);

         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
     set(f(1), 'Color', colors(j, :)  );
    title('mig1?') 
  ps=savedp;  
%mth1
ps.KrepHMT=log(1000); % MTH1 loses the ability to bind HXT
ps.KrepSTM2=log(1000); % MTH1 loses the ability to bind MIG2
ps.KrepMTST=log(1000); % MTH1 loses the ability to bind STD1
%changing initial conditions of MTH1 (number 2)  to 0
argsim.initialconditions= [argsim.mth1ko(1)   0         0    9.1621         0    1.0000         0 0]
pars= defaultparams(model, ps);

if c==1
axMT=axes();
else
   hold on;  axes(axMT);

end
ind=7+c-1;
[locpar, ya]=plotsim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
     set(f(1), 'Color', colors(j, :)  );
    title('mth1?') 
  ps=savedp;  
 % changing back the initial conditions
argsim.initialconditions= [ argsim.datastart   1         0    9.1621         0    1.0000         0 0]

  
  
 %rgt2
 ps.KdegST=log(10); % Std1 can no longer be degraded
pars= defaultparams(model, ps);

if c==1
axR=axes()
else
   hold on;  axes(axR);

end
ind=13+c-1;
[locpar, ya]=plotsim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);   
     set(f(1), 'Color', colors(j, :)  );
    title('rgt2?') 
ps=savedp; 
 %std1
 
  ps.KinhSMG=-40; % Std1 can no longer be degraded
  ps.KinhSM2=-40;
  ps.KrepST=log(1000);
pars= defaultparams(model, ps);
if c==1
axST=axes()
else
   hold on;  axes(axST);

end
ind=10+c-1;
[locpar, ya]=plotsim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);  
     set(f(1), 'Color', colors(j, :)  );
    title('std1?') 
ps=savedp;     
%snf3
 
  ps.KdegMT=log(.3); % Mth1 gets degraded at a higher threshold

pars= defaultparams(model, ps);
if c==1
axSN=axes()
else
   hold on;  axes(axSN);

end
ind=16+c-1;
[locpar, ya]=plotsim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);
         f=get(gca, 'children');
    set(f(1), 'DisplayName', [num2str(glu(j)) '%']);  
     set(f(1), 'Color', colors(j, :)  );
    title('snf3?') 
ps=savedp;     



stackPlots(gcf)    
uniformAxes(gcf, [], [0,20], [],[.8], [.12] )    
    


c=c+1;

end

     
        disp('plotting sugar')
        allaxes=get(gcf, 'children')
        for j=1:numel(allaxes)
      
            axes(allaxes(j))
            yyaxis right
        area( t, argsim.input, 'FaceAlpha', 0.1, 'FaceColor', [1, .6, 0], 'EdgeColor', 'none'); 
        yyaxis left
        
        end
       
        

        
dispnames={'WT 0.2%',...
'WT 0.4%',...
'WT 1%',...
'mig1ko 0.2%',...
'mig1ko 0.4%',...
'mig1ko 1%',...
'mth1ko 0.2%',...
'mth1ko 0.4%',...
'mth1ko 1%',...
'std1ko 0.2%',...
'std1ko 0.4%',...
'std1ko 1%',...
'rgt2ko 0.2%',...
'rgt2ko 0.4%',...
'rgt2ko 1%',...
'snf3ko 0.2%',...
'snf3ko 0.4%',...
'snf3ko 1%'}

  newline=defaultparams(model, savedp);      
 
fprintf(fopen([model '_paramhistory.txt'], 'a'), [logtime newline])
fprintf(fopen([model '_paramhistory.txt'], 'a'), [mat2str(defaultparams(model, savedp)) newline])
fprintf(fopen([model '_input.txt'], 'w'),'%3.3f %3.3f\n', [times(1:230)',  argsim.input']')
counter=counter+1;

%% rearranging figures in final figure order
%WT
axes(axWT)
uniformAxes
%RGT2

%% exploring changes in one parameter

%%
%these parameters nail the mth1 mig1 behaviour
hxt2params=[2 0.0846749835348286 -0.22314355131421 3.91202300542815 -1.20397280432594 2.30258509299405 0.405465108108164 1.09861228866811 -0.693147180559945 -0.196063997334818 2.63905732961526 5 -2.30258509299405 -30 1.79175946922805 -2.30258509299405 0 -1.20397280432594 0.542301272315275 -1.20397280432594 2.07944154167984 -1.20397280432594 2.07944154167984 -1.20397280432594]
gene='hxt4';
model='mechModel8';
mf=extractModelFeatures(model);
%we take a parameter list
ps=paramstruct('mechModel6', hxt2params); 
%tempars= defaultparams('mechModel7', ps);
%argsim.outvar=7;
%figure; plotsim('hxt2', argsim, tempars)
c=1;
glu=[.2, .4, 1, 2];
figure;
j=3; %concentration to show
numvals=30
vals=linspace(-10,2,numvals);
varpar='KrepHM2';
for q=1:numvals
argsim.input=[zeros(1, 38) ones(1, 137-38+1), zeros(1, 92)]*glu(j); %artificial
%glu(j)cose signal
%argsim.input=glu(j)cose*glu(j);
data=argsim.meandata.(gene).g1percent;
argsim.data=data;
argsim.datastart=nanmean(data(:,1));
%mth1 contro parameters
ps=pssaved;
% ps.KdegMT= log(.01); 
% ps.maxdegMT= log(2); 
% ps.hilldegMT= log(1); 
% ps.basaldegMT= log(1); 
% 
% 
% 
% %std1 control parameters
% ps.maxdegST=log(1);
% ps.KdegST=log(.5);
% ps.hilldegST=log(1);
% ps.basaldegST=log(.5);
% ps.KrepMTST=log(.8); 
% ps.hillrepMTST=log(1); 
% 
% %mig1 control parameters
% ps.KMG=log(0.1);
% ps.deloc=log(3);
% ps.hillMG=log(8);
% ps.KinhSMG=log(2);
% 
% %mig2 control parameters
% ps.KrepSTM2=log(.37);
% ps.KinhSM2=log(.5);
% ps.hillrepSTM2=log(3);
% ps.basaldegM2=log(.3);
% 
% %hxt control parameters
% ps.KrepHMT=log(.1); 
% ps.hillrepHMT=log(1); 
% ps.KrepHM2=log(.5);
% ps.hillrepHM2=log(4);
% ps.KrepHMG=log(0.003); % default 0.003
% ps.hillrepHMG=log(1);
% ps.threshdegHXT=log(.1);
% ps.hilldegHXT=log(4);
% 
% ps.hillrepHST=log(2);
% ps.KrepHST=log(100); % 4 is pretty good
% 
% ps.VHXT=3; %default value
% ps.basaldeg= log(.5);%1 starting to look decent. trying lower

%modifying the variable parameter
ps.(varpar)= vals(q);

pars= defaultparams(model, ps);
argsim.onlyparams= 1:numel(mf.paramNames);
argsim.model=model;
argsim.outvar=7;
argsim.initialconditions=[]; %giving plotsim prioirity to assign initial conditions

%uncomment to plot regulators
% if c==1
%     figure;
% ax1=axes()
% else
%     hold on; axes(ax1);
% 
% end
% plotsim(gene, argsim, pars)
%         f=get(gca, 'children');
%     set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
% 
% argsim.outvar=2;
% if c==1
% ax2=axes()
% else
%    hold on;  axes(ax2);
% 
% end
% 
% plotsim(gene, argsim, pars)
%         f=get(gca, 'children');
%     set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
% argsim.outvar=3;
% if c==1
% ax3=axes()
% else
%     hold on; axes(ax3);
% 
% end
% plotsim(gene, argsim, pars)
%         f=get(gca, 'children');
%     set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
% text(1, 5, 'mig1')
% if strcmp(model, 'mechModel8')
%     
% argsim.outvar=8;
% if c==1
% ax4=axes()
% else
%     hold on; axes(ax4);
% 
% end
% plotsim(gene, argsim, pars)
%         f=get(gca, 'children');
%     set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
% text(1, 5, 'mig2')
% end

argsim.outvar=1;
if c==1
ax5=axes()
else
   hold on;  axes(ax5);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', num2str(exp(vals(q))) );
    
    

%     
% uniformAxes(gcf, [], [0,20], [],[], [] )
% stackPlots(gcf)
% uniformAxes(gcf, [], [0,20], [],[.8], [.2] )
% 
%     if c==1
%         figure; 
%     end
%     
%     %%%%%%%%mutants
%     
%     %simulating and plotting mutants
savedp=ps; %above params saved

%mig1
ps.KrepHMG=log(1000); % Mig1 loses the ability to bind
pars= defaultparams(model, ps);

if c==1
axMG=axes()
else
   hold on;  axes(axMG);

end
plotsim(gene, argsim, pars)
         f=get(gca, 'children');
    set(f(1), 'DisplayName', num2str(exp(vals(q))));
    title('mig1?') 
%   ps=savedp;  
% %mth1
% ps.KrepHMT=log(1000); % MTH1 loses the ability to bind HXT
% ps.KrepSTM2=log(1000); % MTH1 loses the ability to bind MIG2
% ps.KrepMTST=log(1000); % MTH1 loses the ability to bind STD1
% %changing initial conditions of MTH1 (number 2)  to 0
% argsim.initialconditions= [argsim.datastart   0         0    9.1621         0    1.0000         0 0]
% pars= defaultparams(model, ps);
% 
% if c==1
% axMT=axes()
% else
%    hold on;  axes(axMT);
% 
% end
% plotsim(gene, argsim, pars)
%          f=get(gca, 'children');
%     set(f(1), 'DisplayName', [num2str(glu(j)) '%']);
%     title('mth1?') 
%   ps=savedp;  
%  % changing back the initial conditions
% argsim.initialconditions= [argsim.datastart    1         0    9.1621         0    1.0000         0 0]
% 
%   
%   
%  %rgt2
%  ps.KdegST=log(1000); % Std1 can no longer be degraded
% pars= defaultparams(model, ps);
% 
% if c==1
% axR=axes()
% else
%    hold on;  axes(axR);
% 
% end
% plotsim(gene, argsim, pars)
%          f=get(gca, 'children');
%     set(f(1), 'DisplayName', [num2str(glu(j)) '%']);   
%     title('rgt2?') 
% ps=savedp; 
%  %std1
%  
%   ps.KinhSMG=-40; % Std1 can no longer be degraded
%   ps.KinhSM2=-40;
%   ps.KrepST=log(1000);
% pars= defaultparams(model, ps);
% if c==1
% axST=axes()
% else
%    hold on;  axes(axST);
% 
% end
% plotsim(gene, argsim, pars)
%          f=get(gca, 'children');
%     set(f(1), 'DisplayName', [num2str(glu(j)) '%']);  
%     title('std1?') 
% ps=savedp;     
%     
%   
uniformAxes(gcf, [], [0,20], [],[.8], [.2] )    
    


c=c+1;
end
stackPlots(gcf)  

