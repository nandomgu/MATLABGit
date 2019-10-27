load('plotargs.mat')
load('argsimMechanistic201903.mat')
load('x1hybrid.mat')
%% 
argsim.theta=[0 ...%1.- mig2 reps mth1 - optional
0 ...%2.- mig1 reps mth1 - optional
1 ...%3.-std1inhibits mig1 - fixed to 1
0 ...%4.-std1 inhibits mig2 -fixed to 1
0 ...%5.- mth1 represses std1 - unsure whether to fix
1....%6.-std1 reps hxt  fixed to 1
1....%7.-mth1 reps mig2  optional
1];%7.-std1 reps mig2  optional

% pars is: row 1= xhybrid. row 2: x1hybrid. row3: xnaturals. row4:pars
row=1;
model='mechModelXS2';
%params for model XS2
pars=[mechmodelbestfits(row, :) mechmodelbestfits(row, 32) mechmodelbestfits(row, 33), .5, 2]
%params model XS3
pars=[mechmodelbestfits(row, :) mechmodelbestfits(row, 32) mechmodelbestfits(row, 33), .5, 2, .2, .1,3,  ]

Ksnf1= params(42);
KSS= params(43);
hillsnf1=params(44);
VinhSMG= params(45);
VinhSM2= params(46);

argsim.defaultparams=pars;
simulator=makesimulatorX(model, argsim);
[l, t, y]=simulator(pars);
plotargs.modelname=model
plotargs.y.mechModelXS2=y;
plotargs.t=t;
plotall(plotargs)

%% horizontal panel



fhandle=get(gcf, 'children')
xmar=0.02;
ymar=0.06;
interrowmar=.04;
intercolmar=.02;
%top left
set(fhandle(1), 'Position', [0+xmar, .5+ymar, .25-intercolmar, .5-interrowmar])    
%bottom left
set(fhandle(6), 'Position', [0+xmar, 0+ ymar, .25-intercolmar, .5-interrowmar])    
%top middle
set(fhandle(5), 'Position', [.25+xmar, .5+ ymar, .25-intercolmar, .5-interrowmar])    
%bottom middle
set(fhandle(4), 'Position', [.25+xmar, 0+ ymar, .25-intercolmar, .5-interrowmar])  
%big center
set(fhandle(2), 'Position', [.50+xmar, 0+ ymar, .25-intercolmar, 1]) 
set(fhandle(2), 'YLim', [0,12]) 
%big right
set(fhandle(3), 'Position', [.75+xmar, 0+ ymar, .25-intercolmar, 1]) 
set(fhandle(3), 'YLim', [0,12]) 
hideAllTicks(gcf, [1 4 5 6 2 3], 0, 1, 'right')

