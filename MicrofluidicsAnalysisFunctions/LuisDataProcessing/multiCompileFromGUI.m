function multiCellInf= multiCompileFromGUI(cExpGUI, posGroups,posFinalNames)
%% performs compilation of multiple cellInfs in position Groups posGroups(cell array), each group named posNames{i} (cell array)

multiCellInf=[]; %initializing our output variable

%the function getRealPosNumbers assumes all positions are called posX where x is the
%position number. The function obtains X.
realPosNumbers= getRealPosNumbers(cExpGUI.cExperiment)

for j= 1:numel(posGroups)
    allpos=zeros(1, numel(realPosNumbers))
    posmapped=[]
    for d= posGroups{j}
        
        bina= realPosNumbers==d
        allpos= allpos | bina
    end
    
    
    posmapped= find(allpos)
    set(cExpGUI.posList, 'Value', posmapped)
    cExpGUI.cExperiment.compileCellInformation(posmapped)
    ['multiCellInf.' posFinalNames{j} '.cellInf= cExpGUI.cExperiment.cellInf']
    pause(2)
    
end



        
%now that we know the value of positions
%find(realPosNumbers==)



%now we select those positions by setting the value of positions in the GUI

