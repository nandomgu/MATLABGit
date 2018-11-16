
figure; axes(); k=1; plot(real(y(:, k:(k+2))), 'color', concolors);  axes(); k=k+3; plot(real(y(:, k:(k+2)))); axes();k=k+3; plot(real(y(:, k:(k+2)))); axes();k=k+3; plot(real(y(:, k:(k+2)))); axes();k=k+3; plot(real(y(:, k:(k+2))));k=k+3;axes(); plot(real(y(:, k:(k+2)))); stackPlots(gcf)

figure; axes(); k=1; plot(real(argsim.datameans(:, k:(k+2))));  axes(); k=k+3; plot(real(argsim.datameans(:, k:(k+2)))); axes();k=k+3; plot(real(argsim.datameans(:, k:(k+2)))); axes();k=k+3; plot(real(argsim.datameans(:, k:(k+2)))); axes();k=k+3; plot(real(argsim.datameans(:, k:(k+2))));k=k+3;axes(); plot(real(argsim.datameans(:, k:(k+2)))); stackPlots(gcf)
%%
figure;
k=1;
lw=1.5
while k<18
axes(); 
j=0; 
plot(t, real(y(:, k+j)), 'color', concolors(j+1,:), 'LineWidth', lw);
hold on;
j=j+1
plot(t,real(y(:, k+j)), 'color', concolors(j+1,:), 'LineWidth', lw);
hold on;
j=j+1
plot(t,real(y(:, k+j)), 'color', concolors(j+1,:), 'LineWidth', lw);
hold on;
k=k+3;
end
stackPlots(gcf)

        disp('plotting sugar')
        allaxes=get(gcf, 'children')
        for j=1:numel(allaxes)
      
            axes(allaxes(j))
            yyaxis right
        area( t, argsim.input, 'FaceAlpha', 0.1, 'FaceColor', [1, .6, 0], 'EdgeColor', 'none'); 
        yyaxis left
        
        end
       

%%
axes(); k=k+3; plot(real(y(:, k:(k+2)))); axes();k=k+3; plot(real(y(:, k:(k+2)))); axes();k=k+3; plot(real(y(:, k:(k+2)))); axes();k=k+3; plot(real(y(:, k:(k+2))));k=k+3;axes(); plot(real(y(:, k:(k+2)))); stackPlots(gcf)





