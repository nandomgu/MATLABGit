%%directories of every experiment

%%340
n=1
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180403_results/cExperiment.mat'
rtype(n)=0

n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180405_results/cExperiment_001real.mat'
rtype(n)=0
%%342
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180329_results/cExperiment_001.mat'
rtype(n)=2

n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180328_results/cExperiment_001c03601.mat'
rtype(n)=2
%344
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180322_results/cExperiment_001.mat'
rtype(n)=4

n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180409_results/cExperiment.mat'
rtype(n)=4
%346
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180410_results/cExperiment.mat'
rtype(n)=6



%%plotting all curves for one
%cm=linspecer(4)

cm=colorRamp([0, 0.2, 0.4; 0,0.8, 1],4) %%gradient of dark blue- cyans
strains={'hxt2', 'hxt4', 'hxt7'}
flag=0;
for m=1:numel(strains)
g=figure;
rampaxes=figure;
ax(m)=axes(g);
axramp=axes();
c=0;

rampDurations=[0,2,4,6];
for j=[0,2,4,6]
    c=c+1;
    inds= find(rtype==j);
    for k=inds
        l1=load(ramppaths{k});
        cExperiment=l1.cExperiment
        pause(0.5)
        if k==4
            [h, means, times]=multiMeanPlotRobustStdAdvanced([], cExperiment, cm(c,:), 'wt', 'mig1', [1:20], 8,3, strains(m))
        else
            [h, means, times]=multiMeanPlotRobustStdAdvanced([], cExperiment, cm(c,:), 'wt', 'mig1g', [1:20], 8,3, strains(m))
            
        end
        child= get(h, 'children');
        originax=child(2);
        rampextract=child(3);
        copyobj(get(originax,'children'), ax(m))
        if flag==0
        copyobj(get(rampextract,'children'), axramp)
        end
        close(h)
    end
end 

flag=1
    
end

%%getting the start and endpoints of a ramp

rampstarts=[];
rampends=[];
for j=1:numel(ramppaths)  
   l1=load(ramppaths{j});
    cExperiment=l1.cExperiment

      mch=makeMultiChamber(cExperiment)
   [cy5, nms, times]=processcy5(mch)
      
   cy5= normalizeTS(nanmean(cy5))
   
   figure; plot(times, cy5); title('click on the start of the ramp')
   [rampstarts(j),y]=ginput(1);
   
  title('click on the end of the ramp')
   [rampends(j),y]=ginput(1);
   
end

 



%%%%plotting mig1 dynamics


figure;
cellchan=2
cols=colorRamp([.8,0,.8; .6,.6,0; 0,.8,.8], numel(ramppaths)+1) %we do plus one for us to start colors from 1 when there are values of 0
g=axes(gcf)
lw=1.2
for j=1:numel(ramppaths)  
   l1=load(ramppaths{j});
    cExperiment=l1.cExperiment

      mch=makeMultiChamber(cExperiment)
   [cy5, nms, times]=processcy5(mch)
      
   cy5= normalizeTS(nanmean(cy5))
    
    plot(g, times, cy5, 'Color', cols(rtype(j)+1, :), 'LineWidth', lw)%some rtypes are 0 so just add one to prevent
    hold on;
    
end
    
figure;
cellchan=7
h=axes(gcf)
smoothParam=0.98;
doSmooth=0


for j=1:numel(ramppaths)  
   l1=load(ramppaths{j});
    cExperiment=l1.cExperiment

[nl, nms, times]=processNucLocFoldChangeBasic(cExperiment, [], [], [], cellchan)
    
    
    response=nl(strcmp('mig1g', nms), :); 
    
    
    if ~isempty(response)
        if doSmooth==1
    response=fillmissing(response, 'linear');
    splFit= fit(times', response','smoothingspline', 'smoothingParam', smoothParam); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
    smoothResponse= splFit(times)
        else
            smoothResponse=response;
        end
    plot(h, times, smoothResponse, 'Color', cols(rtype(j)+1, :), 'LineWidth', lw)
    
    else
        response=nl(strcmp('mig1', nms), :);  
        response=fillmissing(response, 'linear');
         if doSmooth==1
        splFit= fit(times', response','smoothingspline', 'smoothingParam', smoothParam); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
        smoothResponse= splFit(times)
         else
             smoothResponse=response;
         end
        plot(h, times, smoothResponse, 'Color', cols(rtype(j)+1, :), 'LineWidth', lw)
        
    end
   hold on;
end  
xlabel('Time (hrs)')
ylabel('Rel. Mig1 Nuclear localisation (Pop. Mean)')




    plot(ii, times, nonzeroColMedian(cExperiment.cellInf(1).area), 'Color', cols(j,:))
    hold on;
