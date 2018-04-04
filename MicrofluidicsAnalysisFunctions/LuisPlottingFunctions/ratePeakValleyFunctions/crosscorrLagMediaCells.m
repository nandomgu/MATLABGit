function [val, err, out]=crosscorrLagMediaCells(range, cExperiment, varargin)
%%calculates the crosscorrelation between the media level and each cell
%%fluorescence level for a specific window range. this only works with
%%cells that have no zero values
mediaTrace= normalizeTS(nonzeroColMean(cExperiment.cellInf(3).mean(:, range)))
matr= cExperiment.cellInf(2).mean(:, range);
disp (['source is' ]);
full(cExperiment.cellInf(2).mean(:, range))
disp(['matr is']);
matr
nlags= size(matr,2)-1;
%%future development: change this for to receive a row function
out=[];
%figure;

for ii=1: size(matr, 1)
%x=[1 7];
[x, lags]= crosscorr(mediaTrace, full(matr(ii,:)), size(matr,2)-1);



out(ii)= lags(abs(x)==max(abs(x)));


%timneg= lags(find(x==min(x)));






% mxmn=[max(x) min(x)];
% %sgns= [sign(max(x)) sign(min(x))];
% indx= find(abs(mxmn)==max(abs(mxmn)));


%out(ii)= mxmn(indx);  %%finds the max crosscorrelation regardless of whether it is positive or negative)
%plot(x);

%plot(lags, x);

end
out
val=mean(out);
err=std(out);




