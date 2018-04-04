function xcorrmatr= xcorrCy5Derivative(range, cExperiment, cellchan, n)
%% this function performs the crosscorrelation between each cell and the environment
if(nargin<3)
cellchan=2;
n=2;
end

bgchan=3;


%matr=smootheach(cExperiment.cellInf(cellchan).mean(:, range),5);
matr=smoothDeriveAllCells(cExperiment.cellInf(cellchan).mean(:, range));
xcorrmatr=[]

for ii=1:size(matr,1)

[cor, lags]=crosscorr(diff(smooth(normalizeTS(mean(full(cExperiment.cellInf(bgchan).mean))))'), full(matr(ii,:)), numel(range)-2);
xcorrmatr(ii, :)=cor;
end
%max(abs(xcorrmatr'))

% 
% 
% % if type =='rate'
% %     matr= diff(matr);
% % end
% 
% [srt, sortIndices]=sort(matr,2, 'descend');
% arr=sortIndices(:, 1:n)
% x=reshape(arr, size(arr,1)*size(arr,2),1)'
% x=x*5/60;
% 
% den=ksdensity(x, range*5/60)
% val=mean(x);
% err=std(x);
% figure; plot(range*5/60, den);

end

