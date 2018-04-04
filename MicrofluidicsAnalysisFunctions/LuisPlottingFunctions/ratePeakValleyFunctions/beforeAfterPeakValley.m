function out=beforeAfterPeakValley(range, cExperiment, func, window, cellchan, bgchan)


%figure; plot(cExperiment.cellInf(cellchan).mean')
%figure; plot(smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean)')
if nargin <4
    
    window=5
    cellchan=2
    bgchan=3

end

%find media peak and valley times.
%get cell submatrices for before and after the peak and valley times
%func is a function of range,cExperiment, extractrange that produces a value out of a cell submatrix where
%each row is a cell and each column is a time point.

[a,b,c,upShiftTime]= ratePeakTimes(range, cExperiment, 3,2);

[a,b,c,downShiftTime]= rateValleyTimes(range, cExperiment, 3,2);

% beforeUpMatrix= cExperiment.cellInf(cellchan).mean(:,(-window:-1)+upShiftTime )
% afterUpMatrix= cExperiment.cellInf(cellchan).mean(:,(1:window)+upShiftTime )
% 
% beforeDownMatrix= cExperiment.cellInf(cellchan).mean(:,(-window:-1)+downShiftTime )
% afterDownMatrix= cExperiment.cellInf(cellchan).mean(:,(1:window)+downShiftTime )

(-window:-1)+upShiftTime
(1:window)+upShiftTime
(-window:-1)+downShiftTime
(1:window)+downShiftTime


[up1val, up1err, up1percell]= func(range, cExperiment, (-window:-1)+upShiftTime);

[up2val, up2err, up2percell]= func(range, cExperiment, (1:window)+upShiftTime);

[down1val, down1err, down1percell]= func(range, cExperiment, (-window:-1)+downShiftTime);

[down2val, down2err,down2percell]= func(range, cExperiment,(1:window)+downShiftTime );


% upFoldChangePerCell= mean(up2percell)./mean(up1percell)
% 
% upFoldChangeMean= mean(upFoldChangePerCell)
% upFoldChangeStd= std(upFoldChangePerCell)
% 
% 
% downFoldChangePerCell= mean(down2percell)/mean(down1percell)
% downFoldChangeMean= mean(downFoldChangePerCell)
% downFoldChangeStd= std(downFoldChangePerCell)
% 
%out= [upFoldChangeMean upFoldChangeStd, downFoldChangeMean, downFoldChangeStd]


 upFoldChangeMean=  mean(up2percell)/mean(up1percell)
downFoldChangeMean= mean(down2percell)/mean(down1percell)
% out.values=[up1val up2val down1val down2val];
% out.errors=[up1err up2err down1err down2err];
figure;
bar([1,2], [upFoldChangeMean, downFoldChangeMean], 'FaceColor', [1 0 0])
%xlabels({'upshift', 'downshift'})
title('Mean fold change before and after media shift')
% hold on;
 %errorbar([1,2], [upFoldChangeMean, downFoldChangeMean], [upFoldChangeStd, downFoldChangeStd],'o',  'Color', [0 0 0])
% hold on
% bar([3,4], [down1val, down2val], 'FaceColor', [0 0 1])
% hold on; 
% errorbar([3,4], [down1val, down2val], [down1err, down2err], 'o', 'Color', [0 0 0])
% hold on;

end







