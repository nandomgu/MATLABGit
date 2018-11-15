[cellInfs, chosenExperiments] =collectExportCellInfs(strain, expttype, subtype)
%%create a cellInf collection in the shape of a struct array, all with the
%%names cellInf. It is a bit beating around the bush for something that
%should be relatively simple, plus it loses track of what the original
%experiment is.

%%%HAT INFO

if strcmp(expttype, 'hat')==1
subtypes=[
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
}

exptListFile={...%reverse
'20170610multichamber',...
'20170613multichamber',...
'20170615multichamber',...
'20170629multichamber',...
'20170630multichamber',...
'20170703multichamber',...
'20170704multichamber',...
'20170720multichamber',...
'20170721multichamber',...
'20170722multichamber',...
'20170518multichamber',...
'20170525multichamber',...
'20170521multichamber'...
}
end
else if strcmp( expttype, 'ramp')==1
        
n=1
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180403_results/cExperiment.mat'
subtypes(n)=0
repnum(n)=1;
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180405_results/cExperiment_001real.mat'
subtypes(n)=0
repnum(n)=2;
%%342
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180329_results/cExperiment_001.mat'
subtypes(n)=2
repnum(n)=1;

n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180328_results/cExperiment_001c03601.mat'
subtypes(n)=2
repnum(n)=2;
%344
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180322_results/cExperiment_001.mat'
subtypes(n)=4
repnum(n)=1;

n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180409_results/cExperiment.mat'
subtypes(n)=4
repnum(n)=2;
%346
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180410_results/cExperiment.mat'
subtypes(n)=6
repnum(n)=1;




 
for j=1:numel(ramppaths)
     l1=load(ramppaths{j});
     cExperiment=l1.cExperiment;
     multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [1:30], 7,3)
     
end


%%%Placing the data in a form similar to Julian's
cellchan=8;
bgchan=3;
datamatrices=struct;
starttime=7 %in hours
stoppoint=180 % last timepoint index. dependent on the lenght of the experiments.
for j=1:numel(ramppaths)
     l1=load(ramppaths{j});
     cExperiment=l1.cExperiment;
     
     
     
     %                                                     range,
     %                                                        cExperiment,cmap,
     %                                                                           refzero,refone, refrange ,cellchan, 
     % if                                                                                                             bgchan, nms, makeplot
     
     [h, means, times, stdmch]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1g', [1:30], cellchan,bgchan, [], 0)
     [cy, nms]=processcy5(stdmch);
     if ~ismember('mig1g', nms)
        [h, means, times, stdmch]=multiMeanPlotRobustStdAdvanced([], cExperiment, [], 'wt', 'mig1', [1:30], cellchan,bgchan, [], 0)
        [cy, nms]=processcy5(stdmch)
     end
     
     cy= normalizeTS(nanmean(cy)); %%
     startpoint=find(abs(times-7)==min(abs(times-7))) %datapoint closest to 7 hours
     hxt4peakindex=find(nonzeroColMean(stdmch.hxt4.cellInf(cellchan).mean)==nanmax(nonzeroColMean(stdmch.hxt4.cellInf(cellchan).mean))) %hxt4 peak is a proxy for glucose depletion
     hxt4peakval=cy(hxt4peakindex);
     cy= cy.*(cy>cy(hxt4peakindex))%values after the hxt4 peak become the value of glucose at hxt4 peak
     cy(cy==0)=hxt4peakval;
     for k=1:numel(nms)
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).area= full(stdmch.(nms{k}).cellInf(1).area(:, startpoint:stoppoint)); %arbitrarily setting the window to 180
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).GFP= full(stdmch.(nms{k}).cellInf(cellchan).mean(:, startpoint:stoppoint));
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).GFPramp= full(stdmch.(nms{k}).cellInf(cellchan).mean(:, startpoint:hxt4peakindex)); %%traces exclusively during thr ramp
     matr=full(stdmch.(nms{k}).cellInf(cellchan).mean); %get the complete matrix first
     refvalues=matr(:, startpoint:startpoint+4);
     refvalues=nonzeroColMean(refvalues')';
     foldchangematr=matr./ repmat(refvalues, 1, size(matr,2));
     matr=matr.*(matr>0) %make negative values 0 in case something was lower than the wild type
     matr=matr- repmat(nanmean(matr(:, startpoint:startpoint+2),2), 1, size(matr,2)); %subtracting the average of the first 3 timepoints at the ramp startpoint. if negative the trace becomes 0 and we subtract 0.
     matr=matr- repmat(nanmean(matr(:, startpoint:startpoint+2),2), 1, size(matr,2)); %subtracting the average of the first 3 timepoints at the ramp startpoint. if negative the trace becomes 0 and we subtract 0.
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).GFPfoldchange= foldchangematr(:, startpoint:stoppoint);%% full length subtracting the value at start
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).GFPrampfoldchange= foldchangematr(:, startpoint:hxt4peakindex);%% full length subtracting the value at start
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).GFPnobg= matr(:, startpoint:stoppoint);%% full length subtracting the value at start
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).GFPrampnobg= matr(:, startpoint:hxt4peakindex);%% same as above only for the ramp
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).glucose = normalizeTS(cy(startpoint:stoppoint)); %we normalize again, now to make the cy5 go to 0
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).glucoseramp = normalizeTS(cy(startpoint:hxt4peakindex)); %we normalize again, now to make the cy5 go to 0
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).time=times(startpoint:stoppoint)-times(startpoint); %setting initial point as zero
     datamatrices.(nms{k}).(['ramp' num2str(subtypes(j)) 'hr']).(['rep' num2str(repnum(j))]).timeramp=times(startpoint:hxt4peakindex)-times(startpoint);
     end
     
