function mat=cattraces(stru, pattern)
%when cell traces are in a structure with shared names, concatenate them
%those in the fields with names with pattern pattern
nms=fieldnames(stru);  
subset=nms(logical(cellfun(@empty2Zero, strfind( fieldnames(stru), pattern))));
mat=[];
        for j=1:numel(subset)
        mat=[mat; stru.(subset{j}).m];
        end
        
end
        