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
concolors=[0 0.8 .8; 0 0 .8; 0.6 0 0.6 ];
for q=1:size(parmat,1)
    id=strjoin(randsample([letters numbers], 6), '')
plotargs=struct;
plotargs.input=argsim.input;
plotargs.lw=1.5;
plotargs.concolors=concolors;
modell='mechModelX';
plotargs.modelname=modell;
j=1;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 1), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);
%%mig1 represses mth1

modell='mechModelX1';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 2), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);
%%mth1 is not repressed by anyone

modell='mechModelX2';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:32 35:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 3), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);
%%Std1 only inhibits Mig1. KinhSM2 inactive

modell='mechModelX3';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:31 33:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 4), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);

%%Std1 only inhibits Mig2. KinhSM1 inactive

modell='mechModelX4';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:13 15:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 5), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);
%%Std1 does not inhibit any migs

modell='mechModelX5';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:13 15:31  33:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 6), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);
%%Std1 is not a repressor

modell='mechModelX6';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:19  22:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 7), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);

%Std1 is not repressed by Mth1
modell='mechModelX7';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:8  11:37];
argsim.initialconditions(7)=1;
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 8), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);
argsim.initialconditions=inits;

%No rep over Mth1. Std1 inhibits Mig1
modell='mechModelX8';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:13 15:32 35:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 9), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);


%no mth1 repression, std1 does not inhibit mig2
modell='mechModelX9';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:31 35:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 10), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);
%%Std1 only inhibits Mig1. KinhSM2 inactive

%%mig1 represses mth1, std1 does not inhibit mig1
modell='mechModelX10';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:13 15:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 11), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
plotall(plotargs);

%%Std1 only inhibits Mig1. KinhSM2 inactive

%% mig1 represses Mth1, std1 des not inhibit migs
modell='mechModelX11';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:13 15:31  33:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 12), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
%%Std1 only inhibits Mig1. KinhSM2 inactive
plotall(plotargs);

%% Mth1 does not repress Std1. Std1 is not inhibited by Mth1
modell='mechModelX12';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 13), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
%%Std1 only inhibits Mig1. KinhSM2 inactive
plotall(plotargs);

modell='mechModelX13';
plotargs.modelname=modell;
% if q==1
% modelnames{j}= modell;j=j+1;
% end
argsim.onlyparams= [1:37];
simulator=makesimulatorX(modell, argsim);
%costs.(modell)=simulator(refparams);
[modelcosts(q, 14), plotargs.t, plotargs.y.(modell)]= simulator(parmat(q, :));
%%Std1 only inhibits Mig1. KinhSM2 inactive
plotall(plotargs);






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
modell='mechModelX13';
fval=[];
%modelopt=struct;
modelmatrix=[];
argsim.opts2.MaxIter=100;
simulator=makesimulatorX(modell, argsim);
v=find(modelcosts(:,find(strcmp(modelnames, modell)))>0); %work with nonzero indices
[a,b]= sort(modelcosts(v, 2));
x2=parmat(b(1), :);

%model x6 stopped at iteration 64
for j=2:75
try
if j==1
[modelmatrix(j,:), fval(j)]=fminsearch(simulator, x2, argsim.opts2);
else
[modelmatrix(j,:), fval(j)]=fminsearch(simulator,modelmatrix(j-1, :), argsim.opts2);
end
catch
[modelmatrix(j,:), fval(j)]=fminsearch(simulator, pars+randn(1, numel(argsim.mf.paramNames))*.1, argsim.opts2);
end

%%%%%%CHANGE TO YOUR USERNAME BELOW
save(strjoin({'/Users/s1259407/Documents/MATLABGIT/modelmatrix_', modell ,'.mat'}, ''),  'modelmatrix');
end

%%


id={};
for q=1:size(parmat,1)
    id{q}=strjoin(randsample([letters numbers], 6), '');
end


