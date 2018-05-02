%% Script to process many cExperiments at once.
%% Version 1.0.0. By Luis Montano, Fall 2016
%%purpose: The ultimate goal of this script is to generate robust batch
%%processing for multiple microscope experiments (and eventually largescale analysis) 
%%When to use this script:
    %when you have many experiments to analyse, want the same analysis pipeline in all of them
    %but you cannot afford to point and click through the GUI at every point (like if you are on
    %vacation)
    %If you find it hard to remember what experiments, timepoints and
    %positions you have processed and in what way.
    %If you'd rather have most positions processed even though some errors
    %ocurred, rather than find out you lost 8 hrs of overnight processing
    %If you feel like your decision making might be biasing your results
    %If you want to perform batch modifications to all your experiments
    %without having to remember every single path 
    %if you want to run processes emancipating yourself entirely from the
    %GUI.

%%BEFORE USE: Make sure you silence all calls to rethrow(error) thrown by the logger.
%as they will force crashing of the processing. A list of the ones found is below:


    
    
%specific objectives and features:
%%a)Automation of trivial decisions and decision trees. 
    %Any decision that is trivial, scales with the number of positions/groups, and could benefit from standardization should be automated.
        % linking and naming image and results folders, especially as the naming may cause trouble.
        % smart grouping of positions based on group names. 
%%b)Processing modularity and robustness at the position level. 
        % If processing of one position or experiment must crash, this shouldn't interfere with the rest of the processing.
%%c)If errors can be prevented by default harmless processing, such processing should be applied automatically. 
        %Automatically determining the largest shared number of timepoints
%%d)Inspection and visualization of processing and and failure history of each cExperiment, position, trap, timepoint and cell
        %draw an image with all the traps selected in the experiment.
%%e)all successfully completed processing will not be rerun unless %%specified otherwise.
        %processing the new step only happens in positions/experiments where the
        %previous step has been completed.
%%f)It should be possible to do, undo or redo all processes if needed. 
        %robust assignment and reassignment of channels.
%%g) potentially this could pave the way to parallelise processing of positions.

%%%%SECTION 1. ORGANISING PATHS, CREATING RESULTS FOLDERS, OVERVIEW OF EXPERIMENT
%%%%CONTENTS.
%% 1.1 root paths for a folder with multiple experiments, and a path for storing the multiple results. 

%experimentPath= '/Users/s1259407/Desktop/timelapses/201608_differen_slope_ramps';
%timelapseResultsPath= '/Users/s1259407/Desktop/timelapse_results/201608_results';

%experimentPath= '/Users/s1259407/Desktop/timelapses/201609_different_slope_ramps';
%timelapseResultsPath= '/Users/s1259407/Desktop/timelapse_results/201609_results'


%experimentPath='/Users/s1259407/Desktop/timelapses/201610'
%timelapeResultsPath='/Users/s1259407/Desktop/timelapse_results/201610_results'

%experimentPath='/Users/s1259407/Desktop/timelapses/20161014_longRamps'
%timelapseResultsPath='/Users/s1259407/Desktop/timelapse_results/20161014_results'

%experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161015'
%timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161015_results'


%experimentPath='/Users/s1259407/Desktop/timelapses/20161016_rampsUp'
%timelapseResultsPath='/Users/s1259407/Desktop/timelapse_results/20161016_rampsUp_results'

%experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161025';
%timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161025_results';

%experimentPath='/Users/s1259407/Desktop/timelapses/201610'
%timelapseResultsPath='/Users/s1259407/Desktop/timelapse_results/201610_results'


experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161108';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161108_results';


experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161110';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161110_results';


experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161111';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161111_results';


experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161115';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161115_results';



experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161116';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161116_results';



experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161117';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161117_results';


experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161130';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161130_results';


experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161205';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161205_results';

experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161204';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161204_results';

experimentPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapses_mobilefolder/20161206';
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161206_results';

experimentPath='/Users/s1259407/Desktop/timelapses/tempTimelapses/20161207'
timelapseResultsPath='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20161207_results';


%% 1.1.2. creating resultsPath directory 
system(['mkdir ' timelapseResultsPath])

%% 1.2. getting the folders in experimentPath and initializing variables.
dircontents=dir(experimentPath)
%%this is the number of the first significant directory. the other ones are
%%hidden, special directories like . and .. if none, assign 1.
startingFile=3; 
rootPaths={}
resultsPaths={};




%% 1.3. assembling the experiment root Folder names and results folder names.
%%%%If your experiments have custom paths that are scattered throughout, 
%%just make rootPaths a cell array with each path.th
c=1;
for j=startingFile:numel(dircontents)
    rootPaths{c}= [experimentPath filesep dircontents(j).name]
    resultsPaths{c}= [timelapseResultsPath filesep dircontents(j).name ,'_','results']
    c=c+1;
end




%% 1.4.2. creating results directories inside the resultsPath directory
c=1
for j=startingFile:numel(dircontents)

    system(['mkdir ' resultsPaths{c}])

    c=c+1;
end


  %% 1.5. Plot an overview of the cy5 signal in all the experiments.
figure;
lgnds={};

