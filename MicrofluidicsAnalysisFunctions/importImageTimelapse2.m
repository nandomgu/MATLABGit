function imagearray=importImageTimelapse2(directory, searchstring)
%the function assumes that the directory only contains text files that are
%the same dimension and that then looks for images containing the
%appropriate string.

d= dir(directory);
firstfile=3;
flag=0;



for j= firstfile:size(d,1)
    
    if(strfind(d(j).name, '.png')>0)
         disp([d(j).name, ' should be png']);
        if(flag==0)
        firstfile=j;
       
        c=firstfile;
        imageindex=1;
        matlength=size(imread([directory '/' d(firstfile).name]));
         flag=1;
        end
        else
             continue
        end
        
        
    
   if(strfind(d(j).name, searchstring)>0)
   %disp('entered')
   imagearray(:,:,imageindex)= imread([directory '/' d(j).name]);
   imageindex=imageindex+1;
    end
     end
    
end
    
    
    
    
    