costsfile=fopen('mechmodelcosts_laptop2.txt', 'a');
fprintf(costsfile,[ 'modelnames\t' repmat('%s\t', 1, numel(modelnames))], modelnames{:});  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));
fprintf(costsfile,['\n' repmat('%3.3f\t', 1, size(modelcosts,2))], mc');  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));
paramsfile=fopen('trialparams_laptop2.txt', 'a');
%fprintf(paramsfile,['param_names' '\t' repmat(' %s\t', 1, size(parmat,2))], mf.paramNames{:});  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         
fprintf(paramsfile,[repmat(' %s\t', 1, size(parmat,2))], mf.paramNames{:});  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         

completeparmat=parmat(find(parmat(:, 1)>0), :);
completeid=id(find(parmat(:, 1)>0));

%fprintf(paramsfile,['\n' 'paramset_%s' '\t' repmat(' %3.3f\t', 1, size(parmat,2))], completeid{:}, completeparmat');  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));         
fprintf(paramsfile,['\n' repmat(' %3.3f\t', 1, size(parmat,2))], completeparmat');  %3.3f, %3.3f,%3.3f,%3.3f,%3.3f,%3.3f\n', modelcosts(q, :));  



%% plotting curves from all models using the
figure;
megamatrix=[];
strs={'WT', 'Mig1?', 'Mth1?','std1?','rgt2?','snf3'};
levels={'0.2%', '0.4%', '1%'}
mrkrs='o+^xs*vo+^xs*v';
subplot1(6,3,'Gap', [0.03 0.05])
c=1;

for st=1:6
for md=1:3
    
subplot1(c); 
strn=st;
conc=md;

conds=[...
 % 0.2% 0.4% 1%
    1 2 3; %wt
    4 5 6; %mig1
    7 8 9; %mth1
    10 11 12; %std1
    13 14 15;%rgt2
    16 17 18;];%snf3
pick= conds(strn, conc);
plot(plotargs.t, argsim.datameans(:, pick), 'ro', 'LineWidth', .8);
xlim=([0, 20]);
ylim([0, 6]);
hold on;
nms=fieldnames(plotargs.y);
for k=1: numel(nms)
    tmpmat=plotargs.y.(nms{k});
    plot(plotargs.t, tmpmat(:, pick), 'color', palette(k+10), 'DisplayName', nms{k}, 'Marker', mrkrs(k), 'MarkerIndices', 1:20:230, 'LineWidth', 1.2);    
    ylabel(strs{st})
    title(levels{conc})
    megamatrix(pick, k)= nansum((argsim.datameans(:, pick)- tmpmat(:, pick)).^2);
    hold on;
    
end
c=c+1;
end
end

%% heatmap of costs for all curves and models
%gplot2=colorRamp([0 .9 .9;0 0 .9;.3 .3 .3; .6 0 .7; 1 .6 0], 30 )
%gplot2=colorRamp([0 .9 .9;.3 .3 .3; .6 0 .7; 1 .6 0], 30 )
gplot2=colorRamp([0 .9 .9;.3 .3 .3; 1 .6 0], 30 )

%asymmetric
%gplot2=colorRamp([.2 .2 .2;0 0 .7; .6 0 .7; 1 .6 0], 30 )
figure; imshow(imresize(log(megamatrix./ repmat(megamatrix(:,1), 1, size(megamatrix, 2))), 10, 'nearest')', [-3, 3], 'colormap', gplot2)
for h=.5:10:180.5
addVLine(h, 'w')
end
for h=.5:10:120.5
addHLine(h, 'w')
end


%%% rearange plots for nice figure


%% horizontal panel
plotargs.modelname='mechModelXS'
argsim.theta=allthetas(61, :);
simulator=makesimulatorX(plotargs.modelname, argsim);
[a, plotargs.t, plotargs.y.(plotargs.modelname)]= simulator(parmat(1, :));

plotall(plotargs)


fhandle=get(gcf, 'children')
xmar=0.02;
ymar=0.05;
interrowmar=.01;
intercolmar=.02;
%top left
set(fhandle(1), 'Position', [0+xmar, .5+ymar, .25-intercolmar, .5-interrowmar])    
%bottom left
set(fhandle(6), 'Position', [0+xmar, 0+ ymar, .25-intercolmar, .5-interrowmar])    
%top middle
set(fhandle(5), 'Position', [.25+xmar, .5+ ymar, .25-intercolmar, .5-interrowmar])    
%bottom middle
set(fhandle(4), 'Position', [.25+xmar, 0+ ymar, .25-intercolmar, .5-interrowmar])  
%big center
set(fhandle(2), 'Position', [.50+xmar, 0+ ymar, .25-intercolmar, 1]) 
set(fhandle(2), 'YLim', [0,12]) 
%big right
set(fhandle(3), 'Position', [.75+xmar, 0+ ymar, .25-intercolmar, 1]) 
set(fhandle(3), 'YLim', [0,12]) 
hideAllTicks(gcf, [1 4 5 6 2 3], 0, 1, 'right')


%% 
%% plotting the data figures. just needs a bit of shuffling
fhandle=get(gcf, 'children')

        disp('plotting sugar')
        allaxes=get(gcf, 'children')
        for j=1:numel(allaxes)
      
            axes(allaxes(j))
            yyaxis right
        area( t(1:230), input, 'FaceAlpha', 0.1, 'FaceColor', [1, .6, 0], 'EdgeColor', 'none'); 
        ylim([0, 1])
        yyaxis left
        
        end
       

xmar=0.02;
ymar=0.05;
interrowmar=0.005;
intercolmar=.02;
%top left
yyaxis(fhandle(6), 'left')
pause(1)
set(fhandle(6), 'Position', [0+xmar, .5+ymar, .25-intercolmar, .5-interrowmar])    
set(fhandle(6), 'YLim', [0,4]) 
yyaxis(fhandle(6), 'right')
pause(1)
ylim([0, 1])
%bottom left
set(fhandle(5), 'Position', [0+xmar, 0+ ymar, .25-intercolmar, .5-interrowmar])    
yyaxis(fhandle(5), 'left')
pause(1)
set(fhandle(5), 'YLim', [0,4]) 
yyaxis(fhandle(5), 'right')
pause(1)
ylim([0, 1])
%top middle
set(fhandle(4), 'Position', [.25+xmar, .5+ ymar, .25-intercolmar, .5-interrowmar])    
yyaxis(fhandle(4), 'left')
pause(1)
set(fhandle(4), 'YLim', [0,4]) 
yyaxis(fhandle(4), 'right')
pause(1)
ylim([0, 1])
%bottom middle
set(fhandle(3), 'Position', [.25+xmar, 0+ ymar, .25-intercolmar, .5-interrowmar])  
yyaxis(fhandle(3), 'left')
pause(1)
set(fhandle(3), 'YLim', [0,4]) 
yyaxis(fhandle(3), 'right')
pause(1)
ylim([0, 1])
%big center
set(fhandle(2), 'Position', [.50+xmar, 0+ ymar, .25-intercolmar, 1]) 
yyaxis(fhandle(2), 'left')
pause(1)
set(fhandle(2), 'YLim', [0,12]) 
yyaxis(fhandle(2), 'right')
pause(1)
ylim([0, 1])
%big right
set(fhandle(1), 'Position', [.75+xmar, 0+ ymar, .25-intercolmar, 1]) 
yyaxis(fhandle(1), 'left')
pause(1)
set(fhandle(1), 'YLim', [0,12]) 
yyaxis(fhandle(1), 'right')
pause(1)
ylim([0, 1])
hideAllTicks(gcf, [1 4 5 6 2 3], 0, 1, 'right')



%%

%Branches
%Mth1 represses std1
%Std1 inhs Mig1
%Std1 inhs Mig2
%Mth1 reps Mig2
%Mig1 reps Mth1
%Mig2 reps Mth1

%%this gives us  63 different model possiilities to evaluate
%array theta repressents an off branch with a 0 and on with 1
%for 6 branches this is 63 possibilities. 
%to get all possibilities we enumerate from 0 to 63 in binary. 
allthetas=de2bi([0:63]); %all combinations of these 6 branches or on off, 
fvaltheta=[]; %for storing the values
ytheta={} %cell array to store all simulations. each entry is a matrix with col condutions and row timepoints.
for j=1: size(allthetas, 1)  
    argsim.theta= allthetas(j,:);
    simulator=makesimulatorX('mechModelXS', argsim);
    [fvaltheta(j), t, tmpmat] =simulator(parmat(1, :));
    ytheta{j}=tmpmat(:, 1:18);
end
 

    
%% how costs distribute across the conditions
fullmat=[]; 
gplot2=colorRamp([0 .9 .9;.3 .3 .3; 1 .6 0], 30 )

for j=1:64
    
    fullmat(j, :) =nansum((ytheta{j}-argsim.datameans).^2, 1);
end

%% plottig everithing
figure; subplot1(3,1,'Gap', [0.003 0.005])
subplot1(1);
bar(log(fvaltheta/fvaltheta(64)))
xlim([0.5, 64.5])
subplot1(2);
imshow(imresize(allthetas', 20, 'nearest'), [])
for h=.5:20:(64*20+.5)
addVLine(h, 'k')
end
for h=.5:20:(20*6)+.5
addHLine(h, 'k')
end
subplot1(3);
imshow(imresize(log(fullmat./repmat(fullmat(64, :), 64,1)), 20, 'nearest'), [-3, 3], 'colormap', gplot2)
for h=.5:20:(64*20+.5)
addVLine(h, 'k')
end
for h=.5:20:(20*18)+.5
addHLine(h, 'k')
end
    
%% optimising best theta models


besttheta= [41:48 57:64];
for k=13:16
current_theta=allthetas(besttheta(k), :)
%thetascores.(strjoin({'theta' , num2str(besttheta(k))}, '')).fval=[];
thetafval=[];
modell='mechModelXS';
%fval=[];
%modelopt=struct;
thetamatrix=[];
argsim.theta=current_theta;
argsim.opts2.MaxIter=100;
simulator=makesimulatorX(modell, argsim);

x2=parmat(1, :);

%model x6 stopped at iteration 64
for j=1:10
try
if j==1
[thetamatrix(j,:), thetafval(j)]=fminsearch(simulator, x2, argsim.opts2);
else
[thetamatrix(j,:), thetafval(j)]=fminsearch(simulator,modelmatrix(j-1, :), argsim.opts2);
end
catch
[thetamatrix(j,:),thetafval(j)]=fminsearch(simulator, pars+randn(1, numel(argsim.mf.paramNames))*.1, argsim.opts2);
end

%%%%%%CHANGE TO YOUR USERNAME BELOW
save(strjoin({'/Users/s1259407/Documents/MATLABGIT/thetamatrix_', num2str(besttheta(k)) ,'.mat'}, ''),  'thetamatrix', 'thetafval');
end

end

%%






%parameter importance estimation
V parameters: 0 if <k=0.001
Hill parameters: 0 if <0.1
K parameters
