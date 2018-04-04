%%note. when accessing the data from another computer's dropbox,
%%cExperiment.rootfolder and cExperiment.savefolder will be still assigned
%%to the other computer. change them manually to the dropbox path of the
%%computer in use and then run cExperiment.changeRootDirAllTimelapses to
%%select the folder where all the cTimelapses currently reside. 


load('/Users/s1259407/Desktop/timelapse results/20150830_mth1_std1_hxt4_ramp/cExperiment.mat')
multichamber20150830=multiCompile(cExperiment, {[2:6], [7:12]}, {'mth1', 'std1'} )

load('/Users/s1259407/Desktop/timelapse results/20150831_hxt4_mth1_noisyRampDown/cExperiment.mat')
multichamber20150831=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'mth1', 'hxt4'} )



load('/Users/s1259407/Desktop/timelapse results/20160117_mth1hxt4his_std1RampDownatpt3_results/cExperiment.mat')
multichamber20160117=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'mth1', 'hxt4', 'std1'} )
multichamber20160117.expInf.date='20160117'
multichamber20160117.expInf.transitionType= 'rampDown'
multichamber20160117.expInf.media= {'Glu 1%' 'Gal 1%'}


load('/Users/s1259407/Desktop/timelapse results/20151216_yck1hxt4yck2_rampUp/cExperiment.mat')
multichamber20151216=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'yck1', 'hxt4', 'yck2'} )
load('/Users/s1259407/Desktop/timelapse results/20151206_yck1hxt4yck2rampUp/cExperiment.mat')
multichamber20151206=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'yck1', 'hxt4', 'yck2'} )


load('/Users/s1259407/Desktop/timelapse results/20160119_mth1hxt4_RampDown_results/cExperiment.mat')
multichamber20160119=multiCompile(cExperiment, {[1:9], [10:18]}, {'mth1', 'hxt4'} )
multichamber20160119.expInf.date='20160119'
multichamber20160119.expInf.transitionType= 'rampDown'
multichamber20160119.expInf.media= {'Glu 1%' 'Gal 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160120_std1_hxt4his_mth1_rampdown/cExperiment.mat')
multichamber20160120=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'std1', 'hxt4', 'mth1'} )
multichamber20160120.expInf.date='20160120'
multichamber20160120.expInf.transitionType= 'rampDown'
multichamber20160120.expInf.media= {'Glu 1%' 'Gal 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160122_mth1hxt4hisstd1_rampUp_results/cExperiment.mat')
multichamber20160122=multiCompile(cExperiment, {[2:6], [7:12], [13:18]}, {'mth1', 'hxt4', 'std1'} ) %%%position 1 is weird. don't compile it.
multichamber20160122.expInf.date='20160122'
multichamber20160122.expInf.transitionType= 'rampUp'
multichamber20160122.expInf.media= {'Gal 1%' 'Glu 1%'}


load('/Users/s1259407/Desktop/timelapse results/20160123_mth1_hxt4His_std1_rampUprep2/cExperiment.mat')
multichamber20160123=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'mth1', 'hxt4', 'std1'} )
multichamber20160123.expInf.date='20160123'
multichamber20160123.expInf.transitionType= 'rampUp'
multichamber20160123.expInf.media= {'Gal 1%' 'Glu 1%'}



load('/Users/s1259407/Desktop/timelapse results/20160128_hxt4hisstd1Rampup_rep4/cExperiment.mat')
multichamber20160128=multiCompile(cExperiment, {[2:9], [11 13:18]}, {'hxt4', 'std1'} ) %%positions 1 and 10  and 12 are completely screwd up
multichamber20160128.expInf.date='20160128'
multichamber20160128.expInf.transitionType= 'rampUp'
multichamber20160128.expInf.media= {'Gal 1%' 'Glu 1%'}


