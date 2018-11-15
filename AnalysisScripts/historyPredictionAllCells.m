
expt=multichamber20170526
cy5=processcy5(expt);
ctime=nanmean(expt.mig1g.cellInf(1).times/60);
%ctime=(1:size(cy5,2))*5/60;
cy5=normalizeTS(nanmean(cy5));

[t,GFP]=splineAllCells(processNucLocFoldChange(multichamber20170526), 0.98);
cy5=interp1(ctime, cy5, t);
cy5=fillmissing(cy5, 'linear')
%GFP=processNucLocFoldChange(multichamber20170526)
%GFP=processMean(multichamber20170526)
inds=xNaNIndices(multichamber20170526.mig1g, 1)
nl=multichamber20170526.mig1g.cellInf(2).max5(inds,:)./multichamber20170526.mig1g.cellInf(2).median(inds,:)
[time,matr]=splineAllCells(nl, 0.98)
normWindow=15
matr=matr./repmat(nanmean(matr(:,1:normWindow), 2), 1, size(matr,2));


%figure; plot(matr')
generalP={};
generalbeta={};
generalError={};

for m = 1:size(matr, 1)
averageLength=2;
GFP=matr(m,:); %this is the mig1 localisation signal
%figure; plot(GFP)
window=20;
slide=1;
total=1;
c=1;
regcy5=[];
regGFP=[];
levelcy5=[];
regtime=[];

while total+window<numel(GFP)
total+window;
regcy5(c,:)=cy5(total:total+window-2);
levelcy5(c)=cy5(total+window-1);
regGFP(c)=GFP(total+window-1);
regtime(c)=time(total+window-1);
c=c+1;
total=total+slide;
end


%% now we add a column of ones for the intercept parameter
regcy5=[ones( size(regcy5,1), 1), regcy5];
%% performing the regression by matrix inversion
beta=inv(regcy5'*regcy5)*(regcy5'*regGFP');

%%we calculate the sum of squared errors
%regerror=sum(((regcy5*beta)-regGFP').^2);
regerror= (regcy5*beta)-regGFP';
generalP{m}=regcy5*beta;
generalbeta{m}=beta;
generalError{m}=regerror;
disp(m)
pause(0.5)
end



%%weighting the errors by the amount of activity in the GFP channel
%in other words, active bits weigh more than inactive, steady state bits

%regerror= (regerror(1:end-1)).^2.* abs(diff(smooth(regGFP)))

%%no weights by the derivative
regerror= (regerror.^2)

%%sum of squares

regerror=sum(regerror);

figure; plot(regtime, regGFP, '.-')
hold on; plot(regtime,regcy5*beta, 'r-')
xlim([0, time(end)])
%% performing prediction based on levels

levelregcy5= [ones(numel(levelcy5), 1), levelcy5']; %GLM of glucose to Mig1
%%performing the matrix regression
betalevel=inv(levelregcy5'*levelregcy5)*(levelregcy5'*regGFP')
figure; plot(regtime, regGFP, '.-')
hold on; plot(regtime, levelregcy5*betalevel, 'g-')
xlim([0, time(end)])
levelregerror=(levelregcy5*betalevel)-regGFP'
%%weighting the differences by the amount of activity in the GFP channel
%levelregerror= (levelregerror(1:end-1)).^2.* abs(diff(smooth(regGFP)))

%no weight by the derivative

levelregerror= (levelregerror(1:end-1)).^2

%%sum of squares
levelregerror=sum(levelregerror);

levelregerror/regerror

