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

%% hxt experiments


currentfolders={...
%'20170610_results', 0.4;...%20170610  glucose 0.4 hat
%'20170613_results', 0.4;...%20170613 glucose 0.4 hat
%'20170615_results',0.2;...%20170615 glucose 0.2% hat %0.4,...%20170627 glucose 0.4% hat.FAULTY EXPT
%'20170629_results',0.4;...%20170629 glucose 0.4 hat
%'20170630_results',0.4;...%20170630 glucose 0.4 hat
%'20170703_results',1;...%20170703 glucose 1% hat... originallly labelled 20170703 but currently can't find this.
'20170704_results',1; ...%20170704 1% hat
%'20170720_results',0.2; ...%20170720 0.2% hat
%'20170721_results',0.2;...%20170721 0.2% hat
%'20170722_results',0.2;...%20170722 0.2% hat
'20170518_results',1;...%20170518 1% hat
'20170525_results',1;...%20170525 1% hat
'20170521_results',1;...%20170521 1% hat
'20171007_results_omero',1;...%20171007 1% hat
%'20171009_results',1;...%20171009 1% hat 4hr hat it seems
'20171012_results',1;...%20171012 1% hat
%'20171013_results',1;...%20171013 1% hat 4hrs
'20170302Mock',1;...
%'20170303_results', 0.4;...
'20170221_results', 1;...
'20170222_results', 1;...

}

%% currentfolders={...
%'20170610_results', 0.4;...%20170610  glucose 0.4 hat
%'20170613_results', 0.4;...%20170613 glucose 0.4 hat
%'20170615_results',0.2;...%20170615 glucose 0.2% hat %0.4,...%20170627 glucose 0.4% hat.FAULTY EXPT
%'20170629_results',0.4;...%20170629 glucose 0.4 hat
%'20170630_results',0.4;...%20170630 glucose 0.4 hat
%'20170703_results',1;...%20170703 glucose 1% hat... originallly labelled 20170703 but currently can't find this.
'20170704_results',1; ...%20170704 1% hat
%'20170720_results',0.2; ...%20170720 0.2% hat
%'20170721_results',0.2;...%20170721 0.2% hat
%'20170722_results',0.2;...%20170722 0.2% hat
'20170518_results',1;...%20170518 1% hat
'20170525_results',1;...%20170525 1% hat
'20170521_results',1;...%20170521 1% hat
'20171007_results_omero',1;...%20171007 1% hat
%'20171009_results',1;...%20171009 1% hat 4hr hat it seems
'20171012_results',1;...%20171012 1% hat
%'20171013_results',1;...%20171013 1% hat 4hrs
'20170302Mock',1;...
%'20170303_results', 0.4;...
'20170221_results', 1;...
'20170222_results', 1;...

}

%%
cy5=[];
recompile=false;
exptList={};
allnms={};
for n= 1:size(currentfolders, 1)
disp(['trying folder number ' num2str(n) ': ' currentfolders{n,:} ])
pth=[rootpath filesep currentfolders{n,1}] ;
disp(pth)
a=dir(pth);
a={a.name};
disp('Finding cExperiment file...')
cexp=a(logical(cell2mat(cellfun(@empty2Zero, regexp(a, 'ce?E?xperiment_?\d?\d?\d?.mat'), 'UniformOutput', false))));
%in the scary case there might be 2 cExperiment folders...
cexp=cexp(1);
disp('making path for cExperiment file')
exptList{n}= strjoin([pth filesep cexp], '')
%getting the recorded sugar concentration
l1=load(exptList{n})
disp('loading experiment')
cExperiment=l1.cExperiment
mch=makeMultiChamber(cExperiment)
bgchan=3;

%if size(cExperiment.cellInf(bgchan).mean,2)>= 250

    cy5(n, :)= topUp(normalizeTS(nonzeroColMean(cExperiment.cellInf(bgchan).mean)), 250);
    %times=  (0: numel(cy5(n, :)))*5/60;
    hillfactor=6; 
    thresh=0.4
    hill = @(input)   (input^hillfactor)/(thresh^hillfactor+ input^hillfactor); 
    %figure; plot(arrayfun(hill, glucose))
    tmpinput=arrayfun(hill, cy5(n, :));
    figure; plot(cy5(n, :))
    hold on; plot(tmpinput)
    %fprintf(fopen([currentfolders{n, 1} '_input.txt'], 'w'),'%3.3f , %3.3f\n', [times(1:230)',  tmpinput(1:230)']')

    
    %end
drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);
disp('getting experiment''s strain names')
allnms{n}=unique(cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false))
uniquedirs=allnms{n}
try
uniqextracted= unique(drnames(cExperiment.cellInf(1).posNum));
end

% if isempty(cExperiment.cellInf) || ~isfield(cExperiment.cellInf(1),'posNum') || numel(uniquedirs) ~= numel(uniqextracted) || recompile==true
%     cExperiment.posTracked=ones(1, numel(cExperiment.dirs))
%     cExperiment.compileCellInformation()
%     cExperiment.saveExperiment()
% end
%     

