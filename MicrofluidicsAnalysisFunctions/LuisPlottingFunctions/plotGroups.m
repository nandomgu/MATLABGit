function plotGroups(mat, factor)

cols=linspecer(numel(unique(factor)));
c=1;
for j= unique(factor)
    
    plot(mat(strfind(factor, j),:)', 'Color', cols(c,:));
    
    hold on; 
    
    c=c+1;
end
    