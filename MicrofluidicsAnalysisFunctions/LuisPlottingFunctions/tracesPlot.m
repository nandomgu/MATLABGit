function tracesPlot(rng, cExperiment, channel, mainLineFunction, errFunction, numTraces, col)
%%cts- central tendency statistic


if nargin<7 || isempty(col)
cols=lines(20);    
col=cols(1,:);
end


indices=xNaNIndices(cExperiment, ceil(numel(rng)*.2))
figure; 
if nargin<3 || isempty(channel)
    channel=2;
end

if nargin<4 ||isempty(mainLineFunction)
    mainLineFunction=@nonzeroColMean;
end
if nargin<5 ||isempty(errFunction)
    
    errFunction=@nonZeroColSEM;
    
end

if nargin<6 ||isempty(numTraces)
    
    numTraces=10;
    
end

matr=cExperiment.cellInf(channel).mean(:, rng)

randselection= randsample(indices, numTraces)
plot(rng*5/60, mainLineFunction(matr(:, rng)), 'Color', col)
hold on; 
%scatter(stretchMatrix(repmat(rng*5/60,numel(randselection),1)'), stretchMatrix(zero2NaN(full(matr(randselection, rng)'))),'k', 'filled', 'MarkerFaceAlpha',.2) 
a=plot(rng*5/60, zero2NaN(full(matr(randselection, rng)))', 'Color', col+.2);
 %[.8, .8, .8]