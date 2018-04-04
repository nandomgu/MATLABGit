function multiTracePlot(rng, multichamber, numTraces, colorEach, bg)

%many colors

%% 12 distinct colours
colorbrew=[166,206,227;
31,120,180;
178,223,138;
51,160,44;
251,154,153;
227,26,28;
253,191,111;
255,127,0;
202,178,214;
106,61,154;
255,255,153;
177,89,40;]/255

%% sequence of blues

blueColors=[255,255,217
237,248,177;
199,233,180;
127,205,187;
65,182,196;
29,145,192;
34,94,168;
37,52,148;
8,29,88;]/255

%% sequence of greens

greenColors=[255,255,229;
247,252,185;
217,240,163;
173,221,142;
120,198,121;
65,171,93;
35,132,67;
0,104,55;
0,69,41]/255

%% sequence of pinks/purples


pinkColors=[255,247,243;
253,224,221;
252,197,192;
250,159,181;
247,104,161;
221,52,151;
174,1,126;
122,1,119;
73,0,106]/255

%% sequence of greys

greyColors=[255,255,255;
240,240,240;
217,217,217;
189,189,189;
150,150,150;
115,115,115;
82,82,82;
37,37,37;
0,0,0]/255

%% sequence of reds-oranges

redColors=[255,247,236;
254,232,200;
253,212,158;
253,187,132;
252,141,89;
239,101,72;
215,48,31;
179,0,0;
127,0,0;]

%12 distinct colours from colorbrewer2.org


cols= colorbrew;

nms=fieldnames(multichamber);
nms= nms(~strcmp(nms, 'expInf'));
nms= nms(~strcmp(nms, 'dir'));

if nargin<5 ||isempty(bg)
  bg=0;
end

if isempty(rng)
  rng= 1:size( multichamber.(nms{1}).cellInf(1).mean, 2);
end

if nargin<4 ||isempty(colorEach)
    colorEach=0;
end
    

figure;
subplot(numel(nms)+1,1,1)
plot(rng*5/60, normalizeTS(nonzeroColMean(multichamber.(nms{1}).cellInf(3).mean(:,rng))), 'Color', cols(2,:), 'LineWidth', 2)
plotrng=rng*5/60;
for j=1:numel(nms)
subplot(numel(nms)+1, 1,j+1)

if size(multichamber.(nms{j}).cellInf(2).mean,1)>= numTraces
if colorEach==0
mx=tracesPlot(rng, multichamber.(nms{j}), 2, [], numTraces,[0,0,1], 0,0,bg);
else
    
mx=tracesPlot(rng, multichamber.(nms{j}), 2, [], numTraces,cols(j,:), 0,1, bg)  
    
end
end
%%retrieving also the maximum value plotted in the sample
text(plotrng(end)*.1,mx*.9, nms{j}, 'FontSize', 20)
end