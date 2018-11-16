function [med, mn, sd, mx, miin]=experimentTimeAverageOmero(cExperiment, searchstring, poses)
  %% in experiments where omero is used to retrieve the image, we resort to the cExperiment
  %% to retrieve a timepoint.  
whichChannelsMatch=find(strcmp(cExperiment.channelNames, searchstring));
if sum(whichChannelsMatch)==0
    error('No channelname matches the given search string. available channel names are')
    disp('Avaliable channel names', cExperiment.channelNames)
end

if sum(whichChannelsMatch)>1
    disp('More than one matching channel found. taking first matching channel by default')
    whichChannelsMatch= whichChannelsMatch(1);
end


if nargin<3 ||isempty(poses)
    poses=1:numel(cExperiment.dirs);
    
end
med=[]; %to hold the median 
mn=[]; %mean
sd=[]; %standardDeviation
mx=[]; % maximum value %will probably  have to deal with saturation issues but still useful
miin=[]; %minimum value
for j=1:numel(poses)
    ct=cExperiment.returnTimelapse(poses(j));
    tms=numel(ct.cTimepoint);
    disp(['Processing position ', num2str(j)])
    pause(.5)
    tprogress(j/numel(poses))
    for k=1:tms %for each timepoint  
        %disp(k)
        try
        im=ct.returnSingleTimepoint(k, whichChannelsMatch);
        im=im(1:512,1:512);
        med(j, k)= median(im(:));
        mn(j, k)= mean(im(:));
        sd(j, k)= std(double(im(:)));
        mx(j, k)= max(im(:));
        miin(j, k)= min(im(:));
        
        catch
        med(j, k)= NaN;
        mn(j, k)= NaN;
        sd(j, k)= NaN;
        mx(j, k)= NaN;
        miin(j, k)= NaN;
        end

end
end

