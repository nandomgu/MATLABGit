function uniformAxes(fig, axnum, xlim, ylim, wd, len)
%%This function is intended to provide uniformity to a range of selected
%%axes
deselectAxes(fig, [])
selectAxes(fig, axnum)

if isempty(fighandle)
    fig=gcf;
end


xs= get(fig, 'children'); %%getting all the axes in the figure
whichAreAxes=find(cellfun(@strcmp, get(xs, 'type'), repmat({'axes'}, numel(xs), 1)));
xs=xs(whichAreAxes);

if isempty(axnum)
    axnum=1:numel(xs);
end



for j=axnum
    
    if ~isempty(xlim)
    set(xs(j), 'XLim', xlim);
    end
    
    if ~isempty(ylim)
    set(xs(j), 'YLim', ylim);
    end
    
    pos=get(xs(j), 'Position'); %positional parameters
    if isempty(wd) || nargin<5
        
    wd=pos(3);
    end
    
    if isempty(len) || nargin<5
    len=pos(4);
    end
    
    pos(3)=wd;
    pos(4)=len;
    set(xs(j), 'Position', pos)
 
    

end

deselectAxes(fig, [])