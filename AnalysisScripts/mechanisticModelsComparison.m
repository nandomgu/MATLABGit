%% from the same parameter sets, evaluate all these models



%%mig2 represses mth1
refparams=x1hybrid(end, :);
numpars=1000;
parmat= repmat(refparams, numpars, 1)+ rand(numpars, 37)*2-1;
parmat= [refparams; parmat];
paramsetname='x1hybrid';
modelcosts= zeros(size(parmat,1), 7);
%% 
for q=1:size(parmat,1)
modelnames={};
modell='mechModelX';
j=1;
modelnames{j}= modell;j=j+1;
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 1)= simulator(parmat(q, :));
%%mig1 represses mth1

modell='mechModelX1';
modelnames{j}= modell;j=j+1;
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 2)= simulator(parmat(q, :));
%%mth1 is not repressed by anyone

modell='mechModelX2';
modelnames{j}= modell;j=j+1;
argsim.onlyparams= [1:32 35:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 3)= simulator(parmat(q, :));
%%Std1 only inhibits Mig1. KinhSM2 inactive

modell='mechModelX3';
modelnames{j}= modell;j=j+1;
argsim.onlyparams= [1:31 33:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 4)= simulator(parmat(q, :));
%%Std1 only inhibits Mig2. KinhSM1 inactive

modell='mechModelX4';
modelnames{j}= modell;j=j+1;
argsim.onlyparams= [1:13 15:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 5)= simulator(parmat(q, :));

%%Std1 does not inhibit any migs

modell='mechModelX5';
modelnames{j}= modell;j=j+1;
argsim.onlyparams= [1:13 15:31  33:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 6)= simulator(parmat(q, :));
%%Std1 is not a repressor

modell='mechModelX6';
modelnames{j}= modell;j=j+1;
argsim.onlyparams= [1:19  22:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 7)= simulator(parmat(q, :));


fprintf(fopen('trialparams_laptop.txt', 'a'),[repmat('%3.3f', 1, size(parmat,2)) '\n'], parmat(q, :));  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         

fprintf(fopen('mechmodelcosts_laptop.txt', 'a'),[repmat('%3.3f', 1, size(modelcosts,2)) '\n'], modelcosts(q, :));  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         
%dlmwrite(fopen('mechmodelcosts.txt', 'a'), modelcosts(q, :), '\t');         


end
%% 

 figure; bar(struct2array(costs));
 set(gca, 'YScale', 'log')
 set(gca, 'XTickLabels', modelnames)
 title(paramsetname)
 

