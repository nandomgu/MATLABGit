function stackPlots(fig, xlab)

bottomMargin=.05;
topMargin=0;
leftMargin=.08;
rightMargin=.04;
axisSpacing=0.015;

if isempty(fig)
    fig=gcf;
end
deselectAxes(fig)


if nargin<2 || isempty(xlab)
    
    xlab='';
end

 a=getAllAxes(fig);
 
 %%divide the height evenly 


totalHeight=1-bottomMargin-topMargin;
 
 axesHeight= (totalHeight/numel(a))-axisSpacing;
 
  positions =linspace(1-axesHeight-topMargin-axisSpacing, bottomMargin, numel(a));
  axorder= fliplr(1:numel(positions))
 for j= 1:numel(positions)
     disp(j)
     set(a(axorder(j)), 'Position', [leftMargin, positions(j), 1-leftMargin-rightMargin, axesHeight])
    
      if j~=numel(positions)
         
          z=get(a(axorder(j)), 'XAxis');
          set(z, 'Visible', 'off');


      end
    
    
     %if j==numel(positions)
      %   xlabel(xlab)
       % showTicks(a(j));
        
    % end         
 end
end

     
     
 