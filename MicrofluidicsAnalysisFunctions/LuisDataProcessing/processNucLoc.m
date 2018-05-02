function [mn, nms]=processNucLoc(multichamber, nms, rng)
%%nms is a cell array of strings
cellchan=2
if nargin<2 ||isempty(nms)
nms=fieldnames(multichamber);    
nms= nms(~strcmp(nms, 'expInf'));
nms= nms(~strcmp(nms, 'dir'));
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
    
    %uncomment for fold change
    %mn(j,:)= mn(j,:)/ mn(j,1);
end
end


