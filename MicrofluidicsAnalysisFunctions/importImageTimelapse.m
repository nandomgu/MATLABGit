function imagearray=importImageTimelapse(directory)
%the function assumes that the directory only contains text files that are
%the same dimension and belong to the same timelapse.

d= dir(directory);
firstfile=3;
flag=0;



for i= 1:size(d,1)
    
    if(strfind(d(i).name, '.png')>0)
         disp([d(i).name, ' should be png']);
        if(flag==0)
        firstfile=i;
       
        c=firstfile;
        matlength=size(imread([directory '/' d(firstfile).name]));
        imagearray=repmat(0,matlength(1), matlength(2), size(d,1)-firstfile+1);
         flag=1;
        end
        
        
    
   imagearray(:,:,c-firstfile+1)= imread([directory '/' d(i).name]);
   c=c+1;
     end
    
end
   
end
    
    
    
    
    
