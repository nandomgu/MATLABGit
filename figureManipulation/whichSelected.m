function selectedIndices=whichSelected(gcf)
%%this function returns the indices of figures that are selected
ax= get(gcf, 'children');

for j= 1:numel(ax)
s=get(ax(j), 'Selected'); %%retrieve this figure's selection state.
state(j)=strcmp(s, 'on'); %%1 if on, 0 if not
end

selectedIndices=find(state); %% get the indices of the positions that were on.
end