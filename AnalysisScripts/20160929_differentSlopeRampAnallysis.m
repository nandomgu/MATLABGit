% Different slope ramp analysis 20160928. time is always 5 minute
% intervals.


%                             rampTimepointRange    rampDescription                                           rampFileName   strains     startingODs                                               
% ramp{1} cExperimentsmultichambers201609{1}      35:120% 3h_rampDown_fastJerk_long duration_asymptotic 
% ramp{2} multichambers201609{2}      55:120                shootUp_3h_rampDown_fastJerk_cleanTransitions
% ramp{3} multichambers201608{1}      18:49                 2h_rampDown_smooth_cleanTransitions_waveyEnds
% ramp{4} multichambers201608{2}      50:100                1h_shootUp_unevenTop_3h_rampDown_curved_asymptotic
% ramp{5} multichambers201608{5}      2:20                  30min_smooth_fastRamp_smoothRamp


% multichambers{1}.dir   /Users/s1259407/Desktop/timelapses/201609_different_slope_ramps/20160903_rampdown200_try2_oldcells_00
% multichambers{2}.dir   /Users/s1259407/Desktop/timelapses/201609_different_slope_ramps/rampdown200_hxt2_hxt4_hxt6_hxt7_mig1_rampdown_200_00
% multichambers201608{1}.dir /Users/s1259407/Desktop/timelapses/201608_differen_slope_ramps/20160812_rampCharacterisation_02
% multichambers201608{2}.dir  /Users/s1259407/Desktop/timelapses/201608_differen_slope_ramps/20160816_hxt2hxt4hxt6Mig1Hxt7_rampDown200_00
% multichambers201608{5}.dir   /Users/s1259407/Desktop/timelapses/201608_differen_slope_ramps/20160819_hxt2_Hxt4_Mig1_Rampup_previouswasrampup_00


%% plotting multichambers full responses
multiInputPanel([1:120],multichambers201609{1}.hxt4)
multiInputPanel([1:120],multichambers201609{2}.hxt4)
multiInputPanel([1:49],multichambers201608{1}.pos)
multiInputPanel([1:100],multichambers201608{2}.hxt4)
multiInputPanel([1:25],multichambers201608{5}.hxt4)
multiInputPanel([25:65],multichambers20161016{1}.hxt4)






strains={'hxt1', 'hxt2', 'hxt4', 'hxt7'}
for c=1:numel(strains)
strain=strains{c};
rampsDown={};
%% plotting multichambers and obtaining the time series for experiments above, starting at the time of the ramp fall
try
rampsDown{1}=multiInputPanel([35:120],multichambers201609{1}.(strain))
end
try
rampsDown{2}=multiInputPanel([55:120],multichambers201609{2}.(strain))
end
try
rampsDown{3}=multiInputPanel([18:49],multichambers201608{1}.(strain)) %%hxt4 is pos
end
try
rampsDown{4}=multiInputPanel([50:100],multichambers201608{2}.(strain))
end
try
rampsDown{5}=multiInputPanel([2:20],multichambers201608{5}.(strain))
end
try
rampsDown{6}=multiInputPanel([28:77],multichambers20161014{2}.(strain))
end
try
rampsDown{7}=multiInputPanel([42:77],multichambers20161014{1}.(strain))
end
try
rampsDown{8}=multiInputPanel([1:25],multichambers20161016{4}.(strain))
end
try
rampsDown{9}=multiInputPanel([25:48],multichambers20161025{2}.(strain))
end
try
rampsDown{10}=multiInputPanel([32:65],multichambers20161115{2}.(strain))
end
try
rampsDown{11}=multiInputPanel([30:70],multichambers20161116{1}.(strain))
end
try
rampsDown{12}=multiInputPanel([25:70],multichambers20161116{3}.(strain))
end

