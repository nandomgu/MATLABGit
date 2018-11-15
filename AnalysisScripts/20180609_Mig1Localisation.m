%% 
figure;


%cmap=linspecer(5);
hash={0.2, 1;
 0.4, 2;
 1, 3}

concInd=@(hash, opt) hash{cell2mat(hash(:,1))==opt,2}
nl={};
maxes=[];
aucs=[];
for n=1:numel(exptList)

l1=load(exptList{n})
cExperiment=l1.cExperiment

if strcmp(cExperiment.metadata.microscope,'Batman')
    try %trying channel 8 and if it does not exist then channel 7.
[nl{n}, nms, times]= processNucLocFoldChangeBasicMax(cExperiment, {'mig1g'}, [], [1:20]);
    catch
    [nl{n}, nms, times]= processNucLocFoldChangeBasicMax(cExperiment, {'mig1g'}, [], [1:20]);
    end
else %in batgirl we actually want channel 6 or some other one.
[nl{n}, nms, times]= processNucLocFoldChangeBasicMax(cExperiment, {'mig1g'}, [], [1:20]);
end


maxes(n)= nanmax(nl{n})
aucs(n)= trapz(nl{n}-1);
%plot (times, nl{n}, 'Color', cmap(concInd(hash,currentfolders{n,2}),:), 'displayName', [currentfolders{n,1},' ', num2str(currentfolders{n,2})]);
%hold on;

end


for j=1:numel(nl)
nl2(j, :)= topUp(nl{j}, 250);
end


cmap=[0.9904    0.6487    0.3595; 0.2519    0.6392    0.7049;0.6196    0.0039    0.2588]% 0.7852    0.1809    0.3055];


figure; 
axes;
plotByGroupGeneral(times, cy5([1:6, 8:16,18], :), [currentfolders{[1:6, 8:16,18],2}], cmap)
axes;
plotByGroupGeneral(times, nl2([1:6, 8:16,18], :), [currentfolders{[1:6, 8:16,18],2}], cmap)
uniformAxes(gcf,[], [0,15], [],[], [] )
stackPlots(gcf)


%% getting the glucose appearance times for each replicate
%this script depends on experimentQueryPlottingMutants.
[a,b]=max(smoothDeriveAllCells(cy5),[],2)
centers=times(b)';
centeredtimes=repmat(times, 18,1) -repmat(centers, 1, size(times,2));
vls='b'
hls='b--'
figure;
n=true;
ylimcells=[0,2.5];
ylimloc=[0.65, 1.4];
r1=stackProbs(celldata.hxt4.gp2percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.hxt4.gp2percent.rep2.num
%t0=times(find(diff(cy5(num,:))==max(diff(cy5(num,:)))))
area(centeredtimes(num, :), r1', 'FaceAlpha', 0.7)
ylim(ylimcells)
yyaxis right
plot(selectMat(centeredtimes, [currentfolders{:,2}], .2)', selectMat(nl2, [currentfolders{:, 2}], 0.2)', '-', 'Color', [1 0 1])
ylim(ylimloc)
addVLine(0, vls)
addHLine(1.05, hls);
yyaxis left
axes;
r1=stackProbs(celldata.mig1ko.gp2percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.mig1ko.gp2percent.rep2.num
area(centeredtimes(num, :)', r1', 'FaceAlpha', 0.7)
ylim(ylimcells)
addVLine(0, vls)

axes;
r1=stackProbs(celldata.hxt4.g1percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.hxt4.g1percent.rep2.num
area(centeredtimes(num, :)', r1', 'FaceAlpha', 0.7)
ylim(ylimcells)
yyaxis right
plot(selectMat(centeredtimes, [currentfolders{:,2}], 1)', selectMat(nl2, [currentfolders{:, 2}],1)', '-', 'Color', [1 0 1])
ylim(ylimloc)
addVLine(0, vls);
addHLine(1.05, hls);
yyaxis left




axes;
r1=stackProbs(celldata.mig1ko.g1percent.rep2, [0.5,1,2,3,4,5,6], n)
num=locdata.mig1ko.g1percent.rep2.num
t0=times(find(diff(cy5(num,:))==max(diff(cy5(num,:)))))
area(centeredtimes(num, :)', r1', 'FaceAlpha', 0.7)
ylim(ylimcells)
addVLine(0, vls)
stackPlots(gcf)
uniformAxes(gcf,[], [-1,8], [],[.85], [] )



%% step Info Analysis. official version from now on, don't use the other script
%the script was moved here in order to make use of all the variables here. 

%%
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

[a,b]=sort(n);
weightedTimeRanks(num)=sum(t(b).*b');
css(num,:)= cumsum(n);

%j=j+5;

%end
end
figure; boxplot(settlingMinTimes, [currentfolders{:, 2}])
%%






