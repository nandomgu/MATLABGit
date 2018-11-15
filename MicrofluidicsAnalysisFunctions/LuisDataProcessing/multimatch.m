function [result, subset]=multimatch(obj, patterns)

% if struct we assume it is the names that are important
if isstruct(obj)
    nms=fieldnames(obj);
    result=zeros(numel(obj), 1);
    for j=1:numel(patterns)
    result= result+ strcmp(nms, patterns{j});
    
    end
    result=logical(result);
    C= struct2cell(obj);
    sC= C(result);
    subset=cell2struct(sC, nms(result));
end


if iscell(obj)
    result=zeros(numel(patterns), 1);
    for j=1:numel(patterns)
    result= result+ strcmp(obj, patterns{j});
    
    end
    
    subset= obj(result);
end
    

end