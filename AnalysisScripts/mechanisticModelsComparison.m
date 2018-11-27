%% from the same parameter sets, evaluate all these models



%%mig2 represses mth1
refparams=x1hybrid(end, :);
numpars=1000;
parmat= repmat(refparams, numpars, 1)+ rand(numpars, 37)*2-1;
parmat= [refparams; parmat];
paramsetname='x1hybrid';
modelcosts= zeros(size(parmat,1), 7);
paramsfile=fopen('trialparams_laptop.txt', 'a');
costsfile=fopen('mechmodelcosts_laptop.txt', 'a');
modelnames={'mechModelX', 'mechModelX1','mechModelX2','mechModelX3','mechModelX4','mechModelX5','mechModelX6','mechModelX7'}
fprintf(paramsfile,['param_names' '\t' repmat(' %s\t', 1, size(parmat,2))], mf.paramNames{:});  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         
fprintf(costsfile,[ 'modelnames\t' repmat('%s\t', 1, numel(modelnames))], modelnames{:});  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         
inits=argsim.initialconditions;
%fclose(paramsfile)
letters = num2cell('a':'z');
numbers = string(1:9)

%% 
for q=1:size(parmat,1)
    id=strjoin(randsample([letters numbers], 6), '')

modell='mechModelX';
j=1;
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 1)= simulator(parmat(q, :));
%%mig1 represses mth1

modell='mechModelX1';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 2)= simulator(parmat(q, :));
%%mth1 is not repressed by anyone

modell='mechModelX2';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:32 35:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 3)= simulator(parmat(q, :));
%%Std1 only inhibits Mig1. KinhSM2 inactive

modell='mechModelX3';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:31 33:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 4)= simulator(parmat(q, :));
%%Std1 only inhibits Mig2. KinhSM1 inactive

modell='mechModelX4';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:13 15:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 5)= simulator(parmat(q, :));

%%Std1 does not inhibit any migs

modell='mechModelX5';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:13 15:31  33:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 6)= simulator(parmat(q, :));
%%Std1 is not a repressor

modell='mechModelX6';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:19  22:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 7)= simulator(parmat(q, :));

modell='mechModelX7';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:8  11:37];
argsim.initialconditions(7)=1;
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 8)= simulator(parmat(q, :));
argsim.initialconditions=inits;
%for q=1:size(parmat, 1)
fprintf(paramsfile,['\n' 'paramset_%s' '\t' repmat(' %3.3f\t', 1, size(parmat,2))], id, parmat(q, :));  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         
% if q==1
% fprintf(costsfile,[ 'modelnames\t' repmat('%s\t', 1, numel(modelnames))], modelnames{:});  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         
% end
fprintf(costsfile,['\n' 'paramset_%s' '\t' repmat('%3.3f\t', 1, size(modelcosts,2))], id, modelcosts(q, :));  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         

% if mod(q, 10)==0
%    save('/Users/s1259407/Documents/MATLABGIT/mechanisticModelWorkspace.mat')  
%     
% end

end
%dlmwrite(fopen('mechmodelcosts.txt', 'a'), modelcosts(q, :), '\t');         
fclose all;

end
%% 




 figure; bar(struct2array(costs));
 set(gca, 'YScale', 'log')
 set(gca, 'XTickLabels', modelnames)
 title(paramsetname)
 
 
 
%% rerunning all mechmodelX6 and mechModelX7 . last q=    
for q=359:382
    
modell='mechModelX6';
argsim.onlyparams= [1:19  22:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 7)= simulator(parmat(q, :));


modell='mechModelX7';
if q==1
modelnames{j}= modell;j=j+1;
end
argsim.onlyparams= [1:8  11:37];
argsim.initialconditions(7)=1;
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
modelcosts(q, 8)= simulator(parmat(q, :));
argsim.initialconditions=inits;

end


%%
modell='mechModelX1';
modelopt=struct;
modelmatrix=[];
argsim.opts2.MaxIter=100;
simulator=makesimulatorX(modell, argsim);
v=find(modelcosts(:,find(strcmp(modelnames, modell)))>0);  [a,b]= sort(modelcosts(v, 2)); x2=parmat(b(2), :)


for j=1:50
try
if j==1
modelmatrix(j,:)=fminsearch(simulator, x2, argsim.opts2);
else
modelmatrix(j,:)=fminsearch(simulator,x1hybrid(j-1, :), argsim.opts2);
end
catch
modelmatrix(j,:)=fminsearch(simulator, pars+randn(1, numel(argsim.mf.paramNames))*.1, argsim.opts2);
end

modelopt.(modell)=modelmatrix;
save(strjoin({'/Users/s1259407/Documents/MATLABGIT/modelmatrix_', modell ,'.mat'}, ''),  'modelmatrix');
end