%[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, 8, 3, [], true)
disp('getting experiment''s declared sugar concentration')
try
stri=char(cExperiment.metadata.acq.pumpInit{1, 'contents'})
parts=strsplit(stri, '%');
catch
    disp('no metadata')
end
%currentfolders{n, 2}= str2double(parts{1});
end

if recompile
for j=1:numel(exptList)
try
l1=load(exptList{j});
disp('loading experiment')
cExperiment=l1.cExperiment ;   
cExperiment.posTracked=ones(1, numel(cExperiment.dirs));
cExperiment.compileCellInformation();
cExperiment.saveExperiment()
catch
    disp(['experiment' exptList{j} 'could not be recompiled'])
end

end
end



%%

mrkrs= ['o', '+', '^','x', 's', '*', 'v'];

%distinct colors for each HXT
straincolors=[
 0 0.8 0.8;
 0 0 0.5;
 0.8 0 0.8;
 1 0 0;
 1 0.8 0;
 0.3 0.3 0.3;
 0 0.5 0
]


newcolors=[.8 0 .8; %magenta
    .08, .6, 1; % light blue
    .5, 0, .9; % purple
   0,0, .6; %dark blue
   0,0,0; % black
   .3,.8, .3;  %lighter green
   .1, .5, .1]           %darker green
    

%%
refstrain='hxt4' %make [] if unwanted
refrange=[1:30]   % make [] if unwanted
mode=2; 

 strains={...
      'hxt1';
      'hxt2';...
      'hxt3';...
      'hxt4';...
     'hxt5';...
      'hxt6';...
      'hxt7';
}
 
%strains={'mocloHXT4', 'mocloSTRE'}


%strains={'mocloSTRE'}
%cmap=[0,0,0;0,.5, .5;0,.8,.8];
%which experiments contain mig1
containsmig= cellfun(@(c) sum(strcmp(c, 'mig1g'))>0, allnms)
currentfolders(containsmig)
meandata=struct;
subtractiondata=struct;
locdata=struct;
celldata=struct;
diffdata=struct;
fl=0;
cmap=linspecer(size(exptList,2));
plotcons=[ 1]; % just interested in 1% for now
flag=0
  figure;
 mod=1 ;
for q=1:numel(strains)
 % subplot(numel(strains), 1, q); when plotting per concentration
for j=1:numel(plotcons)
      nam=['g' strrep(strrep(num2str(plotcons(j)), '.', 'p'), '0', '') 'percent'] %the name of the condition to name data structures
   %try 
%this mode matches the exact strain


