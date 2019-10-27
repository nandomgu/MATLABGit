
%% initialising everything for the editCellSegGUI
load('/Users/s1259407/Documents/MATLAB/mySystemPreferences.mat')
addpath('/Users/s1259407/Documents/MATLAB/GeneralFunctions2019')
addpath('/Users/s1259407/Documents/MATLAB/Add-ons')
addpath(genpath('/Users/s1259407/Documents/MATLAB/OmeroCode'))
addpath(genpath('/Users/s1259407/Documents/MATLAB/MattSegCode2019'))
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20181213_results/cExperiment_001_with_lineage.mat')

%% load omeroand edit gui
odb = SystemPreferences.omerodb;
cExperiment.OmeroDatabase= odb;
cExperiment.omeroDs= odb.getDsListFromTag(cExperiment.id)
a=editCellSegGUI(cExperiment, 'channels', {'Brightfield_3', 'GFPFast', 'cy5'})


%% recalculate which positions have any mothers 
budtimepoints=struct;
posbud=[]
for j=1: numel(cExperiment.dirs) 
   if  any(any(cExperiment.returnTimelapse(j).cellMothers))
       posbud=[posbud j];
   end 
end
%%

%posbud=[2 3 4 7 8 14 15 16 23 24 25 26]
strainmothers=struct;
for h=1:numel(posbud)
ct=cExperiment.returnTimelapse(posbud(h))
strainmothers.columns={'posnum', 'trapNum', 'motherLabel', 'budCount'}
mothertable=full(ct.cellMothers);
nm=ct.getName;
alltps=numel(ct.cTimepoint);
strainmothers.(nm)=[];

budtimepoints.(nm)=[];
for j=1:size(mothertable, 1) %for each trap
   traptable=tabulate(mothertable(j, :));
   
   mothernonzeroindices=traptable(:, 1)~=0;
   %make a little array that tells you the trap number, mother label and
   %bud count
   strainmothers.(nm)= [strainmothers.(nm);repmat(posbud(h), numel(find(mothernonzeroindices)), 1),  repmat(j, numel(find(mothernonzeroindices)), 1) traptable(mothernonzeroindices, [1 2]) ];
   
