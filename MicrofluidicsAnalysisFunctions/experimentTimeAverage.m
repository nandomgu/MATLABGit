function [valueArray, namecell]=experimentTimeAverage(experimentDir, searchstring)
    
d= dir(experimentDir)
posindex=1
for j=3:size(d,1)
       
    if isdir([experimentDir filesep d(j).name])
        disp([experimentDir filesep d(j).name])
        imt= importImageTimelapse([experimentDir filesep d(j).name], searchstring) ;% retrieving the images containing the searchstring
        valueArray(:, posindex)=imageTimeAverage(imt);
        namecell{posindex}= d(j).name;
        posindex=posindex+1;
    end
end
end