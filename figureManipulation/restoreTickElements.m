function ticks=restoreTickElements(fig, ticks)

if isempty(fig)
    fig=gcf;
end

% 
 a=getAllAxes(fig);
      
% 
for j=1:numel(a)
    %ticks(j).XTick= get(a(j), 'XTick');
    set(a(j), 'XTick', ticks(j).XTick);
    %ticks(j).XTicklabel= get(a(j), 'XTickLabel');
    set(a(j), 'XTickLabel', ticks(j).XTicklabel);
    %ticks(j).YTick= get(a(j), 'YTick');
    set(a(j), 'YTick', ticks(j).YTick);
    %ticks(j).YTicklabel= get(a(j), 'YTickLabel');
    set(a(j), 'YTickLabel',  ticks(j).YTicklabel);
end

end