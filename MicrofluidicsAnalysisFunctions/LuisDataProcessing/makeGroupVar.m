function gv=makeGroupVar( varargin)
%create a concatenated vector of labels for all matrices in varargin

gv=[];
for j=1:numel(varargin)
    
    s= size(varargin{j}, 1);
    disp(s)
    
    gv{j}= (ones(s, 1)*j)';
end

% catch err
%     
%     error('The matrices couldn''t be concatenated. make sure you  added the correct type.')
%  end

gv=[gv{:}]';

%  else
%      if strcmp(type, 'vector')
%          
%          try
%              
%              for j=1:numel(varargin)
%               s= size(varargin{j}, 1);
%                 disp(s)
%                  
%                  gv{j}= (ones(s, 1)*j)'    
%                  
%              end
%              
%              all=vertcat(varargin{:})
%          end
%      end
%      
%  end
%          
%          
         