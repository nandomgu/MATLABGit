function flmatr=upShiftProcessing(range,col, cExperiment, customend)
%%function that receives a step experiment, finds the upshift time  and
%%makes it zero , and subtractsthe background expression (that is, looks at
%%the points in subwindow positions before the upshift and subtracts the
%%average.
%%Extension: check out the mode decision. it will define where the range
%%ends. you'll have to modify the mode variable to change the default way
%%the end is defined.

mode='complete';

 %default mode is downshift. change variable mode within the function to change the default.
   
   
if isempty(range)
    
    range= 1:size(cExperiment.cellInf(1).mean, 2);
    
end

    tsub=-5; %arbirtrary number of points to average before the shift
    alignedRange=aligntoUpshift(range,cExperiment);
    

    [cellval, cellerr, indices,downShiftIndex,celltimes,den,ratePeakFigure]=rateValleyTimes(range, cExperiment,3,2, 1);

    
    flag=0;
   while flag==0
    switch mode
        case 'downshift'
            finalpoint=downShiftIndex-5;
            flag=1;
        case 'complete'
            finalpoint= numel(alignedRange);
            flag=1;
        case 'custom'
            if nargin >5 && ~isempty(customend)
            finalpoint = customend;
            else
                mode='complete'
            end
    end
    
   end
   
  

   
    subwindow=range(ismember(alignedRange, tsub:0)); %% finding the original indices for the preshift window
    
    flmatr=cExperiment.cellInf(2).mean(xNaNIndices(cExperiment),range);
    %flmatr=flmatr- nanmean(nanmean(flmatr(:,subwindow)));
    flmatr=flmatr-repmat(nanmean(flmatr(:,subwindow),2), 1, size(flmatr,2))
    
    
    flmatr=flmatr(:,find(alignedRange==0):finalpoint)
    
    alignedRangeRT=alignedRange*5/60;
   
    
    if isempty(col)
        cmap=lines(20);
        col=cmap(1,:);
    end
    
    
    boundedline(alignedRangeRT(find(alignedRange==0):finalpoint), nonzeroColMean(flmatr), prepareBound(flmatr, @nonZeroColSEM), 'cmap', col, 'transparency', .1, 'alpha')
    
    
    