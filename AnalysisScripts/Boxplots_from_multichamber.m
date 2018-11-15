
intervals=struct;
intervals.r1=1:30
intervals.r2=38:56
intervals.r3= 90:120
intervals.r4= 130:156
intervals.r5= 170:200

sst=@(s) [s.r1; s.r2; s.r3; s.r4; s.r5 ] %making an array of all the ramp section values ( rx's) in a structure
ssg=@(s) [s.r1*0+1; s.r2*0+2; s.r3*0+3; s.r4*0+4; s.r5*0+5 ] % making a grouping variable for the above

%for all the strains in multichamber s getting rates in the n section

%getting the boxplots structure

alln=@(s,sugar,rep, n) [s.hxt4.(sugar).(['r' num2str(n)]).(rep); s.mig1ko.(sugar).(['r' num2str(n)]).(rep);s.snf3ko.(sugar).(['r' num2str(n)]).(rep);s.rgt2ko.(sugar).(['r' num2str(n)]).(rep);s.std1ko.(sugar).(['r' num2str(n)]).(rep);s.mth1ko.(sugar).(['r' num2str(n)]).(rep) ]

allng=@(s,sugar,rep, n) [s.hxt4.(sugar).(['r' num2str(n)]).(rep)*0+1; s.mig1ko.(sugar).(['r' num2str(n)]).(rep)*0+2;s.snf3ko.(sugar).(['r' num2str(n)]).(rep)*0+3;s.rgt2ko.(sugar).(['r' num2str(n)]).(rep)*0+4;s.std1ko.(sugar).(['r' num2str(n)]).(rep)*0+5;s.mth1ko.(sugar).(['r' num2str(n)]).(rep)*0+6 ]


%  
nms=fieldnames(cellrates)
for j=1:numel(nms)
    
    

flds=fieldnames(intervals)
nms=fieldnames(stdmch)
for j= 1:numel(flds)
    for k= 1:numel(nms)
        disp([nms{k}, ' ' flds{j} ' ;'])
[downval, downerr,cellrates.(strn).(['rep' num2str(k)]).(nms{k}).(flds{j})]= meanFLRateWindow(intervals.(flds{j}), stdmch.(nms{k}),[], 8)
    end
end



figure; 
for j=1:5
subplot(1,5,j)
 boxplot(alln(cellrates,j), allng(cellrates,j), 'Notch', 'on')
 ylim([-20,20])
end









%% cell sizes exploration line.
%strn='mth1ko'; media='g1percent'; rep='rep1'; figure; scatterhist(stretchMatrix(sizedata.(strn).(media).(rep)), stretchMatrix(celldata.(strn).(media).(rep)),'Kernel', 'on')