load('/Users/s1259407/Desktop/timelapse results/20160129_Fyck1Hxt4hisFyck2/cExperiment.mat')
multichamber20160129=multiCompile(cExperiment, {[7:12]}, { 'hxt4'} )
multichamber20160129.expInf.date='20160129'
multichamber20160129.expInf.transitionType= 'rampUp'
multichamber20160129.expInf.media= {'Gal 1%' 'Glu 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160204_hxt4_galglu1percentStep/cExperiment.mat')
multichamber20160204=multiCompile(cExperiment, {[1:20]}, { 'hxt4'} )
multichamber20160204.expInf.date='20160204'
multichamber20160204.expInf.transitionType= 'stepUpDown'
multichamber20160204.expInf.media= {'Gal 1%' 'Glu 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160206_yck1_hxt4_yck2_galgluc1percentStepRep2/cExperiment.mat')
multichamber20160206=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'yck1', 'hxt4', 'yck2'} )
multichamber20160206.expInf.date='20160206'
multichamber20160206.expInf.transitionType= 'stepUpDown'
multichamber20160206.expInf.media= {'Gal 1%' 'Glu 1%'}


load('/Users/s1259407/Desktop/timelapse results/20160208_yck1hxt4yck2_galp2glucStep/cExperiment.mat')
multichamber20160208=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'yck1', 'hxt4', 'yck2'} )
multichamber20160208.expInf.date='20160208'
multichamber20160208.expInf.transitionType= 'stepUpDown'
multichamber20160208.expInf.media= {'Gal 1%' 'Glu 0.2%'}


load('/Users/s1259407/Desktop/timelapse results/20160210_mig1hxt4mig2results/cExperiment.mat')
multichamber20160210=multiCompile(cExperiment, {[7:12]}, { 'hxt4'} )
multichamber20160210.expInf.date='20160210'
multichamber20160210.expInf.transitionType= 'RampDown'
multichamber20160210.expInf.media= {'Glu 1%' 'Gal 1%'}


load('/Users/s1259407/Desktop/timelapse results/20160215_hxt2hishxt4hishxt1hisRampUp_results/cExperiment.mat')
multichamber20160215=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'hxt2', 'hxt4', 'hxt1'} )

multichamber20160215.expInf.date='20160215'
multichamber20160215.expInf.transitionType= 'RampUp'
multichamber20160215.expInf.media= {'Gal 1%' 'Glu 1%'}


load('/Users/s1259407/Desktop/timelapse results/20160217_yck2hxt4hxt2_strangerampupresults/cExperiment.mat')
multichamber20160217=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'yck2', 'hxt4', 'hxt2'} )

multichamber20160217.expInf.date='20160217'
multichamber20160217.expInf.transitionType= 'RampUp'
multichamber20160217.expInf.media= {'Gal 1%' 'Glu 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160223_hxt2hxt4yck2_gal2percentglucStep_results/cExperiment.mat')
multichamber20160223=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'hxt2', 'hxt4', 'yck2'} )

multichamber20160223.expInf.date='20160223'
multichamber20160223.expInf.transitionType= 'stepUpDown'
multichamber20160223.expInf.media= {'Gal 1%' 'Glu 0.2%'}

load('/Users/s1259407/Desktop/timelapse results/20160224_hxt2hxt4_galp2glucsteprep2/cExperiment.mat')
multichamber20160224hxt2hxt4=multiCompile(cExperiment, {[1:9], [10:18]}, {'hxt4', 'hxt2'} )

multichamber20160224hxt2hxt4.expInf.date='20160224'
multichamber20160224hxt2hxt4.expInf.transitionType= 'stepUpDown'
multichamber20160224hxt2hxt4.expInf.media= {'Gal 1%' 'Glu 0.2%'}


load('/Users/s1259407/Desktop/timelapse results/20160224_hxt4hxt4yck2galglucp2percentstep_results/cExperiment.mat') %%this experiment is dodgy as cy5 and hxt vehaviour are off.
multichamber20160224hxt4hxt4yck2=multiCompile(cExperiment, {[2:6], [7:12], [13:18]}, {'yck2', 'hxt2', 'hxt4'} ) 

