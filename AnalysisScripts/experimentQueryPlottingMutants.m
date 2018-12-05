% exptList={'multichambers201608{2}', 'multichambers201608{3}',...
% 'multichambers201608{4}',...
% 'multichambers201608{5}',...
% 'multichambers201608{6}',...
% 'multichambers201608{7}',...
% 'multichambers201608{8}',...
% 'multichambers20161014{1}',...
% 'multichambers20161014{2}',...
% 'multichambers20161015{1}',...
% 'multichambers20161015{2}',...
% 'multichambers20161016{1}',...
% 'multichambers20161016{2}',...
% 'multichambers20161025{1}',...
% 'multichambers20161025{2}',...
% 'multichambers20161110{1}',...
% 'multichambers20161115{1}',...
% 'multichambers20161115{2}',...
% 'multichambers20161116{1}',...
% 'multichambers20161116{2}',...
% 'multichambers20161116{3}',...
% 'multichambers20161116{3}',...
% 'multichambers20161130{1}',...
% 'multichambers20161130{2}',...
% 'multichambers20161130{3}',...
% 'multichambers20161130{4}',...
% 'multichambers20161204{1}',...
% 'multichambers20161204{2}',...
% 'multichambers20161204{3}',...
% 'multichambers20161206{1}',...
% 'multichambers20161206{2}',...
% 'multichambers20161207{1}',...
% 'multichambers20161207{2}',...
% }'
% 
% containsStrain = @(expmt,str) sum(strcmp(fieldnames(evalin( 'base', expmt)), str))>0;
% sCon=cellfun(containsStrain, repmat(exptList, numel(strains), 1), repmat(strains', 1, numel(exptList)))
% strains={'hxt4', 'mig1gfp'}


concentrations=[
0.4,...%20170610  glucose 0.4 hat
0.4,...%20170613 glucose 0.4 hat
0.2,...%20170615 glucose 0.2% hat %0.4,...%20170627 glucose 0.4% hat.FAULTY EXPT
0.4,...%20170629 glucose 0.4 hat
0.4,...%20170630 glucose 0.4 hat
1,...%20170703 glucose 1% hat
1, ...%20170704 1% hat
0.2, ...%20170720 0.2% hat
0.2,...%20170721 0.2% hat
0.2,...%20170722 0.2% hat
1,...%20170518 1% hat
1,...%20170525 1% hat
1,...%20170521 1% hat
1,...%20171007 1% hat
1,...%20171009 1% hat
1,...%20171012 1% hat
1,...%20171013 1% hat

]

exptList={...
    'multichamber20170610',... 
    'multichamber20170613',... 
    'multichamber20170615',... 
    'multichamber20170629',... 
    'multichamber20170630',... 
    'multichamber20170703',... 
    'multichamber20170704',... 
    'multichamber20170720',... 
    'multichamber20170721',... 
    'multichamber20170722'...  
    'multichamber20170518'...  
    'multichamber20170525'...  
    'multichamber20170521'...  
    'multichamber20171009'...  
    'multichamber20171012'...  
    'multichamber20171013'... 
    
    
    }

  multichamberPaths={
 '/Users/s1259407/Google Drive/matlabDrive/20170610multichamber.mat' 
 '/Users/s1259407/Google Drive/matlabDrive/20170613multichamber.mat' 
  '/Users/s1259407/Google Drive/matlabDrive/20170615multichamber.mat' 
  '/Users/s1259407/Google Drive/matlabDrive/20170629multichamber.mat' 
  '/Users/s1259407/Google Drive/matlabDrive/20170630multichamber.mat' 
   '/Users/s1259407/Google Drive/matlabDrive/20170703multichamber.mat' 
  '/Users/s1259407/Google Drive/matlabDrive/20170704multichamber.mat' 
  '/Users/s1259407/Google Drive/matlabDrive/20170720multichamber.mat' 
 '/Users/s1259407/Google Drive/matlabDrive/20170721multichamber.mat' 
 '/Users/s1259407/Google Drive/matlabDrive/20170722multichamber.mat'
 '/Users/s1259407/Google Drive/matlabDrive/20170518_multichamber.mat'
  '/Users/s1259407/Google Drive/matlabDrive/20170525multichamber.mat' 
  '/Users/s1259407/Google Drive/matlabDrive/20170521multichamber.mat' 
  '/Users/s1259407/Google Drive/matlabDrive/20171009_multichamber.mat'
  '/Users/s1259407/Google Drive/matlabDrive/20171012_multichamber.mat'
  '/Users/s1259407/Google Drive/matlabDrive/20171013_multichamber.mat' 
  
  }

%     'multichamber20171009'...
%     'multichamber20171012'...
%     'multichamber20171013'...
%     'multichamber20170704'...
%     'multichamber20171221'...
%     'multichamber20171229'...
%     'multichamber20171229'...
%     
%     
% }
%% 

%hxt experiments

currentfolders={...
'20170610_results', 0.4;...%20170610  glucose 0.4 hat
'20170613_results', 0.4;...%20170613 glucose 0.4 hat
'20170615_results',0.2;...%20170615 glucose 0.2% hat %0.4,...%20170627 glucose 0.4% hat.FAULTY EXPT
'20170629_results',0.4;...%20170629 glucose 0.4 hat
'20170630_results',0.4;...%20170630 glucose 0.4 hat
'20170704_results',1; ...%20170704 1% hat
'20170720_results',0.2; ...%20170720 0.2% hat
'20170721_results',0.2;...%20170721 0.2% hat
'20170722_results',0.2;...%20170722 0.2% hat
'20170518_results',1;...%20170518 1% hat
'20170525_results',1;...%20170525 1% hat
'20170521_results',1;...%20170521 1% hat
'20171007_results_omero',1;...%20171007 1% hat
'20171009_results',1;...%20171009 1% hat
'20171012_results',1;...%20171012 1% hat
'20171013_results',1;...%20171013 1% hat

}
%% 
%tb=table(exptList(:), concentrations(:), 'VariableNames',{'Experiment', 'Concentration'} )
rootpath= '/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder'
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
    '20180613_1_results', 0.2;
    '20180614_1_results', 0.2; %no mig1 gfp in this experiment
    '20180614_2_results', 0.2; %no  mig1 gfp in this experiment
    '20180615_1_results', 0.2;
    '20180615_2_results', 0.2;
    '20180621_results', 0.4;
    '20180622_results', 0.4;
    
    }