for j=startingFile:numel(dircontents)
    try
        [cy5averages, namecell]=experimentTimeAverage([experimentPath filesep dircontents(startingFile+j-1).name], 'cy5')
        plot([1:size(cy5averages,1)]*5/60, mean(cy5averages,2))
        hold on;
        lgnds{c}=strrep(dircontents(j).name, '_', ' ')
        matrices{c}=cy5averages;
    catch err
        disp('failed to open file. fprobably it is not there yet.')
        lgnds{c}= strrep(dircontents(j).name, '_', ' ')
    end

    c=c+1;
end

%%%SECTION 2. CEXPERIMENT CREATION.
%%% things needed for this section: 
%%% rootPaths : cell array with all the paths to each experiment.
%%% resultsPaths: cell array with allthe paths to each experiment's
%%% results. these two 
%%% file.


%%2.1 loading cell vision. 
%here it makes sense to use whatever cell vision you want best.

load(fullfile('/Users/s1259407/Documents/MATLAB/MattSegCode/Matt Seg GUI/cCellvisionFiles','cCellVision_DIC_default.mat'),'cCellVision');

%% 2.2.1 Creating folders and cExperiment files for all for all experiments and creating the objects
%%the cExperiments object is a cell array of cExperiments, ordered the same
%%way as the paths. the cellvision is automatically inserted in this
%%snippet because it repeatedly fails to find it after loading.
cExperiments={};

for j=1:numel(rootPaths)

    cExperiments{j}=experimentTracking(rootPaths{j},resultsPaths{j})
    cExperiments{j}.cCellVision=cCellVision;  
end  

%% 2.2.1.2 in case you only want to insert the cell vision...

for j=1:numel(cExperiments)
    cExperiments{j}.cCellVision=cCellVision;  
 
end


% for j=1:numel(rootPaths)
% try
%     cExperiments{j}=experimentTracking(rootPaths{j},resultsPaths{j})
%     
% catch err
%     disp('file could not be opened')
% end


%% 2.2.2 ALTERNATIVELY, if you already have a rootPaths object and already created cExperiment
%files, you can load them like here.
cExperiments={}
for j=1:numel(resultsPaths)
    
try
    l1 = load(fullfile(resultsPaths{j},'cExperiment.mat'))
    cExperiments{j}= l1.cExperiment
    cExperiments{j}.cCellVision=cCellVision; 
    cExperiments{j}.logger=experimentLogging(cExperiments{j})
end
end


%%%2.2.3 making sure that all the logger cancel traps are removed.

for j=1:numel(cExperiments)
    cExperiments{j}.logger.cancel=0;
    for ii=1:numel(cExperiments{j}.dirs)
        cExperiments{j}.returnTimelapse(ii).logger.cancel=0;
    end
end

        

%% 2.3 create timelapse positions %%NOT AUTOMATED SO FAR.
refBFChannel='Brightfield_003';
for j=1:numel(cExperiments)
    try
      % cExperiment.createTimelapsePositions(searchString,positionsToLoad,pixelSize,image_rotation,timepointsToLoad,magnification,imScale,traps_present)
    cExperiments{j}.createTimelapsePositions([],'all', [],[],[], 60,[],[]);
    end

end

%% 2.4 Displaying  a particular position in a particular channel.
cExperiment=cExperiments{2}
cTimelapse=cExperiment.returnTimelapse(7);
%cExpGUI.currentGUI=cTimelapseDisplay(cTimelapse);
d=cTimelapseDisplay(cTimelapse);
%cExpGUI.currentGUI.channel=cExpGUI.channel;
d.channel=1;
%cExpGUI.currentGUI.slider_cb();
d.slider_cb();



%% 2.5. Making sure that all positions have exactly the same processing length per experiment.

numTimepoints={};
startPos=1
for j=1:numel(cExperiments)
    disp(['cExperiment ', num2str(j)])
    numTimepoints{j}=[];
    %%finding the number of positions
     posnum=numel(cExperiments{j}.dirs);
     disp(['Number of positions ', num2str(posnum)])
    for ii=1:posnum
        %finding the number of timepoints
         %disp(['position ', num2str(ii)])
        try 
            %%retrieving the length of each timelapse and storing it
            cTimelapse=cExperiments{j}.returnTimelapse(ii);
            numTimepoints{j}(ii)=numel(cTimelapse.cTimepoint);
        catch err
             numTimepoints{j}(ii)=nan;
        end
    end
    %%setting timepoints to process to top the length of the shortest
    %%position.
    disp(['setting timepoints to process to shared timepoints:'  num2str(nanmin(numTimepoints{j}))])
    cExperiments{j}.selectTPToProcess(1:posnum, 1:nanmin(numTimepoints{j}));
end
       
%% 2.6. showing all the positions and selected traps in one image
j=1;
expt=cExperiments{j}
%defining the closest square to tile the images.
vert=floor(numel(expt.dirs)/sqrt(numel(expt.dirs)));
horz=ceil(numel(expt.dirs)/sqrt(numel(expt.dirs)));
figure;
subplot(vert, horz, 1)
h=gcf %%we get the figure handle
for ii= 1: numel(expt.dirs)
cDisplay=cTrapSelectDisplay(expt.returnTimelapse(ii),cCellVision,1,1)
im=frame2im(getframe(cDisplay.figure));
subplot(vert, horz, ii);
imshow(im, []);
title(expt.dirs{ii})
a=gcf;
copyobj(gca, h);
close(a)
end


%% 2.7 selecting the traps %%STILL MANUAL BUT DOES IT FOR ALL THE EXPERIMENTS ONE AFTER ANOTHER.