%close all;
rampsDown= rampsDown(find(~cellfun(@isempty, rampsDown)))
% %% figure plotting the ramps, each in a different color
% 
% figure; plot(rampsUp{1}.cy5)
% hold on; plot(rampsUp{2}.cy5)
% hold on; plot(rampsUp{3}.cy5)
% hold on; plot(rampsUp{4}.cy5)
% hold on; plot(rampsUp{5}.cy5)
% hold on; plot(rampsUp{6}.cy5)
% hold on; plot(rampsUp{7}.cy5)
% hold on; plot(rampsUp{8}.cy5)
% hold on; plot(rampsUp{9}.cy5)
% hold on; plot(rampsUp{10}.cy5)
% hold on; plot(rampsUp{11}.cy5)
% hold on; plot(rampsUp{12}.cy5)
% 
% %%figure containing the mean responses, raw
% figure; plot(rampsUp{1}.mean)
% hold on; plot(rampsUp{2}.mean)
% hold on; plot(rampsUp{3}.mean)
% hold on; plot(rampsUp{4}.mean)
% hold on; plot(rampsUp{5}.mean)
% hold on; plot(rampsUp{6}.mean)
% hold on; plot(rampsUp{7}.mean)
% hold on; plot(rampsUp{8}.mean)
% hold on; plot(rampsUp{9}.mean)
% hold on; plot(rampsUp{10}.mean)
% hold on; plot(rampsUp{11}.mean)
% hold on; plot(rampsUp{12}.mean)
% %% figure containing the responses centered to before the ramp
% 
% figure; plot(rampsDown{1}.mean-rampsDown{1}.mean(1))
% hold on; plot(rampsDown{2}.mean-rampsDown{2}.mean(1))
% hold on; plot(rampsDown{3}.mean-rampsDown{3}.mean(1))
% hold on; plot(rampsDown{4}.mean-rampsDown{4}.mean(1))
% hold on; plot(rampsDown{5}.mean-rampsDown{5}.mean(1))
% hold on; plot(rampsDown{6}.mean-rampsDown{6}.mean(1))

%% ramps up, adjusted to start half an hour within the time series

rampsUp={}
try
rampsUp{1}=multiInputPanel([8:20],multichambers201608{2}.(strain))
end
try
rampsUp{2}=multiInputPanel([1:20],multichambers201608{7}.(strain))
end
try
rampsUp{3}=multiInputPanel([40:87],multichambers201608{3}.(strain))
end
try
rampsUp{4}=multiInputPanel([40:95],multichambers201609{3}.(strain))
end
try
rampsUp{5}=multiInputPanel([40:90],multichambers201608{8}.(strain))
end
try
rampsUp{6}=multiInputPanel([25:65],multichambers20161016{1}.(strain))
end
try
rampsUp{7}=multiInputPanel([28:55],multichambers20161110{1}.(strain))
end
try
rampsUp{8}=multiInputPanel([44:54],multichambers20161025{1}.(strain))
end
try
rampsUp{9}=multiInputPanel([25:65],multichambers20161110{1}.(strain))
end
try
rampsUp{10}=multiInputPanel([33:50],multichambers20161115{1}.(strain))
end
try
rampsUp{11}=multiInputPanel([25:70],multichambers20161116{2}.(strain))
end
try
rampsUp{12}=multiInputPanel([33:65],multichambers20161117{1}.(strain))
end

% close all;

rampsUp= rampsUp(find(~cellfun(@isempty, rampsUp)))

