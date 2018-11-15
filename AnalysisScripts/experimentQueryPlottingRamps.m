
%% 
exptList=[];
n=1
exptList{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180403_results/cExperiment.mat'
rtype(n)=0

n=n+1;
exptList{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180405_results/cExperiment_001real.mat'
rtype(n)=0
%%342
n=n+1;
exptList{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180329_results/cExperiment_001.mat'
rtype(n)=2

n=n+1;
exptList{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180328_results/cExperiment_001c03601.mat'
rtype(n)=2
%344
n=n+1;
exptList{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180322_results/cExperiment_001.mat'
rtype(n)=4

n=n+1;
exptList{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180409_results/cExperiment.mat'
rtype(n)=4
%346
n=n+1;
exptList{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180410_results/cExperiment.mat'
rtype(n)=6

%the moments when th downshift starts in every experiment
rampStartIndices = [87    86    89    90    91    93    95]

%% declare the rootpath
%tb=table(exptList(:), concentrations(:), 'VariableNames',{'Experiment', 'Concentration'} )
rootpath= '/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder'

%% making the currentfolders structure for the mutants
currentfolders={
    %'20180424_results',0.2;... %%levels all wrong. 
    '20180505_results',0.2;...
    '20180522_results',0.2;...
    '20180523_results',0.2;...
    '20180524_results',0.2;...
    '20180525_results',0.2;...
    '20180529_results',0.4;...
    %'20180530_results',0.4;... %experiment  is of very poor quality in
    %many ways.
    '20180531_results', 0.4;...
    '20180601_results', 0.4;...
    %'20180604_results', 0.4; experiment says 0.4% but it behaves quite
    %similarly to  0.2% glucose. No other replicate behaves lite this.
    %probably a mistake int the medium.
     '20180605_results', 0.4;
     '20180607_results', 0.2;
    '20180610_results', 0.2;
    '20180611_1_results', 0.2;
    '20180611_2_results', 0.2;
    %'20180613_1_results', 0.2; 4hr step
    '20180614_1_results', 0.2;
    '20180614_2_results', 0.2;
    '20180615_1_results', 0.2;
    '20180615_2_results', 0.2;
    }
%% assemble experiment list and extract basic info of experiments one by one

allnms={}
times=[];
cy5=[];
for n=1:numel(exptList)
% disp(['trying folder number ' num2str(n) ': ' currentfolders{n,:} ])
% pth=[rootpath filesep currentfolders{n,1}] ;
% disp(pth)
% a=dir(pth);
% a={a.name};
% disp('Finding cExperiment file...')
% cexp=a(logical(cell2mat(cellfun(@empty2Zero, regexp(a, 'ce?E?xperiment_?\d?\d?\d?.mat'), 'UniformOutput', false))));
% %in the scary case there might be 2 cExperiment folders...
% cexp=cexp(1);
% disp('making path for cExperiment file')
% exptList{n}= strjoin([pth filesep cexp], '')
%getting the recorded sugar concentration
l1=load(exptList{n})
disp('loading experiment')
cExperiment=l1.cExperiment

 if ~isempty(regexp(exptList{n},  '20180322')) %this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
               
 cExperiment.dirs=strrep(cExperiment.dirs, 'mig1', 'mig1g')
 end


mch=makeMultiChamber(cExperiment)
bgchan=3;
%if size(cExperiment.cellInf(bgchan).mean,2)>= 250
    disp('processing cy5')
    [c,~,t] = processcy5(mch, []);
    disp('adding cy5 to matrix')
    cy5(n,:)= topUp(normalizeTS(nonzeroColMean(c)), 250);
    
    times(n, :)= topUp(t, 250);
% else
%     cy5(n,:)= nan(1, 250);
%     times= nan(1,250);
% end
drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);
disp('getting experiment''s strain names')
allnms{n}=unique(cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false))
uniquedirs=allnms{n}
try
uniqextracted= unique(drnames(cExperiment.cellInf(1).posNum));
end

% if isempty(cExperiment.cellInf) || ~isfield(cExperiment.cellInf(1),'posNum') || numel(uniquedirs) ~= numel(uniqextracted)
%     cExperiment.posTracked=ones(1, numel(cExperiment.dirs))
%     cExperiment.compileCellInformation()
%     cExperiment.saveExperiment()
% end
%     

%[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, 8, 3, [], true)
% disp('getting experiment'' declared sugar concentration')
% try
% stri=char(cExperiment.metadata.acq.pumpInit{1, 'contents'})
% parts=strsplit(stri, '%');
% currentfolders{n, 2}= str2double(parts{1});
%end
end



%%
%cm=colorRamp([0 0.4 0.4; 0,0.8, 1],4) %gradient of blues
%cm=colorRamp([0 0 0.5; 1 0 1],4) % blue to magenta

%cm=colorRamp([0 0 0.5; .5 0 .5; 1 .4 0],4) % blue purple orange
prewindow=20;
rampwindow=100;
cm=colorRamp([0 .8 1;1 0 1; 1 .5 0;],4) % cyan magenta orange


findmig= @(ce) find(cellfun(@empty2Zero, strfind(ce, 'mig1'))>0)
refzero='wt'
refones= cellfun(findmig, allnms, 'UniformOutput', false); %finding which string has the mig1  substring and using that as a reference.
% irritating... had to make this matrix into a cell array. couldn't it just calculate that they match in the number of elements and apply them?
getmig= @(ce, num) ce{num};
refones=cellfun(getmig, allnms, refones, 'UniformOutput', false)
straincolors=[
 0 0.8 0.8;
 0 0 0.5;
 0.8 0 0.8;
 1 0 0;
 1 0.8 0;
 0.3 0.3 0.3;
 0 0.5 0
]

refstrain='hxt4' %make [] if unwanted
refrange=[1:30]   % make [] if unwanted
mode=2; 

 strains={...
     'wt';...
      'hxt2';...
      'hxt4';...
      'hxt7'}
 
%strains={'mig1g'}


%strains={'mocloSTRE'}
%cmap=[0,0,0;0,.5, .5;0,.8,.8];
%which experiments contain mig1
containsmig= cellfun(@(c) sum(strcmp(c, 'mig1g'))>0, allnms)
currentfolders(containsmig)
meandataramp=struct;
subtractiondataramp=struct;
celldataramp=struct;
diffdataramp=struct;
sizedataramp=struct;
locdataramp=struct;
rampdata=struct;
cmap=linspecer(size(exptList,2));
plotcons=[0,2,4,6]; % just interested in 1% for now
numreps=3;
plotreps=2; %which replicate numbers to plot. explicitly include numbers 1,2, n.
flag=0
  figure;
 mod=1 ;
for q=1:numel(strains)
  
for j=1:numel(plotcons)
    %subplot by both ramp duration and strain
    %subplot(numel(strains), numel(plotcons), numel(plotcons)*(q-1)+j);
    %subplot by strain
    subplot(numel(strains), 1, q);
    nam=['ramp' num2str(plotcons(j)) 'h']; %the name of the condition to name data structures
   %try 
%this mode matches the exact strain

concentrations=rtype;
containsStrain = @(nms,str) sum(strcmp(nms, str))>0;
sCon=cell2mat(cellfun(containsStrain, repmat(allnms, numel(strains(q)), 1), repmat(strains(q)', 1, numel(exptList)), 'UniformOutput', false));
cCon=(concentrations== plotcons(j));

exptchoice=exptList(sCon);
matchingExperiments=find(sCon & cCon);

colorchoice=cmap(sCon, :);
   localcons= concentrations(sCon); %concs of the experiments chosen
   whicharequery= localcons==plotcons(j); %which expts belong to the concentration in place
   conlist=exptchoice(whicharequery);
   colorlist=colorchoice(whicharequery,:)
    
              mat=[];
        submat=[];
   if ~isempty(matchingExperiments)
    l=0;
    for k=matchingExperiments
    l=l+1;
        l1=load(exptList{k})
        cExperiment=l1.cExperiment
        if ~isempty(regexp(exptList{k},  '20180322')) %this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
               
            cExperiment.dirs=strrep(cExperiment.dirs, 'mig1', 'mig1g')
          end
        
        strn=strains{q};
        %strn=reflist{k}

        
        
        if strcmp(cExperiment.metadata.microscope, 'Batman')
            chan=8;
            disp('experiment is from batman')
            if ~isempty(regexp(exptList{k},  '20180614_1')) %this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
               
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mig1', 'mig1g')
                 
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], refzero, refones{k}, refrange, chan, 3, {strn, 'hxt4'}, false, 200);
            else
            
          try  
        [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], refzero, refones{k}, refrange, chan, 3, {strn, 'hxt4'}, false)
        catch
          [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], refzero, refones{k}, refrange, 7, 3, {strn, 'hxt4'}, false)
          end
            end
        else  %experiment is from batgirl   
        disp('experiment is from batgirl')
        chan=6;
             if ~isempty(regexp(exptList{k},  '20180614_2')) || ~isempty(regexp(exptList{k},  '20180614_1')) || ~isempty(regexp(exptList{k},  '20180615_2'))%this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
                 
                 
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mig1g', 'mig1ko')
                 
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], refzero, refones{k}, refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             if ~isempty(regexp(exptList{k},  '20180615_2'))
                  cExperiment.dirs=strrep(cExperiment.dirs, 'mig1ko', 'mig1g')
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mth1ko', 'mig1ko')
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], refzero, refones{k}, refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             end
             else
            [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], refzero, refones{k}, refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             
        end
        end
        
        disp(['interpolating main data. strain ' strn 'media ' num2str(plotcons(j)), ' replicate ' num2str(k) ])
        ntimes=linspace(0, 20, 250); %new time vector
        
        newy= interp1(times, means(1, :), ntimes, 'pchip',nan); %interpolating times to sample at the same point throughout.
        mat(k,:)=newy;
        disp(['interpolating hxt4 for this replicate'])
        wty= interp1(times, means(2, :), ntimes,'pchip',  nan); %geting the mean of hxt4
        submat(k,:)=newy-wty;
        
        %interpolating cell traces
        disp('creating interpolant')
        F=griddedInterpolant({times, 1:size(stdmch.(strn).cellInf(chan).mean, 1)},stdmch.(strn).cellInf(chan).mean', 'linear', 'none' );
        
        disp('creating new time grid for all cells')
        qgrid= {ntimes, 1:size(stdmch.(strn).cellInf(chan).mean, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        if l<=numreps
            disp('extracting cell data')
            matr=F(qgrid)'
        celldataramp.(strn).(nam).(['rep' num2str(l)])= matr;
        
        disp('extracting ramp data')
        rampdata.(strn).(nam).(['rep' num2str(l)])=matr(:, rampStartIndices(k)-prewindow: rampStartIndices(k)+rampwindow) ;
        end
              
        %interpolating cell sizes
        disp('creating interpolant')
        F=griddedInterpolant({times, 1:size(stdmch.(strn).cellInf(1).area, 1)},full(stdmch.(strn).cellInf(1).area)', 'linear', 'none' );
        
        disp('creating new time grid for all cells')
        qgrid= {ntimes, 1:size(stdmch.(strn).cellInf(1).area, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        if l<=numreps
        sizedataramp.(strn).(nam).(['rep' num2str(l)])= F(qgrid)';
        end
              
        %interpolating localisation
        disp('creating interpolant')
        nucloc=full(stdmch.(strn).cellInf(chan).max5./stdmch.(strn).cellInf(chan).median);
        nucloc= nucloc./ repmat(nanmean(nucloc(:, refrange),2), 1, size(nucloc, 2))
        F=griddedInterpolant({times, 1:size(nucloc, 1)},full(nucloc)', 'linear', 'none' );
        
        disp('creating new time grid for all cells')
        qgrid= {ntimes, 1:size(nucloc, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        if l<=numreps
        locdataramp.(strn).(nam).(['rep' num2str(k)])= F(qgrid)';
        end
        
        
        

        %colorlist(k,:) for colours by experiment 
        if ismember(l, plotreps)
        boundedline(times, means(1,:),bnds.(strn), 'cmap', cm(j,:),'alpha',  'transparency', 0.5);
         
        h=gca;
        a= get(h, 'children');
        nm=strsplit(exptList{k}, '/'); %getting the experiment's name
        nm=nm{end-1}
        a(1).DisplayName= nm
        a(2).DisplayName= nm
        hold on;
        if q==numel(strains)
        xlabel('Time (Hrs)');
        end
        ylabel('Mean cell FL (±SEM)');
        title([strn 'in' num2str(plotcons(j))]);
        ylim([0,10])
       end  
        
        
    end
    
    
   

    
   end
    disp('adding matrices')
    meandataramp.(strn).(nam)=mat;
    subtractiondataramp.(strn).(nam)=submat; %data where the hxt4 mean trace is subtracted from the traces.
    pause(0.5)
   
   
end


end

 locdataramps.times=ntimes
 locdataramps.cy5=cy5
 locdataramps.ramplength=rtype
savejson('',celldataramp,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/rampsdata.json');
savejson('',rampdata,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/trimmedrampsdata.json');

%savejson('',locdata,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/201807_mig1rampdata.json');


%%coloring the plots based on the least square diff from wt hxt4
%%
uniformAxes(gcf, [], [0,14], [0, 40],[], [] )

axes;
for j= fliplr(1:numel(rtype)) %plotting the areas in reverse in order not to mask the small ones
area(cy5(j,:), 'FaceAlpha', 0.9, 'LineStyle', 'none', 'FaceColor',  cm(find(plotcons== rtype(j)),:)); hold on;
end

stackPlots(gcf);

%% making mini plot  of aligned ramps for the encoding delay diagram
alignedramps=[];
prewindow=20;
window=100;
figure;
for j=1:numel(rampStartIndices)
    col=selectMat(cm, [0, 2, 4, 6], rtype(j));
    interval=(rampStartIndices(j)-prewindow):(rampStartIndices(j)+window-1);
    ntimes(rampStartIndices(j))-ntimes(rampStartIndices(j))
    alignedramps(j, :)= cy5(j, interval);
    plot(alignedramps(j, :), 'Color', col);
    hold on;
end
    


%%coloring the plots based on the least square diff from wt hxt4



%% clustering the dynamics of the hxts

%getting one replicate per Hxt
hxtmeanrep=structfun(@(c) c.g1percent(randsample(1:size(c.g1percent,1), 1), :), meandataramp, 'UniformOutput', false)

%creating a matrix of all replicates
hxtmeanmat=[];
nms=fieldnames(hxtmeanrep)
for j = 1:numel(nms)
    hxtmeanmat(j, :)=hxtmeanrep.(nms{j})
end


%% %making clusters or levels and rates
%rates
figure;clustergram(smoothDeriveAllCells(hxtmeanmat), 'RowLabels', nms, 'Cluster', 'column', 'ColorMap', colorRamp([0 1 1;0 0 0.5; 0 0 0;0 0 0.3; 0.8 0 .8], 30 ))

%derivative
figure;clustergram(hxtmeanmat, 'RowLabels', nms, 'Cluster', 'column', 'ColorMap', colorRamp([0 0 0; 0 0 1;.6 0 .6; 1 .3 0], 300 ), 'Symmetric', false )






