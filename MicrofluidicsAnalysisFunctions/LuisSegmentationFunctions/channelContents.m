function out=channelContents(cExperiment, outputType)
%%tries to figure out what channels are contained in the timelapse images,
%%per position. Returns a cell array of channels found. 

%being greedy. jus adding the 

if nargin<2|| isempty(outputType)
    outputType='simple';
end


sep='-';

brightfields=generateStackNames('Brightfield', 10, sep);
dics= generateStackNames('DIC', 10, sep);
GFPs=generateStackNames('DIC', 10, sep);
mCherrys= generateStackNames('DIC', 10, sep);
YFPs=generateStackNames('DIC', 10, sep);
GFPWides=generateStackNames('DIC', 10, sep);
mKO2s=generateStackNames('mKO2', 10, sep);
PHluorins=generateStackNames('PHLuorin405', 10, sep);
cy5s=generateStackNames('cy5', 10, sep);
possibleChannels= {'_Brightield_.','_GFP_.' '_cy5_.', brightfields{:}, '_mCherry_.',mCherrys{:}, '_YFP_.',YFPs{:}, '_GFPWide_.', GFPWides{:}, 'mKO2', mKO2s{:},'PHLuorin405', PHluorins{:}, cy5s{:}};
   


directoryContents=dir(cExperiment.rootFolder);

startPoint=4; %%all previous directories are hidden/system directories we are not interested in.

%directoryContents=directoryContents(startPoint:end); %%simply get rid of the hidden ones for simplicity.
directoryContents=directoryContents([directoryContents.isdir]);
posDirs= {directoryContents(3:end).name};%% get the folder names of those who are only directories. this gets rid of any other file that may be present

%the critical thing is to add all possible channels that are found, even
%though they may not be present in all positions.
imageTypes=struct;
channelIndices=struct;
for j=1:numel(posDirs)
    
    %%assemble the folder path with the root directory and the position
    %%folder name
    disp(['directory' posDirs(j)])
    posPath= strjoin([cExperiment.rootFolder filesep posDirs(j)], '');
    
    %%get the contents of this assembled directory
    posDirContents= dir(posPath);
    
    %%get rid of all the hidden files again, retrieve the names of the
    %%image files
    %posDirContents=posDirContents(startPoint:end);
    
    %%extract all the names of posFileNames
    posFileNames={posDirContents([posDirContents.isdir]==0).name};
    channelIndices.(posDirs{j}).posFileNames=posFileNames;
    %%find out which images correspond to which channel and store the
    %%content.
    for ii=1:numel(possibleChannels)
        channelfiles=cellfun(@empty2Zero, strfind( posFileNames, strrep(possibleChannels{ii}, '-', '_')))>1; %%looking for files with the right searchstring
        channelField=strrep(strrep(possibleChannels{ii}, '.', ''), '_', '');
        channelField=strrep(channelField, '-', '_');

        if sum(channelfiles)>0
        
            
     %this below is such that the structure display the channels per position, and which timepoints have it. probably overkill but may come in handy.     
    channelIndices.(posDirs{j}).(channelField)=channelfiles;
    
    %This stores all channels found, and stores 1 if the channel is found in
    %a position. This way we get quick access to all channels in the
    %experiment.
    imageTypes.(channelField).(posDirs{j})=1;
%By doing nothing otherwise, we  avoid storing anything about the channels that
%weren't found.
    
            
        end
    %%this  following line extracts the timepoint number from a single file
    %%name
    %[startIndices, endIndices]=regexp(posFileNames, '_\d{6}_')
    %%str2double(strrep(posFileNames{1}(startIndices{1}:endIndices{1}), '_', ''))
    
end

end



switch outputType
    case 'simple' %case simple means to add all channels found
        out=fieldnames(imageTypes)';
    case 'complete' %returns the full structure
        out=imageTypes;
    case 'indices'
        out=channelIndices;
        
end
end
    