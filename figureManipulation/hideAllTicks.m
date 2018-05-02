
function hideAllTicks(fig)
%ticks
%ticks=struct;

if nargin<1 ||isempty(fig)
    fig=gcf;
end

 selectAxes(fig, []);

% 
 a=getAxes(fig);
 
 for j=1:numel(a)
     
     nr= get(a(j), 'XAxis');
     set(nr, 'Visible', 'off')
     
     nr= get(a(j), 'YAxis');
     for b=1:numel(nr)
         
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






