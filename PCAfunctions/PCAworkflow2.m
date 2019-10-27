function [coeffs, scores, yArray, groupVector]=  PCAworkflow2(yArray,components, varargin)
%pcawrorkflow 2 projects matrices varargin{...}
%into the PC space of yArray
%%%comps could default to [1,2]
groupVector= ones(size(yArray, 1),1)
zArray=[];

    
 
 [coeffs, scores,~, ~, explained, mu]=pca(yArray)


 [coeffs, scores]= labelledPCA(yArray, groupVector, components);
 cols=lines(20);
 groupVector=[];
 for j= 1: numel(varargin)
    
     
     t=(varargin{j}-mu)*coeffs; 
     %projectng each varargin matrix onto the PCs
    groupVector= [groupVector; ones(size(varargin{j},1), 1)];
    
    hold on; biplot(coeffs(:, 1:2), 'scores', t(:, 1:2), 'Color', cols(j, :))
    
    
 end

end
    
    
    



