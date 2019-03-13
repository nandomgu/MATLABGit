function multichamber=makeMultiChamber(cExperiment, channels)
    
    if nargin<2
        channels=1:numel(cExperiment.cellInf);
    end
    drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);
    nms=unique(drnames);   
    cellposes=drnames(cExperiment.cellInf(1).posNum);
    multichamber=struct;
    for j=1:numel(nms)
        nmcells=find(strcmp(nms{j}, cellposes));
    
    
       for q=channels
           
            flds=fieldnames(cExperiment.cellInf(q));
            flds= flds(~strcmp(flds, 'extractionParameters'));
            flds= flds(~strcmp(flds, 'date'));
            flds= flds(~strcmp(flds, 'times'));
            flds= flds(~strcmp(flds, 'extractedTimepoints'));
            flds= flds(~strcmp(flds, 'annotations'));
            flds= flds(~strcmp(flds, 'timepointsNotProcessed'));
        for k=1:numel(flds)
            matr=cExperiment.cellInf(q).(flds{k});
            %disp(['strain  ' nms{j} '  channel  ' q '  field  ' flds{k}])
            try
            multichamber.(nms{j}).cellInf(q).(flds{k})= matr(nmcells, :);
            catch
                %disp('trying vector assignment instead of matrix assignment')
                try
                multichamber.(nms{j}).cellInf(q).(flds{k})= matr(nmcells);
                end
            end
        end
       end
       
      
 
       
       
    end
    

    