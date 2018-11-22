%% assemble default parameters manually:

paramvals=struct
paramvals.('VHXT'  		)	=2.6528
paramvals.('Vloc'    		)	=8.3923
paramvals.('basaldeg'  	)	 =-1.1092
paramvals.('maxdegMT'   	)	= 0.8044
paramvals.('KdegMT'    	)	=0.0007
paramvals.('hilldegMT'   	)	=		4.1181
paramvals.('basaldegMT'  	)	=	-1.0028
paramvals.('maxdegST'   	)	= 0.8044
paramvals.('KdegST'    	)	=0.0007
paramvals.('hilldegST'   	)	=		4.1181
paramvals.('basaldegST'  	)	=	-1.0028
paramvals.('deloc'    	)	=	1.2254
paramvals.('KrepMT'   	)	=-2.8048
paramvals.('hillrepMT'   	)	=	2.8987
paramvals.('KrepHMG'   	)	=-4.0021
paramvals.('hillHMG'    	)	=0.8293
paramvals.('KrepHMT'   	)	=-0.5924
paramvals.('hillHMT'    	)	=1.3689
paramvals.('KMG'    		)	=0.4901
paramvals.('hillMG'    	)	=2.7869
paramvals.('VdegHXT'   	)	=-0.3587
paramvals.('threshdegHXT'	)	=  -5.0099
paramvals.('hilldegHXT'  	)	= 	1.3232
paramvals.('KinhSMG')	= 	-.5

pars=[]
for j =1:numel(mf.paramNames)
    pars(j)= paramvals.(mf.paramNames{j});
end
    


%% preparing stuff for fitting
load('cy5.mat')
load('201807_mig1steps.mat')
meandata=load('hxtmeandata.mat');
meandata=meandata.meandata;
opts=optimset('fminsearch');
opts.Display='iter';
opts.MaxIter=600;
opts2=optimset('fminsearch');
opts2.Display='iter';
opts2.MaxIter=600;
%fitparams=struct; % wae don't want to erase the structure for now.
startparams=[1,1,1,1,1,1,1]; %make everything 1
models={ 'simpleModel1', 'simpleModel2', 'simpleModel3','simpleModel4', 'simpleModel5','simpleModel6','simpleModel7'};
glucose=cy5(2,1:230)
mig1=nanmean(locdata.mig1g.g1percent.rep1.data)-1;
lsq=true;
genes=fieldnames(meandata);

%% fitting the data of all hxts using all models using fminsearch
figure; 
for j=1:numel(genes)
axes()
    for m=5:numel(models)  %fitting only 5 and 6 
        %try
        data=meandata.(genes{j}).g1percent;

        argsim=struct;
        argsim.input=glucose;
        argsim.data=data
        argsim.lsq=lsq
        %mig1 localisation trace
        mat=locdata.mig1g.g1percent.rep1.data
        imat=mat(:, 1:30)
        imedian= nanmedian(imat(:))
        istd= nanstd(imat(:))
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        % figure; plot(repmat(locdata.times, size(mat, 1), 1)', zmat', 'b:');

        argsim.mig1=zmedian
        simulator=makesimulator(models{m}, argsim);

        if isfield(fitparams, genes{j}) && isfield(fitparams.(genes{j}), models{m}) && isfield(fitparams.(genes{j}).(models{m}), 'fminsearch')
            x1=fminsearch(simulator, fitparams.(genes{j}).(models{m}).fminsearch, opts);
        else
        x1=fminsearch(simulator, log(startparams), opts); %we run fit twice just in case we run out of steps.
        end
        x2=fminsearch(simulator, x1, opts2);
        fitparams.(genes{j}).(models{m}).fminsearch=x2;
        [l,t,y,d]=simulator(x2);  plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end
        end
    plot(t,d);
    yyaxis right;
    plot(t,glucose);
end

save('fitsModels56.mat', 'meandata', 'trialparams', 'fitparams', 'fval')
%% simulating from 30 different initial conditions.

%% reset lasts to start from zero
startm=7
lastm=7;
lastj=1;
lastk=struct;

%%
opts.MaxIter=200;
opts2.MaxIter=800;
figure; 
for j=lastj:numel(genes)
    %lastj=j;
axes()
    for m=lastm:numel(models)
        %lastm=m;
        mf=extractModelFeatures(models{m});
       disp(['trying strain ' genes{j} ' model ' models{m}])
     data=meandata.(genes{j}).g1percent;
         argsim=struct;
        argsim.input=glucose;
        argsim.data=data;
        argsim.lsq=lsq;
        %mig1 localisation trace. steps
        mat=locdata.mig1g.g1percent.rep1.data;
         %mig1 localisation trace. ramp6h
        %mat=locdataramps.mig1g.ramp6h.rep1
        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); %making negatives zero
        %ramp6h=locdataramps.cy5(7,:);
        %argsim.input=ramp6h
        
        % figure; plot(repmat(locdata.times, size(mat, 1), 1)', zmat', 'b:');

        argsim.mig1=zmedian;
        simulator=makesimulator(models{m}, argsim);
      
        try
            nextk=lastk.(genes{j}).(models{m})+1;
        catch
         nextk=1;
         arr=[];
        x1=[];
        startparams=rand(30, numel(mf.paramNames) ); %we make random parameters
        startparams(:, 1)= startparams(:, 1)*20;
        end
        for k=nextk:size(startparams, 1)  
            lastk.(genes{j}).(models{m})=k;
        [x1(k, :), arr(k)]=fminsearch(simulator, log(startparams(k, :)), opts); %we run fit twice just in case we run out of steps.
        end
        fval.(genes{j}).(models{m})=arr;
        trialparams.(genes{j}).(models{m})=x1;
        [a,b]=min(arr); %looking for the smallest cost in all the simulations. 
        x2=fminsearch(simulator, x1(b,:), opts2);
        fitparams.(genes{j}).(models{m}).fminsearch=x2;
        [l,t,y,d]=simulator(x2); plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end
        end
    plot(t,d);
    yyaxis right;
    plot(t,glucose);
    
    end
