function result=stackProbs(mat, thresh, freq)
if nargin<3 || isempty(freq)
    
    freq=false;
end
%%for a matrix of cell values, obtain the probability 
%%at each timepoint (cols) that the population exceeds
%% thresholds thresh. output is a matrix with 

%sorting the values from lowest to highest for ease of plotting.
thresh= sort(thresh, 'ascend');
result=nan(numel(thresh), size(mat, 2));
%take all values above the threshold
mat(mat<thresh(1))=0;
for j=1:numel(thresh) 
        if j==numel(thresh)
result(j, :)=sum(mat>=thresh(j))%./ nansum(mat>0);
        else
  result(j, :)=sum(mat>=thresh(j) & mat<thresh(j+1))%./ nansum(mat>0);
        end;
end%
            
    

if freq
    
    result= result./ repmat(nansum(mat>=0), numel(thresh), 1);
end

%save2pdf('/Users/s1259407/Google Drive/0AFigures/paper/mig1/p2_1_stackProbs_t0_all.pdf')