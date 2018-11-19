%% 
%checking model 1
for j=1:7
m=1
mf=extractModelFeatures(models{m})
RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
Lterms=RS./ dvar';
chisq= sum(Lterms);
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic1= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
figure; plot(d.(genes{j}));hold on;
plot(y.(genes{j}).(models{m}), 'DisplayName', [genes{j} ' ' models{m}])
%checking model 2



m=2
mf=extractModelFeatures(models{m})
RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
Lterms=RS./ dvar';
chisq= sum(Lterms);
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic2= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
plot(y.(genes{j}).(models{m}) , 'DisplayName', [genes{j} ' ' models{m}]);hold on;



%checking model 3

m=3
mf=extractModelFeatures(models{m})
RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
Lterms=RS./ dvar';
chisq= sum(Lterms);
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic3= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
plot(y.(genes{j}).(models{m}), 'DisplayName', [genes{j} ' ' models{m}] );hold on;

%checking model 4

m=4
mf=extractModelFeatures(models{m})
RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
Lterms=RS./ dvar';
chisq= sum(Lterms);
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic4= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
plot(y.(genes{j}).(models{m}), 'DisplayName', [genes{j} ' ' models{m}] );hold on;

%checking model 5

m=5
mf=extractModelFeatures(models{m})
RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
Lterms=RS./ dvar';
chisq= sum(Lterms);
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic5= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
plot(y.(genes{j}).(models{m}) , 'DisplayName', [genes{j} ' ' models{m}]);hold on;

%checking model 6

m=6
mf=extractModelFeatures(models{m})
RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
Lterms=RS./ dvar';
chisq= sum(Lterms);
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic6= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
plot(y.(genes{j}).(models{m}) , 'DisplayName', [genes{j} ' ' models{m}]);hold on;
%checking model 7

m=7
mf=extractModelFeatures(models{m})
RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
Lterms=RS./ dvar';
chisq= sum(Lterms);
%Now for the BIC we  add the chi square with numparams *log(number of datapoints)
testbic7= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
plot(y.(genes{j}).(models{m}), 'DisplayName', [genes{j} ' ' models{m}] );hold on;


allbics(j,:)=[testbic1, testbic2, testbic3, testbic4, testbic5, testbic6, testbic7]

end

%%
 hxts={'Hxt1', 'Hxt2', 'hxt3', 'Hxt4', 'hxt5', 'Hxt6', 'Hxt7'}
selectedmodels=[1,6,7];
figure; bar(allbics(:, selectedmodels));
linspecs={'^-',    's-',    'o-',    '-+' ,   '-*',    '-x',    '-d',    'r:'}
lls=linspecs(selectedmodels)
l=get(gca, 'Legend');
set(l, 'visible', 'on')
set(l, 'String', s)
set(gca, 'XTickLabels', hxts)
set(gca, 'Yscale', 'log')
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