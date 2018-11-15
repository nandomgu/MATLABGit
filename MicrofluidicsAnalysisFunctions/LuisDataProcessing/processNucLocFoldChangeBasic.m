function [mn, nms, times]=processNucLocFoldChangeBasic(cExperiment, nms, rng,baserange, cellchan)
%% this function receives a cExperiment rather than a multichamber object and figures out the 
%%strains and positions. it is more autonomous this way.

%%getting the positions' strain names
drnames=cellfun(@trimPosName, cExperiment.dirs, 'UniformOutput', false);

%finding the strainname of each cell
cellposes=drnames(cExperiment.cellInf(1).posNum) 


if nargin<2 ||isempty(nms) %we get the names for which there are cells.
nms=unique(cellposes);
end

if nargin< 4 || isempty(baserange)
    baserange=1:20
end


if nargin<5 ||isempty(cellchan)
cellchan=2;
end

debug=1;


    times=nanmean(cExperiment.cellInf(1).times/60);
if ~isfield(cExperiment.cellInf(1), 'times')
    disp('experiment likely does not contain time variable. defaulting to hours in 5 minute intervals')
    len=size(cExperiment.cellInf(cellchan).mean,2);
    times=(1:len)*5/60;
else if size(cExperiment.cellInf(1).times,2) ~= size(cExperiment.cellInf(cellchan).mean,2)
    disp(' the sizes of the times variable and the data do not match. calculating time as 5 min intervals')
     len=size(cExperiment.cellInf(cellchan).mean,2);
     times=(1:len)*5/60;
    end
end

        
        

if nargin<3 ||isempty(rng)
    
    rng= 1:size(cExperiment.cellInf(cellchan).mean, 2);
end
    
    
mn=[];
%disp([nms{:}])
for j=1:numel(nms)
    disp(j)
    nmcells=[]; %%cleaning just in case there is a run on from the previous iteration
    nmcells=find(strcmp(nms{j}, cellposes));
    mn(j,:)=nonzeroColMedian(cExperiment.cellInf(cellchan).max5(nmcells, rng) ./cExperiment.cellInf(cellchan).median(nmcells, rng))
        %mn(j,:)= normalizeTS(mn(j,:)/ mn(j,1));  %0-1 scaling
    mn(j,:)= mn(j,:)/ mean(mn(j,baserange));
end
end


