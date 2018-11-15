function handle=mutantsimulator(ps, argsim)

%% this function simulates all mutants and all concentrations of glucose
handle=@msimulator;
colors= [0 0.8 0.8; 0 0 0.8; 0.6 0 0.8; 1 0 0.8 ; 1 0 1; 1 .3 1]
%these parameters nail the mth1 mig1 behaviour in model 6
hxt2params=[2 0.0846749835348286 -0.22314355131421 3.91202300542815 -1.20397280432594 2.30258509299405 0.405465108108164 1.09861228866811 -0.693147180559945 -0.196063997334818 2.63905732961526 5 -2.30258509299405 -30 1.79175946922805 -2.30258509299405 0 -1.20397280432594 0.542301272315275 -1.20397280432594 2.07944154167984 -1.20397280432594 2.07944154167984 -1.20397280432594]

%these params are a fairly ok starting point for hxt4 in model 8, KinhSMG
%is a bit off
%pars=[6 0.0846749835348286 1.09861228866811 0.693147180559945 -4.60517018598809 0 0 1.09861228866811 -0.22314355131421 0 0 0 -2.30258509299405 -40 1.09861228866811 -5.80914299031403 0 -2.30258509299405 0.542301272315275 1.38629436111989 0 -2.30258509299405 0 -1.20397280432594 -2.30258509299405 1.38629436111989 -1.20397280432594 -0.994252273343867 1.09861228866811 -0.393042588109607 1.38629436111989 -40]
pars=[6.90775527898214 0.0846749835348286 0.182321556793955 1.38629436111989 -4.60517018598809 1.38629436111989 0 1.38629436111989 -0.510825623765991 1.38629436111989 -0.693147180559945 0 -2.99573227355399 3.91202300542815 1.09861228866811 -9.90348755253613 0 -3.91202300542815 0.542301272315275 0.405465108108164 1.09861228866811 -2.30258509299405 0 -1.20397280432594 -4.60517018598809 0 0.405465108108164 -1.6094379124341 1.38629436111989 -3.91202300542815 1.09861228866811 2.99573227355399 -2.81341071676004 0.693147180559945 2.30258509299405 -2.30258509299405 1.38629436111989]

gene=argsim.gene;
model=argsim.model
mf=extractModelFeatures(model);



totallength=230;
%rampsection=[zeros(1, 38) ones(1, 50) linspace(1, 0, glu(j))];
%synramp= [rampsection zeros(1, totallength-numel(rampsection))]; 

%glu(j)cose signal
%argsim.input=glu(j)cose*glu(j);
data=argsim.meandata.(gene).g1percent;
argsim.data=data;
argsim.datastart=nanmean(data(:,1));
pars= defaultparams(model, ps);

argsim.onlyparams= 1:numel(mf.paramNames);
argsim.model=model;



function [l, simfitmeans]= msimulator(pars)
ps=paramstruct(argsim.model, pars);
c=1;

glu=  [.2, .4, 1];   %concentrations %[0 20]%ramp lengths 
for j=1:3
    argsim.input=[zeros(1, 38) ones(1, 137-38+1), zeros(1, 92)]*glu(j); %artificial
   
    if sum(glu(j) == argsim.concentrations)<1
        continue
    end

    %%%%%%%%mutants
    
    %simulating and plotting mutants
savedp=ps; %parameters from free testing that have been previously saved
%WT

ind=1+c-1;
[locpar, ya]=genesim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);

%mig1
ps.KrepHMG=log(1000); % Mig1 loses the ability to bind
pars= defaultparams(model, ps);

ind=4+c-1;
[locpar, ya]=genesim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);

  ps=savedp;  
%mth1
ps.KrepHMT=log(1000); % MTH1 loses the ability to bind HXT
ps.KrepSTM2=log(1000); % MTH1 loses the ability to bind MIG2
ps.KrepMTST=log(1000); % MTH1 loses the ability to bind STD1
%changing initial conditions of MTH1 (number 2)  to 0

ind=7+c-1;
argsim.initialconditions= [argsim.datameans(1, ind)   0         0    9.1621         0    1.0000         0 0]
pars= defaultparams(model, ps);


[locpar, ya]=genesim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);

  ps=savedp;  
 % changing back the initial conditions
argsim.initialconditions= [ argsim.datastart   1         0    9.1621         0    1.0000         0 0]

  
  
 %rgt2
 ps.KdegST=log(1000); % Std1 can no longer be degraded
pars= defaultparams(model, ps);

ind=13+c-1;
[locpar, ya]=genesim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);

ps=savedp; 
 %std1
 
  ps.KinhSMG=-40; % Std1 can no longer be degraded
  ps.KinhSM2=-40;
  ps.KrepST=log(1000);
pars= defaultparams(model, ps);

ind=10+c-1;
[locpar, ya]=genesim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);

ps=savedp;     
%snf3
 
ps.KdegMT=log(.3); % Mth1 gets degraded at a higher threshold
pars= defaultparams(model, ps);
ind=16+c-1;
[locpar, ya]=genesim(gene, argsim, pars);
simfitmeans(:, ind)=topUp(ya, 230, Inf);


c=c+1;

end

l=nansum(nansum((simfitmeans-argsim.datameans).^2));

end
end

