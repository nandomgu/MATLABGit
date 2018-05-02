function multiCellInf= multiCompile(cExperiment, posGroups,posFinalNames, initialStrings, poses, force)
%% performs compilation of multiple cellInfs in position Groups posGroups(cell array), each group named posNames{i} (cell array)

multiCellInf=[]; %initializing our output variable

%the function getRealPosNumbers assumes all positions are called posX where x is the
%position number. The function obtains X.
realPosNumbers=[];

if nargin<4 %%making poses to be all positions if it is absent.
    poses= 1: numel(cExperiment.dirs);
    force=false;

end

if nargin<5 || isempty(poses)
    poses=1:numel(cExperiment.dirs)
end

if nargin<6 || isempty(force)
    force=true;
end

if nargin>3
    for j=1:numel(initialStrings)  %%searches for the strain name, and takes out all those positions that don't want to be considered.
        
        
        %find the positions whose initial string matches the strain
        %identification string in initialStrings
        nameMatchers=find(cellfun(@empty2Zero, strfind(cExperiment.dirs, initialStrings{j}))) %indices of positions named as such
        %%now we obtain the intersection between those with the names and
        %%those positions willing to be considered
        realPosNumbers=intersect(nameMatchers, poses);
        
        
       % compileCellInformation(cExperiment,positionsToExtract,force)
        cExperiment.compileCellInformation(realPosNumbers,force)
        eval(['multiCellInf.' initialStrings{j} '.cellInf= cExperiment.cellInf'])
        pause(2)
        
    end
else
    realPosNumbers= cell2mat(cellfun(@trimPosNumbers, cExperiment.dirs, 'UniformOutput',false));
    disp('this section of the code is being used')
    for j= 1:numel(posGroups)%for each group of positions
        disp(posGroups{j})
        allpos=zeros(1, numel(realPosNumbers));
        posmapped=[];
    for d= posGroups{j}
        bina= realPosNumbers==d;
        allpos= allpos | bina
    end
    
    
    posmapped= find(allpos)
    cExperiment.compileCellInformation(posmapped, force)
    eval(['multiCellInf.' posFinalNames{j} '.cellInf= cExperiment.cellInf'])
    pause(2)


end





    
end



        
%now that we know the value of positions
%find(realPosNumbers==)



%now we select those positions by setting the value of positions in the GUI