save('fitsModels56.mat', 'meandata', 'trialparams', 'fitparams', 'fval')

%% just plotting
%models={ 'simpleModel1', 'simpleModel2', 'simpleModel3','simpleModel4', 'simpleModel5','simpleModel6','simpleModel7'};
models={ 'simpleModel1','simpleModel6','simpleModel7'};

linspecs= {'k^-', 'ks-', 'ko-', 'k-+', 'k-*', 'k-x','k-d','ro'}
figure; 
y=struct;
d=struct;
BIC=struct;
for j=1:numel(genes)
axes()
    for m=1:numel(models)  

        mf=extractModelFeatures(models{m});
        %argsim=struct;
        
          data=meandata.(genes{j}).g1percent;
          mat=locdata.mig1g.g1percent.rep1.data;
          argsim.input=glucose;
        %ramptype='ramp0h'
         
        %data=meandataramp.(genes{j}).(ramptype);
        data(data==0)=NaN;
        %ramp=locdataramps.cy5(2,:);
        %argsim.input=ramp;
         %mat=locdataramps.mig1g.(ramptype).rep2;
         %mig1 localisation trace. ramp6h

        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); %making negatives zero
        orig=zmedian;
        zmedian=smooth(zmedian)';
        tims=linspace(0,20, 250);
        tims=tims(1:numel(zmedian));
        smoothParam=0.999
        splFit= fit(tims', zmedian','smoothingspline', 'smoothingParam', smoothParam); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
        zmedian= splFit(tims);%figure; plot(tims, zmedian); hold on; plot(tims, orig);
        
        data(:, 1)= data(:, 1).*(data(:, 1)>0);
        argsim.data=data;
        argsim.lsq=lsq;

         %making negatives zero
         zmedian=zmedian.*(zmedian>0);
         
        % figure; plot(repmat(locdata.times, size(mat, 1), 1)', zmat', 'b:');

        argsim.mig1=zmedian;
        simulator=makesimulator(models{m}, argsim);
        x2=fitparamsOpt2.(genes{j}).(models{m}).fminsearch;
        [l,t,y.(genes{j}).(models{m}),d.(genes{j})]=simulator(x2);  
        plot(t,y.(genes{j}).(models{m}),linspecs{m}, 'LineWidth', 1.2, 'MarkerSize', 8, 'DisplayName', [genes{j} ' ' models{m}],'MarkerIndices', randi(30,1):10:250); hold on; 
        
        %residuals squared
        RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
        
        %dividing by twice the variance at each timepoint. this is the
        %expansion of all terms for the exponential in the likelihood
        %(1/2?var) * e^ ((di-yi)2/2var)
        %getting the variance of the means is causing nasty issues so we se
        %the variance of the cells.
        dvar=[];
        repnms=fieldnames(celldata.(genes{j}).g1percent);
%         for q=1:numel(repnms)
%         dvar= [dvar;celldata.(genes{j}).g1percent.(repnms{q})];
%         end
        dvar= nanvar(data);
        dvar=dvar(1:numel(t));
        Lterms=RS./ dvar';
        %%then the likelihood is a product of all these probabilities. we
        %%take the log to make it easier to compute and we get that the log
        %%likelihood is the sum of all these terms.
        % -2ln(L)= chi square + nln(2?var) where chi square is defined as the (squared sum of errors) /var
        % ultimately the nln(2?var) does not add anything when comparing
        % models as variance is the same for all of them. so the chi square
        % calculation is all that matters.
        chisq= sum(Lterms);
        %Now for the BIC we  add the chi square with numparams *log(number of datapoints)
        BIC.(genes{j}).(models{m})= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
        
        
%         dnorm.(genes{j})= (d.(genes{j})- nanmean(d.(genes{j})))/ nanstd(d.(genes{j})); %normalising the trace time series to put all the errors on the same scale
%         modelz.(genes{j}).(models{m})=(y.(genesj}).(models{m})- nanmean(d.(genes{j})))/ nanstd(d.(genes{j}));%z scores of each point of the model based on the mean and std of the timecourse.
%         fvalnormalized.(genes{j}).(models{m})= sum((dnorm.(genes{j})-modelz.(genes{j}).(models{m})).^2);
%         errsnormalized.(genes{j}).(models{m})= (dnorm.(genes{j})-modelz.(genes{j}).(models{m})).^2;
%                               %BIC= klog(n)+ nlog(RSS/n)
%         BIC.(genes{j}).(models{m})=   log(numel(d.(genes{j})))*numel(mf.paramNames) +numel(d.(genes{j}))* log(fvalnormalized.(genes{j}).(models{m})/numel(d.(genes{j})))
        
    end
        h=randi(30,1);
    plot(t,d.(genes{j}), linspecs{8}, 'DisplayName', 'Data mean of means', 'LineWidth', .5,'MarkerIndices', 1:250);
    yyaxis right;
    plot(t,argsim.input, 'DisplayName', 'Glucose');
    title(genes{j})
    
   
