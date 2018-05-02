function [fig,out]=comparePeakValley(cExperiment, func, window, cellchan, bgchan)
%a full experiment contains a peak and a valley in th e cy5 signal, and the
%function funct is calculated for windows spanning the peak and the valley.
range= 1:size(cExperiment.cellInf(2).mean,2);
%figure; plot(cExperiment.cellInf(cellchan).mean')
%figure; plot(smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean)')
if nargin <4
    
    
    cellchan=2
    bgchan=3
    side=0

end

%find media peak and valley times.
%get cell submatrices for before and after the peak and valley times
%func is a function of range,cExperiment, extractrange that produces a value out of a cell submatrix where
%each row is a cell and each column is a time point.

[a,b,c,upShiftTime]= ratePeakTimes(range, cExperiment, 3,2);

[a,b,c,downShiftTime]= rateValleyTimes(range, cExperiment, 3,2);


upShiftTime
downShiftTime

% beforeUpMatrix= cExperiment.cellInf(cellchan).mean(:,(-window:-1)+upShiftTime )
% afterUpMatrix= cExperiment.cellInf(cellchan).mean(:,(1:window)+upShiftTime )
% 
% beforeDownMatrix= cExperiment.cellInf(cellchan).mean(:,(-window:-1)+downShiftTime )
% afterDownMatrix= cExperiment.cellInf(cellchan).mean(:,(1:window)+downShiftTime )

(-window:-1)+upShiftTime
(1:window)+upShiftTime
(-window:-1)+downShiftTime
(1:window)+downShiftTime


%[up1val, up1err, up1percell]= func(range, cExperiment, (-window:-1)+upShiftTime);


%if side==0

upspan=[upShiftTime-window: upShiftTime+window];
downspan=[downShiftTime-window:downShiftTime+window];

% elseif side==-1
%     
%    upspan=[upShiftTime-window: upShiftTime];
% downspan=[downShiftTime-window:downShiftTime];
% 
% elseif side==1
%        upspan=[upShiftTime: upShiftTime+window];
% downspan=[downShiftTime:downShiftTime+window];
% 
% end
    
    

[upval, uperr, uppercell]= func(upspan, cExperiment );

%[down1val, down1err, down1percell]= func(range, cExperiment, (-window:-1)+downShiftTime);

%[(-window:-1)+downShiftTime (1:window)+downShiftTime]
[downval, downerr,downpercell]= func(downspan, cExperiment);

a=1;
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


 %upFoldChangeMean=  mean(up2percell)/mean(up1percell)
%downFoldChangeMean= mean(down2percell)/mean(down1percell)
% out.values=[up1val up2val down1val down2val];
% out.errors=[up1err up2err down1err down2err];

% uppercell
% downpercell
out=[uppercell, downpercell];
figure; 
boxplot([uppercell, downpercell]);
%bar([1,2], [upval, downval], 'FaceColor', [1 0 0])
%xlabels({'upshift', 'downshift'})
title(['Mean ' varname(func) 'value for upshift and downshift'])
% hold on;
 %errorbar([1,2], [upval, downval], [uperr, downerr],'o',  'Color', [0 0 0])
% hold on
% bar([3,4], [down1val, down2val], 'FaceColor', [0 0 1])
% hold on; 
% errorbar([3,4], [down1val, down2val], [down1err, down2err], 'o', 'Color', [0 0 0])
% hold on;

end







