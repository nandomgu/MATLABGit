function plotByGroupGeneral(matr, groupVector)

numGroups= unique(groupVector);
greens= .5
blues=1
figure; 
for i= 1: numel(numGroups)
    
    plot( matr(find(groupVector==numGroups(i))   ,:)', 'Color', [i/length(numGroups) greens  blues], 'lineWidth', 2);
    hold on;
    %,'LineWidth', 1)
    
end

end