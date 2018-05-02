function xcolors=intensity2Color(x, colorstops,nbins, varargin)
%% x is a column vector
if nargin<2
    colorstops= jet(3)
end

if nargin <3
    nbins=10
end

if nargin<4
   range= [min(x) max(x)]
else
    range= varargin{1}
end

cmap= colorRamp(colorstops, nbins);


rng= linspace(range(1), range(2), nbins);

%replicate x so it is a matrix of  x nbins times as columns
rngmat= repmat(rng, numel(x),1);
xmat= repmat(x, 1, nbins);



[a,b]=sort(abs(xmat- rngmat),2); %this line subtracts both matrices, gets the absolute value, and sorts by rows. therefore the first column
% of b corresponds to the indices of the smallest  alues of the subtraction, in other words, where the indices of the corresponding bins in range for each value of x.

inds=b(:,1);

xcolors= cmap(inds, :);

figure; scatter(1:numel(x), x, [], xcolors);


%here we have two matrices of equal sizes. now we subtract elementwise.






end

