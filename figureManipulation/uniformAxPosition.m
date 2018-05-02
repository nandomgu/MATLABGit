function uniformAxPosition(fig, axnum, x, y)

if isempty(fig)
    fig=gcf;
end

allaxes=get(fig, 'children')
if isempty(axnum)
    
    
    axnum= whichSelected(fig);
    if isempty(axnum)
        
    axnum= 1:numel(allaxes);
    end
end


for j= axnum
    pos= get(allaxes(j), 'Position')
    
    if isempty(x)
        c1=pos(1);
    else
        c1=x;
    end
    if isempty(y)
        c2=pos(2);    
    else
      c2=y;  
    end
    
    pos([1 2])=[c1 c2]
    set(allaxes(j), 'Position', pos);
    
end

end
