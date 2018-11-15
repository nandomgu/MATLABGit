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
'20170703_results',1;...%20170703 glucose 1% hat
'20170704_results',1; ...%20170704 1% hat
'20170720_results',0.2; ...%20170720 0.2% hat
'20170721_results',0.2;...%20170721 0.2% hat
'20170722_results',0.2;...%20170722 0.2% hat
'20170518_results',1;...%20170518 1% hat
'20170525_results',1;...%20170525 1% hat
'20170521_results',1;...%20170521 1% hat
'20171007_results',1;...%20171007 1% hat
'20171009_results',1;...%20171009 1% hat
'20171012_results',1;...%20171012 1% hat
'20171013_results',1;...%20171013 1% hat

}

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
    '20180614_1_results', 0.2;
    '20180614_2_results', 0.2;
    '20180615_1_results', 0.2;
    '20180615_2_results', 0.2;
    }

exptList={}
allnms={}
for n=1:size(currentfolders, 1)
pth=[rootpath filesep currentfolders{n,1}] ;
a=dir(pth);
a={a.name};
cexp=a(logical(cell2mat(cellfun(@empty2Zero, regexp(a, 'cExperiment_?\d?\d?\d?.mat'), 'UniformOutput', false))));
%in the scary case there might be 2 cExperiment folders...
cexp=cexp(1);
exptList{n}= strjoin([pth filesep cexp], '')
%getting the recorded sugar concentration
l1=load(exptList{n})
cExperiment=l1.cExperiment
allnms{n}=unique(cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false))
%[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, 8, 3, [], true)
stri=char(cExperiment.metadata.acq.pumpInit{1, 'contents'})
parts=strsplit(stri, '%');
currentfolders{n, 2}= str2double(parts{1});
end








refstrain='hxt4' %make [] if unwanted
refrange=[1:30]   % make [] if unwanted
mode=2; 

strains={...
    'hxt4';...
    'mig1ko';...
    'snf3ko';...
    'rgt2ko';...
    'std1ko';...
    'mth1ko'}

% strains={...
%     'hxt4';...
%     'mig1ko';...
%     'std1ko'}



%allnms= cellfun(@(expt)fieldnames(multiChamberFromPath(expt)), exptList, 'UniformOutput', false);

%making 20180614_2 contain the name mig1ko as it is mislabelled as mig1g

tmp=allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_2'))>0}
tmp{end+1}='mig1ko'
allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_2'))>0}=tmp;

%% this experiment does not have mig1ko well annotated.
tmp=allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_1'))>0}
tmp{end+1}='mig1ko'
allnms{cellfun(@empty2Zero, regexp(exptList, '20180614_1'))>0}=tmp;




%cmap=[0,0,0;0,.5, .5;0,.8,.8];
meandata=struct;
subtractiondata=struct;
celldata=struct;
cmap=linspecer(size(exptList,2));
plotcons=[0.2, 0.4, 1];
flag=0
  figure;
 mod=1 ;
for q=1:numel(strains)
  
for j=1:numel(plotcons)
   subplot(numel(strains), numel(plotcons), numel(plotcons)*(q-1)+j);
   nam=['g' strrep(strrep(num2str(plotcons(j)), '.', 'p'), '0', '') 'percent'] %the name of the condition to name data structures
   %try 
%this mode matches the exact strain


containsStrain = @(nms,str) sum(strcmp(nms, str))>0;
sCon=cell2mat(cellfun(containsStrain, repmat(allnms, numel(strains(q)), 1), repmat(strains(q)', 1, numel(exptList)), 'UniformOutput', false));



concentrations=[currentfolders{:,2}];
 exptchoice=exptList(sCon);  
 colorchoice=cmap(sCon, :);
   localcons= concentrations(sCon); %concs of the experiments chosen
   whicharequery= localcons==plotcons(j); %which expts belong to the concentration in place
   conlist=exptchoice(whicharequery);
   colorlist=colorchoice(whicharequery,:)
   
              mat=[];
        submat=[];
   if ~isempty(conlist)

    for k=1:numel(conlist)

        l1=load(conlist{k})
        cExperiment=l1.cExperiment
        strn=strains{q};
        

        
        
        if strcmp(cExperiment.metadata.microscope, 'Batman')
            chan=8;
            
            if ~isempty(regexp(conlist{k},  '20180614_1')) %this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
               
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mig1g', 'mig1ko')
                 
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
            else
            
          try  
        [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false)
        catch
          [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, 7, 3, {strn, 'hxt4'}, false)
          end
            end
        else  %experiment is from batgirl   
        disp('experiment is from batgirl')
        chan=6;
             if ~isempty(regexp(conlist{k},  '20180614_2')) || ~isempty(regexp(conlist{k},  '20180614_1')) || ~isempty(regexp(conlist{k},  '20180615_2'))%this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
                 
                 
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mig1g', 'mig1ko')
                 
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             if ~isempty(regexp(conlist{k},  '20180615_2'))
                  cExperiment.dirs=strrep(cExperiment.dirs, 'mig1ko', 'mig1g')
                 cExperiment.dirs=strrep(cExperiment.dirs, 'mth1ko', 'mig1ko')
                 [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             end
             else
            [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
             
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
        if k<=3
        celldata.(strn).(nam).(['rep' num2str(k)])= F(qgrid)';
        end
        
        boundedline(times, means(1,:),bnds.(strn), 'cmap', colorlist(k,:), 'transparency', 0.2);
             
        h=gca;
        a= get(h, 'children');
        nm=strsplit(conlist{k}, '/'); %getting the experiment's name
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
    disp('adding matrices')
    meandata.(strn).(nam)=mat;
    subtractiondata.(strn).(nam)=submat; %data where the hxt4 mean trace is subtracted from the traces.
    pause(0.5)
   
   
end


end
savejson('',celldata,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/stepsdata.json');
%%coloring the plots based on the least square diff from wt hxt4

for q=1:numel(strains)
    strn= strains{q};
    for j=1:numel(plotcons)
        subplot(numel(strains), numel(plotcons), numel(plotcons)*(q-1)+j);
        nam=['g' strrep(strrep(num2str(plotcons(j)), '.', 'p'), '0', '') 'percent']
        mat=subtractiondata.(strn).(nam)
        lsq= @(mat) nanmean(nansum((mat.^2),2))
        set(gca, 'Color', [0, 0, lsq(mat)/10000])
        
    end
end








uniformAxes(gcf, [], [0,20], [0, 8],[], [] )



