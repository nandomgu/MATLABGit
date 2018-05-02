function formatBars(barhandle)
%%general formatting of bars in a bar plot
%%for now the style is no edges, pastel colors.

%% apply alpha of 0.3-0.5 for nicest pastel colors
cols= [0.9000 0.4000 0;...%%nice orange
            0, .4, 1;... %% nice blue
            0.95, 0, 0.95;... %%nice magenta 
            0, 0.8, 0.5;... %%nice turquoise
            0.3, 0, 1;... %%nice purple
            1, .05, 0]; ... %nice red
            
        %% applying format
        for j=1:numel(barhandle)
            barhandle(j).FaceAlpha=0.5;
            barhandle(j).FaceColor= cols(j, :);
            barhandle(j).EdgeColor='None'
        end
end
            
            
        
        
        
        
        
        
        


%      low: [0.9000 0.4000 0]
%       upshift: [0, .4, 1]
%          high: [0.9500 0 0.9500]
%     downshift: [0 0.8000 0.5000]


