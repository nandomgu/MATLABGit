function ticks=removeTickElements(fig)

if isempty(fig)
    fig=gcf;
end

% 
 a=getAllAxes(fig);
      
% 
for j=1:numel(a)
    ticks(j).XTick= get(a(j), 'XTick');
    set(a(j), 'XTick', []);
    ticks(j).XTicklabel= get(a(j), 'XTickLabel');
    set(a(j), 'XTickLabel', []);
    ticks(j).YTick= get(a(j), 'YTick');
    set(a(j), 'YTick', []);
    ticks(j).YTicklabel= get(a(j), 'YTickLabel');
    set(a(j), 'YTickLabel', []);
end

end
%     