
function modelh= mechModel6(params, args)

description=['mechModel6- glucose deg mth1'  ...
             'glucose deg std1'...
             'mth1 rep Std1' ...
             'std1 inhibits mig1' ...
             'Mig1, Mth1, (not std1) repress hxt'
             ];
             
             
mediaInput= args.input;
modelh= @transcriptModelh;
times=linspace(0,20,250);
times=times(1:numel(mediaInput));
function dout=transcriptModelh(t, x)

%mediaInput=smooth(mediaInput);
Glucose=interp1(times, mediaInput,t);

HXT= x(1);
MTH1=x(2);
MIG1=x(3);
HXTMTH1=x(4);
HXTMIG1=x(5);
MTH1MIG1=x(6);
STD1=x(7);

VHXT=params(1);
Vloc=params(2);
basaldeg=params(3);
maxdegMT=params(4);
%gluc induced deg threshold of Std1
KdegMT=params(5);
hilldegMT=params(6);
basaldegMT=params(7);
maxdegST=params(8);
%mth1 repression of Std1
KrepMTST=params(9);
hillrepMTST=params(10);
%gluc induced deg threshold of Std1
KdegST=params(11);
hilldegST=params(12);
basaldegST=params(13);
%with KinhSMG, std1 inhibits the action of mig1.
%first we try a proportional one. 
KinhSMG=params(14);
deloc=params(15);
%Repression of HXT by Mig1
KrepHMG=params(16);
hillHMG=params(17);
%repression of HXT by MTH1
KrepHMT=params(18);
hillHMT=params(19);
%Mig1 localisation by glucose
KMG=params(20);
hillMG=params(21);
VdegHXT=params(22);
threshdegHXT=params(23);
hilldegHXT=params(24);

degMT=maxdegMT*(Glucose)^hilldegMT /(KdegMT^hilldegMT+Glucose^hilldegMT);
degST=maxdegST*(Glucose)^hilldegST /(KdegST^hilldegST+Glucose^hilldegST);



%fixing mth1 production to be 1
DMTH1= 1  - (degMT+ basaldegMT)*MTH1 ;

%fixing std1 production to be 1
DSTD1= 1/(1- (MTH1/KrepMTST)^hillrepMTST) - (degST+ basaldegST)*STD1 ;



%the equation of Mth1 when there is no mig1 to repress it
DMTH1MIG1= 1  - (degMT+ basaldegMT)*MTH1 ;



cytMIG1=1-MIG1;
DMIG1= Vloc*cytMIG1*(Glucose/KMG)^hillMG/(1 + (Glucose/KMG)^hillMG) -deloc*MIG1 -KinhSMG*STD1*MIG1;

%start with basal degradation only
deg=VdegHXT/(1+ (Glucose/threshdegHXT)^hilldegHXT)+basaldeg;

DHXT=  VHXT/ (1+ (MIG1/KrepHMG)^hillHMG +(MTH1/KrepHMT)^hillHMT) - deg*HXT;
DHXTMTH1=  VHXT/ (1+ (MIG1/KrepHMG)^hillHMG +(0/KrepHMT)^hillHMT) - deg*HXT;
DHXTMIG1=  VHXT/ (1+ (0/KrepHMG)^hillHMG +(MTH1/KrepHMT)^hillHMT) - deg*HXT;

%(VHXT*Glucose/KHXT)^hillHXT / (1 + (Glucose/KHXT)^hillHXT+ (Glucose/KrepHXT)^hillrepHXT)-basaldeg*HXT;
 %(1+ (Glucose/KrepHXT)^hillrepHXT))
dout= zeros(3,1);
dout(1)=DHXT;
dout(2)=DMTH1;
dout(3)=DMIG1;
dout(4)=DHXTMTH1;
dout(5)=DHXTMIG1;
dout(6)=DMTH1MIG1;
dout(7)=DSTD1 ;
end 
end