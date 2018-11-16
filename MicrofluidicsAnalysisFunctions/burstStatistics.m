function [burstMass,burstLength,burstMaxRate, burstLag, zeroCrossingIndices, burstTimeRange]=burstStatistics(response, type, plt)
  %%this function receives a response (assumed to  be preprocessed), 
  %%finds its zero crossings and finds an expression burst. results are 
  %%performed on the first expression burst seen.
  if nargin<3 ||isempty(plt)
      
      plt=1;
  end
  
  
  flag=0;
  tresponse= (0:numel(response)-1)*5/60;
  tinterp=linspace(tresponse(1), tresponse(end), 500);
  interpResponse= interp1(tresponse, response, tinterp);
  %smoothResponse= smooth(interpResponse,40, 'rlowess');
  %%alternatively fit with a smoothing spline. probably better
  splFit= fit(tinterp', interpResponse','smoothingspline', 'smoothingParam', .7); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
  smoothResponse= splFit(tinterp);
  derivResponse=diff(smoothResponse);
  if plt==1
  figure; 
  subplot(1,4,1); plot(tinterp, interpResponse); hold on; plot(tinterp, smoothResponse)
  subplot(1,4,2);
  plot(tinterp(2:end), derivResponse);
  addHLine(0);
  end
  %%a lot of magic happens in the next line. MATLAB at its best. we scan 
  %%for the positions in
  %%the response derivative where it changes sign. we do it by generating a
  %%parallel vector to derivResponse where all elements have been displaced
  %%once.then we obtain the elementwise product of the vectors in this
  %%matrix. the positions where there has been a sign change will become
  %%negative. signChanges is 1 where the sign changes occurred.
  %plot(derivResponse);hold on;
  lgs=lagmatrix(derivResponse,[0 1]);
  signChanges=prod(lgs,2)<0;
  %%this gives us all the  exact changes of direction.
  %%now we have to apply some heuristic decisions to these changes. 
  %%we must figure out the sign of the change. the first crossing must
  %%be a negative to positive change and the second to be a positive to
  %%negative. In this particular instance, column 1 has no delay and column
  %%2 is 1 tp behind. this means that if there is a sign change, the sign
  %%of column 1 at the change point determines the directionality.
  
  
  %%if signChanges is empty that means that there is only increase or
  %%decrease. we find out which
  
  if isempty(find(signChanges))
      
      if sign(derivResponse(1))> 0
          positives=[1,numel(derivResponse)];
          negatives=[];
      end
      if sign(derivResponse(1))<0
          positives=[];
          negatives=[1,numel(derivResponse)];
      end
        
  else
  %%%detecting the directionalities of each change
  %directionalityOfChange=sign(lgs(signChanges,1)); %%we obtain the second number of the sequence where change was detected. get the sign.

 positives= find( sign(lgs(:,1).*signChanges)>0);%%we mask to show the numbers which show only a positive sign change, and get their index.
  
  

  
 negatives= find( sign(lgs(:,1).*signChanges)<0); %%find the indices of those who are positive 
  end


  
  %%now we apply heuristics about the  burst. a burst can be positive,
  %%negative or intermittent. 
  %the function could return statistics about the first positive, the first
  %negative or the first, whatever it is. 
  
  if nargin<2 || isempty(type)
     
      type='first';
  end
  
  flag=0;
  buffer=0; %%buffer is the minimal number of points required between crossings
  
 
  switch type
      case 'positive'
          
                       if isempty(positives) && ~isempty(negatives) %% it could be that there are no positive changes, only negatives.
      
                    positives(1)=1;
     
                       end
                       
                          
            first=positives(1);
                      
             if isempty(negatives) %% it could be that there are no positive changes, only negatives.
      
      negatives(1)=numel(derivResponse);
             end
            second=negatives(1); 
            
             if positives(1) > negatives(1)
                 
                 if numel(negatives)>1
                     j=1;
                    while(numel(negatives)>1 && j<=numel(negatives))
             
                            if negatives(j)>positives(1)             
                                second=negatives(j); 
                                break
                            else
                              second=negatives(1)  
                            end
                            j=j+1;
                    end
                 else 
                     first= 1;
                     positives = [1; positives];
                 end
                 
             end
          zeroCrossingIndices(1)=first;
          zeroCrossingIndices(2)=second;
       
           case 'negative'
          
                       if isempty(negatives) && ~isempty(positives) %% it could be that there are no positive changes, only negatives.
      
                    negatives(1)=1;
     
                       end
            first=negatives(1);
                      
             if isempty(positives) %% it could be that there are no positive changes, only negatives.
      
      positives(1)=numel(derivResponse);
             end
             second=positives(1);
             
             if negatives(1) > positives(1)
                 
                 if numel(positives)>1
                    while(numel(positives)>1 && j<=numel(positives))
             
                            if positives(j)>negatives(1)             
                                second=positives(j); 
                                break
                            else
                              second=positives(1);  
                            end
                    end
                 else 
                     first= 1;
                     negatives = [1; negatives];
                 end
                 
             end
             
          zeroCrossingIndices(1)=first;
          zeroCrossingIndices(2)=second;

      case 'first' %%this is the standard case          
  zeroCrossingIndices=find(signChanges)+1;
  
  
  
  end
  
  
   if isempty(zeroCrossingIndices) || flag==-1 %% if there never are zero crossings then make the first number 1 (it becomes 0 when nottaken care of) 
       zeroCrossingIndices(1)=1;
   end
  
  if numel(zeroCrossingIndices)<2 %% if there is only one zero crossing (burst never stops), then make the second number the final one.
      zeroCrossingIndices(2)=numel(signChanges);
  end
  
  zeroCrossingTimes=tinterp(zeroCrossingIndices);
  %%then we draw vertical lines where the sign change occured.
  
  if plt==1
  %addVLine(zeroCrossingTimes);
  addHLine(0);
  subplot(1,4,3)
   area(tinterp([zeroCrossingIndices(1):zeroCrossingIndices(2)]), smoothResponse([zeroCrossingIndices(1):zeroCrossingIndices(2)]), 'Facealpha',0.5);
  subplot(1,4,4)
  area(tinterp([zeroCrossingIndices(1):zeroCrossingIndices(2)]), derivResponse([zeroCrossingIndices(1):zeroCrossingIndices(2)]), 'Facealpha',0.5);
  end
  
   burstInterval=tinterp([zeroCrossingIndices(1):zeroCrossingIndices(2)]);
   burstTimeRange=tinterp([zeroCrossingIndices(1) zeroCrossingIndices(2)]);
   %overall time length of the burst.
   burstLength= burstTimeRange(2)-burstTimeRange(1);
   %delay in positive expression
   burstLag=tinterp(zeroCrossingIndices(1));
   burstMass= trapz(tinterp([zeroCrossingIndices(1) zeroCrossingIndices(2)]),smoothResponse([zeroCrossingIndices(1) zeroCrossingIndices(2)]));
   %%this is the max rate between the zero crossings
   %burstMaxRate=max(derivResponse([zeroCrossingIndices(1):zeroCrossingIndices(2)]));
   
   %%this is the max rate in the whole segment
   burstMaxRate=max(derivResponse);

   burstMaxRate=burstMaxRate(1);
   %%not yet included:
   %%fit slope of the response
   %%average expression rate during the pulse
   %%max expression rate during the pulse
   
  %A=eye(numel(interpResponse)).*repmat(interpResponse, 500,1)
  
  