exptIndex=@(name) find(strcmp(currentfolders(:,1), name))
% cy5channel=ones(18, 1)*3; % we generate a general one and then add exceptions manually
% cy5channel(13)=1;

 %nuclocChannel(13)=13

%% 
cy5=[];
timesc=[];
exptList={};
nuclocChannel=ones(size(currentfolders,1),1)*7;
nuclocChannel(15)=8;
cy5channel=[];

allnms={}
for n=1:size(currentfolders, 1)
    disp(['trying experiment ' num2str(n)])
pth=[rootpath filesep currentfolders{n,1}] ;
a=dir(pth);
a={a.name};
cexp=a(logical(cell2mat(cellfun(@empty2Zero, regexp(a, 'cExperiment_?\d?\d?\d?.mat'), 'UniformOutput', false))));
%in the scary case there might be 2 cExperiment folders...
cexp=cexp(1);
exptList{n}= strjoin([pth filesep cexp], '')
%getting the recorded sugar concentration
l1=load(exptList{n})
cExperiment=l1.cExperiment;
try
   disp('getting microscope name')
microscope{n}=cExperiment.metadata.microscope;
catch
    disp('failed to retrieve microscope name')
microscope{n}='Batman';
end

disp(['making multichamber for expt' num2str(n)])
mch=makeMultiChamber(cExperiment);
% try
% nuclocChannel(n)=find(strcmp(cExperiment.channelNames, 'GFPFast_005'));
% catch
%     try
%     nuclocChannel(n)=find(strcmp(cExperiment.channelNames, 'GFPFast_5'));
%     catch
%         try
% nuclocChannel(n)=find(strcmp(cExperiment.channelNames, 'GFP_005'));
%         catch
% nuclocChannel(n)=find(strcmp(cExperiment.channelNames, 'GFP_5'));
% end
%     end
% end


cy5channel(n)=find(strcmp(cExperiment.channelNames, 'cy5'));

bgchan=cy5channel(n);

