function cy5SensitivityMap(range, colorRange, scaling, downsample, varargin)  %varargins are cExperiment objects


threshold=0
if isempty(colorRange)    
colorRange= [-10 10];

end

if isempty(scaling)
    
    scaling= repmat(1, 1, numel(varargin));
    
end

%varargin is one or more varargin{ii}s.

for ii=1:numel(varargin)
    

    

%x= stretchMatrix(normalizeTS(repmat(mean(varargin{ii}.cellInf(3).mean(:, 1:range(numel(range))-1)), size(varargin{ii}.cellInf(3).mean,1),1)));
%mediamatrix=normalizeTS(repmat(nonzeroColMean(varargin{ii}.cellInf(3).mean(:, 1:range(numel(range)-1))), size(varargin{ii}.cellInf(3).mean,1), 1))*scaling; %% scaling allows to work adapt the rates for different final levels of glucose in steps (otherwise the level of glucose would be assumed to be 1
mediamatrix=normalizeTS(varargin{ii}.cellInf(3).mean(:, 1:range(numel(range)-1)))*scaling; %% scaling allows to work adapt the rates for different final levels of glucose in steps (otherwise the level of glucose would be assumed to be 1

x=stretchMatrix(mediamatrix); 

figure; plot(normalizeTS(nonzeroColMean(varargin{ii}.cellInf(3).mean(:, 1:range(numel(range)-1))))')
dermatrix=smoothDeriveAllCells(normalizeTS(varargin{ii}.cellInf(3).mean(:, range))*scaling);
y= stretchMatrix(dermatrix);


if isempty(downsample)
    
a= 1:numel(x);
else
a = randi(length(y), downsample);

a=unique(a);
end


clrs=intensity2Color(stretchMatrix(smoothDeriveAllCells(varargin{ii}.cellInf(2).mean(:, range))), [0 0 1; 0 0 0; .8 .8 0], 20, colorRange)
figure; 
%plot(x(randi(numel(a),10)), y(randi(numel(a),10)), '-')
figure;


for j= 1:2 
smp=randsample(size(mediamatrix,1),1)
smpcolors=intensity2Color(stretchMatrix(smoothDeriveAllCells(varargin{ii}.cellInf(2).mean(smp, range))), [0 0 1; 0 0 0; .8 .8 0], 20, colorRange)
plot(mediamatrix(smp,:), dermatrix(smp,:), '-')
hold on; 
scatter(mediamatrix(smp,:), dermatrix(smp,:), [], smpcolors);
hold off
end

% figure; 
 scatter(x(a), y(a), [], clrs(a,:));

figure; 
%scatter(x(a), y(a), [], clrs(randsample(a, numel(a)),:));
% title('permutation')









end


end




