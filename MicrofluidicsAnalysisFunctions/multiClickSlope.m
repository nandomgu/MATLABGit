function [slopes, intercepts, rs, xs]=multiClickSlope(numLines, numClicks, linespecnum)
%allows fit numLines lines for groups of numClicks dots that are clicked on a figure, 

xs={};
slopes={};
intercepts={};
rs={};
for j=1:numLines

   [slopes{j}, intercepts{j}, rs{j}]= clickSlope(numClicks, linespecnum)
    
    
  xs{j}=gca;  
end



