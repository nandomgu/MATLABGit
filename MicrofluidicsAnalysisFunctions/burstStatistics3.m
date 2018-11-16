function  [positiveStartsMatrix, positiveEndsMatrix, derivs]= burstStatistics3(matrix)
  %[positiveTransientAvg, negativeTransientAvg,burstMaxRate, maxRateIndex, totalMass, totalDuration,fractionPositives, intermittency, continuityAvg, sparsityAvg, tinterp, rankMask]= burstStatistics3(response)
positiveStartsMatrix=zeros(size(matrix, 1), size(matrix, 2));
positiveEndsMatrix=zeros(size(matrix, 1), size(matrix, 2));
plt=0;
%figure;
for k=1:size(matrix, 1)
    response= full(matrix(k,:));
    tresponse= (0:numel(response)-1)*5/60;
  tinterp=linspace(tresponse(1), tresponse(end), 500);
  interpResponse= interp1(tresponse, response, tinterp);
  %smoothResponse= smooth(interpResponse,40, 'rlowess');
  %%alternatively fit with a smoothing spline. probably better
  figure;
  %for x= linspace(1,.1,200)
  splFit= fit(tinterp', interpResponse','smoothingspline', 'smoothingParam', 0.7); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
  smoothResponse= splFit(tinterp);
  derivResponse=diff(smoothResponse)';
%   scatter(x, max(derivResponse)); hold on; 
%   end
  
  
  figure;
  subplot(2,1,1); hold on; plot(tinterp, smoothResponse); hold on
  subplot(2,1,2); plot(tinterp(1:end-1), derivResponse);hold on;
  if plt==1
  figure; 
  subplot(2,1,2); plot(tinterp, interpResponse); hold on; plot(tinterp, smoothResponse)
  subplot(1,4,2);
  plot(tinterp(1:end-1), derivResponse);
  addHLine(0, 'red')
  end
  
  
  isPositive= derivResponse>0;
  positiveIndices=find(isPositive);
  fractionPositives=numel(positiveIndices)/ numel(derivResponse);
  isNegative=derivResponse<=-0;
  negativeIndices=find(isNegative);
  
  fractionNegatives=numel(negativeIndices)/ numel(derivResponse);
  
  
  %lgs=lagmatrix(derivResponse,[0 1]);
  
%%%afer getting the positive and negative derivative indices you get the
%%%second derivative but add trailing zeros to keep the dims mathching
positiveStartsMatrix(k,find(diff([0, isPositive,0])==1))=1;
positiveEndsMatrix(k,find(diff([0, isPositive,0])==-1))=-1;

% positiveRanges= [positiveStarts', positiveEnds'];
% 
% negativeStartsMatrix(k,:)=find(diff([0, isNegative,0])==1);
% negativeEndsMatrix(k,:)=find(diff([0, isNegative,0])==-1)-1;
end

end




  
  