end
     
 savejson('',datamatrices,'/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/rampData.json');
 
 
 %%%plotting 
 strainnames=fieldnames(stdmch);    
 flds=fieldnames(datamatrices.hxt4);
 figure;
 
 for k=1:numel(strainnames)
for j=1:numel(flds) 
    try
    subplot(numel(strainnames),numel(flds), (k-1)*numel(flds)+j); plot(datamatrices.(strainnames{k}).(flds{j}).rep1.glucose, datamatrices.(strainnames{k}).(flds{j}).rep1.GFP');title(flds{j});     
    catch
        subplot(numel(strainnames),numel(flds), (k-1)*numel(flds)+j); plot(datamatrices.('mig1').(flds{j}).rep1.glucose, datamatrices.('mig1').(flds{j}).rep1.GFP');title(flds{j});         
    end
    ylim([0,30])
if ismember(j, [1,4,7,10])
    ylabel(strainnames(k))
end
end

 end



     mch= makeMultiChamber(cExperiment);
     [cy, nms, times]=processcy5(mch)
     cy= normalizeTS(nanmean(cy5)); %% getting the normalised cy5 signal
     expdate=cExperiment.metadata.data
     nms=fieldnames(mch);
     
end




     
     
   

%% COLLECTING ALL RAMP EXPERIMENTS IN A CELLINFS STRUCTURE
 sCon=zeros(1, numel(ramppaths));
 cellInfs=struct;
for j=1:numel(ramppaths)
     l1=load(ramppaths{j});
     cExperiment=l1.cExperiment;
     mch= makeMultiChamber(cExperiment);
    
     
     splits=strsplit(ramppaths{j}, filesep);
     foldersplits=strsplit(splits{end-1}, '_');
     expdate=foldersplits{1};
     nms=fieldnames(mch);
     for k =1:numel(nms)
         
       mch.(nms{k})=trimCellInf(mch.(nms{k}));
       %mch.(nms{k}).cellInf=formatCellInf(mch.(nms{k}).cellInf);
       expname=['e_' expdate '_' num2str(subtypes(j)) 'hr_' nms{k}];
       cellInfs.(expname)= mch.(nms{k}).cellInf;
     end

end

%convert the object above into a structure array... because the export json
%function just can't deal with a structure of cellInfs and works well when
%given just one preformatted cellInf
%when cellInfs a structure containing preformatted cellInfs in each field,
%then it just pretends to write but actually doesn't write anything. 
exportJSONCellInf(cellInfs, 'test.json')

%when not preformatting the cellInfs, the thing just crashes. saying that
%too many arguments are being passed. 


%if we take individual cellInfs of that structure and put them in an
%array...
exportJSONCellInf([cellInfs.e_20180322_4hr_hxt2,cellInfs.e_20180322_4hr_hxt4,cellInfs.e_20180322_4hr_hxt7],'ramps.json')
%%it magically works! so we just need to create an array. but this is
%%extremely inconvenient because we lose track of what is what.
%%trying to skip the exportJSON modality altogether and just directly do
%%the savejson

savejson('',cellInfs,'ramps.json')

%%nope, it didn't write anything. now we just concatenate a struct array
%%manually
%%Whis works but has issues when adding more than 20 experiments... no idea
%%why

nms=fieldnames(cellInfs)
rng=1:numel(nms)
cellInfs2= struct('cellInf', 1)
c=1
for j =rng
cellInfs2(c).cellInf= cellInfs.(nms{j})
c=c+1
%cellInfs2(j).name= nms{j}   
end

exportJSONCellInf(cellInfs2, 'ramps.json')








%strains={'hxt2', 'hxt4', 'hxt7'} 
typenames={'hxt4_0hr', 'hxt4_2hr', 'hxt4_4hr', 'hxt4_6hr'}
types={'0hr_hxt4', '2hr_hxt4', '4hr_hxt4', '6hr_hxt4'}
cellInfGrouped=struct;
for y=1:numel(types)

selected=~cellfun(@isempty, cellfun(@strfind,  nms,repmat({types{y}}, numel(nms),1), 'UniformOutput', false));
rng=find(selected); 

%IT REALLY DOESNT DO RECURSION WELL.... BACK TO CELLINF ARRAY
%%cellInfGrouped.(typenames{y})=cellInfs2(rng)

cellInfs3=cellInfs2(rng).
exportJSONCellInf(cellInfs3, ['/Users/s1259407/Dropbox/PhD/phd_peter_swain/R/' typenames{y} '.json'])
end











     sCon(j)=sum(strcmp(fieldnames(mch), strain))==1
     
    
        

%%future developments:
%check whether some experiment in the list is a cExperiment and if so then create a multichamber
%structure with makeMultiChamber JSON.
containsStrain = @(expmt,str) sum(strcmp(fieldnames(evalin( 'base', expmt)), str))>0;
sCon=cell2mat(cellfun(containsStrain, exptList, repmat({strain}, 1, numel(exptList)), 'UniformOutput', false))

chosenExperiments=exptList(sCon);

if nargin<3
    choiceBySubtype= ones(1, numel(chosenExperiments))
else
    choiceBySubtype= subtypes==subtype


 parts=strsplit(exptList{1},'multichamber')
 dat=parts{1}
 
 
for j =1:numel(exptListFile) 
load(['/Users/s1259407/Google Drive/matlabDrive' filesep exptListFile{j}  '.mat'])
'cellInfs(j)=' exptList{j}.(strain).cellInf

end





%%weird thing where we have to initialize the structure fields to a number.
initArray= mat2cell(ones(1, numel(chosenExperiments)),1);
cellInfs= struct('cellInf', initArray)
for j=1:numel(chosenExperiments)
    multichamber=evalin('base', chosenExperiments{j})
    mtrimmed=trimCellInf(multichamber.(strain))
    cellInfs(j).cellInf= mtrimmed.cellInf
end
 

cellInfs=struct;
for j=1:numel(chosenExperiments)
    multichamber=evalin('base', chosenExperiments{j})
%then you can call
exportJSONCellInf(cellInfs,'test.json')



% %%works
% cellInfs=struct('cellInf', {1,1,1,1,1})
% cellInfs(1).cellInf=mm.hxt1
% cellInfs(2).cellInf=mm.hxt3
% cellInfs(3).cellInf=mm.hxt4
% cellInfs(4).cellInf=mm.hxt6
% cellInfs(5).cellInf=mm.mig1g
% exportJSONCellInf(cellInfs,'test.json')
% 
% 
% %%Does not work!
% 
% cellInfs=struct('cellInf', {1,1,1,1,1})
% cellInfs(1).cellInf=multichamber.(strain).cellInf
% cellInfs(2).cellInf=multichamber.(strain).cellInf
% cellInfs(3).cellInf=multichamber.(strain).cellInf
% cellInfs(4).cellInf=multichamber.(strain).cellInf
% cellInfs(5).cellInf=multichamber.(strain).cellInf
% exportJSONCellInf(cellInfs,'test.json')
% 
% %%must be some of the fields in the cellInf causing the problem, 
% %%as that is the only difference between the two prev. blocks.
% %created function trimCellInf to get rid of extra fields such as I did
% %for makeMultiChamberJSON
% 
% mtrimmed=trimCellInf(multichamber.(strain));
% cellInfs=struct('cellInf', {1,1,1,1,1})
% cellInfs(1).cellInf=mtrimmed.cellInf
% cellInfs(2).cellInf=mtrimmed.cellInf
% cellInfs(3).cellInf=mtrimmed.cellInf
% cellInfs(4).cellInf=mtrimmed.cellInf
% cellInfs(5).cellInf=mtrimmed.cellInf
% exportJSONCellInf(cellInfs,'test.json')
% %%works!! :D
% 