end
 stackPlots(gcf)
 
 
 %plotting 
%% plotting all ramp fits for a certain model/gene
yramps=struct;
rtypes=[0,2,4,6];
ramptypenames={'ramp0h', 'ramp0h','ramp2h','ramp2h', 'ramp4h','ramp4h', 'ramp6h'}
rlengths=locdataramps.ramplength
cy5indices=[2,2,4,4,5,6,7];%there are some cy5 signals that are not there
mig1indices=[2,2,3,4,5,6,7]; %some experiments have a shit mig1 signal
mig1scalings=[2,2,1,1,1,1,1]; %for the same reason one experiment's signal has to be amplified to have comparable levels to the other experiments
reps={'rep1','rep2','rep1','rep1', 'rep1','rep2','rep1' };
m=4; %number of model

gene=2;
figure;

for j=1:numel(rlengths)

    rtypelabel=rtypenames{j};


 mf=extractModelFeatures(models{m});
        argsim=struct;
        
%          data=meandata.(genes{j}).g1percent;
%          mat=locdata.mig1g.g1percent.rep1.data;
%          argsim.input=glucose;

         
        data=meandataramp.(genes{gene}).(ramptypenames{j});
        data(data==0)=NaN;
        ramp=locdataramps.cy5(cy5indices(j),:);
        argsim.input=ramp;
         mat=locdataramps.mig1g.(ramptypenames{mig1indices(j)}).(reps{mig1indices(j)});
         %mig1 localisation trace. ramp6h

        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); %making negatives zero
        orig=zmedian;
        zmedian=smooth(zmedian)';
        tims=linspace(0,20, 250);
        tims=tims(1:numel(zmedian));
        smoothParam=0.999;
        splFit= fit(tims', zmedian','smoothingspline', 'smoothingParam', smoothParam); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
        zmedian= splFit(tims);%figure; plot(tims, zmedian); hold on; plot(tims, orig);
        
        data(:, 1)= data(:, 1).*(data(:, 1)>0);
        argsim.data=data;
        argsim.lsq=lsq;

         %making negatives zero
         zmedian=zmedian.*(zmedian>0)*mig1scalings(j);
         
        % figure; plot(repmat(locdata.times, size(mat, 1), 1)', zmat', 'b:');

        argsim.mig1=zmedian;
        simulator=makesimulator(models{m}, argsim);
        x2=fitparamsRamp.(genes{gene}).(models{m}).fminsearch;
        [l,t,yramps.(genes{gene}).(models{m}).(ramptypenames{j}),dramps.(ramptypenames{j}).(genes{gene})]=simulator(x2);  
        
        plot(t,yramps.(genes{gene}).(models{m}).(ramptypenames{j}),linspecs{m}, 'LineWidth', 1.2, 'MarkerSize', 8, 'DisplayName', [genes{gene} ' ' models{m}],'MarkerIndices', 1:10:250); hold on; 

end
 %%
 allparams1=[];
 allparams2=[];
 allparams3=[];
 for j=1:numel(genes)
     try
     allparams1(j, :)= fitparams.(genes{j}).simpleModel1.fminsearch(1:4)
     end
     try
     allparams2(j, :)= fitparams.(genes{j}).simpleModel2.fminsearch
     end
     try
     allparams3(j, :)= fitparams.(genes{j}).simpleModel3.fminsearch
     end
 end

%%

%% fitting the data of all hxts using all models using fmincon


opts=optimset('fmincon');
opts.Display='iter';
opts.MaxIter=600;
opts2=optimset('fmincon');
opts2.Display='iter';
opts2.MaxIter=100;
figure; 
for j=1:numel(genes)
axes()
    for m=1:numel(models)  
        
        data=meandata.(genes{j}).g1percent;
        simulator=makesimulator(models{m}, glucose, data, lsq);
        if isfield('fmincon', fitparams.(genes{j}).(models{m}))
            x=fitparams.(genes{j}).(models{m}).fmincon;
            x1=fmincon(simulator, x, [],[],[],[],zeros(1,numel(x)),[],[], opts);
        else
        x1=fmincon(simulator, startparams,[],[],[],[],zeros(1,numel(startparams)),[],[], opts); %we run fit twice just in case we run out of steps.
        end
        x2=fmincon(simulator, x1,[],[],[],[],zeros(1,numel(startparams)),[],[], opts2);
        fitparams.(genes{j}).(models{m}).fmincon=x2;
        [l,t,y,d]=simulator(x2);  plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
       
        end
    plot(t,d);
    yyaxis right;
    plot(t,glucose);
end



%% bar plot