end



%%plotting area

figure;
cols=linspecer(numel(ramppaths))
for j=1:numel(ramppaths)  
   l1=load(ramppaths{j});
    cExperiment=l1.cExperiment
    

  %%%building a model to predict the ramp end point
  %%% using the hxt4 peak times as a proxy for a positive training set.  
  %%% we produce design matrix 
  
  spacing=3
  len=3*spacing
  designMatrix=[];
  designMatrixPositive=[]
  fullResponseVector=[]
  slide=1
  cellchan=2;
  k=1;
  for j=1:numel(ramppaths)  
   l1=load(ramppaths{j});
    cExperiment=l1.cExperiment
    mch=makeMultiChamber(cExperiment)
    [cy5, nms, times]=processcy5(mch);
    cy= nanmean(normalizeTS(cy5))
    %getting the mean of Hxt4
    mn=nonzeroColMean(mch.hxt4.cellInf(cellchan).mean);
    %getting the peak of Hxt4 
    peak=nanmax(mn);
    meanpeaktime= find(mn==peak)%getting the index at which the peak is reached
    responseref= mn==peak  %logical that indicates which one is the pea
    responseVector=[];
     count=len+1
     while count+len<numel(responseref)
        designMatrix(k,:) =cy([count-len:spacing:count-spacing  count+spacing:spacing:count+len]);
        responseVector(k)=responseref(count)
        k=k+1
        count=count+slide
     end
      
    responseVector=responseVector
    glucoseDepletionIndexHxt4(j)=find(mn==peak)
    glucoseDepletionTimeHxt4(j)=meanpeaktime*5/60;
    designMatrixPositive(j,:) =cy([meanpeaktime-len:spacing:meanpeaktime-spacing  meanpeaktime+spacing:spacing:meanpeaktime+len])
    responseVector(j)=1;
  end

  %%%gettig the activation time of the gene by ginput (the lowest point to
  %%%the left of the peak
  strains={'hxt2', 'hxt4', 'hxt7'}
  
  for k=1:numel(strains)
      strain=strains{k};
  for j=1:numel(ramppaths)  
   l1=load(ramppaths{j});
    cExperiment=l1.cExperiment
    mch=makeMultiChamber(cExperiment)
    try
        times= nanmean(mch.(strain).cellInf(1).times)
    catch
        times= (1:size(mch.(strain).cellInf(1).mean, 2))*5/60
    end
    mn= nonzeroColMean(mch.(strain).cellInf(cellchan).mean)
    
    figure; plot(times, mn)
    title(['strain ' strain '. expt number ' num2str(j) '. Please sample 3 candidate activation points']) 
    [x, y]=ginput(3);
    props.(strain).activationTimes(j)=mean(x);
  end
  end
    
  
  
  
  %Getting the ramp properties of each hxt

nl={}
times={};
cols=linspecer(numel(ramppaths))

figure;

props=struct;
for j=1:numel(ramppaths)  
   l1=load(ramppaths{j});
    cExperiment=l1.cExperiment
        cellchan=8
    %processNucLocFoldChangeBasic(cExperiment, nms, rng,baserange, cellchan)
    [nl, nms, times]=processNucLocFoldChangeBasic(cExperiment, [], [], [], 7) 
    
    %standardising fluorescence values with the mean and 
    
    mch=makeMultiChamber(cExperiment)
    
    %in case there is no channel 7 extract 2
%     try 
%         test=mch.hxt2.cellInf(cellchan).mean
%     catch
%         test=[];
%         cellchan=2;
%     end
%     normvals= @(mch, strain) (mch.(strain).cellInf(cellchan).mean - nanmedian(mch.wt.cellInf(cellchan).mean))/nanmean(nonzeroColMean(mch.mig1g.cellInf(cellchan).mean(:, 1:20)))
%     normvals2= @(mch, strain) (mch.(strain).cellInf(cellchan).mean - nanmean(mch.wt.cellInf(cellchan).mean))/nanmean(nonzeroColMean(mch.mig1.cellInf(cellchan).mean(:, 1:20)))
% 
%     
%     try
%     mch.hxt2.cellInf(cellchan).mean=normvals(mch, 'hxt2')
%     mch.hxt4.cellInf(cellchan).mean=normvals(mch, 'hxt4')
%     mch.hxt4.cellInf(cellchan).mean=normvals(mch, 'hxt7')
%      catch
%     mch.hxt2.cellInf(cellchan).mean=normvals2(mch, 'hxt2')
%     mch.hxt4.cellInf(cellchan).mean=normvals2(mch, 'hxt4')
%     mch.hxt4.cellInf(cellchan).mean=normvals2(mch, 'hxt7') 
%     end
    
    props.hxt2.maxmedian(j)= median(nanmax(mch.hxt2.cellInf(cellchan).mean, [], 2))
    props.hxt4.maxmedian(j)= median(nanmax(mch.hxt4.cellInf(cellchan).mean, [], 2))
    props.hxt7.maxmedian(j)= median(nanmax(mch.hxt7.cellInf(cellchan).mean, [], 2))
    
    props.hxt2.p25(j)= prctile(nanmax(mch.hxt2.cellInf(cellchan).mean, [], 2), 25)
    props.hxt4.p25(j)= prctile(nanmax(mch.hxt4.cellInf(cellchan).mean, [], 2), 25)
    props.hxt7.p25(j)= prctile(nanmax(mch.hxt7.cellInf(cellchan).mean, [], 2), 25)
    
    props.hxt2.p75(j)= prctile(nanmax(mch.hxt2.cellInf(cellchan).mean, [], 2), 75)
    props.hxt4.p75(j)= prctile(nanmax(mch.hxt4.cellInf(cellchan).mean, [], 2), 75)
    props.hxt7.p75(j)= prctile(nanmax(mch.hxt7.cellInf(cellchan).mean, [], 2), 75)
    
    %getting the cell median per column and then extracting the value at
    %depletion
    matr=nonzeroColMedian(mch.hxt2.cellInf(cellchan).mean)
    props.hxt2.depletionMedian(j)=matr(glucoseDepletionIndexHxt4(j))
    matr=nonzeroColMedian(mch.hxt4.cellInf(cellchan).mean)
    props.hxt4.depletionMedian(j)=matr(glucoseDepletionIndexHxt4(j))
    matr=nonzeroColMedian(mch.hxt7.cellInf(cellchan).mean)
    props.hxt7.depletionMedian(j)=matr(glucoseDepletionIndexHxt4(j))
    
    [val, err, x,ind]= FLPeakTimes(1:numel(times), mch.hxt2, cellchan, 5, 1)
    props.hxt2.peakTime5max(j)=times(ind)
    [val, err, x,ind]= FLPeakTimes(1:numel(times), mch.hxt4,cellchan , 5, 1)
    props.hxt4.peakTime5max(j)=times(ind)
    [val, err, x,ind]= FLPeakTimes(1:numel(times), mch.hxt7, cellchan, 5, 1)
    props.hxt7.peakTime5max(j)=times(ind)
end
    
markers= ['^', 's', 'o'];
strains={'hxt2', 'hxt4', 'hxt7'}
cols=linspecer(3)

figure; 
for j=1:numel(strains)
scatter(rtype, props.(strains{j}).peakTime5max, 50, cols(j, :),'Marker', markers(j), 'MarkerFaceColor',cols(j, :) )
hold on
end
xlabel('Ramp Duration')
ylabel('Peak Time (hrs)')



figure; 
for j=1:numel(strains)
scatter(rtype, props.(strains{j}).peakTime5max-rampends, 50, cols(j, :),'Marker', markers(j), 'MarkerFaceColor',cols(j, :) )
hold on
end
addHLine(0)
xlabel('Ramp Duration')
ylabel('Peak Time relative to ramp endpoint')

figure; 
for j=1:numel(strains)
scatter(rtype, props.(strains{j}).maxmedian, 50, cols(j, :),'Marker', markers(j), 'MarkerFaceColor',cols(j, :) )
hold on
end
xlabel('Ramp Duration')
ylabel('Peak Fluorescence \newline (Pop. Median)')

figure; 
for j=1:numel(strains)
scatter(rtype, props.(strains{j}).activationTimes, 50, cols(j, :),'Marker', markers(j), 'MarkerFaceColor',cols(j, :) )
hold on
end
xlabel('Ramp Duration')
ylabel('activation Time')

figure; 
for j=1:numel(strains)
scatter(rtype, props.(strains{j}).activationTimes-glucoseDepletionTimeHxt4, 50, cols(j, :),'Marker', markers(j), 'MarkerFaceColor',cols(j, :) )
hold on
end
xlabel('Ramp Duration')
ylabel('activation Time relative to Glucose depletion (Hxt4 peak)')


figure; 
for j=1:numel(strains)
scatter(rtype, props.(strains{j}).depletionMedian, 50, cols(j, :),'Marker', markers(j), 'MarkerFaceColor',cols(j, :) )
hold on
end
xlabel('Ramp Duration')
ylabel('cell Median at the time of glucose depletion (Hxt4 peak)')




%