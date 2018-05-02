function [mn, nms, times]=processNucLocFoldChange(multichamber, nms, rng,baserange, cellchan)


%%nms is a cell array of strings

if nargin<2 ||isempty(nms)
nms=fieldnames(multichamber);    
nms= nms(~strcmp(nms, 'expInf'));
nms= nms(~strcmp(nms, 'dir'));
end

if nargin< 4 || isempty(baserange)
    
    baserange=1:20
end


if nargin<5 ||isempty(cellchan)
cellchan=2;
end

debug=1;


    times=nanmean(multichamber.(nms{1}).cellInf(1).times/60);
if ~isfield(multichamber.(nms{1}).cellInf(1), 'times')
    disp('experiment likely does not contain time variable. defaulting to hours in 5 minute intervals')
    len=size(multichamber.(nms{1}).cellInf(cellchan).mean,2);
    times=(1:len)*5/60;
else if size(multichamber.(nms{1}).cellInf(1).times,2) ~= size(multichamber.(nms{1}).cellInf(cellchan).mean,2)
    disp(' the sizes of the times variable and the data do not match. calculating time as 5 min intervals')
     len=size(multichamber.(nms{1}).cellInf(cellchan).mean,2);
     times=(1:len)*5/60;
    end
end

        
        

if nargin<3 ||isempty(rng)
    
    rng= 1:size(multichamber.(nms{1}).cellInf(cellchan).mean, 2);
end
    
    
mn=[];
disp([nms{:}])
for j=1:numel(nms)
    disp(j)
    mn(j,:)=nonzeroColMean(multichamber.(nms{j}).cellInf(cellchan).max5(:, rng)./multichamber.(nms{j}).cellInf(cellchan).median(:, rng));
    %mn(j,:)= normalizeTS(mn(j,:)/ mn(j,1));  %0-1 scaling
    mn(j,:)= mn(j,:)/ mean(mn(j,baserange));
end
end


