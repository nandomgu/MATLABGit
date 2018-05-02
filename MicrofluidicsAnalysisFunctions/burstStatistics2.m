function [positiveTransientAvg, negativeTransientAvg,burstMaxRate, maxRateIndex, totalMass, totalDuration,fractionPositives, intermittency, continuityAvg, sparsityAvg, tinterp, rankMask] = burstStatistics2(response)
%[positiveTransientAvg, negativeTransientAvg,burstMaxRate, maxRateIndex, totalMass, totalDuration,fractionPositives, intermittency, continuityAvg, sparsityAvg, tinterp, rankMask]  

plt=1;

    tresponse= (0:numel(response)-1)*5/60;
  tinterp=linspace(tresponse(1), tresponse(end), 500);
  interpResponse= interp1(tresponse, response, tinterp);
  %smoothResponse= smooth(interpResponse,40, 'rlowess');
  %%alternatively fit with a smoothing spline. probably better
  splFit= fit(tinterp', interpResponse','smoothingspline', 'smoothingParam', .7); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
  smoothResponse= splFit(tinterp);
  derivResponse=diff(smoothResponse)';
  
  
  
  isPositive= derivResponse>0;
  positiveIndices=find(isPositive);
  fractionPositives=numel(positiveIndices)/ numel(derivResponse);
  isNegative=derivResponse<=0;
  negativeIndices=find(isNegative);
  
  fractionNegatives=numel(negativeIndices)/ numel(derivResponse);
  
  
  lgs=lagmatrix(derivResponse,[0 1]);
  
positiveStarts=find(diff([0, isPositive,0])==1);
positiveEnds=find(diff([0, isPositive,0])==-1)-1;

positiveRanges= [positiveStarts', positiveEnds'];

negativeStarts=find(diff([0, isNegative,0])==1);
negativeEnds=find(diff([0, isNegative,0])==-1)-1;

negativeRanges= [negativeStarts', negativeEnds'];
if plt==1
  figure; 
  subplot(1,4,1); plot(tinterp, interpResponse); hold on;
  plot(tinterp, smoothResponse)
  subplot(1,4,2);
  plot(tinterp(2:end), derivResponse);
  addHLine(0);
%  addVLine(tinterp(positiveRanges))
  end
  

positiveTransients=zeros(size(positiveRanges, 1));
 positiveTransientAvg=0;
 totalMass=0;
 totalDuration=0;
  for j=1:size(positiveRanges,1)
      current= trapz(smoothResponse(positiveRanges(j,1):positiveRanges(j,2)))/(tinterp(positiveRanges(j,2))-tinterp(positiveRanges(j,1)));
      positiveTransientAvg=positiveTransientAvg+current;
      positiveTransients(j)= current;
      totalMass=trapz(smoothResponse(positiveRanges(j,1):positiveRanges(j,2)))-trapz(ones(1, numel(positiveRanges(j,1):positiveRanges(j,2))));
      totalDuration= totalDuration + (tinterp(positiveRanges(j,2))-tinterp(positiveRanges(j,1)));
  end
  
  
  
  negativeTransientAvg=0;
  negativeTransients=zeros(size(negativeRanges,1));
  for j=1:size(negativeRanges,1)
      current= trapz(smoothResponse(negativeRanges(j,1):negativeRanges(j,2)))/(tinterp(negativeRanges(j,2))-tinterp(negativeRanges(j,1)));
      negativeTransientAvg=negativeTransientAvg+current;
      negativeTransients(j)=current;
  end
  
  %%get the ranks for each element in the derivative
  [~, ~, derivativeRanking] = unique(derivResponse);
  derivativeRanking=numel(derivResponse)-derivativeRanking+1;
  
  %%now we apply a ranking mask to the response
  rankMask=[ones(1, numel(smoothResponse(1:end-1)))./derivativeRanking',0];
  
  %
  [~, ~, positiveRanking] = unique(derivResponse(positiveIndices));
  %signChanges=prod(lgs,2)<0; %%this gives the exact chagnes of direction
  
  intermittency=sum(size(negativeRanges, 1)+ size(positiveRanges,1))/2; %% intermittency is the average number of sign changes in the segment.
  sparsity=[]; %%sparsity refers to the average time between two consecutive positive bursts
  %in other words, the average duration of negative phases
  for j=1:size(negativeRanges,1)
  sparsity(j)= tinterp(negativeRanges(j,2))-tinterp(negativeRanges(j,1));
  %%now find stretches
  end
  sparsityAvg= mean(sparsity);
  continuity=[];%%continuity is the duration of the ositive bursts
  for j=1:size(positiveRanges,1)
  continuity(j)= tinterp(positiveRanges(j,2))-tinterp(positiveRanges(j,1));
  %%now find stretches
  end
  continuityAvg=mean(continuity);
  
  [burstMaxRate, maxRateIndices]=max(derivResponse);
  burstMaxRate=burstMaxRate(1);
  maxRateIndex= maxRateIndices(1);
  
  
  