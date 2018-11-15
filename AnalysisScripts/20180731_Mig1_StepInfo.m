%% This script has been migrated to the mig1 localisation one. 
%this was done in order to make use of the other variables therein. 
figure;
css=[]
for num=1:size(nl, 2)
    disp(num)
smoothing=5;
ts=centeredtimes(num, :);
[a,b]=min(abs(ts+.33));
disp(2)
interval=(1:50)+b-1;
t=ts(interval);
%t=times(interval);

disp(3)
t=t-t(1);
n=smooth(nl2(num, interval),3)-1; plot(t, n, 'Color', selectMat(concolors, [0.2, 0.4, 1], currentfolders{num, 2})); 
s=stepinfo(n', t);
settlingTimes(num)=s.SettlingTime;
%addVLine(s.SettlingTime, 'k-'); 
%addHLine(s.SettlingMin, 'r--'); 
%addHLine(s.Peak, 'b--'); 
settlingMinTimes(num)=t(n==s.SettlingMin);
peakEndIndex=9
peakEndVal(num)= n(peakEndIndex)
specs={0.2, 'c-'; 0.4, 'b-';, 1, 'r-'};

whichspec=@(nm) specs{[specs{:,1}]==nm, 2}; 


addVLine(settlingMinTimes(num), whichspec(currentfolders{num,2}))
%while(j<numel(t))
    
css(num,:)= cumsum(n);

%j=j+5;

%end
end
figure; boxplot(settlingMinTimes, [currentfolders{:, 2}])
%%
