function axs=selectAxes(fighandle, axnum)
%select axes by number and retrieve their corresponding handles.
if isempty(fighandle)
    fighandle=gcf;
end


allaxes= getAllAxes(fighandle);

if nargin<2 || isempty(axnum)
   axnum= 1:numel(allaxes) ;
end


for j= axnum
    set(allaxes(j), 'Selected', 'on')
end

axs= allaxes(axnum);




