%%directories of every experiment

%%340
n=1
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180403_results/cExperiment.mat'
rtype(n)=0

n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180405_results/cExperiment_001real.mat'
rtype(n)=0
%%342
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180329_results/cExperiment_001.mat'
rtype(n)=2
%344
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180322_results/cExperiment_001.mat'
rtype(n)=4

n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180409_results/cExperiment.mat'
rtype(n)=4
%346
n=n+1;
ramppaths{n}='/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20180410_results/cExperiment.mat'
rtype(n)=6



%%plotting all curves for one
%cm=linspecer(4)

cm=colorRamp([0, 0.2, 0.4; 0,0.8, 1],4) %%gradient of dark blue- cyans
strains={'hxt2', 'hxt4', 'hxt7'}
flag=0;
for m=1:numel(strains)
g=figure;
rampaxes=figure;
ax(m)=axes(g);
axramp=axes();
c=0;
for j=[0,2,4,6]
    c=c+1;
    inds= find(rtype==j);
    for k=inds
        l1=load(ramppaths{k});
        cExperiment=l1.cExperiment
        pause(0.5)
        if k==4
            h=multiMeanPlotRobustStdAdvanced([], cExperiment, cm(c,:), 'wt', 'mig1', [1:20], 7,3, strains(m))
        else
            h=multiMeanPlotRobustStdAdvanced([], cExperiment, cm(c,:), 'wt', 'mig1g', [1:20], 7,3, strains(m))
        end
        child= get(h, 'children');
        originax=child(2);
        rampextract=child(3);
        copyobj(get(originax,'children'), ax(m))
        if flag==0
        copyobj(get(rampextract,'children'), axramp)
        end
        close(h)
    end
end 

flag=1
    
end



%