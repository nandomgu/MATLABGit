function matrix=smootheach(matrix,window)
matrix=full(matrix);
for i =1:size(matrix, 1)
    
   matrix(i,:)= smooth(matrix(i, :),window);
end
end

    
    
%plot(smooth(cExperiment.cellInf(2).mean(nicecells_20140421(4), :)))