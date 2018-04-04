function [coeff, scores]=labelledPCA(matr, indices, comps)
%%caution. indices are the row numbers of the reference
%Statuses= zeros(size(matr,1),1);
%Statuses([indices])= 1:numel(indices);
Statuses=indices

[coeff, scores]=princomp(matr);

figure;
colohs=colormap;
hbi = biplot(coeff(:,comps), ...
    'Scores', scores(:,comps), ...
    'markersize', 14 ...
);
title('Bi-Plot: Standardized Data');
xlabel('Bi-Plot: Standardized Data');
xlabel(['Principal component ' num2str(comps(1))]);
ylabel(['Principal component ' num2str(comps(2))]);
 colohs=lines(30);
% Manipulate plot colors
for ii = 1:numel(hbi)-size(matr,1)
    set(hbi(ii), 'Color', [0.2 0.2 0.2]);
end
for ii = length(hbi)-size(matr,1):numel(hbi)
    userdata = get(hbi(ii), 'UserData');
    if ~isempty(userdata)
        if Statuses(userdata) == 1
            set(hbi(ii), 'Color', colohs(1,:));
            %%set(hbi(ii), 'markerSize', 4);
        elseif Statuses(userdata) == 0
            set(hbi(ii), 'Color', 'b');
             elseif Statuses(userdata) == 2
            set(hbi(ii), 'Color', colohs(2,:));
             elseif Statuses(userdata) == 3
            set(hbi(ii), 'Color', colohs(3,:));
             elseif Statuses(userdata) == 4
            set(hbi(ii), 'Color', colohs(4,:));
             elseif Statuses(userdata) == 6
            set(hbi(ii), 'Color',colohs(5,:));
             elseif Statuses(userdata) == 7
            set(hbi(ii), 'Color', colohs(1,:));
             elseif Statuses(userdata) == 8
            set(hbi(ii), 'Color',  colohs(2,:));
             elseif Statuses(userdata) == 9
            set(hbi(ii), 'Color',  colohs(3,:));
        end
    else
        set(hbi(ii), 'Color', 'k');
    end
end

end