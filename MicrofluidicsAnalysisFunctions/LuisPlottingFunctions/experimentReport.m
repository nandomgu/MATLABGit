
function experimentReport(range, multichamber, window,  varargin)

%this report is currently best suited for step-like experiments.
%first include everything that must be include and figure out the panel
%afterwards. 
    
% multiMeanPlot of the experiment
strs= varargin;
varargin=strjoin({repmat('@',numel(varargin),1),  char(varargin(1:numel(varargin))')},'');


%varargin
mainFigure=figure; 




if isempty(window)
window=30;

end


multiMeanFigure=multiMeanPlotRobust(range, multichamber);

nms=fieldnames(multichamber)
nms=nms(~strcmp(nms, 'expInf'));
eval(['cExperiment= multichamber.' nms{1} ';'])

if isempty(range)
    
    range= 1: size(cExperiment.cellInf(1).mean,2);
    
end

exptName= [reverseDate()  '_Report_' multichamber.expInf.media{1} '_to_' multichamber.expInf.media{2} '_' multichamber.expInf.transitionType '_' strjoin(nms', '-')]; 
set(mainFigure, 'Name', exptName);

%obtaining the media peak and valley times independently
[cellval, cellerr, timehr,ind,celltimes,den,ratePeakFigure]=ratePeakTimes(range, cExperiment,2,2, 0);
[upval, uperr, uptimes, upShiftTime]=ratePeakTimes(range, cExperiment, 3,2);
[downval, downerr, downtimes, downShiftTime]=rateValleyTimes(range, cExperiment, 3,2);

%val, err, x,ind, indices, den, fig

mediaFigure= figure;
mediaAxes= axes();
plot(mediaAxes, range, normalizeTS(nonzeroColMean(cExperiment.cellInf(3).mean(:,range))));

hold on
area((upShiftTime-window/2):(upShiftTime+window/2), repmat(1, 1,numel((upShiftTime-window/2):(upShiftTime+window/2))), 'Facealpha', .5, 'FaceColor', [1 0 0])
area((downShiftTime-window/2):(downShiftTime+window/2), repmat(1, 1,numel((downShiftTime-window/2):(downShiftTime+window/2))), 'Facealpha', .5, 'FaceColor', [.1 .1 1])
hold off

num=4; % to generate a numxnum template
%%general figure parameters

if(numel(nms)<=2)
    special=6;
else
    special=4;
end
    
if numel(nms)==1
    maxwd=.2;
    maxlen=.2;
    startleft=.1;
    startbottom=.8;
    leftMargin=maxwd/3
    bottomMargin=maxwd/3
else

maxwd=  1/(numel(nms)+special) ;%size must be smaller than 1. all figure sizes will be calculated upon these width and length.

maxlen=1/(numel(strs)+3);
startleft=.3/(numel(nms)+special*2);
bottomMargin=(maxwd+(.03*numel(nms)))/(numel(nms));
startbottom=1-maxlen-bottomMargin;
leftMargin=(maxwd+(.02*numel(nms)))/(numel(nms));


end


spacing=1/10;
rightMargin=leftMargin
topMargin=bottomMargin;
marginExpansion= [leftMargin -topMargin 0 0]
currentleft=startleft;
currentbottom=startbottom;
smallwd= maxwd/1.5;





ax= get(multiMeanFigure, 'children');

d=copyobj(ax(3), mainFigure)
set(d, 'Position',  [0+ leftMargin, currentbottom-bottomMargin, maxwd, maxlen])
axes(ax(3))
legend('Position', [0.2671857923497267 0.48484848484848486 0.08176157607132589 0.22064393939393256])
d=copyobj(ax(1), mainFigure )
set(d, 'Position',  [0+ leftMargin, currentbottom-bottomMargin*2-maxlen, maxwd, maxlen])
d=copyobj(ax(2), mainFigure)
set(d, 'Position',  [0+ leftMargin, currentbottom-bottomMargin*3-maxlen*2, maxwd, maxlen])



close(multiMeanFigure);

d=copyobj(mediaAxes, mainFigure)
set(d, 'Position',  [maxwd+ leftMargin*2, currentbottom-bottomMargin, maxwd, maxlen])
currentleft= maxwd+ maxwd+ leftMargin*4;

close(mediaFigure);


func= eval(varargin(1,:));
for j=1:numel(nms)
    
    eval(['cExperiment= multichamber.' nms{j} ';']);
 comparePeakValley(cExperiment, func,window,2,3);
 title(sprintf([nms{j}, ': \n' sprintf([strtrim(strs{1}), '\n']) ', upshift vs downshift']));
 addHLine(0);
 p=get(gca,'Parent');
 d=copyobj(gca, mainFigure);
 close(p);
 set(d, 'Position',  [currentleft, currentbottom-bottomMargin, smallwd, maxlen])
 
 currentleft=currentleft+smallwd+leftMargin;
 
end



densityFigure=figure;
 densityAxes=axes();

for j=1:numel(nms)
 
  eval(['cExperiment= multichamber.' nms{j} ';']);
 [cellval, cellerr, timehr,ind,celltimes,den,ratePeakFigure]=ratePeakTimes(range, cExperiment,2,2, 1);
 
 plot(range*5/60, normalizeTS(den));
 xlabel('Time')
 ylabel('frequency of cells that peak')
 
 hold on;
 title(sprintf(['Frequency of cells \n bursting at specific times']));
 
 
 
 
end

d=copyobj(densityAxes, mainFigure);
set(d, 'Position',  [maxwd+leftMargin*2, currentbottom-maxlen-bottomMargin*2, maxwd, maxlen])

close(densityFigure);

currentleft= maxwd+ maxwd+ leftMargin*4;
currentbottom= currentbottom-maxlen-bottomMargin;
func= eval(varargin(2,:));
for j=1:numel(nms)
    
    eval(['cExperiment= multichamber.' nms{j} ';']);
 comparePeakValley(cExperiment, func,window,2,3);
 title(sprintf([nms{j}, ':  \n' sprintf([strtrim(strs{2}), '\n']) ' , upshift vs downshift']));
 ylim([-1,1])
 addHLine(0);
 
 %p=get(gca,'Parent');
 d=copyobj(gca, mainFigure);
 %close (p);
 set(d, 'Position',  [currentleft, currentbottom-bottomMargin, smallwd, maxlen])
  
 currentleft=currentleft+smallwd+leftMargin;
 close 
end


currentleft= maxwd+ maxwd+ leftMargin*4;
currentbottom= currentbottom-maxlen-bottomMargin*1;


func= eval(varargin(3,:));

for j=1:numel(nms)
    
    eval(['cExperiment= multichamber.' nms{j} ';']);
 comparePeakValley(cExperiment, func,window,2,3);
 title(sprintf([nms{j}, ': \n' sprintf([strtrim(strs{3}), '\n']) ' , upshift vs downshift']));
 ylim([-1,1])
 addHLine(0);
 %p=get(gca,'Parent');
 d=copyobj(gca, mainFigure);
 %close(p);
 set(d, 'Position',  [currentleft, currentbottom-bottomMargin, smallwd, maxlen])
  
 currentleft=currentleft+smallwd+leftMargin;
 
end


 
 