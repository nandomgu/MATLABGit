function plotByGroupGeneral(matr, groupVector)

numGroups= unique(groupVector);
greens= .5
blues=1

cols=linspecer(numel(numGroups));
figure; 
for i= 1: numel(numGroups)
    if iscell(groupVector)
        plot( matr(strcmp(groupVector, numGroups{i})   ,:)', 'Color',  cols(i, :), 'lineWidth', 1);

    else
    plot( matr(groupVector==numGroups(i)   ,:)', 'Color', cols(i, :), 'lineWidth', 1);
    end
    hold on;
    %,'LineWidth', 1)
    
end

end