% %% plotting the ramps up
% 
% figure; plot(rampsUp{1}.cy5)
% hold on; plot(rampsUp{2}.cy5)
% hold on; plot(rampsUp{3}.cy5)
% hold on; plot(rampsUp{4}.cy5)
% hold on; plot(rampsUp{5}.cy5)
% hold on; plot(rampsUp{6}.cy5)
% 
% %%figure containing the mean responses, raw
% figure; plot(rampsUp{1}.mean)
% hold on; plot(rampsUp{2}.mean)
% hold on; plot(rampsUp{3}.mean)
% hold on; plot(rampsUp{4}.mean)
% hold on; plot(rampsUp{5}.mean)
% hold on; plot(rampsUp{6}.mean)
% 
% %% figure containing the ramps up, adjusted to start half an hour within the time series
% 
% 
% figure; plot(rampsUp{1}.mean-rampsUp{1}.mean(1))
% hold on; plot(rampsUp{2}.mean-rampsUp{2}.mean(1))
% hold on; plot(rampsUp{3}.mean-rampsUp{3}.mean(1))
% hold on; plot(rampsUp{4}.mean-rampsUp{4}.mean(1))
% hold on; plot(rampsUp{5}.mean-rampsUp{5}.mean(1))
% 
% %% plotting glucose in the x axis
% figure; plot(ramp{1}.cy5, ramp{1}.mean-ramp{1}.mean(1))
% hold on; plot(ramp{2}.cy5,ramp{2}.mean-ramp{2}.mean(1))
% hold on; plot(ramp{3}.cy5,ramp{3}.mean-ramp{3}.mean(1))
% hold on; plot(ramp{4}.cy5,ramp{4}.mean-ramp{4}.mean(1))
% hold on; plot(ramp{5}.cy5,ramp{5}.mean-ramp{5}.mean(1))
% 
% %% plotting the glucose in the x axis for rhe ramps Up
% 
% figure; plot(ramp{6}.cy5,ramp{6}.mean-ramp{6}.mean(1))
% hold on; plot(ramp{7}.cy5,ramp{7}.mean-ramp{7}.mean(1))
% hold on; plot(ramp{8}.cy5,ramp{8}.mean-ramp{8}.mean(1))
% hold on; plot(ramp{9}.cy5,ramp{9}.mean-ramp{9}.mean(1))
% hold on; plot(ramp{10}.cy5,ramp{10}.mean-ramp{10}.mean(1))


%% fitting lines for a specific transition
high=1;
low=0.1;
polytype='poly1'
strength=10;
%%for each of the transition values, a fitting weight is given?i.e. points
%%with heavier weight are priority to the fit. in this particular case we
%%have values between 1 to 0, and we want the middle values to be more
%%important for the transition, whereas we don't care as much for the
%%extremes. to simulate this fit, we take the normal probability
%%density function with mean 0.5 to provide those weights. the larger the
%%sigma, the more inclusive it will be towards points near the edges.
mu=0.5;
sigma=.1; %%weights have standard deviation of 0.2
fiUp=[];
fiDown=[];
tiUp=[];
tiDown=[];
precisionUp={};
precisionDown={};


for j=1:numel(rampsDown)
[fiDown(j), tiDown(j), precisionDown{j}]=getTransitionIndices(rampsDown{j}.cy5, high,low)
end


for j=1:numel(rampsUp)
[fiUp(j), tiUp(j), precisionUp{j}]=getTransitionIndices(rampsUp{j}.cy5,low, high)
end



%% fitting slopes between the transition indices
slopesUp=[];
interceptsUp=[];
fitobjectUp={};
gofUp={};

slopesDown=[];
interceptsDown=[];
fitobjectDown={};
gofDown={};



for j=1:numel(rampsUp)
[fitobjectUp{j}, gofUp{j}]=fit(((fiUp(j):tiUp(j))*5/60)', (rampsUp{j}.cy5(fiUp(j):tiUp(j)))', polytype, 'weights', normpdf(rampsUp{j}.cy5(fiUp(j):tiUp(j)),mu,sigma)*strength)
slopesUp(j)=fitobjectUp{j}.p1;
interceptsUp(j)=fitobjectUp{j}.p2;
end


