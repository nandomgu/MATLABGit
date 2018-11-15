
function hideAllTicks(fig, axnum, x, y, side)
%ticks
%ticks=struct;

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
     nr= get(a(j), 'XAxis');
     set(nr, 'Visible', 'off')
     end
     if y
     nr= get(a(j), 'YAxis');
     for b=1:numel(nr)
     end    
         set(nr(b), 'Visible', 'off');
     end
 end
 deselectAxes(gcf);
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