multichamber20160224.expInf.date='20160224'
multichamber20160224.expInf.transitionType= 'stepUpDown'
multichamber20160224.expInf.media= {'Gal 1%' 'Glu 0.2%'}




load('/Users/s1259407/Desktop/timelapse results/20160304_yck1hxt4yck2std1hxt2rep2_results/cExperiment.mat')
multichamber20160304=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'yck1', 'hxt4', 'yck2', 'hxt2', 'std1'} )

multichamber20160304.expInf.date='20160304'
multichamber20160304.expInf.transitionType= 'stepUpDown'
multichamber20160304.expInf.media= {'Gal 1%' 'Glu 1%'}



load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/shared_timelapse_results/20160228_yck2hxt4hxt2_galp4glucstep/cExperiment.mat')
multichamber20160228=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'yck2', 'hxt4', 'hxt2'} )  %%% problem was the directory pointing at my laptop's dropbox. it is fine now.
multichamber20160228.expInf.date='20160228'
multichamber20160228.expInf.transitionType= 'stepUpDown'
multichamber20160228.expInf.media= {'Gal 1%' 'Glu 0.4%'}


load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/shared_timelapse_results/20160301_hxt2hxt4yck2galglucp4step/cExperiment.mat') %%make sure directories match when loading
multichamber20160301=multiCompile(cExperiment, {[1:6], [7:12], [13:18]}, {'hxt2', 'hxt4', 'yck2'} )  
multichamber20160301.expInf.date='20160301'
multichamber20160301.expInf.transitionType= 'stepUpDown'
multichamber20160301.expInf.media= {'Gal 1%' 'Glu 0.4%'}

load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/shared_timelapse_results/20160302_hxt4hxt2gal1percentstep/cExperiment.mat')
multichamber20160302=multiCompile(cExperiment, {[1:6], [7:12]}, {'phxt4', 'hxt2'} ) 
multichamber20160302.expInf.date='20160302'
multichamber20160302.expInf.transitionType= 'stepUpDown'
multichamber20160302.expInf.media= {'Gal 1%' 'Glu 1%'}



load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/shared_timelapse_results/20160303_yck1hxt4yck2hxt2std1_galp2glucStep_results/cExperiment.mat')
multichamber20160303=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'yck1', 'hxt4', 'yck2', 'hxt2', 'std1'} )

multichamber20160303.expInf.date='20160303'
multichamber20160303.expInf.transitionType= 'stepUpDown'
multichamber20160303.expInf.media= {'Gal 1%' 'Glu 0.2%'}



load('/Users/s1259407/Desktop/timelapse results/20160329_atpt2_hxt4yck2phxt4rgt2snf3_rampDown200/cExperiment.mat')
multichamber20160329=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'hxt4', 'yck2', 'phxt4', 'rgt2', 'snf3'} )

multichamber20160329.expInf.date='20160329'
multichamber20160329.expInf.transitionType= 'rampDown'
multichamber20160329.expInf.media= {'Glu 1%' 'Gal 1%'}


load('/Users/s1259407/Desktop/timelapse results/20160403_galglucswitch_hxt4yck2phxt4rgt2snf3/cExperiment.mat')
multichamber20160403=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'hxt4', 'yck2', 'phxt4', 'rgt2', 'snf3'} )
multichamber20160403.expInf.date='20160403'
multichamber20160403.expInf.transitionType= 'complex'
multichamber20160403.expInf.media= {'Gal 1%' 'Glu 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160404_galp4gluc_hxt4yck2phxt4rgt2snf3/cExperiment.mat')
multichamber20160404=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'hxt4', 'yck2', 'phxt4', 'rgt2', 'snf3'} )
multichamber20160404.expInf.date='20160404'
multichamber20160404.expInf.transitionType= 'stepUpDown'
multichamber20160404.expInf.media= {'Gal 1%' 'Glu 0.4%'}