for j=1:numel(rampsDown)
[fitobjectDown{j}, gofDown{j}]=fit(((fiDown(j):tiDown(j))*5/60)', (rampsDown{j}.cy5(fiDown(j):tiDown(j)))', polytype, 'weights', normpdf(rampsDown{j}.cy5(fiDown(j):tiDown(j)),mu,sigma)*strength)
slopesDown(j)=fitobjectDown{j}.p1;
interceptsDown(j)=fitobjectDown{j}.p2;
end



%% plotting the ramp Up fits
% figure;
% horz= floor(sqrt(numel(rampsUp)))
% vert= ceil(sqrt(numel(rampsUp)))
% for j=1:numel(rampsUp)
% subplot(horz,vert,j); plot(((fiUp(j):tiUp(j))*5/60)', rampsUp{j}.cy5(fiUp(j):tiUp(j)))'; hold on; plot(fitobjectUp{j}); legend(['ramp' num2str(j)], ['y=' num2str(slopesUp(j)) 'x + ' num2str(interceptsUp(j))]);
% end
% 
% %% plotting the ramp Down fits
% figure;
% horz= floor(sqrt(numel(rampsDown)))
% vert= ceil(sqrt(numel(rampsDown)))
% for j=1:numel(rampsDown)
% subplot(horz,vert,j); plot(((fiDown(j):tiDown(j))*5/60)', rampsDown{j}.cy5(fiDown(j):tiDown(j)))'; hold on; plot(fitobjectDown{j}); legend(['ramp' num2str(j)], ['y=' num2str(slopesDown(j)) 'x + ' num2str(interceptsDown(j))]);
% end



%% analysis of the bursts for individual ramps
burstMassUp=[];
burstLengthUp=[];
burstMaxRateUp=[];
burstLagUp=[];

burstMassDown=[];
burstLengthDown=[];
burstMaxRateDown=[];
burstLagDown=[];

for j=1:numel(rampsUp)
  r= rampsUp{j};
  bg= r.mean(fiUp(j));%%response level before the ramping
 % response=r.mean(fi(j):ti(j)); %%response during the time of the ramping
  response=r.mean(fiUp(j):end);
  j%%full response
  centeredResponse=response-bg;
  
  [burstMassUp(j),burstLengthUp(j),burstMaxRateUp(j), burstLagUp(j), zeroCrossingIndices, burstTimeRange]=burstStatistics(centeredResponse, 'first');
  
end


for j=1:numel(rampsDown)
  r= rampsDown{j};
  bg= r.mean(fiDown(j));%%response level before the ramping
 % response=r.mean(fi(j):ti(j)); %%response during the time of the ramping
  response=r.mean(fiDown(j):end); %%full response
  centeredResponse=response-bg;
  
  [burstMassDown(j),burstLengthDown(j),burstMaxRateDown(j), burstLagDown(j), zeroCrossingIndices, burstTimeRange]=burstStatistics(centeredResponse, 'positive');
  
end

%% plotting burst mass over time explained by the slope
cols=lines(10)
symbols= {'o', 'x', 's', '+', '^', '*', 'd'}
scatter(slopesDown, burstMassDown./ (tiDown-fiDown) ,symbols{c}, 'markeredgecolor', cols(c,:))
hold on; scatter(slopesUp, burstMassUp./ (tiUp-fiUp),symbols{c}, 'markeredgecolor', cols(c,:))
addVLine(0, [0.6,0.6,0.6])
addHLine(0, [0.6,0.6,0.6])
ylabel('Accumulated fluorescence/time', 'fontsize', 20)
xlabel('Slope', 'fontsize', 20)


%% plotting burst mass (raw) explained by the slope

% figure; scatter(slopesDown, burstMassDown,symbols(c),'markeredgecolor', cols(c,:) )
% hold on; scatter(slopesUp, burstMassUp,symbols(c),'markeredgecolor', cols(c,:) )
% addVLine(0, [0.6,0.6,0.6])
% addHLine(0, [0.6,0.6,0.6])
% ylabel('Accumulated fluorescence/time', 'fontsize', 20)
% xlabel('Slope', 'fontsize', 20)

end
