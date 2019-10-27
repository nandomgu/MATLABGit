 
%% all high quality experiments to archive
currentfolders={
    %ramps
'20180403_results',0;
'20180405_results', 0;
'20180329_results',2;
'20180328_results',2;
'20180322_results',4;
'20180409_results',4;
'20180410_results',6;


'20180505_results',0.2;...
    '20180522_results',0.2;...
    '20180523_results',0.2;...
    '20180524_results',0.2;...
    '20180525_results',0.2;...
    '20180529_results',0.4;...
    %'20180530_results',0.4;... %experiment  is of very poor quality in
    %many ways.
    %'20180531_results', 0.4;... %excluding experiment because the
    %downshift occurs earlier
    '20180904_results_extended', 0.4;
    '20180601_results', 0.4;
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
odb = SystemPreferences.omerodb;
for n= 1:size(currentfolders, 1)
disp(['trying folder number ' num2str(n) ': ' currentfolders{n,:} ])
pth=[rootpath filesep currentfolders{n,1}] ;
disp(pth)
a=dir(pth);
a={a.name};
disp('Finding cExperiment file...')
cexp=a(logical(cell2mat(cellfun(@empty2Zero, regexp(a, 'ce?E?xperiment_?\d?\d?\d?\w*.mat'), 'UniformOutput', false))));
%in the scary case there might be 2 cExperiment folders...
cexp=cexp(1);
disp('making path for cExperiment file')
exptList{n}= strjoin([pth filesep cexp], '')
%getting the recorded sugar concentration
l1=load(exptList{n})
disp('loading experiment')
cExperiment=l1.cExperiment
rootfolders{n}= cExperiment.rootFolder
ids{n}=cExperiment.id
odbtags{n}=odb.getDsListFromTag(cExperiment.id)
end
%%


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