load('/Users/s1259407/Desktop/timelapse results/20160405_rep2galp4switch_hxt4yck2phxt4rgt2snf3/cExperiment.mat')
multichamber20160405=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'hxt4', 'yck2', 'phxt4', 'rgt2', 'snf3'} )
multichamber20160405.expInf.date='20160405'
multichamber20160405.expInf.transitionType= 'stepUpDown'
multichamber20160405.expInf.media= {'Gal 1%' 'Glu 0.4%'}


load('/Users/s1259407/Desktop/timelapse results/20160615_galgluc121_results/cExperiment.mat')
multichamber20160615=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'std1', 'hxt4', 'mth1','snf3','rgt2'} ) 
multichamber20160615.expInf.date='20160615'
multichamber20160615.expInf.transitionType= 'stepUpDown'
multichamber20160615.expInf.media= {'Gal 1%' 'Glu 1%'}

%%%%%%

load('/Users/s1259407/Desktop/timelapse results/20160706_galglucstepresults/cExperiment.mat')
multichamber20160706=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'std1', 'hxt4', 'mth1','snf3','rgt2'}, {'std1', 'hxt4', 'mth1','snf3','pos'} ) 
multichamber20160706.expInf.date='20160706'
multichamber20160706.expInf.transitionType= 'stepUpDown'
multichamber20160706.expInf.media= {'Gal 1%' 'Glu 1%'}


%%%
load('/Users/s1259407/Desktop/timelapse results/20160707_galglucstep_results/cExperiment.mat')
multichamber20160707=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'std1', 'hxt4', 'mth1','snf3','rgt2'}, {'std1', 'hxt4', 'mth1','pos','rgt2'} )
multichamber20160707.expInf.date='20160707'
multichamber20160707.expInf.transitionType= 'stepUpDown'
multichamber20160707.expInf.media= {'Gal 1%' 'Glu 1%'}


load('/Users/s1259407/Desktop/timelapse results/20160713_0gluc0step_results/cExperiment.mat')
multichamber20160713=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'std1', 'hxt4', 'mth1','snf3','rgt2'}, {'std1', 'hxt4', 'mth1','snf3','rgt2'} )
multichamber20160713.expInf.date='20160713'
multichamber20160713.expInf.transitionType= 'stepUpDown'
multichamber20160713.expInf.media= {'no sugar' 'Glu 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160714_01gluc0_step_results/cExperiment.mat')
multichamber20160714=multiCompile(cExperiment, {[1:6], [7:12], [13:18], [19:24], [25:30]}, {'std1', 'hxt4', 'mth1','snf3','rgt2'}, {'std1', 'hxt4', 'mth1','snf3','rgt2'} )
multichamber20160714.expInf.date='20160714'
multichamber20160714.expInf.transitionType= 'stepUpDown'
multichamber20160714.expInf.media= {'no sugar' 'Glu 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160727_0glu10step_results/cExperiment.mat')
multichamber20160727=multiCompile(cExperiment, {[1:6], [7:18], [19:24], [25:33]}, {'hxt4', 'mth1','snf3','rgt2'}, { 'hxt4', 'mth1','snf3','rgt2'} )
multichamber20160727.expInf.date='20160727'
multichamber20160727.expInf.transitionType= 'stepUpDown'
multichamber20160727.expInf.media= {'no sugar' 'Glu 1%'}

load('/Users/s1259407/Desktop/timelapse results/20160728_0glu10step_results/cExperiment.mat')
multichamber20160728=multiCompile(cExperiment, {[1:6], [7:18], [19:24], [25:33]}, { 'hxt4', 'mth1','snf3','rgt2'}, { 'hxt4', 'mth1','snf3','rgt2'} )
multichamber20160728.expInf.date='20160728'
multichamber20160728.expInf.transitionType= 'stepUpDown'
multichamber20160728.expInf.media= {'no sugar' 'Glu 1%'}



%all gal p2gluc replicates:  
multichamber20160208 %poor quality
multichamber20160223 %good quality for the 3
multichamber20160224 %%good quality, only hxt2 and 4
multichamber20160303
multichamber20160304 %medium quality


