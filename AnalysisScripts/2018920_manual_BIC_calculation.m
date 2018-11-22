%% filling missing values in cell data
celldata2=struct;

for j=1:7
%disp('gene change')
    repnames=fieldnames(celldata.(genes{j}).g1percent);
    
    for r= 1: numel(repnames)
        
        %disp('rep change')
        mat=[];
    for row= 1: size(celldata.(genes{j}).g1percent.(repnames{r}), 1)
    tmp=celldata.(genes{j}).g1percent.(repnames{r});
    %disp(['row' num2str(row)])
    mat(row, :)=fillmissing(tmp(row, :), 'linear');
    end
    celldata2.(genes{j}).g1percent.(repnames{r})=mat;
    end
end
figure; plot(celldata2.hxt1.g1percent.rep2')

%% calculating BICs, one per replicate

%% 
allbicsmean=[];
allbicsstd=[];
%checking model 1
 figure; 
 linspecs={'k^-',    'ks-',    'ko-',    'k-+' ,   'k-*',    'k-x',    'k-d',   }

bictree=struct;
d=struct;
for j=1:7
   axes();
for m=1:numel(models)
mf=extractModelFeatures(models{m});
genereps= 1:numel(fieldnames(celldata.(genes{j}).g1percent));
%genereps=[2,3]; %hxt1 reps without problems
bictree.(genes{j}).(models{m})=[];

tempmat=[];
tempbic=[];
for r= genereps
    data=celldata.(genes{j}).g1percent.(['rep' num2str(r)]);
    tempmat(r, :)=fillmissing(nanmean(data), 'linear');
    
    plot(tims, tempmat(r, :), 'ro', 'markersize', 5);hold on;
    dvar= nanvar(data);
    sz=numel(y.(genes{j}).(models{m}));
RS= (tempmat(r, 1:sz)- y.(genes{j}).(models{m})').^2;
Lterms=RS./ dvar(1:sz);
valid=isfinite(Lterms) & ~isnan(Lterms);
totvalid=sum(isfinite(Lterms) & ~isnan(Lterms));
chisq= nansum(Lterms(valid));
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic1= chisq + numel(mf.paramNames)* log(totvalid);
tempbic(r)=testbic1;
%bictree.(genes{j}).(models{m})=[bictree.genes{j} testbic1];
end
bictree.(genes{j}).(models{m})=tempbic;
 d.(genes{j})=tempmat;

allbicsmean(j, m)=nanmean(bictree.(genes{j}).(models{m}));
allbicsstd(j, m)=nanstd(bictree.(genes{j}).(models{m}));


end
for o=1:numel(models)
plot(t, ylocal.(genes{j}).(models{o}),linspecs{o}, 'DisplayName', [genes{j} ' ' models{o}], 'MarkerIndices', randi(30,1):15:250, 'markersize', 8, 'linewidth', 1.5)
end

end
        
  stackPlots(gcf) 
  uniformAxes(gcf, [], [], [],[.5], [.115] )
  uniformAxPosition(gcf, [],.1, []) 

hxts={'Hxt1', 'Hxt2', 'hxt3', 'Hxt4', 'hxt5', 'Hxt6', 'Hxt7'}  
barax= axes('Position', [.65, .4, .35, .5])
barhandle=barwitherr(allbicsstd, allbicsmean); set(gca, 'Yscale', 'log')
set(gca, 'XTickLabels', hxts)



%% test block

j=2; 
m=1;
r=1;
randx=randn(1, 6); 
data=celldata.(genes{j}).g1percent.(['rep' num2str(r)]);
argsim.data=data;
tmp=cy5tree.(genes{j})
argsim.input= tmp(r, :)
simulator=makesimulator(models{m}, argsim); 
pars =fminsearch(simulator, randn(1, 6), argsim.opts2);
[l, t, ylocal.(genes{j}).(models{m})]= simulator(pars);
plot(t, ylocal.(genes{j}).(models{m}),linspecs{m}, 'DisplayName', [genes{j} ' ' models{m}], 'MarkerIndices', randi(30,1):15:250, 'markersize', 8, 'linewidth', 1.5); hold on
 
%% attempting to refit models on individual datasets to obtain individual BICs
%checking model 1
 figure; 
 linspecs={'k^-',    'ks-',    'ko-',    'k-+' ,   'k-*',    'k-x',    'k-d',   }

bictree=struct;
d=struct;
for j=1:7
   axes();
for m=1:numel(models)
mf=extractModelFeatures(models{m});
genereps= 1:numel(fieldnames(celldata.(genes{j}).g1percent));
%genereps=[2,3]; %hxt1 reps without problems
bictree.(genes{j}).(models{m})=[];

tempmat=[];
tempbic=[];
for r= genereps
    data=celldata.(genes{j}).g1percent.(['rep' num2str(r)]);
    tempmat(r, :)=fillmissing(nanmean(data), 'linear');
    
    plot(tims, tempmat(r, :), 'ro', 'markersize', 5);hold on;
    dvar= nanvar(data);
    %sz=numel(y.(genes{j}).(models{m}));
    tmp=cy5tree.(genes{j})
    argsim.input= tmp(r, :)
    argsim.data=data;
    simulator=makesimulator(models{m}, argsim);
    
    %x2=fitparamsOpt2.(genes{j}).(models{m}).fminsearch;
   % fitparamsOptRep.(genes{j}).(models{m}).(['rep' num2str(r)]) =fminsearch(simulator, x2, argsim.opts2)
    x=fitparamsOptRep.(genes{j}).(models{m}).(['rep' num2str(r)]);
    [l, t, ylocal.(genes{j}).(models{m})]= simulator(x);
    sz=numel(ylocal.(genes{j}).(models{m}));
    RS= (tempmat(r, 1:sz)- ylocal.(genes{j}).(models{m})').^2;
    Lterms=RS./ dvar(1:sz);
    valid=isfinite(Lterms) & ~isnan(Lterms);
    totvalid=sum(isfinite(Lterms) & ~isnan(Lterms));
    chisq= nansum(Lterms(valid));
    %Now for the BIC we  add the chi square with numparams *log(number of datapoints)
    testbic1= chisq + numel(mf.paramNames)* log(totvalid);
    tempbic(r)=testbic1;
    %bictree.(genes{j}).(models{m})=[bictree.genes{j} testbic1];
end
bictree.(genes{j}).(models{m})=tempbic;
 d.(genes{j})=tempmat;

allbicsmean(j, m)=nanmean(bictree.(genes{j}).(models{m}));
allbicsstd(j, m)=nanstd(bictree.(genes{j}).(models{m}));


end
for o=1:numel(models)
plot(t, ylocal.(genes{j}).(models{o}),linspecs{o}, 'DisplayName', [genes{j} ' ' models{o}], 'MarkerIndices', randi(30,1):15:250, 'markersize', 8, 'linewidth', 1.5); hold on
end

end
        
  stackPlots(gcf) 
  uniformAxes(gcf, [], [], [],[.5], [.115] )
  uniformAxPosition(gcf, [],.05, []) 

hxts={'Hxt1', 'Hxt2', 'hxt3', 'Hxt4', 'hxt5', 'Hxt6', 'Hxt7'}  
barax= axes('Position', [.68, .35, .35, .5])
barhandle=barwitherr(allbicsstd, allbicsmean); set(gca, 'Yscale', 'log')
set(gca, 'XTickLabels', hxts)
ylabel('BIC')



%%
 hxts={'Hxt1', 'Hxt2', 'hxt3', 'Hxt4', 'hxt5', 'Hxt6', 'Hxt7'}
s= {' Gluc activation',    '1+ gluc. induced degradation' ,   '1+ gluc. repressed degradation' ,   'gluc activation  + hill gluc repression ',  'hill gluc activation + Mig1 induced repression', ' activation+  repression', 'activation+ repression+ \newline gluc repressed degradation'};

figure; [barout1, barout2]= barwitherr(allbicsstd, allbicsmean)
 selectedmodels=[1,6,7];
linspecs={'^-',    's-',    'o-',    '-+' ,   '-*',    '-x',    '-d',    'r:'}
lls=linspecs(selectedmodels)
l=get(gca, 'Legend');
set(l, 'visible', 'on')
set(l, 'String', s(selectedmodels))
set(gca, 'XTickLabels', hxts)
set(gca, 'Yscale', 'log')
save2pdf('/Users/s1259407/Google Drive/0AFigures/paper/supportingMaterial/20181116_BICscores_with_errorbars.pdf')

%%
%get indices of best models in b
[a,b]=nanmin(allbics(:, selectedmodels),[], 2);
figure; 

for j= [1 4 7] %number of hxts
    
  l=1:numel(y.(genes{j}).(models{selectedmodels(b(j))}))
  plot(tims(l)', y.(genes{j}).(models{selectedmodels(b(j))}), lls{b(j)}, 'LineWidth', 1.5, 'DisplayName', [genes{j} ' ' models{selectedmodels(b(j))}], 'Color', straincolors(j, :),  'MarkerIndices', 1:10:250);hold on;
  a=get(gca, 'children')
%
  plot(tims(l)', d.(genes{j}), 'o', 'LineWidth', 1.5,'MarkerSize', 3, 'DisplayName', [genes{j} 'data'], 'Color', straincolors(j, :) );hold on;
  
  
end


%figure; bar( allbics)       