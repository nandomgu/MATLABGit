%trying to set a 
lth=1:140
strnnms= fieldnames(meandata)
for k=1: numel(strnnms)
    
nms=fieldnames(meandata.(strnnms{k}))
for j=1:numel(nms)

cu=meandata.(strnnms{k}).(nms{j});
cu=cu(:,lth); 
rtimes= repmat(ntimes, size(cu, 1), 1);
rtimes=rtimes(:, lth);
%finding the indices at which the signal reaches 1.
whenone= abs(cu-1)==nanmin(abs(cu-1),[], 2)

%get ramp time
activationtime.(strnnms{k}).(nms{j})= rtimes(whenone)
end
end

figure; 
for j= 1:numel(strnnms)
    plot([0.2, 0.4, 1], smn(activationtime.(strnnms{j})), 'DisplayName', strnnms{j})
    hold on
end

    