end
   
   mat=strainmothers.(nm) %annoying value pass as we cannot consult entries for. struct.(name)(1,2) because of the stupid parenthesis
   %now for each mother (rows of a matrix) get the budding timepoints 
   motherspresent=[];
   budtimepoints.(nm).m=[];
   
   %this array indicates the timepoints a mother is present
   for g= 1:size(mat, 1) %for all the mother labels 
       trap= mat(g, 2);
       motherlabel=mat(g, 3);
       daughterlabels=find(mothertable(trap, :)==motherlabel) %which cells are daughters of mother g
   labelpresent= @(trap, tp, labels) any(ismember(ct.cTimepoint(tp).trapInfo(trap).cellLabel, labels))
   daughterspresent= @(labels) any(ismember(labels, daughterlabels)) 
   %checking which timepoints contain the mother
   
   motherspresent(g, :)= arrayfun(labelpresent, ones(1, alltps)*trap, 1:alltps, ones(1, alltps)*motherlabel);
   %a bit course but checking per timepoint whether it contains daughters
   %of mother g
   budtimestemp=[];
   
   
   for k=1:numel(daughterlabels)  
   budtimestemp(k, :)= arrayfun(labelpresent, ones(alltps,1)*trap, (1:alltps)', ones(300,1)*daughterlabels(k))
   end
   
  if size(budtimestemp, 1)>1
   budtimepoints.(nm).m(g, :)= sum(budtimestemp);
  else
      budtimepoints.(nm).m(g, :)= budtimestemp;
  end
   end
end
%% chymographs
figure; subplot(6,1,1); plot(nanmean(cExperiment.cellInf(3).imBackground)); 
subplot(6,1,2); imshow([budtimepoints.hxt4008.m;budtimepoints.hxt4009.m;budtimepoints.hxt4010.m;], []);title('WT')
subplot(6,1,3); imshow([budtimepoints.mth1ko031.m;budtimepoints.mth1ko032.m], []);title('mth1?')
subplot(6,1,4); imshow([budtimepoints.rgt2ko022.m;budtimepoints.rgt2ko023.m; budtimepoints.rgt2ko024.m], []);title('rgt2?')
subplot(6,1,5); imshow([budtimepoints.std1ko013.m;budtimepoints.std1ko014.m;budtimepoints.std1ko015.m;budtimepoints.std1ko016.m], []); title('std1?')

%% budding freuencies


figure; subplot(6,1,1); plot(nanmean(cExperiment.cellInf(3).imBackground))
mat=[budtimepoints.hxt4008.m;budtimepoints.hxt4008.m]
 subplot(6,1,2);plot(sum(mat)/size(mat, 1)');
title('WT')
totalbuds.wt=sum(mat, 2)

mat=[budtimepoints.mth1ko031.m;budtimepoints.mth1ko032.m]
totalbuds.mth1=sum(mat, 2)
subplot(6,1,3); plot(sum(mat)/size(mat, 1)');
title('mth1?')


mat=[budtimepoints.rgt2ko022.m;budtimepoints.rgt2ko023.m;budtimepoints.rgt2ko024.m];
totalbuds.rgt2=sum(mat, 2)
subplot(6,1,4);plot(sum(mat)/size(mat, 1)');
title('rgt2?')

mat=[budtimepoints.std1ko013.m];
totalbuds.std1=sum(mat, 2)
subplot(6,1,5); plot(sum(mat)/size(mat, 1)');

title('std1?')

%% after running above- boxplots of budding events per cell
 nms={'wt', 'mth1', 'rgt2', 'std1'}
r=makeGroupVar( totalbuds.wt, totalbuds.mth1, totalbuds.rgt2, totalbuds.std1)
figure; boxplot([totalbuds.wt; totalbuds.mth1; totalbuds.rgt2; totalbuds.std1] ,   {nms{r}})
ylim([0, 20])
ylabel('budding events per cell')
%% smoothed budding frequencies

mth1s=cattraces(budtimepoints, 'mth1')
std1s=cattraces(budtimepoints, 'std1')
hxt4s=cattraces(budtimepoints, 'hxt4')
rgt2s=cattraces(budtimepoints, 'rgt2')

figure;
subplot(2,1,1)
cy5=nanmean(cExperiment.cellInf(3).imBackground);
plot(cy5); 
addVLine([74,88, 101, 114, 127, 140, 153, 168, 180, 194, 208,220, 233])

subplot(2, 1 ,2)
yyaxis right
addVLine([74,88, 101, 114, 127, 140, 153, 168, 180, 194, 208,220, 233])
yyaxis left
sm=3
mth1line=smooth(sum(mth1s)/sum(mth1s(:)),sm)
std1line=smooth(sum(std1s)/sum(std1s(:)),sm)
rgt2line=smooth(sum(rgt2s)/sum(rgt2s(:)),sm)
hxt4line=smooth(sum(hxt4s)/sum(hxt4s(:)),sm)
hold on; plot(1:300, smooth(sum(mth1s)/sum(mth1s(:))), 'DisplayName', 'mth1ko', 'Color', palette('orange'), 'LineWidth', 1.2)
hold on; plot(1:300, smooth(sum(std1s)/sum(std1s(:))), 'DisplayName', 'std1ko','Color', palette('blue'),'LineWidth', 1.2)
hold on; plot(1:300, smooth(sum(rgt2s)/sum(rgt2s(:))),'DisplayName', 'rgt2ko','Color', palette('red'),'LineWidth', 1.2)
hold on; plot(1:300, smooth(sum(hxt4s)/sum(hxt4s(:))),'DisplayName', 'WT','Color', palette('black'),'LineWidth', 1.2)

figure; plot(cy5, mth1line)


%% retrieving extracted information from mothers
%strain name of each position
posnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput',  false)

try
strainmothers=rmfield(strainmothers, 'columns')
end
nms= fieldnames(strainmothers)
motherfl=[];
motherarea=[];
allbudtimes=[];
allsm=[]
%%this table gives you the position, trap and cell number in the whole
%%table of cellinf
idmat= [cExperiment.cellInf(chan).posNum', cExperiment.cellInf(chan).trapNum' cExperiment.cellInf(chan).cellNum'];
for j=1:numel(nms)
    sm= strainmothers.(nms{j});% going position per position
    sm=sm(:, 1:3); %trimming the bud counts    
    chan=2;
for k=1:size(sm, 1)
    motherindex= find(idmat(:, 1)== sm(k, 1) & idmat(:, 2)== sm(k, 2) & idmat(:, 3)== sm(k, 3));
    if isempty(motherindex)
        motherfl=[motherfl; ones(1, alltps)*NaN];
        motherarea=[motherarea; ones(1, alltps)*NaN];
        continue
        
    end
    motherfl=[motherfl; cExperiment.cellInf(chan).mean(motherindex, :)];
    motherarea=[motherarea; cExperiment.cellInf(1).area(motherindex, :)];
end
allsm=[allsm; sm];
allbudtimes=[allbudtimes; budtimepoints.(nms{j}).m];
end
cats=posnames(allsm(:, 1))
%%  plotting mother fluroescence and their budding events
figure;
subplot(3,1,1)
cy5=nanmean(cExperiment.cellInf(3).imBackground);
plot(cy5); 
addVLine([74,88, 101, 114, 127, 140, 153, 168, 180, 194, 208,220, 233])



for g=40:size(allsm, 1)
    
subplot(3, 1 ,2)
yyaxis right
%addVLine([74,88, 101, 114, 127, 140, 153, 168, 180, 194, 208,220, 233])
plot(allbudtimes(g, :), 'k-'); 
yyaxis left
plot(motherfl(g, :), 'r-' ); 
title([num2str(g) '-' cats{g} ' GFP'])

subplot(3, 1 ,3)
yyaxis right
%addVLine([74,88, 101, 114, 127, 140, 153, 168, 180, 194, 208,220, 233])
plot(allbudtimes(g, :), 'k-'); 
yyaxis left
plot(motherarea(g, :), 'b-', 'DisplayName', cats{g} ); 
ylim([200, 500])
title([num2str(g) '-' cats{g} ' cell area'])
ginput(1)
end

%% calculating the budding precision per cell 
%see how many timpoints away is the closest cy5 peak from each 
figure;
cols={'r-', 'g-', 'b-', 'y-'};
strains=unique(cats);
strainindex=@(strain)  find(strcmp(strain, strains));

colinds=cellfun(strainindex, cats)
res=struct;
for g=1: size(allbudtimes, 1)
peaktimes=[57, 74,88, 101, 114, 127, 140, 153, 168, 180, 194, 208,220, 233]
    
retrievemin=@(num) min(abs(num-peaktimes));
%arrayfun(retrievemin,  find(allbudtimes(g,:)))    

%subplot(5,1, colinds(g))
    %try
    
    if ~isfield(res, strains{colinds(g)})
        res.(strains{colinds(g)})=[]
        
    end
        res.(strains{colinds(g)})=[res.(strains{colinds(g)}) arrayfun(retrievemin,  find(allbudtimes(g,40:210))) ]  ;                                             
    
    %end
        hold on
    
end
figure; 
for j=1:numel(strains)
    
   plot(ksdensity(res.(strains{j})), 'DisplayName', strains{j}) 
 hold on;
end
title('alignment between buds and cy5 peaks')
xlabel('Distance from bud to closest cy5 peak (timepoints)')
ylabel('Density (budding events)')

%% budding frequency over time.
%effective time period
timepoints=54:12:234
getwindow=@(num) timepoints(num):timepoints(num+1);
cols=linspecer(4);
freqsovertime=[]
for ind =1: size(allbudtimes,1)
getcellfreq= @(num) sum(allbudtimes(ind, getwindow(num)));
freqsovertime(ind, :) =arrayfun(getcellfreq, 1:numel(timepoints)-1);
end
figure; 
for j=1:4
  %subplot(5,1,j)  
localmat=freqsovertime(colinds==j, :);
errorbar([], mean(localmat),std(localmat),  'color', cols(j, :), 'DisplayName', strains{j});


hold on;
end
%% 
figure; plotByGroupGeneral(freqsovertime+ randn(size(freqsovertime))*.1, cats)