%if size(cExperiment.cellInf(bgchan).mean,2)>= 250
    disp('processing cy5')
    [c,~,t] = processcy5(mch, [], bgchan);
    disp('adding cy5 to matrix')
    filling= nan(1,250);
    pc=normalizeTS(nonzeroColMean(c));
    filling(1:numel(pc))=pc;
    cy5(n,:)= filling;
    tfilling= nan(1,250);
    tfilling(1:numel(t))=t;
    timesc(n, :)= tfilling;
%else
%    cy5(n,:)= nan(1, 250);
%    times= nan(1,250);
%end

allnms{n}=unique(cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false))
%[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, 8, 3, [], true)
try 
stri=char(cExperiment.metadata.acq.pumpInit{1, 'contents'})
 parts=strsplit(stri, '%');
 currentfolders{n, 2}= str2double(parts{1});
end
end
%
concentrations=[currentfolders{:,2}]';
%multiplying cy5 signals by the concentration
cy5= cy5.*repmat(concentrations, 1, size(cy5,2))


%%



refstrain='hxt4'; %make [] if unwanted
refrange=[1:30] ;  % make [] if unwanted
mode=2; 

strains={...
    'hxt4';...
    'snf3ko';...
    'rgt2ko';...
    'std1ko';...
    'mig1ko';...
    'mth1ko';...
    
    }
%strains={ 'mig1ko';'hxt4' };
% strains={...
%     'hxt4';...
%     'mig1ko';...
%     'std1ko'}

%strains={'mocloHXT4', 'mocloSTRE'};

%allnms= cellfun(@(expt)fieldnames(multiChamberFromPath(expt)), exptList, 'UniformOutput', false);

%making 20180614_2 contain the name mig1ko as it is mislabelled as mig1g

% tmp=allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_2'))>0};
% tmp{end+1}='mig1ko';
% allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_2'))>0}=tmp;

%this experiment does not have mig1ko well annotated.
% tmp=allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_1'))>0};
% tmp{end+1}='mig1ko';
% allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_1'))>0}=tmp;
% 


%color by concentration
savedexpts=[];
numreps=2
concolors=[0 0.8 .8; 0 0 .8; 0.6 0 0.6 ];
meandatamutants=struct;
subtractiondatamutants=struct;
celldatamutants=struct;
sizedatamutants=struct;
locdatamutants=struct;
allbnds=struct;
cellratesmutants=struct; %structure that will hold the cell rates at multiple stages in the experiment
celllevelsmutants=struct; %storing the the average cell levels in a window
%intervals=sections in which th environment is divided
intervals=struct;
intervals.r1=1:30; %original 30
intervals.r2=35:65; %original 38 56
intervals.r3= 90:120; %original 90 120
intervals.r4= 125:155; %original 130 156
intervals.r5= 170:200; %original 170 200
intervals.special=170:180; %original 170 180
flds=fieldnames(intervals);
cmap=lines(20)
figure;
for j=1:numel(flds)
%plot(times(:, intervals.(flds{j}))',cy5(:, intervals.(flds{j}))', 'Color', cmap(j,:) )
hold on;
end
hold off;


cmap=linspecer(size(exptList,2)); %colors for each experiment. 
%shuffling the colors to eliminate sugar date correlations
cmap=cmap(randsample(numel(exptList), numel(exptList), 0),:);
plotcons=[0.2, 0.4, 1];
flag=0
  figure;
 mod=1 ;
for q=1:numel(strains)
  
for j=1:numel(plotcons)
   %full grid of strains/conditions 
   %subplot(numel(strains), numel(plotcons), numel(plotcons)*(q-1)+j);
   %single column, one strain multple conditions
   subplot(numel(strains), 1, q);
   nam=['g' strrep(strrep(num2str(plotcons(j)), '.', 'p'), '0', '') 'percent']; %the name of the condition to name data structures
   %try 
%this mode matches the exact strain


