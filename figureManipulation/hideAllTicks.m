
function hideAllTicks(fig, axnum, x, y, side, labels)
%ticks
%ticks=struct;
if nargin<6 || isempty(labels)
    labels=1;
end

if nargin<1 ||isempty(fig)
    fig=gcf;
end


 selectAxes(fig, []);

if nargin<3
    x=1;
    y=1;
end

if nargin<4
    
    side='left';
end

 a=getAxes(fig);
 
if nargin<2
axnum= 1:numel(a);
end

 for j=axnum
     yyaxis(a(j), side);
     if x
         
         if labels==0
     nr= get(a(j), 'XAxis');
     set(nr, 'Visible', 'off')
         end
     
                  else
     a(j).XTickLabel='';
         
     
      end
         
     if y
         
         if labels==0
     nr= get(a(j), 'YAxis');
     
     
     
         if strcmp(side,'right')
         set(nr(2), 'Visible', 'off');
         else
         set(nr(1), 'Visible', 'off');
         end
         else
     a(j).YTickLabel='';
         
     
      end
 deselectAxes(gcf);
     end
         
 end
 
 
 
 
      
% 
% for j=1:numel(a)
%     ticks(j).XTick= get(a(j), 'XTick');
%     set(a(j), 'XTick', []);
%     ticks(j).XTicklabel= get(a(j), 'XTickLabel');
%     set(a(j), 'XTickLabel', []);
%     ticks(j).XTick= get(a(j), 'YTick');
%     set(a(j), 'YTick', []);
%     ticks(j).YTicklabel= get(a(j), 'YTickLabel');
%     set(a(j), 'YTickLabel', []);
% end
%     
%     
% set(gca, 'Position', [0, 1-j*(1/numel(rampsDownNames)), 1, 1/numel(rampsDownNames)])
% set(gca, 'XTickLabel','' )
% set(gca, 'YTickLabel','' )






