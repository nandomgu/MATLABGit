function [val, err, arr]=downShiftFunction(range,cExperiment, funcwindow, func, col  )
%%function that receives a step experiment, finds the downshift time  and
%%makes it zero , and subtracts the background expression (that is, looks at
%%the points in subwindow positions before the downshift and subtracts the
%%average

%func is the function applied to the postishift window matrix. it must
%output a mean, error and value per cell.



if isempty(range)
    
    range= 1:size(cExperiment.cellInf(1).mean, 2);
    
end


    tsub=-5;%% number of indices before zero which will be considered as the baseline.

    [cellval, cellerr, indices,downShiftIndex,celltimes,den,ratePeakFigure]=rateValleyTimes(range, cExperiment,3,2, 1);

    alignedRange=aligntoDownshift(range,cExperiment);
   
    subwindow=range(ismember(alignedRange, tsub:0)); %% finding the original indices for the window that will be used as the baseline.
    
    flmatr=cExperiment.cellInf(2).mean(xNaNIndices(cExperiment),range); %%we extract the data matrix of the specified range
    %flmatr=flmatr- nanmean(flmatr(:,subwindow),2); % we subtract the average of the baseline window positions. 
    flmatr=flmatr-repmat(nanmean(flmatr(:,subwindow),2), 1, size(flmatr,2))
    
    if nargin<3
    
        flmatr=flmatr(:,find(alignedRange==0):end); %we subtract the window of the matrix that corresponds to after the downshift. 
    
    else
        
        flmatr=flmatr(:,find(alignedRange==0):find(alignedRange==0)+funcwindow);
        
    end
      
    if nargin<4
        
        func= @integrateMatrix;
        
    end
    
    
    
    [val, err, arr]= func(flmatr);
    
    
    
    
    
%     alignedRangeRT=alignedRange*5/60; %we make the time appear in real time rather that in index time.
%     
%  
     if nargin<5
         cmap=lines(20);
         col=cmap(1,:);
     end
%     
%     
%     
%     
%     
%     boundedline(alignedRangeRT(find(alignedRange==0):end), nonzeroColMean(flmatr), prepareBound(flmatr, @nonZeroColSEM), 'cmap', col, 'transparency', .1, 'alpha')
%     
    
    