for j=2:numel(cExperiments)
    try
        poses = 1:length(cExperiments{j}.dirs)
        cExperiments{j}.identifyTrapsTimelapses(cExperiments{j}.cCellVision,poses)
    end

end


%% 2.8.1. Automatically find which channels are there in each experiment.
channels={}
for j=1:numel(cExperiments)
channels{j}= channelContents(cExperiments{j}, 'simple');
end


%% 2.8.2 adding channels, the same for all experiments.
for j=1:numel(cExperiments)
    %channels = {'GFP','cy5','Brightfield_001','Brightfield_003','Brightfield_004','Brightfield_005'};
        
            for chi=1:length(channels{j})
                
               try 
            cExperiments{j}.addSecondaryChannel(channels{j}{chi});
            
            
            end
        end

end


%% 2.8.3  remove secondary channels (for example, to to add them again in case of mistake

for j =1:numel(cExperiments)
       channelIndices=channelContents(cExperiments{j}, 'indices');
    for ii =1:numel(cExperiments{j}.dirs)
        disp('loading timelapse')
        cExperiments{j}.loadCurrentTimelapse(ii);
        disp('changing channelnames to one element')
       

        cExperiments{j}.cTimelapse.channelNames=cExperiments{j}.searchString;
        
        
        fileList=channelIndices.(char(cExperiments{j}.dirs(ii))).posFileNames(channelIndices.(char(cExperiments{j}.dirs(ii))).(char(cExperiments{j}.searchString)));
        disp('starting to reset file names')
        
            for iii=1:numel(cExperiments{j}.timepointsToProcess)
                
              
                cExperiments{j}.cTimelapse.cTimepoint(iii).filename=fileList{iii};
                
                
            end
                
      %%%chcking wwhether there is any cellInf compiled

        saveTimelapseExperiment(cExperiments{j}, ii);
 
    end
    
                if ~isempty(cExperiments{j}.cellInf)
                cExperiments{j}.cellInf= cExperiments{j}.cellInf(1)%%channels are going to change so might as well
                end
                    
end               
 
                

%% 2.9.1. preparing for identification. making sure no cTimelapse is corrupt.
goodPositions={}
for j=1:numel(cExperiments)
    
    for ii=1:numel(poses)
        try
        cT=cExperiment.returnTimelapse(ii);
        goodPositions{j}(ii)=1;
        catch
            goodPositions{j}(ii)=0;
            
        end
    end
end
        

%% 2.9.2 identifying, tracking, autoselection and extraction per position. fills all the defaults, 
%%processes only those positions which haven't been segmented.
identStatus={};
identerrs=[];
positionStage={}
for j=1:numel(cExperiments)
 
    def(1) = {num2str(cCellVision.twoStageThresh)};
    def(2) = {num2str(cExperiments{j}.trackTrapsOverwrite)};%%%%
    def(3) = {'completed'};

    cCellVision.twoStageThresh=str2double(def(1))
    %we attempt to find the positions which havent been processed.
    %first we fill a zero array with the total number of existing positions.
    %the cExperiments.posSegmented sadly is not initialized to this so we have
    %to do it ourselves.
    posSegmented=zeros(1, numel(cExperiments{j}.dirs))
    %we merely copy the contents of the posSegmented into our new
    %posSegmented. we do this by getting the indices of the 1 elements and
    %making those indices 1 in the new vector. 
    posSegmented(find(cExperiments{j}.posSegmented==1))=1
    %now we retrieve all the positions which havent been segented. 
    posNotSegmented= posSegmented~=1 %binary vector that indicates what has been segmented
    poses= find(posNotSegmented) %unprocessed position indices
    allposes= 1:numel(cExperiments{j}.dirs)
    posTracked=zeros(1, numel(cExperiments{j}.dirs))
    posTracked(find(cExperiments{j}.posTracked==1))=1
    %now we retrieve all the positions which havent been segmented. 
    posNotTracked= posTracked~=1 %binary vector that indicates what has been segmented
    posesNotTracked= find(posNotTracked); %unprocessed position indices
    cExperiments{j}.cellVisionThresh=cCellVision.twoStageThresh  
    cExperiments{j}.trackTrapsOverwrite=1
    save('temp.mat')
        for ii= 1:numel(poses)
        
        %%saves a backup for the timelapse in case something goes wrong and
        %%it gets corrupted.
        cTBackup=cExperiments{j}.returnTimelapse(poses(ii))
            try 
            cExperiments{j}.returnTimelapse(poses(ii)).logger.cancel=0;
            cExperiments{j}.segmentCellsDisplay(cCellVision,poses(ii))
            positionStage{j}{ii}='segmented'
            cExperiments{j}.saveExperiment()
            end
        end
 
        for ii= 1:numel(poses)
            try
            
            cExperiments{j}.trackCells(poses(ii),5)
            positionStage{j}{ii}='tracked'
            cExperiments{j}.saveExperiment()
            params = standard_extraction_cExperiment_parameters_default(cExperiments{j},poses(ii)) % this function generates a structure that contains all default parameters used for extraction.
            cExperiments{j}.selectCellsToPlotAutomatic(poses(ii),params.paramsCellSelect)
            positionStage{j}{ii}='autoselected'
            cExperiments{j}.saveExperiment()
            
        
            
            extractParameters=timelapseTraps.defaultExtractParameters;
            if ~isempty(channels{j})
            extractParameters.functionParameters.channels= find(ismember( cExperiments{j}.returnTimelapse(poses(ii)).channelNames, channels{j}))
            %%cExperiment.extractCellInformation(positionsToExtract,doParameterGUI,extractParameters)
            
            end
           % [channelsPresent, channelPositions]=ismember( {'Brightfield_003', 'GFP', 'cy5'}, c.returnTimelapse(ii).channelNames)
            extractionChannels={'Brightfield_003', 'GFP', 'cy5'}
            [channelsPresent, channelPositions]=ismember(extractionChannels, cExperiments{j}.returnTimelapse(poses(ii)).channelNames)
            
            extractParameters.functionParameters.channels= channelPositions;
                
            
            [gfpPresent, gfpPosition]=ismember( {'GFP'}, cExperiments{j}.returnTimelapse(poses(ii)).channelNames)
                extractParameters.functionParameters.nuclearMarkerChannel=gfpPosition
                extractParameters.functionParameters.maxPixOverlap=5
                extractParameters.functionParameters.maxAllowedOverlap=25
            cExperiments{j}.extractCellInformation(poses(ii),false, extractParameters)
            
            positionStage{j}{ii}='extracted'
           cExperiments{j}.saveExperiment();
            end
        end
        
end
        




%% 2.9.3 code snippet for simple tracking, selecting and extraction of  cell info
for j=1:numel(cExperiments)
    poses = 1:length(cExperiments{j}.dirs)
    try
        cExperiments{j}.trackCells(find(cExperiments{j}.posSegmented),7);
        params = standard_extraction_cExperiment_parameters_default(cExperiments{j},find(cExperiments{j}.posTracked));
        cExperiments{j}.selectCellsToPlotAutomatic(find(cExperiments{j}.posTracked),params.paramsCellSelect);
        cExperiments{j}.extractCellInformation(find(cExperiments{j}.posTracked),false);
        
        
    end
end

%% 2.9.4 code snippet for tracking cell info
for j=1:numel(cExperiments)
    poses = 1:length(cExperiments{j}.dirs)
    
    for ii= find(cExperiments{j}.posSegmented)
    try
        cExperiments{j}.trackCells(ii,7);
    end
    end
end

   %% 2.9.5 code snippet for autoselecting
   
params = standard_extraction_cExperiment_parameters_default(cExperiments{j},find(cExperiments{j}.posTracked));
params.paramsCellSelect.duration=60
for j=1:numel(cExperiments)
    poses = 1:length(cExperiments{j}.dirs)
        try

            cExperiments{j}.selectCellsToPlotAutomatic(find(cExperiments{j}.posTracked),params.paramsCellSelect);
        end
    end
 
%% 2.9.6. code snippet for selecting cells manually
for j=1:numel(cExperiments)

cExperiments{j}.selectCellsToPlot(cCellVision,find(cExperiments{j}.posTracked),1,0)

end


%% 2.9.7. code snippet for only extracting
for j=1:numel(cExperiments)
     poses=1:numel(cExperiments{j}.dirs)
        for ii=1:numel(poses)
        try
                %%we find, out of thee channels found in the specific
                %%timelapse, which ones are actually found inside channels
                %%list and get their indices. we do this because other
                %%channels and erroneous names may have been added to the
                %%timelapse, and the indices arebecause the
                %%extractParameters object receives indices and not names. 
                
                 extractParameters.functionParameters.channels= find(ismember( cExperiments{j}.returnTimelapse(poses(ii)).channelNames, channels{j}))
               extractionChannels={'Brightfield_003', 'GFP', 'cy5'}
            [channelsPresent, channelPositions]=ismember(extractionChannels, cExperiments{j}.returnTimelapse(poses(ii)).channelNames)
            
            extractParameters.functionParameters.channels= channelPositions;
                 [gfpPresent, gfpPosition]=ismember( {'GFP'}, cExperiments{j}.returnTimelapse(poses(ii)).channelNames)
                extractParameters.functionParameters.nuclearMarkerChannel=gfpPosition
                extractParameters.functionParameters.maxPixOverlap=5
                extractParameters.functionParameters.maxAllowedOverlap=25
            cExperiments{j}.extractCellInformation(poses(ii),false, extractParameters);
                cExperiments{j}.saveExperiment()
         
        
        end
        
        end
        
end

 %% 2.10. generating a structure that informs what positions contain extracted data

posExtracted={}

for j=1:numel(cExperiments)
    disp(['experiment ' num2str(j)])
    for ii= 1:numel(cExperiments{j}.dirs)
        
        try
            cT= cExperiments{j}.returnTimelapse(ii);
            if ~isempty(cT.extractedData)
                posExtracted{j}(ii)= 1;
                 disp(['  position ' num2str(ii) ' extracted'])  
                
            else
                posExtracted{j}(ii)= 0;
                 disp(['  position ' num2str(ii) ' not yet extracted']) 
            end
          catch err
               posExtracted{j}(ii)= 0;
                
                 end
         
        end
    end

%% 2.11. multi compiling experiments. 
%This chunk creates a structure where each sub element is a cellInf for each of the strains in the experiment.
%. This block assumes each position has been named in a particular way.
%any position named pos will be considered the same group.

strainNames={};
multichambers={}
for j=1:numel(cExperiments)
    %getting a human/readable experiment name
    %nm=strsplit(rootPaths{j}, filesep);
    disp(['compiling experiment ' num2str(j) ':' cExperiments{j}.rootFolder])
    % obtain names of strains in experiment. we do this heuristically by trimming off the
    % last 3 digits. this is what trimPosName does
    try
    strainNames{j}=unique(cellfun(@trimPosName, cExperiments{j}.dirs(find(posExtracted{j})), 'uniformOutput', false));
    
%%%%%            cExperiment  posGroups posFinalNames, initialStrings
    multichambers{j}=multiCompile(cExperiments{j}, [],strainNames{j}, strainNames{j}, find(posExtracted{j}), false)
   % multichambers{j}.dir= rootPaths{j}
    end
end




%%%SECTION 3. PLOTTING AND MISCELANEOUS FUNCTIONS.
%% 3.1. loading the GUI for a particular experiment (if more specific troubleshooting is required)

j=1;
cExpGUI=experimentTrackingGUI;
cExpGUI.cExperiment=cExperiments{j};
cExpGUI.cCellVision=cCellVision;
set(cExpGUI.posList,'Value',1);
set(cExpGUI.posList,'String',cExpGUI.cExperiment.dirs);
set(cExpGUI.figure,'Name',cExpGUI.cExperiment.saveFolder);
%%be careful: the cExperiment in the cExperiments array is another
%%instance, so it is advised that, when done, the cExperiment in the gui be
%%copied onto the original one in cExperiments structure. using the line below.     
%%%cExperiments{j}= cExpGUI.cExperiment;    


%% 3.2. multiMeanPlots of each multichamber
for j=1:numel(multichambers)        
    try
    multiMeanPlotRobust([], multichambers{j})
    end
end
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
% % % % sdffsafsa
% % % %     
% % % %     sdfafaf
% % % %     
% % % %     
% % % %     sasffdasfaf
% % % %     
% % % %    asdafafafadff 
% % % %                                 ELCOS CODE BELOW
% % % %    sdfsafsadfaf 
% % % %     
% % % %     
% % % %     asdfafafafasf
% % % %     
% % % %     afdsafafaf
% % % %     
% % % %     
% % % %     asfafdafadsf
% % % %     
% % % %     
% % % %     
    
    
    
    
    






%% GUI
% make the analysis GUI for loading/creating cExperiments and editing the
% results. This GUI allows easy access to the editing functions

d = experimentTrackingGUI;

% use the 'create cExperiment' or 'load cExperiment' to load the default
% load a cExperiment.

%% select poses
% running the following code will define poses as those position
% highlighted in the GUI.

poses = d.posList.Value;


%% or do all positions

poses = 1:length(d.cExperiment.dirs)

%% load a cTimelapse
% the cExperiment object organises cTimelapse objects - one for each
% position. One is loaded here for easy access to some of its properties,
% but it will not be saved by default. 
% 
% Here we also make the cExperiment object accessible. Since it is a handle
% object, changes to it will also affect the cExperiment object in the
% cExpGUI.
%
% poses is a list of all positions which is generally useful.
cTimelapse = d.cExperiment.loadCurrentTimelapse(1);
cExperiment = d.cExperiment;

%% add channels
% corresponding to the 'add Channel' button, which does the same thing
% individually. Adds the other channels (i.e. those in addition to DIC) to
% the cExperiment so that they are accessible in the processing and data
% extraction.

%channels = {'Brightfield_001','Brightfield_003','GFP','GFP_001','GFP_002','GFP_003','mCherry','mCherry_001','mCherry_002','mCherry_003'};

%channels = {'Brightfield_002','Brightfield_003','Brightfield_004','Brightfield_005','GFP','cy5','DIC_002'};

%LUIS. adapting channel cell array to fit my experiments.
%GFP stacks
%channels = {'GFP_001','cy5','Brightfield_001','Brightfield_002','Brightfield_004','Brightfield_005', 'GFP_002', 'GFP_003', 'GFP_004', 'GFP_005'};
channels = {'GFP','cy5','Brightfield_001','Brightfield_002','Brightfield_004','Brightfield_005', 'GFPFast_001', 'GFPFast_002', 'GFPFast_003', 'GFPFast_004', 'GFPFast_005'};


d.cExperiment.addSecondaryChannel(channels);

set(d.selectChannelButton, 'String', d.cExperiment.channelNames, 'Value', 1)


%% set TP to process
% often it is not desirable to process all timepoints (for example, if the
% device becomes clogged at the end). In order to only process a part of
% the experiment click the 'Tp to process' button, or run:

%cExperiment.selectTPToProcess;

%% setting offset

% the different channels acquired can be 'offset' with respect to each
% other. i.e. it might be necessary to shift them a pixel or two
% up/down/left/right to get them to 'overlap' properly. This is done using
% the setChannelOffset method of the cExperiment.

%% try an offset
% 
% % here we set the offset of the DIC channel by comparing it to another
% % channel (GFP) and checking the outcome by eye. DIC is most often poorly
% % registered with the other channels. 
% % Play with the offset assignment and see how the outcome looks.
% cTimelapse = cExperiment.loadCurrentTimelapse(poses(1));
% 
 DICch = 1;
 GFPch = 2;
timepoint = 100;
% 
cTimelapse=d.cExperiment.returnTimelapse(1)
cTimelapse.offset(1,:) = [0 0];
im1 = double(cTimelapse.returnSingleTimepoint(timepoint,DICch));
im2 = double(cTimelapse.returnSingleTimepoint(timepoint,GFPch));
imdic1 = double(cTimelapse.returnSingleTimepoint(timepoint,4));
imdic3 = double(cTimelapse.returnSingleTimepoint(timepoint,5));

im1 = (im1-min(im1(:)))/iqr(im1(:));
im2 = (im2-min(im2(:)))/iqr(im2(:));
% 
figure(5);
imshow(OverlapGreyRed(im1,im2),[]);
figure(6)
imshow(imdic1,[])
figure(7)
imshow(imdic3,[])
% 
% %% set offset
% % having found a good offset above, we set it for all positions.
% d.cExperiment.setChannelOffset;
% 
% %% set flat field (optional)
% % often a fluorescent has an uneven illumination, and therefore response,
% % across the field. This can be compensated by provided a flat field
% % correction, by which an image is premultiplied before it is returned. 
% %
% % Elco has some methods for finding this, but it is generally the inverse
% % of an image of a fluorescent slide if constant brightness. It is set
% % using the following method.
% 
% d.cExperiment.setBackgroundCorrection(BGcorrGFP)
% 

%% editing the cellVision trap outline (optional)

% this line will first load a cell vision model
d.loadCellVision
% this is not necessary if the timelapse does not have traps.
% the cellVision model, used for identifying cells, has an outline of the
% trap which is used to 'blot out' trap pixels in the cell detection. This
% can be improved, sometimes improving the cell detection, using the
% following code.
%
% first select a single trap in position 1.

d.cExperiment.identifyTrapsTimelapses(cExperiment.cCellVision,1,false);

% this function will then use that image of the trap to try and refine the
% trap outline - with user intervention. Instructions should be clear, if
% in doubt press enter.
%% probably ctimelapse, ctimepoint, channel, position i think)
d.cExperiment.editCellVisionTrapOutline(1,1,1,1) %black gui