containsStrain = @(nms,str) sum(strcmp(nms, str))>0;
sCon=cell2mat(cellfun(containsStrain, repmat(allnms, numel(strains(q)), 1), repmat(strains(q)', 1, numel(exptList)), 'UniformOutput', false));
cy5tree.(strains{q})=cy5(sCon, :);
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
        
        %subplot(numel(strains), numel(plotcons), numel(plotcons)*(q-1)+j);
        disp(['fetching experiment' num2str(k)])
        l1=load(conlist{k})
        cExperiment=l1.cExperiment;
        strn=strains{q};

        %if strcmp(cExperiment.metadata.microscope, 'Batman') %experiments of Hxts are all from batman and were extracted from channel 2
            
        if strfind(conlist{k}, '20171007')>0
         chan=1;
        else
        chan=2;
        end
              disp(['processing data for strain ' strn])
              if strfind(conlist{k}, '20171009')>0
              [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdBasic([], cExperiment, [], refstrain , chan,3, {strn, 'hxt4'}, 0, 0.48); %mig1 background levels are higher and clearly scaled in this experiment with respect to others
              else
                  if strfind(conlist{k}, '20171007')>0
              [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdBasic([], cExperiment, [], refstrain , chan,3, {strn, 'hxt4'}, 0, 0.26); %mig1 background levels are higher and clearly scaled in this experiment with respect to others
                  else
              [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdBasic([], cExperiment, [], refstrain , chan,3, {strn, 'hxt4'}, 0, 0.22);
                  end
              end
        %if q==3   
         allsplits=strsplit(conlist{k}, '/'); expname= allsplits(end-1);
         %multiMeanPlotRobust3([], stdmch, colstruct)   
         title(expname);
         disp('pausing')
         tmpmn=nanmean(stdmch.(strains{q}).cellInf(chan).mean)';
         tmpsd=nanstd(stdmch.(strains{q}).cellInf(chan).mean)';
         fprintf(fopen(strjoin(['experiment_' expname '_' strains{q} '_data.txt'] , ''), 'w'),'%3.3f ,%3.3f, %3.3f\n', [times(1:230)',  tmpmn(1:230), tmpsd(1:230)]')
         
         %pause(30)
        %end   
              %%
        disp('plotting sugar')
        if fl==0
            yyaxis right
        area(times, cy5(2,:), 'FaceAlpha', 0.1, 'FaceColor', [1, .6, 0], 'EdgeColor', 'none'); 
        yyaxis left
        fl=1;
        end
        
       
        
        %%
        disp('making the boundedline plot')
        boundedline(times, means(1,:),bnds.(strn), 'cmap', straincolors(q, :), 'transparency', 0.1, 'alpha');
       %inputdlg('')
        h=gca;
        a= get(h, 'children');
        nm=strsplit(conlist{k}, '/'); %getting the experiment's name
        nm=nm{end-1}
        a(1).DisplayName= nm;
        a(2).DisplayName= nm;
        hold on;
        if q==numel(strains)
        xlabel('Time (Hrs)');
        end
        ylabel('Mean cell FL (±SEM)');
        title([strn ' in ' num2str(plotcons(j))]);
        %ylim([0,10])
       
              
               %[h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
%             end
%         else  %experiment is from batgirl   
%         disp('experiment is from batgirl')
%         chan=6;
%              if ~isempty(regexp(conlist{k},  '20180614_2')) || ~isempty(regexp(conlist{k},  '20180614_1')) || ~isempty(regexp(conlist{k},  '20180615_2'))%this experiment lacks mig1 gfp so scaling based on hxt4 from other experiments is applied
%                  
%                  
%                  cExperiment.dirs=strrep(cExperiment.dirs, 'mig1g', 'mig1ko')
%                  
%                  [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
%              if ~isempty(regexp(conlist{k},  '20180615_2'))
%                   cExperiment.dirs=strrep(cExperiment.dirs, 'mig1ko', 'mig1g')
%                  cExperiment.dirs=strrep(cExperiment.dirs, 'mth1ko', 'mig1ko')
%                  [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
%              end
%              else
%             [h, means, times, stdmch, bnds]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', refrange, chan, 3, {strn, 'hxt4'}, false, 200);
%              
%         end
%         end
        
        disp(['interpolating main data. strain ' strn 'media ' num2str(plotcons(j)), ' replicate ' num2str(k) ])
        ntimes=linspace(0, 20, 450); %new time vector
        newy= interp1(times, means(1, :), ntimes, 'pchip',nan); %interpolating times to sample at the same point throughout. points above return a nan
        mat(k,:)=newy;
        disp(['interpolating hxt4 for this replicate'])
        wty= interp1(times, means(2, :), ntimes,'pchip',  nan); %geting the mean of hxt4
        submat(k,:)=newy-wty;
        
        %interpolating cell traces
        
        if k<=10
        disp('creating interpolant')
        F=griddedInterpolant({times, 1:size(stdmch.(strn).cellInf(chan).mean, 1)},stdmch.(strn).cellInf(chan).mean', 'linear', 'none' );
        
        disp('creating new time grid for all cells')
        qgrid= {ntimes, 1:size(stdmch.(strn).cellInf(chan).mean, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        
       
        celldata.(strn).(nam).(['rep' num2str(k)])= F(qgrid)';
        
        
        
        
         %interpolating localisation
        disp('creating interpolant');
        nucloc=full(stdmch.(strn).cellInf(chan).max5./stdmch.(strn).cellInf(chan).median);
        nucloc= nucloc./ repmat(nanmean(nucloc(:, refrange),2), 1, size(nucloc, 2))
        F=griddedInterpolant({times, 1:size(nucloc, 1)},full(nucloc)', 'linear', 'none' );
        
        disp('creating new time grid for all cells');
        qgrid= {ntimes, 1:size(nucloc, 1)};
        
        disp('storing the interpolated cell data for the first 2 reps  only');
        
        locdata.(strn).(nam).(['rep' num2str(k)])= F(qgrid)';
        
        end
        
        
        

            end  
 
   
    
   
    
    


    disp('adding matrices')
    meandata.(strn).(nam)=mat;
    subtractiondata.(strn).(nam)=submat; %data where the hxt4 mean trace is subtracted from the traces.
    pause(0.5)
   
   
end


end
end

ylim([0, 25])
xlim([0,20])
savejson('',celldata,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/hxtdata.json');
savejson('',meandata,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/hxtmeandata.json');

uniformAxes(gcf, [], [0,20], [0, 5],[], [] )




%% adjusting line visibilities and alpha


ax=get(gcf, 'children')

c=1;
for k=1:numel(ax)

a=get(ax(k), 'children')
for j=1:numel(a)
if isa(a(j), 'matlab.graphics.primitive.Line') || isa(a(j), 'matlab.graphics.chart.primitive.Line')
set(a(j), 'Visible', 'on')
%set(a(j), 'Marker', 'none')
%set(a(j), 'MarkerSize', 8)
%set(a(j), 'MarkerIndices', 1:10:250)
set(a(j), 'LineStyle', '-')
%set(a(j), 'Color', [.2 .2 .2])
%set(a(j), 'MarkerEdgeColor', [0 0 0])
c=c+1;
end
if isa(a(j), 'matlab.graphics.primitive.Patch')
set(a(j), 'FaceAlpha', 0.2)
end
end
end


%%coloring the plots based on the least square diff from wt hxt4
%% 
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

%% clustering the dynamics of the hxts

%getting one replicate per Hxt
hxtmeanrep=structfun(@(c) c.g1percent(randsample(1:size(c.g1percent,1), 1), :), meandata, 'UniformOutput', false)

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






