function [val err arr]= probPeakingWindow(range, cExperiment, threshold)



matr=smoothDeriveAllCells(noZeroMatrix(cExperiment.cellInf(2).mean));




if nargin<3
    
    
    threshold =prctile(stretchMatrix(matr), 90)
    
end


% figure; plot(sum(matr>threshold)');


% mediaFigure= figure;
% mediaAxes= axes();
% plot(mediaAxes, range, normalizeTS(nonzeroColMean(cExperiment.cellInf(3).mean(:,range))));
% 
% hold on
% area([range(1),range(end)], [100,100], 'Facealpha', .5, 'FaceColor', [1 0 0])
% hold off


matr=matr(:, range);

arr= sum(matr>threshold, 2);

arr= arr/numel(range);

arr=log2(arr);


val=mean(arr);
err=std(arr);







%%for each row in matr, it gives the number of times that row surpasses the
%%threshold. the output is a value per cell