%% now select traps for all positions. normal one
% the selection of the traps defines the areas in which the code will look
% for cells, and also sets up the organisation of the 


d.cExperiment.identifyTrapsTimelapses(d.cExperiment.cCellVision)



%% if intending to run the active contour method
% there is an active contour methd, but it only works well if out of focus
% DIC or. ideally, Brightfield images are available. It is rather slow but
% can improve the quality of data.
%f you intend to run it you need to add the out of focus DIC/brightfield channels:



% %%
% % then set the following parameters:
% % (these are only correct if you have added the channels as prescribed -
% % adjust as necessary).

%% showing all channels
figure
allchannels= {d.cExperiment.searchString, d.cExperiment.channelNames}
for j=1:numel(d.cExperiment.channelNames)
subplot(1,numel(d.cExperiment.channelNames),j)
imshow(d.cExperiment.returnTimelapse(1).returnSingleTimepoint(1, j), [])
title(d.cExperiment.channelNames{j});
end



lower_brightfield_channel = 1; % lower z stack slice of brightfield
upper_brightfield_channel = 7; % upper z stack slice of brightfield
% 
d.cExperiment.ActiveContourParameters.ImageTransformation.channel = [lower_brightfield_channel -upper_brightfield_channel];

%% adjust extraction parameter (Extract data normal parameters)
% there are a number of parameters for the extraction. These are set by the
% following function, which would be called from the GUI if you press the
% extract Data button.

