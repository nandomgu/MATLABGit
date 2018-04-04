function expPaths=collectExperiments(dirName)
%% this function allows you to retrieve a cell array of all experiments found inside a folder. It does so by looking for cExperiment.mat files. 
expPaths={};

pathString=genpath(dirName)
allPaths=strsplit(pathString, ':')

for j=1:numel(allPaths)
    
    d= dir(allPaths{j});
    
    isExp=strcmp({d.name}, {'cExperiment.mat'});
    disp(['dir', num2str(j),num2str(sum(isExp))])
    if sum(isExp)>0
       newPathNames= strcat(repmat(allPaths{j} ,numel(find(isExp)),1), repmat(filesep ,numel(find(isExp)),1), {d(find(isExp)).name}')
       
       expPaths={expPaths{:}, newPathNames{:}} 
    end
    
end