fun= @(gene) [min(fval.(gene).simpleModel1) min(fval.(gene).simpleModel2) min(fval.(gene).simpleModel3) min(fval.(gene).simpleModel4)]
figure; bar([fun('hxt1'); fun('hxt2'); fun('hxt3'); fun('hxt4'); fun('hxt5'); fun('hxt6'); fun('hxt7')]')


%plotting bars of normalised data errors
fun2= @(gene) [min(fvalnormalized.(gene).simpleModel1) min(fvalnormalized.(gene).simpleModel2) min(fvalnormalized.(gene).simpleModel3) min(fvalnormalized.(gene).simpleModel4)]
figure; bar([fun2('hxt1'); fun2('hxt2'); fun2('hxt3'); fun2('hxt4'); fun2('hxt5'); fun2('hxt6'); fun2('hxt7')])
s= {'1: Gluc.induced activation',    '1+ gluc. induced degradation' ,   '1+ gluc. repressed degradation' ,   '1+ gluc. induced repression'};
l=get(gca, 'Legend');
set(l, 'String', s)
ylabel('Normalised fit error (LS)')
xlabel('Hexose transporter')

%plotting by hxts
figure; bar([fun2('hxt1'); fun2('hxt2'); fun2('hxt3'); fun2('hxt4'); fun2('hxt5'); fun2('hxt6'); fun2('hxt7')]')
s= {'Gluc.induced activation',    '1+ gluc. induced degradation' ,   '1+ gluc. repressed degradation' ,   '1+ gluc. induced repression'};
l=get(gca, 'Legend');
set(l, 'String', s)

%% BIC bar plot
%[l,t,y]=simulator(x); figure; plot(t,y); hold on; plot(t,d);
s= {' Gluc activation',    '1+ gluc. induced degradation' ,   '1+ gluc. repressed degradation' ,   'gluc activation  + hill gluc repression ',  'hill gluc activation + Mig1 induced repression', ' activation+  repression', 'activation+ repression+ gluc repressed degradation'};
sumbic=@(model) [ BIC.hxt1.(model), BIC.hxt2.(model), BIC.hxt3.(model), BIC.hxt4.(model), BIC.hxt5.(model), BIC.hxt6.(model), BIC.hxt7.(model)]
figure;
subplot(1,3,1)
bar([sumbic('simpleModel1'); sumbic('simpleModel6'); sumbic('simpleModel3');sumbic('simpleModel4');sumbic('simpleModel5');sumbic('simpleModel6');]')%sumbic('simpleModel7')])
title('BIC per model per Hxt')
l=get(gca, 'Legend');
set(l, 'visible', 'on')
hxts={'Hxt1', 'Hxt2', 'hxt3', 'Hxt4', 'hxt5', 'Hxt6', 'Hxt7'}
set(l, 'String',s )
subplot(1,3,2)
bar(([sumbic('simpleModel1'); sumbic('simpleModel2');sumbic('simpleModel3');sumbic('simpleModel4');sumbic('simpleModel5');sumbic('simpleModel6');sumbic('simpleModel7')])', 'stacked')
title('BIC per model per Hxt')
l=get(gca, 'Legend');
set(l, 'visible', 'on')
set(l, 'String', s)

subplot(1,3,3)
b=bar((1./[sumbic('simpleModel1'); sumbic('simpleModel2');sumbic('simpleModel3');sumbic('simpleModel4');sumbic('simpleModel5');sumbic('simpleModel6');sumbic('simpleModel7')])', 'stacked')
title('Goodness of fit (1/BIC)')
l=get(gca, 'Legend');
set(l, 'visible', 'on')
set(l, 'String', s)
set(gca, 'XTickLabels', hxts)


%% improve the best fits

opts.MaxIter=1000;
figure; 
for j=1:numel(genes)
    lastj=j;
axes()
    for m=1:numel(models)
        lastm=m;
       disp(['trying strain ' genes{j} ' model ' models{m}])
     data=meandata.(genes{j}).g1percent;
         argsim=struct;
        argsim.input=glucose;
        argsim.data=data;
        argsim.lsq=lsq;
        %mig1 localisation trace. steps
        mat=locdata.mig1g.g1percent.rep1.data;
         %mig1 localisation trace. ramp6h
        %mat=locdataramps.mig1g.ramp6h.rep1
               %ramp6h=locdataramps.cy5(7,:);
        %argsim.input=ramp6h
        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); %making negatives zero
 
        
        % figure; plot(repmat(locdata.times, size(mat, 1), 1)', zmat', 'b:');

        argsim.mig1=zmedian;
        simulator=makesimulator(models{m}, argsim);
 %looking for the smallest cost in all the simulations. 
        %normal line
        x1= fitparams.(genes{j}).(models{m}).fminsearch
        %explicitily optimising for hxt2 instead using the params of model
        %4 which are great.
        %x1= fitparams.hxt2.(models{4}).fminsearch
        x2=fminsearch(simulator, x1, opts2);
        fitparamsOpt2.(genes{j}).(models{m}).fminsearch=x2;
        
        [l,t,y,d]=simulator(x2); %                       plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end                                                                                             
    end                                                                        
         [l,t, y,d]=simulator(x2); plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end
end                                                                     
    plot(t,d);
    yyaxis right;
    plot(t,glucose);
    

save('fitsModelsOpt2.mat', 'meandata', 'trialparams', 'fitparams', 'fitparamsOpt', 'fitparamsOpt2', 'fitparamsRamp', 'fval', 'celldata', 'celldataramp', 'meandataramp')



%% improve the models by fitting the ramp response from the known parameters
fitParamsRamp=struct;
lastm=1;
lastj=1;
genes={'hxt2', 'hxt4', 'hxt7'};
opts.MaxIter=1000;

figure; 
for j=1:numel(genes)
    lastj=j;
axes()
    for m=1:numel(models)
        lastm=m;
       disp(['trying strain ' genes{j} ' model ' models{m}])
     data=meandataramp.(genes{j}).ramp6h;
     data(data==0)=NaN;
         argsim=struct;
        argsim.input=glucose;
        argsim.data=data;
        argsim.lsq=lsq;
        %mig1 localisation trace. steps
        %mat=locdata.mig1g.g1percent.rep1.data;
         %mig1 localisation trace. ramp6h
        mat=locdataramps.mig1g.ramp6h.rep1;
               ramp6h=locdataramps.cy5(7,:);
        argsim.input=ramp6h
        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); %making negatives zero
        tims=linspace(0,20, 250);
        tims=tims(1:numel(zmedian));
        smoothParam=0.999
        splFit= fit(tims', zmedian','smoothingspline', 'smoothingParam', smoothParam); %the larger the smoothing parameter, the larger the resemblance to the original data. 1 means almost preserving the original data.
        zmedian= splFit(tims);%figure; plot(tims, zmedian); hold on; plot(tims, orig);

        
        % figure; plot(repmat(locdata.times, size(mat, 1), 1)', zmat', 'b:');

        argsim.mig1=zmedian;
        simulator=makesimulator(models{m}, argsim);
 %looking for the smallest cost in all the simulations. 
        %normal line
        x1= fitparamsOpt.(genes{j}).(models{m}).fminsearch
        %explicitily optimising for hxt2 instead using the params of model
        %4 which are great.
        %x1= fitparams.hxt2.(models{4}).fminsearch
        x2=fminsearch(simulator, x1, opts2);
        fitparamsRamp.(genes{j}).(models{m}).fminsearch=x2;
        
        [l,t,y,d]=simulator(x2);                        plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end                                                                                             
    end                                                                        
         [l,t, y,d]=simulator(x2); plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end
                                                                     
    plot(t,d);
    yyaxis right;
    plot(t,argsim.input);
    
end
save('fitsModelsOpt.mat', 'meandata','meandataramp', 'trialparams', 'fitparams',  'fitparamsRamp', 'fitparamsOpt','fval', 'celldata', 'celldataramp')
save('fitsRampWorkspace.mat', 'fitparamsRamp', 'celldataramp', 'meandataramp')




%% load argsim general features
models={ 'mechModel3'};
        m=1;
        load('matlab.mat', 'meandatamutants')
        load('matlab.mat', 'celldatamutants')
        mf=extractModelFeatures(models{m});
        argsim=struct;
        argsim.input=glucose;
        argsim.lsq=lsq;
        argsim.outvar=1;
        %providing the mutant traces and fitting them too
        argsim.mig1ko=nanmean(meandatamutants.mig1ko.g1percent);
        argsim.mth1ko=nanmean(celldatamutants.mth1ko.g1percent.rep2);
        argsim.wt1=nanmean(meandatamutants.hxt4.g1percent);
        argsim.wt2=nanmean(meandatamutants.hxt4.gp2percent);
        argsim.wt4=nanmean(meandatamutants.hxt4.gp4percent);
        %mig1 localisation trace. steps
        mat=locdata.mig1g.g1percent.rep1.data;
         %mig1 localisation trace. ramp6h
        %mat=locdataramps.mig1g.ramp6h.rep1
        imat=mat(:, 1:30);
        imedian= nanmedian(imat(:));
        istd= nanstd(imat(:));
        zmat=(mat-imedian)/istd;
         zmedian=nanmedian(zmat);
        zmedian=zmedian.*(zmedian>0); %making negatives zero
       
        argsim.mig1=zmedian;
        argsim.defaultparams= defaultparams(models{m});
        argsim.onlyparams=[1:22];
        datastart=nanmean(data(:,1));
        
        
        %ramp6h=locdataramps.cy5(7,:);
        %argsim.input=ramp6h
        
        % figure; plot(repmat(locdata.times, size(mat, 1), 1)', zmat', 'b:');
        
        argsim.mig1=zmedian;
%% reset lasts to start from zero
startm=1
lastm=1;
lastj=1;
lastk=struct;
%% fitting mechanistic models

models={ 'mechModel6', 'mechModel7'};
improve=0;% make 1 if you want to just improve the paraeters already found in fitparams
maxitersample=5;
opts.MaxIter=maxitersample;
maxiterfit=3000;
opts2.MaxIter=maxiterfit;
stepsize=30; %baby steps of how many iterations for the fitting to do temporary storage
numsteps=maxiterfit/stepsize;
numstarts=500 %we simulate this number of times and then 
numtop=10;
%fit the top 10 sets.
figure; 
for j=1:numel(genes)
    lastj=j;
axes()
    for m=lastm:numel(models)
        lastm=m;
        mf=extractModelFeatures(models{m});
       disp(['trying strain ' genes{j} ' model ' models{m}])
      data=meandata.(genes{j}).g1percent;
%         
         argsim.meandata=data;
         datastart=nanmean(data(:,1));
         argsim.initialconditions= [datastart, 1,    0,   argsim.mth1ko(1), argsim.mig1ko(1), 1, 1];
         argsim.initialconditions(argsim.initialconditions<0)=0;
         argsim.initialconditions=argsim.initialconditions(1:numel(mf.varnames));
%         argsim.defaultparams= defaultparams(models{m});
%         argsim.onlyparams=[1:numel(mf.paramNames)];
%         argsim.lsq=lsq;
%         simulator=makesimulator4(models{m}, argsim);
%       
%         try
%             nextk=lastk.(genes{j}).(models{m})+1;
%         catch
%          nextk=1;
%          arr=[];
%         x1=[];
%         %startparams= log(repmat([20, 100, .1, 5, .9, 6, .3, 4, .02, 4, .02, 4, .5, 4, .05, 9,2, .1, 4], 10, 1)); %.*randn(16*4, 16).*randi(5,16*4,16).*repmat(eye(16), 4, 1) ;
%         startparams= repmat(argsim.defaultparams, numstarts, 1) +randn(numstarts, numel(mf.paramNames));
%         figure;
%         l=[]
%         disp('preliminary simulations');
%         for n=1:size(startparams,1)
%             disp(num2str(n))
%             try
%         [l(n),t,y,d]=simulator(startparams(n,:)); %plot(t,y, 'DisplayName',num2str(n)); hold on;
%             catch
%                 l(n)=Inf;
%             end
%         end
%         [a,b]= sort(l);
%         startparams=startparams(b(1:numtop), :) %best params
%         
%         %startparams(:, 15)= rand(10, 1).*randi(4, 10,1);
%         %startparams(:, 1)= startparams(:, 1)*randi(20);
%         end
%         for k=nextk:size(startparams, 1)  
%             lastk.(genes{j}).(models{m})=k;
%             try
%                 disp('trying fminsearch with new random param set')
%         [x1(k, :), arr(k)]=fminsearch(simulator, startparams(k, :), opts); %we run fit twice just in case we run out of steps.
%             catch
%                 arr(k)=Inf;
%             end
%             end
%         fval.(genes{j}).(models{m})=arr;
%         trialparams.(genes{j}).(models{m})=x1;
%         [a,b]=min(arr); %looking for the smallest cost in all the simulations. 
%         if improve==1
%             disp(['improving fit for ' genes{j}])
%             x2=fminsearch(simulator, refitparams2.(genes{j}).(models{m}).fminsearch, opts2);
%         else
%             x2=x1(b,:);
%             opts2.MaxIter=stepsize;
%             for o =1:numsteps
%                 tic;
%             x2=fminsearch(simulator, x2, opts2);
%             elapsed=toc;
%             refitparams2.(genes{j}).(models{m}).fminsearch=x2;
%             if elapsed> 300 %if the duration of this bit is more than 5 mins then we reduce the number of steps by half
%                 numsteps= round(numsteps/2);
%             end
%             end
%         end
                argsim.model=models{m}
                x2=exploreparamFMS(genes{j}, argsim)
                for o=1:5 %improve parameters 5 times
                   x2=exploreparamFMS(genes{j}, argsim, x2) 
                end
                
                
                fitparams.(genes{j}).(models{m}).fminsearch=x2;
        [l,t,y,d]=simulator(fitparams.(genes{j}).(models{m}).fminsearch); plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end
        end
    plot(t,d(1:numel(t)));
    yyaxis right;
    plot(t,glucose(1:numel(t)));
    
    end
save('fitsModelsMechanistic.mat', 'meandata', 'trialparams', 'fitparams', 'fval')


%% %%
save('fitsModelsMechanistic_sharedsignals_freehills.mat', 'meandata', 'trialparams', 'refitparams2')



%% simulate/plot all hxts (or mig or mth1) for one model at once.
%% run previous block to fill out argsim
figure;
for k=1:numel(genes)
g=genes{k};
mod='mechModel3'
data=meandata.(g).g1percent;
argsim.data=meandata.(g).g1percent;
argsim.outvar=1;
argsim.input=glucose
argsim.onlyparams=[8 9 10 11 12 14 15 16 17 20 21 22,23,24]% mechmodel1  [1,3,11,12,13,14];
datastart=nanmean(data(:,1)) %
                           % hxt  mth1 mig1  hxtmth1?   hxtmig1?  mth1mig1?
                           % std1
argsim.initialconditions= [datastart, 1,    0,   datastart, datastart, 1, 1]
argsim.initialconditions=argsim.initialconditions(1:numel(mf.varnames))


%for j=1: size(trialparams.hxt2.mechModel1,1)
argsim.input=glucose;
    simulator=makesimulator4(mod, argsim);
    xd=refitparams2.(g).(mod).fminsearch
    [l,t,y1,d]=simulator(xd); plot(t,y1, 'Color', straincolors(k, :), 'DisplayName', [g ' ' mod ' params ' num2str(j)]); hold on; 

  %x2=fminsearch(simulator, xd(j,:), opts2);  
end

%% simulate/plot hxts/mth1, mig1 for varying concentrations of glucose
figure;
for k=1:numel(genes)
    axes();
g=genes{k};
mod='mechModel2'
data=meandata.(g).g1percent;
argsim.data=meandata.(g).g1percent;
argsim.outvar=3;
%parameters with conventional mig1-mth1 signals
argsim.defaultparams= fitparamsh4mgh1mt.hxt1.mechModel1.fminsearch
%parameter indices that we are interested in fitting.
%that is, parameters to do with hxt regulation.
argsim.onlyparams=[1,3,6,10, 11,12,13,14,16];
c=1;
mat=[]
for j=linspace(0, 1, 10)
argsim.input=glucose*j;
    simulator=makesimulator2(mod, argsim);
    xd=fitparams.(g).(mod).fminsearch;
    sc=straincolors(k, :);
    sc=sc*(j>.5);
    try
    [l,t,y1,d]=simulator(xd); plot(t,y1, 'LineWidth', 1.5, 'Color', sc, 'DisplayName', [g ' ' mod ' params ' num2str(j)]); hold on; 
    mat(c,:)=y1;
    allinductions.(g).(mod)=mat;
    catch
        c=c+1;
        continue
    end
       c=c+1;
  %x2=fminsearch(simulator, xd(j,:), opts2);  
end
 plot(t,d);
    yyaxis right;
    plot(t,argsim.input); 
    yyaxis left
end
stackPlots(gcf)


%% readjust parameters to a uniform mth1 and mig1 signal
%% reincorporated the hill parameters, which were left too rigid...
%% at least from here we can see whether flexibility on certain hills is needed or some terms become nullified. 
figure;
opts2.MaxIter=1000
options = optimoptions(@particleswarm,'Display', 'iter')
%refitparams2=struct;
for k=6:numel(genes)
    axes();
g=genes{k};
mod='mechModel3'
mf=extractModelFeatures(mod)
data=meandata.(g).g1percent;
argsim.data=meandata.(g).g1percent;
argsim.outvar=1;
%parameters with conventional mig1-mth1 signals
argsim.defaultparams= defaultparams(mod);
[fitparamsh4mgh1mt.(g).mechModel1.fminsearch fitparams.(g).mechModel2.fminsearch(17:19)]
%parameter indices that we are interested in fitting.
%that is, parameters to do with hxt regulation.
internalhills=[6,10,16]
argsim.onlyparams=[8 9 10 11 12 14 15 16 17 20 21 22]% mechmodel1  [1,3,11,12,13,14];
datastart=nanmean(data(:,1)) %
                           % hxt  mth1 mig1  hxtmth1?   hxtmig1?  mth1mig1?
                           % std1
argsim.initialconditions= [datastart, 1,    0,   datastart, datastart, 1, 1]
argsim.initialconditions=argsim.initialconditions(1:numel(mf.varnames))
%for j=linspace(0, 1, 10)
argsim.input=glucose;
    simulator=makesimulator4(mod, argsim);
    xd=argsim.defaultparams
    x2=fminsearch(simulator, xd, opts2);
    pause(0.5);
    %x2=particleswarm(simulator, 22);
    sc=straincolors(k, :);
    %sc=sc*j;%*(j>.5);
    %mixing default and only fit params in case the defaults were 
    %jittered by the simulator
    refitparams2.(g).(mod).fminsearch=argsim.defaultparams ;  
    refitparams2.(g).(mod).fminsearch(argsim.onlyparams)=x2(argsim.onlyparams)
    [l,t,y1,d]=simulator(refitparams2.(g).(mod).fminsearch); plot(t,y1, 'LineWidth', 1.5, 'Color', sc, 'DisplayName', [g ' ' mod ' params ' num2str(j)]); hold on; 
  %x2=fminsearch(simulator, xd(j,:), opts2);  
end
%end
stackPlots(gcf)



%%
%retrieveparam= @(k) [
%%
plot(t,d);
    yyaxis right;
    plot(t,glucose);

%% just plotting mechanistic models
models={ 'mechModel1', 'mechModel3'};
linspecs= {'k^-', 'ks-', 'ko-', 'k-+', 'k-*', 'k-x','k-d','r.'}
figure; 
y=struct;
d=struct;
BIC=struct;
for j=1:numel(genes)
axes()
    for m=1:numel(models)  

        mf=extractModelFeatures(models{m});
        
        argsim.data=meandata.(genes{j}).g1percent;
       
        datastart=nanmean(argsim.data(:,1));
        argsim.initialconditions= [datastart, 1,    0,   argsim.mth1ko(1), argsim.mig1ko(1), 1, 1];
        argsim.initialconditions(argsim.initialconditions<0)=0;
        argsim.initialconditions=argsim.initialconditions(1:numel(mf.varnames));
        argsim.onlyparams= 1:numel(mf.paramNames)
        argsim.outvar=1;
        %ramptype='ramp0h'
        
        simulator=makesimulator4(models{m}, argsim);
        %for mechanistic model 1, use refitparams2.
        %for mechanistic model2, use fitparams
        x2=fitparams.(genes{j}).(models{m}).fminsearch;
        [l,t,yy,d.(genes{j})]=simulator(x2);  
        y.(genes{j}).(models{m})=real(yy);
        plot(t,y.(genes{j}).(models{m}),linspecs{m}, 'LineWidth', 1.2, 'MarkerSize', 8, 'DisplayName', [genes{j} ' ' models{m}],'MarkerIndices', randi(30,1):10:250); hold on; 
        
        %residuals squared
        disp(['residuals squared']);
        
        try
        RS= (d.(genes{j})- y.(genes{j}).(models{m})).^2;
        
        
        pause(1)
        %dividing by twice the variance at each timepoint. this is the
        %expansion of all terms for the exponential in the likelihood
        %(1/2?var) * e^ ((di-yi)2/2var)
        %getting the variance of the means is causing nasty issues so we se
        %the variance of the cells.
        dvar=[];
        %repnms=fieldnames(celldata.(genes{j}).g1percent);
%         for q=1:numel(repnms)
%         dvar= [dvar;celldata.(genes{j}).g1percent.(repnms{q})];
%         end
        dvar= nanvar(data);
        
        Lterms=RS./ dvar';
        %%then the likelihood is a product of all these probabilities. we
        %%take the log to make it easier to compute and we get that the log
        %%likelihood is the sum of all these terms.
        % -2ln(L)= chi square + nln(2?var) where chi square is defined as the (squared sum of errors) /var
        % ultimately the nln(2?var) does not add anything when comparing
        % models as variance is the same for all of them. so the chi square
        % calculation is all that matters.
        chisq= sum(Lterms);
        %Now for the BIC we  add the chi square with numparams *log(number of datapoints)
        BIC.(genes{j}).(models{m})= chisq + numel(mf.paramNames)* log(numel(d.(genes{j})));
        
        catch
        BIC.(genes{j}).(models{m})=NaN;
            
        end
%         dnorm.(genes{j})= (d.(genes{j})- nanmean(d.(genes{j})))/ nanstd(d.(genes{j})); %normalising the trace time series to put all the errors on the same scale
%         modelz.(genes{j}).(models{m})=(y.(genesj}).(models{m})- nanmean(d.(genes{j})))/ nanstd(d.(genes{j}));%z scores of each point of the model based on the mean and std of the timecourse.
%         fvalnormalized.(genes{j}).(models{m})= sum((dnorm.(genes{j})-modelz.(genes{j}).(models{m})).^2);
%         errsnormalized.(genes{j}).(models{m})= (dnorm.(genes{j})-modelz.(genes{j}).(models{m})).^2;
%                               %BIC= klog(n)+ nlog(RSS/n)
%         BIC.(genes{j}).(models{m})=   log(numel(d.(genes{j})))*numel(mf.paramNames) +numel(d.(genes{j}))* log(fvalnormalized.(genes{j}).(models{m})/numel(d.(genes{j})))
        
    end
        h=randi(30,1);
        ln=topUp(t, numel(d.(genes{j})),  NaN);
    plot(ln,d.(genes{j}), linspecs{8}, 'DisplayName', 'Data mean of means', 'LineWidth', 4);
    yyaxis right;
    plot(ln,argsim.input, 'DisplayName', 'Glucose');
    title(genes{j})
    
   
end
 stackPlots(gcf)
 

 %% plotting a specific model per each hxt. 
 %for the mechanistic model we plot only 1,
 %assuming it is mechModel1.

models={'mechModel1'};
selectedmodels=1;
 b=ones(1, 7);
 figure; 

for j= 1:7 %number of hxts
    
  l=1:numel(y.(genes{j}).(models{selectedmodels(b(j))}))
  plot(tims(l)', y.(genes{j}).(models{selectedmodels(b(j))}), lls{b(j)}, 'DisplayName', [genes{j} ' ' models{selectedmodels(b(j))}], 'Color', straincolors(j, :),  'MarkerIndices', 1:10:250);hold on;
  a=get(gca, 'children')
%
  plot(tims(l)', d.(genes{j}), 'o', 'LineWidth', 1.5,'MarkerSize', 3, 'DisplayName', [genes{j} 'data'], 'Color', straincolors(j, :) );hold on;
  
  
end

%% fitting first hxt1 and hxt3 to get the mth1 trace. then fit hxt67 to fit the mig1 trace.
%% then use said mth1 and mig1 trace to fit 2 4 5

models={ 'mechModel6', 'mechModel7', 'mechModel8'};
improve=0;% make 1 if you want to just improve the paraeters already found in fitparams
maxitersample=5;
opts.MaxIter=maxitersample;
maxiterfit=3000;
opts2.MaxIter=maxiterfit;
stepsize=30; %baby steps of how many iterations for the fitting to do temporary storage
numsteps=maxiterfit/stepsize;
numstarts=100 %we simulate this number of times and then 
numtop=10;
%fit the top 10 sets.
figure; 
axes()
    for m=lastm:numel(models)
        lastm=m;
        mf=extractModelFeatures(models{m});
       disp(['trying strain ' genes{j} ' model ' models{m}])
     data=meandata.(genes{j}).g1percent;
        
        argsim.data=data;
        datastart=nanmean(data(:,1));

        argsim.defaultparams= defaultparams(models{m});
        
        mig1params=cellfun(@empty2Zero, strfind(mf.paramNames, 'MG'))>0;
        mth1params=cellfun(@empty2Zero, strfind(mf.paramNames, 'MT'))>0;
        argsim.onlyparams=[1:numel(mf.paramNames)];

        %simulating hxt1 and getting initial mth1 estimates. all pars free
        hxt1params=exploreparamFMS('hxt1', argsim)
        argsim.defaultparams=hxt1params;
        argsim.onlyparams = find(~mth1params);
        hxt3params=exploreparamFMS('hxt3', argsim)
        argsim.onlyparams=1:numel(mf.paramNames)
        hxt6params=exploreparamFMS('hxt6', argsim, hxt6params)
        argsim.defaultparams=hxt6params;
        argsim.onlyparams = find(~mig1params);
        hxt7params=exploreparamFMS('hxt7', argsim)
        
        [l,t,y,d]=simulator(refitparams2.(genes{j}).(models{m}).fminsearch); plot(t,y, 'DisplayName', [genes{j} ' ' models{m}]); hold on; 
        %end
        end
    plot(t,d(1:numel(t)));
    yyaxis right;
    plot(t,glucose(1:numel(t)));
    
    end
