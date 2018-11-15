

%%
nu=530
 [a1,b1]= mergeMatrices(locdata.mig1g.g1percent, 'data',nu);
 [a2,b2]= mergeMatrices(locdata.mig1g.gp2percent, 'data', nu);
 [a4,b4]= mergeMatrices(locdata.mig1g.gp4percent, 'data', nu);


num=15
concolors=linspecer(num);
condnames={'glu 0.2%', 'glu 0.4%', 'glu 1%'}
%concolors=concolors(randsample(1:size(concolors, 1), num), :);

concolors=[0.9904    0.6487    0.3595; 0.2519    0.6392    0.7049;0.6196    0.0039    0.2588]% 0.7852    0.1809    0.3055];

getformat= @(val) {'MarkerEdgeColor',concolors(val,:),  'Marker', '.', 'MarkerSize', 10, 'DisplayName',condnames{val} }
groupformats=arrayfun(getformat, [1,2,3], 'UniformOutput', false)




%all rep1s: p2 separates from the others
%%331 relatively nice separation of p2 and of p4 p1 in comp 2,3

%121 also works
%3 4 1 gives great separation between components 2 and 3


% a2=locdata.mig1g.gp2percent.rep2.data;
% a4=locdata.mig1g.gp4percent.rep1.data;
% %a1=locdata.mig1g.g1percent.rep3.data(1:200, :); % cells 200:249 in rep3 probably belong to another strain.
% a1=locdata.mig1g.g1percent.rep2.data; % cells 200:249 in rep3 probably belong to another strain.
% 

[coeffs, scoress]= pca([noNaNcells(a2);noNaNcells(a4);noNaNcells(a1)]);
gv=makeGroupVar(noNaNcells(a2),noNaNcells(a4),noNaNcells(a1));
figure;
subplot(1,3,1);
biplotG(coeffs, scoress, 'Groups', gv, 'Format', groupformats)
xlabel('Component 1'); ylabel('Component 2');
subplot(1,3,2);
biplotG(coeffs(:, [1,3]), scoress(:, [1,3]), 'Groups', gv, 'Format', groupformats)
xlabel('Component 1'); ylabel('Component 3');
subplot(1,3,3);
biplotG(coeffs(:, [2,3]), scoress(:, [2,3]), 'Groups', gv, 'Format', groupformats)
xlabel('Component 2'); ylabel('Component 3');

save2pdf('/Users/s1259407/Google Drive/0AFigures/paper/mig1/Mig1PCA_reps341.pdf')