%d.cExperiment.setExtractParameters([],d.cExperiment.guiSetExtractParameters);

%% set segmentation channels (select the two layers of the brighfield. 

% if you are using a non standard cCellVision or have added the channels in
% a different order you will need to run this block to set the channels
% used to identify cell centres

d.cExperiment.setSegmentationChannels %%%% just opened the block and selected DIC_002. dont know what i have to do to change the order of the channels....






% test 1 position 
%% refine trap Pixels for the first position to be processed
% uses the refinement_channel to make a refined trap outline that can
% improve the illimination of traps. 
% refinement_channel shoudl be out of focus bright field in which traps are
% white surrounded by black outline.
trap_outline_refine_channel = 1; %% I 

for diri=poses(1)
    
    cTimelapse = d.cExperiment.loadCurrentTimelapse(diri);
    cTimelapse.refineTrapOutline(d.cExperiment.cCellVision.cTrap.trapOutline,trap_outline_refine_channel,[],[],false,true);
    d.cExperiment.cTimelapse = cTimelapse;
    d.cExperiment.saveTimelapseExperiment(diri,false);
    fprintf('%d ',diri)
    
end

%no gui opens
%LUIS: not sure what to do about the traps that dont look right.
%% show refined trapOutline 
figure()
for diri=poses
    cTimelapse = d.cExperiment.loadCurrentTimelapse(diri);
    for tp = cTimelapse.timepointsToProcess
        % NB: to see other time points, the traps need to be tracked
        % throughout the timelapse
        im = cTimelapse.returnTrapsTimepoint([],tp,2);
        for ti = 1:length(cTimelapse.cTimepoint(tp).trapInfo)
            imshow(OverlapGreyRed(im(:,:,ti),full(cTimelapse.cTimepoint(tp).trapInfo(ti).refinedTrapPixelsInner),[],...
                full(cTimelapse.cTimepoint(tp).trapInfo(ti).refinedTrapPixelsBig),true),[]);
            title(sprintf('pos: %d tp: %d trap: %d',diri,tp,ti))
            pause(0.1);
            
        end
    end
end

%% go to decision image 


%% inspect decision image

%%
%cTimelapse = d.cExperiment.loadCurrentTimelapse(1);
% color paramerts  for AC
tp = 100; %check
channel = 1;
thresh1 = -3; %yellow
thresh2 = -3; %green
pos = poses(1);
%% track this position 
d.cExperiment.RunActiveContourExperimentTracking(d.cExperiment.cCellVision,pos,min(d.cExperiment.timepointsToProcess),max(d.cExperiment.timepointsToProcess),true,5,true,false);


%% calculates the decision image for position 1
cTimelapse = d.cExperiment.loadCurrentTimelapse(pos);

num_traps = length(cTimelapse.cTimepoint(tp).trapInfo);
tic;
DIM = identifyCellCentersTrap(cTimelapse,d.cExperiment.cCellVision,tp,1:num_traps);
%DIM = identifyCellCentersTrap(cTimelapse,cCellVision,1,1:num_traps);
toc

%% opens the 3 images with color  and adjust parametres if needed
trapImage = cTimelapse.returnTrapsTimepoint(1:num_traps,tp,channel);
mega_image_size = ceil(sqrt(num_traps));

min_DIM = min(DIM(:));

DIM(:,:,(end+1):(mega_image_size^2)) = min_DIM;
trapImage(:,:,(end+1):(mega_image_size^2)) = min(trapImage(:));

mega_image = [];
mega_trap_image = [];
mega_acwe_image = [];
n = 1;
for i=1:mega_image_size;
    temp_col = [];
    temp_col2 = [];
    temp_col_acwe = [];
    for j=1:mega_image_size;
        temp_col = [temp_col;DIM(:,:,n)];
        temp_col2 = [temp_col2;trapImage(:,:,n)];
        %temp_col_acwe = imshow(acwe(1-2*(DIM(:,:,n)<0),DIM(:,:,n),[],[],0),[]);
        
        n = n+1;
    end
    mega_image = [mega_image temp_col];
    mega_trap_image = [mega_trap_image temp_col2];
    %mega_acwe_image = [mega_acwe_image temp_col_acwe];
    

end

imtool(mega_image,[])
figure;imshow(OverlapGreyRed(mega_trap_image,mega_image<thresh1,[],mega_image<thresh2),[])
figure;imshow(mega_trap_image,[])


%try several combinations of thresholds
thresholdOptions=linspace(-3,3,8);
totrow=numel(thresholdOptions);
totcol=numel(thresholdOptions);
c=.8 %scaling factor for every square
figure;
for j=1:numel(thresholdOptions)
for k=1:numel(thresholdOptions)
axes();
imshow(OverlapGreyRed(mega_trap_image,mega_image<thresholdOptions(j),[],mega_image<thresholdOptions(k)),[])
xlabel(thresholdOptions(k))
ylabel(thresholdOptions(j))
set(gca,'Position', [(1/totcol)*(k-1), (j/totrow)-(1/totrow), (1/totcol)*c, (1/totrow)*c]) 
hold on;
end

end





%% set Active Contour parameters
% using the imaging below, test a few decision images and see what
% threshold values you want to use.

% threshold for detecting cells (lower is more stringent)

% new cells:
d.cExperiment.ActiveContourParameters.CrossCorrelation.twoStageThresh = thresh1; %update with the color 

% tracking cells that are there
d.cExperiment.ActiveContourParameters.CrossCorrelation.CrossCorrelationDIMthreshold = thresh2;

%
% set to be the same
%d.cExperiment.ActiveContourParameters.CrossCorrelation.CrossCorrelationValueThreshold = ...
%d.cExperiment.ActiveContourParameters.CrossCorrelation.CrossCorrelationDIMthreshold;

% active contour search parameters:

% more is potentially more accurate but slower
d.cExperiment.ActiveContourParameters.ActiveContour.seeds_for_PSO = 20;

% always needs to be bigger than the one above. Not very significant so
% leave high.


d.cExperiment.ActiveContourParameters.ActiveContour.seeds = 100;

d.cExperiment.ActiveContourParameters.ActiveContour.TerminationEpoch = 30;


% maximum allowed radius change between timepoints. More stringent means
% faster but can be problematic since it allows edge errors to endure.
d.cExperiment.ActiveContourParameters.ActiveContour.MaximumRadiusChange = Inf;

%adjust for cell size
% maximum allowed radius of cell
d.cExperiment.ActiveContourParameters.ActiveContour.R_max = 14;


% minimum allowed radius of cell
d.cExperiment.ActiveContourParameters.ActiveContour.R_min = 2;


%% look at the results for the first position
%opens a gui the first time. select the brightfields stacks
                              
                              
                              
%********* identification and active contour *************
                              
                              
%d.cExperiment.RunActiveContourExperimentTracking(d.cExperiment.cCellVision,poses(1),min(d.cExperiment.timepointsToProcess),max(d.cExperiment.timepointsToProcess),true,1,true,false);

%adjust from here

%% Actual long run.  Elco standard extraction
% run when happy with verything else. 
% 
poses = 1:length(d.cExperiment.dirs)

%RunActiveContourExperimentTracking(            cExperiment,   cCellVision, positionsToIdentify,FirstTimepoint,          LastTimepoint,      OverwriteTimelapseParameters,ACmethod,TrackTrapsInTime,LeaveFirstTimepointUnchanged,CellsToUse)
d.cExperiment.RunActiveContourExperimentTracking(d.cExperiment.cCellVision,poses,min(d.cExperiment.timepointsToProcess),max(d.cExperiment.timepointsToProcess),true,        1,      true,            false);
%%%%%%
%%%%%%
%%%%%%
%%%%%%
%%%%%%

% refine trap outline
for diri=poses
    
    cTimelapse = cExperiment.loadCurrentTimelapse(diri);
    cTimelapse.refineTrapOutline(cExperiment.cCellVision.cTrap.trapOutline,trap_outline_refine_channel,[],[],false,true);
    cExperiment.cTimelapse = cTimelapse;
    cExperiment.saveTimelapseExperiment(diri,false);
    fprintf('%d ',diri)
    
end
% identification and active contour
cExperiment.RunActiveContourExperimentTracking(cExperiment.cCellVision,poses,min(cExperiment.timepointsToProcess),max(cExperiment.timepointsToProcess),true,1,false,false);

% retrack
params = standard_extraction_cExperiment_parameters_default(d.cExperiment,poses);
cExperiment.trackCells(poses,params.trackingDistance);

%automatically select cells
d.cExperiment.selectCellsToPlotAutomatic(poses,params.paramsCellSelect);

%select cells manually if needed


cExperiment.extractCellInformation(poses,false);
cExperiment.compileCellInformation(poses)





%
% get mother index
for diri=poses
    
    cTimelapse = cExperiment.loadCurrentTimelapse(diri);
    cTimelapse.findMotherIndex('refined_trap');
    cExperiment.cTimelapse = cTimelapse;
    cExperiment.saveTimelapseExperiment(diri,false);

    
end
% mother processing
standard_extraction_cExperiment(cExperiment,poses,Inf,false,false,false,false,true,params);




%% OTHER USEFUL FUNCTIONS

%% changing the location of images:
% when you move a cExperiment from one computer to another, you need to
% make two changes:
% first the saveFolder field needs to be changed to the location of the
% cExperiment.
% then the image locations need to be changed to their location on the
% current computer.
cExperiment.saveFolder = uigetdir;
cExperiment.changeRootDirAllTimelapses;

%% refine trap Pixels (Elco)
% uses the refinement_channel to make a refined trap outline that can
% improve the illimination of traps. 
% refinement_channel shoudl be out of focus bright field in which traps are
% white surrounded by black outline.

for diri=1:length(cExperiment.dirs)
    
    cTimelapse = cExperiment.loadCurrentTimelapse(diri);
    cTimelapse.refineTrapOutline(cExperiment.cCellVision.cTrap.trapOutline,trap_outline_refine_channel,[],[],false,true);
    cExperiment.cTimelapse = cTimelapse;
    cExperiment.saveTimelapseExperiment(diri,false);
    fprintf('%d ',diri)
    
end

%% refine trap Pixels (Elco) for just position 1
% uses the refinement_channel to make a refined trap outline that can
% improve the illimination of traps. 
% refinement_channel shoudl be out of focus bright field in which traps are
% white surrounded by black outline.

for diri=1
    
    cTimelapse = cExperiment.loadCurrentTimelapse(diri);
    cTimelapse.refineTrapOutline(cExperiment.cCellVision.cTrap.trapOutline,trap_outline_refine_channel,[],[],false,true);
    cExperiment.cTimelapse = cTimelapse;
    cExperiment.saveTimelapseExperiment(diri,false);
    fprintf('%d ',diri)
     
end

%% inspect decision image

%%
%cTimelapse = d.cExperiment.loadCurrentTimelapse(1);

tp = 50;
channel = 1;
thresh1 = -1.5; %yellow
thresh2 = -1; %green
pos = 1;

%% track the position
%DO NOT RUN IF YOU HAVE IDENTIFIED CELLS AND WANT TO KEEP THE RESULT
cExperiment.RunActiveContourExperimentTracking(cExperiment.cCellVision,pos,min(cExperiment.timepointsToProcess),max(cExperiment.timepointsToProcess),true,5,true,false);


%%
cTimelapse = d.cExperiment.loadCurrentTimelapse(pos);

num_traps = length(cTimelapse.cTimepoint(tp).trapInfo);
tic;
DIM = identifyCellCentersTrap(cTimelapse,d.cExperiment.cCellVision,tp,1:num_traps);
%DIM = identifyCellCentersTrap(cTimelapse,cCellVision,1,1:num_traps);
toc

%%
trapImage = cTimelapse.returnTrapsTimepoint(1:num_traps,tp,channel);
mega_image_size = ceil(sqrt(num_traps));

min_DIM = min(DIM(:));

DIM(:,:,(end+1):(mega_image_size^2)) = min_DIM;
trapImage(:,:,(end+1):(mega_image_size^2)) = min(trapImage(:));

mega_image = [];
mega_trap_image = [];
mega_acwe_image = [];
n = 1;
for i=1:mega_image_size;
    temp_col = [];
    temp_col2 = [];
    temp_col_acwe = [];
    for j=1:mega_image_size;
        temp_col = [temp_col;DIM(:,:,n)];
        temp_col2 = [temp_col2;trapImage(:,:,n)];
        %temp_col_acwe = imshow(acwe(1-2*(DIM(:,:,n)<0),DIM(:,:,n),[],[],0),[]);
        
        n = n+1;
    end
    mega_image = [mega_image temp_col];
    mega_trap_image = [mega_trap_image temp_col2];
    %mega_acwe_image = [mega_acwe_image temp_col_acwe];
    

end

imtool(mega_image,[])
figure;imshow(OverlapGreyRed(mega_trap_image,mega_image<thresh1,[],mega_image<thresh2),[])
figure;imshow(mega_trap_image,[])



