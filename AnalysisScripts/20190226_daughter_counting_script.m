
%% 
addpath('/Users/s1259407/Documents/MATLAB/GeneralFunctions2019')
addpath('/Users/s1259407/Documents/MATLAB/Add-ons')
addpath(genpath('/Users/s1259407/Documents/MATLAB/OmeroCode'))
addpath(genpath('/Users/s1259407/Documents/MATLAB/MattSegCode2019'))
load('/Users/s1259407/Dropbox/PhD/phd_peter_swain/data/timelapse_results_mobilefolder/20181213_results/cExperiment_001_with_lineage.mat')
odb = SystemPreferences.omerodb;
cExperiment.OmeroDatabase= odb;
cExperiment.omeroDs= odb.getDsListFromTag(cExperiment.id)
a=editCellSegGUI(cExperiment, 'channels', {'Brightfield_3', 'GFPFast', 'cy5'})
