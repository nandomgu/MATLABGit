
experimentPath=d.cExperiment.saveFolder
%% 1.2. getting the folders in experimentPath and initializing variables.
dircontents=dir(experimentPath)
%%this is the number of the first significant directory. the other ones are
%%hidden, special directories like . and .. if none, assign 1.
startingFile=3; 

%% getting the directories of positions
dircontents=dircontents(startingFile:end);
dircontents=dircontents([dircontents.isdir]);
dircell= {dircontents.name};
appendPath= @(str)  [experimentPath str];

fullposdirs=cellfun(appendPath, dircell, 'UniformOutput', false)

%% 1.3. assembling the experiment root Folder names and results folder names.
%%%%If your experiments have custom paths that are scattered throughout, 
%%just make rootPaths a cell array with each path.th
c=1;
for j=startingFile:numel(dircontents)
    rootPaths{c}= [experimentPath filesep dircontents(j).name]

    c=c+1;
end




%% 1.4.2. creating results directories inside the resultsPath directory
c=1
for j=startingFile:numel(dircontents)

    system(['mkdir ' resultsPaths{c}])

    c=c+1;
end



%%
bfaverages={};
namecell={};
for j=startingFile:numel(fullposdirs)
    [bfaverages{j}, namecell{j}]=experimentTimeAverage(fullposdirs{j}, 'Brightfield_003')
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