containsStrain = @(nms,str) sum(strcmp(nms, str))>0;
sCon=cell2mat(cellfun(containsStrain, repmat(allnms, numel(strains(q)), 1), repmat(strains(q)', 1, numel(exptList)), 'UniformOutput', false));
cCon=(concentrations== plotcons(j))';

exptchoice=exptList(sCon);
matchingExperiments=find(sCon & cCon);

colorchoice=cmap(sCon, :);
   localcons= concentrations(sCon); %concs of the experiments chosen
   whicharequery= localcons==plotcons(j); %which expts belong to the concentration in place
   conlist=exptchoice(whicharequery);
   colorlist=colorchoice(whicharequery,:);
   
        mat=[]; %will hold the means for this condition's reps
        submat=[]; %will hold the means minus the wildtype
        bndsmat=[];
   if ~isempty(matchingExperiments)

     l=0;  
    for k= matchingExperiments
    l=l+1;
        cExperiment=loadExpt(exptList{k});
        %cExperiment=l1.cExperiment
        strn=strains{q};
        

        
        
        if strcmp(cExperiment.metadata.microscope, 'Batman')
            chan=8;
            
            if ~isempty(regexp(exptList{k},  '20180614_1')) %this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
               
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mig1g', 'mig1ko');
                 disp('special processing of processing 20180614');
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', [], refrange, chan, 3, {strn, 'hxt4'}, false, 200);
            else
            
          try  
        [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false);
        catch
          [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, 7, 3, {strn, 'hxt4'}, false);
          end
            end
        else  %experiment is from batgirl   
        disp('experiment is from batgirl')
        chan=7;
             if ~isempty(regexp(exptList{k},  '20180614_2')) || ~isempty(regexp(exptList{k},  '20180614_1')) || ~isempty(regexp(exptList{k},  '20180615_2'));%this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
                 
                 
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mig1g', 'mig1ko')
                 
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', [], refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             if ~isempty(regexp(exptList{k},  '20180615_2'))
                  cExperiment.dirs=strrep(cExperiment.dirs, 'mig1ko', 'mig1g');
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mth1ko', 'mig1ko');
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             end
             else
            [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
           
        end
        end
        
        disp(['interpolating main data. strain ' strn 'media ' num2str(plotcons(j)), ' replicate ' num2str(k) ]);
        ntimes=linspace(0, 20, 250); %new time vector
        
%         try
        newy= interp1(times, means(1, :), ntimes, 'pchip',nan); %interpolating times to sample at the same point throughout.
%         catch
%             continue
%         end
        
        mat(l,:)=newy;
        disp(['interpolating hxt4 for this replicate']);
        wty= interp1(times, means(2, :), ntimes,'pchip',  nan); %geting the mean of hxt4
        submat(l,:)=newy-wty;
        %interpolating cell traces
        disp('creating interpolant');
        F=griddedInterpolant({times, 1:size(stdmch.(strn).cellInf(chan).mean, 1)},stdmch.(strn).cellInf(chan).mean', 'linear', 'none' );
        
        disp('creating new time grid for all cells');
        qgrid= {ntimes, 1:size(stdmch.(strn).cellInf(chan).mean, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        if l<=numreps
        celldatamutants.(strn).(nam).(['rep' num2str(l)])= F(qgrid)';
        end
        
        disp('making SEM bounds of the interpolated values')
        bndsmat(l,:)=nonZeroColSEM(F(qgrid)');
        
         %interpolating cell sizes
        disp('creating interpolant');
        F=griddedInterpolant({times, 1:size(stdmch.(strn).cellInf(1).area, 1)},full(stdmch.(strn).cellInf(1).area)', 'linear', 'none' );
        
        disp('creating new time grid for all cells');
        qgrid= {ntimes, 1:size(stdmch.(strn).cellInf(1).area, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        if l<=numreps
        sizedatamutants.(strn).(nam).(['rep' num2str(l)])= F(qgrid)';
        end
              
        %interpolating localisation
        disp('creating interpolant');
        nucloc=full(stdmch.(strn).cellInf(nuclocChannel(k)).max5./stdmch.(strn).cellInf(nuclocChannel(k)).median);
        nucloc= nucloc./ repmat(nanmean(nucloc(:, refrange),2), 1, size(nucloc, 2));
        F=griddedInterpolant({times, 1:size(nucloc, 1)},full(nucloc)', 'linear', 'none' );
        
        disp('creating new time grid for all cells');
        qgrid= {ntimes, 1:size(nucloc, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        if l<=numreps
            
        locdatamutants.(strn).(nam).(['rep' num2str(l)]).data= F(qgrid)';
        locdatamutants.(strn).(nam).(['rep' num2str(l)]).num= k;
        end
        
        flds=fieldnames(intervals)
        for o= 1:numel(flds)
            disp(flds{o})
            try        
        [downval, downerr,cellratesmutants.(strn).(nam).(flds{o}).(['rep' num2str(l)])]= meanFLRateWindow(intervals.(flds{o}), stdmch.(strn),[], chan);
            catch
                try
        [downval, downerr,cellratesmutants.(strn).(nam).(flds{o}).(['rep' num2str(l)])]= meanFLRateWindow(intervals.(flds{o}), stdmch.(strn),[], 7);
                catch
         [downval, downerr,cellratesmutants.(strn).(nam).(flds{o}).(['rep' num2str(l)])]= meanFLRateWindow(intervals.special, stdmch.(strn),[], 7);
                end
                
                end
 
        end
            
        
           for o= 1:numel(flds)
            disp(flds{o})
            try        
        [downval, downerr,celllevelsmutants.(strn).(nam).(flds{o}).(['rep' num2str(l)])]= meanFLWindow(intervals.(flds{o}), stdmch.(strn),[], chan);
            catch
                try
        [downval, downerr,celllevelsmutants.(strn).(nam).(flds{o}).(['rep' num2str(l)])]= meanFLWindow(intervals.(flds{o}), stdmch.(strn),[], 7);
                catch
         [downval, downerr,celllevelsmutants.(strn).(nam).(flds{o}).(['rep' num2str(l)])]= meanFLWindow(intervals.special, stdmch.(strn),[], 7);
                end
                
                end
 
            end
        
        
        

        
        %for coloring by experiment, use colorlist(k,:)
        
        if l<=numreps
        boundedline(times, means(1,:),bnds.(strn), 'cmap', concolors(j,:) , 'transparency', 0.05, 'alpha');
             
        h=gca;
        a= get(h, 'children');
        nm=strsplit(exptList{k}, '/'); %getting the experiment's name
        nm=nm{end-1};
        a(1).DisplayName= nm;
        a(2).DisplayName= nm;
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
    meandatamutants.(strn).(nam)=mat;
    allbnds.(strn).(nam)=bndsmat;
    subtractiondata.(strn).(nam)=submat; %data where the hxt4 mean trace is subtracted from the traces.
    locdatamutants.times=ntimes;
    locdatamutants.cy5=cy5;
    locdatamutants.type=concentrations;
    pause(0.5)
%     if strn=='mig1g'
%     locdata.mig1g.g1percent.rep3.data= locdata.mig1g.g1percent.rep3.data(1:200,:)
%    
end


end
%savejson('',celldatamutants,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/mutantsdata.json');

%savejson('',locdata,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/mig1stepsdata.json');
%save('201807_mig1steps.mat', 'locdata')
%% coloring the plots based on the least square diff from wt hxt4

for q=1:numel(strains)
    strn= strains{q};
    for j=1:numel(plotcons)
        subplot(numel(strains), numel(plotcons), numel(plotcons)*(q-1)+j);
        nam=['g' strrep(strrep(num2str(plotcons(j)), '.', 'p'), '0', '') 'percent'];
        mat=subtractiondata.(strn).(nam);
        lsq= @(mat) nanmean(nansum((mat.^2),2));
        set(gca, 'Color', [0, 0, lsq(mat)/10000]);
        
    end
end








uniformAxes(gcf, [], [0,20], [0, 8],[], [] )


%% adjusting line visibilities and alpha


ax=get(gcf, 'children')
set(gco, 'Marker', 's')
c=1;
for k=1:numel(ax)

a=get(ax(k), 'children')
for j=1:numel(a)
if isa(a(j), 'matlab.graphics.primitive.Line')
set(a(j), 'Visible', 'on')
set(a(j), 'Marker', 'o')
set(a(j), 'MarkerSize', 8)
set(a(j), 'MarkerIndices', 1:10:250)

c=c+1;
end
if isa(a(j), 'matlab.graphics.primitive.Patch')
set(a(j), 'FaceAlpha', 0.3)
end
end
end

%% 

gluc={'gp2percent', 'gp4percent', 'g1percent'};

rep='rep1';
figure;

for g=1:3
for r=1:5
subplot(3,5,5*(g-1)+r);
boxplot(alln(cellratesmutants, gluc{g}, 'rep1', r),allng(cellratesmutants, gluc{g}, 'rep1', r), 'ColorGroup',cmap([r r r r r r],:) )
ylim([-.5,.5])
end
end



%