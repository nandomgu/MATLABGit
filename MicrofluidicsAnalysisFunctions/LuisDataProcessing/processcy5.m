function [newcy5mean, nms, times]=processcy5(multichamber, rng, chan)
nms=fieldnames(multichamber);
nms= nms(~strcmp(nms, 'expInf'))
nms= nms(~strcmp(nms, 'dir'))



if nargin<3 ||isempty(chan)
  chan=3;  
end


if nargin<2 ||isempty(rng)
   rng= 1:size(multichamber.(nms{1}).cellInf(chan).mean, 2);
    
end


try
    times=nanmean(multichamber.(nms{1}).cellInf(1).times/60);
catch
    disp('experiment likely does not contain time variable. defaulting to hours in 5 minute intervals')
    len=size(multichamber.(nms{1}).cellInf(1).mean,2);
    times=(1:len)*5/60;
end

cy5mean=[];
%disp([nms{:}])
for j=1:numel(nms)
   % disp(j);
    cy5mean(j,:)=nonzeroColMean(multichamber.(nms{j}).cellInf(chan).imBackground(:, rng));


    
end
    %create a mask for glitches based on second derivative. 
    %we assign a value of 150 in the second derivative for it to pass as a
    %glitch
%%filtering out outliers that are more than 2 standard deviations away
%%from the mean
sd=std(stretchMatrix(cy5mean));
mn=nanmean(nanmean(cy5mean));
zscores= (cy5mean-mn)./ sd;
%mask that contains the outlier positions
nanmsk= zscores>2;


%allders=deriveAllCells(deriveAllCells(cy5mean))>400;
%allders=[repmat(0,numel(nms), 2), allders]; %% adding a couple of zero columns to the right to compensate for reduction
%figure; plot(times, cy5mean.*(allders==0) )

%nanmsk=deriveAllCells(smoothDeriveAllCells(cy5mean))>200;
newcy5mean=[];
for j =1:numel(nms)
    %%interpolating the values where there were glitches
    tc=cy5mean(j,:); %temporary cy5 mean
    %using non gitch points as an interpolation ref 
    newcy5mean(j,:)= interp1(times(nanmsk(j,:)==0),  tc(nanmsk(j,:)==0), times) ;
    %figure; plot(times, newcy5mean(j,:))

end

end


