function [val, err, out, cormat]=crosscorrMediaCells(range, cExperiment, varargin)
%%calculates the crosscorrelation between the media level and each cell
%%fluorescence level for a specific window range. this only works with
%%cells that have no zero values
% if isempty(varargin)
%     mediaTrace= nonzeroColMean(cExperiment.cellInf(2).mean(:, range));
%     matr= noZeroMatrix(full(cExperiment.cellInf(2).mean(:, range)));
% elseif(varargin{1}=='derivative')
%     mediaTrace= diff(normalizeTS(mean(cExperiment.cellInf(2).mean(:, range))));
%     matr= smoothDeriveAllCells(full(noZeroMatrix(cExperiment.cellInf(2).mean(:, range))));
% 
% end



% disp (['mediaTrace is' ]);
% mediaTrace;
% disp(['matr is']);
% matr;

cormat=[];
%%future development: change this for to receive a row function
out=[];
%figure;


matr= cExperiment.cellInf(2).mean(xNaNIndices(cExperiment),range);

y1= nonzeroColMean(full(cExperiment.cellInf(3).mean(xNaNIndices(cExperiment),range)));
for ii=  1: size(matr, 1)

y2= full(matr(ii,:));

[x lags]=crosscorr(y1, y2, size(y2,2)-1); 

absx= abs(x);

mxvc= absx==max(absx);
cormat(ii,:)=x;

 try out(ii)= x(find(mxvc)); catch out(ii)=NaN; end %%finds the max crosscorrelation regardless of whether it is positive or negative)
%plot(x);


 %plot(lags, x);
 hold on;
end

% figure;
% errorbar(lags, mean(cormat), std(cormat));
out=out';
val=mean(out);
err=std(out);




