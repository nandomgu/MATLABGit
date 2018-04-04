function flmatr=downShiftProcessing(range, col, cExperiment)
%%function that receives a step experiment, finds the downshift time  and
%%makes it zero , and subtracts the background expression (that is, looks at
%%the points in subwindow positions before the downshift and subtracts the
%%average


if isempty(range)
    
    range= 1:size(cExperiment.cellInf(1).mean, 2);
    
end


    tsub=-5;

    [cellval, cellerr, indices,downShiftIndex,celltimes,den,ratePeakFigure]=rateValleyTimes(range, cExperiment,3,2, 1);

    alignedRange=aligntoDownshift(range,cExperiment);
   
    subwindow=range(ismember(alignedRange, tsub:0)); %% finding the original indices for the preshift window
    
    flmatr=cExperiment.cellInf(2).mean(xNaNIndices(cExperiment),range);
   % flmatr=flmatr- nanmean(nanmean(flmatr(:,subwindow)));
    flmatr=flmatr-repmat(nanmean(flmatr(:,subwindow),2), 1, size(flmatr,2))
    
    
    
    flmatr=flmatr(:,find(alignedRange==0):end)
    
    alignedRangeRT=alignedRange*5/60
    
 
    if isempty(col)
        cmap=lines(20);
        col=cmap(1,:);
    end
    
    
    boundedline(alignedRangeRT(find(alignedRange==0):end), nonzeroColMean(flmatr), prepareBound(flmatr, @nonZeroColSEM), 'cmap', col, 'transparency', .1, 'alpha')
    
    
    