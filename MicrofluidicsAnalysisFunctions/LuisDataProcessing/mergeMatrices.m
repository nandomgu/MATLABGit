function [final, gv]=mergeMatrices(varargin)
%merge matrices in a struct
%varargin{1} is a struct with matrices in each field
%varargin{2} is an optional name of field under which the matrix is stored.
%varargin{3} is a downsampling size. it randomly picks
%for example, a matrix can be mat.rep1, mat.rep2 or mat.rep1.data,
%mat.rep2.data

if numel(varargin)>1
    subfield=varargin{2};
end
if isa(varargin{1}, 'struct')
    
    nms=fieldnames(varargin{1});
    final=[];
    gv=[];
    for j=1:numel(nms)
        
        if numel(varargin)>1
            
            sz= size(varargin{1}.(nms{j}).(subfield),1);
            vec=ones(sz,1)*j;
            final=[final; varargin{1}.(nms{j}).(subfield)];
            gv=[gv; vec];
        else
            sz= size(varargin{1}.(nms{j}),1);
            vec=ones(sz,1)*j;
            final=[final; varargin{1}.(nms{j})];
            gv=[gv; vec];
        end
        

    end
    
    if numel(varargin)>2
        
    subsample= randsample(1:size(final,1),varargin{3} );
    
    subsample=sort(subsample);
    final=final(subsample, :);
    gv=gv(subsample);
    end
    
end
    
    