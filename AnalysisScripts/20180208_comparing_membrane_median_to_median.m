figure;
nms=fieldnames(multichamber20180110);
cols=lines(20);
for j= 1:numel(nms)
subplot(numel(nms),1,j)
t=(1:size(multichamber20180110.(nms{j}).cellInf(2).membraneMedian, 2))*5/60
hold on
plot(t, nonzeroColMean(multichamber20180110.(nms{j}).cellInf(2).median), 'Color', cols(1,:));
hold on
plot(t,nonzeroColMean(multichamber20180110.(nms{j}).cellInf(2).membraneMedian), 'Color', cols(2,:));
hold on
plot(t, nonzeroColMean(multichamber20180110.(nms{j}).cellInf(2).std), 'Color', cols(3,:));
hold on
plot(t, nonzeroColMean(multichamber20180110.(nms{j}).cellInf(2).eccentricity), 'Color', cols(4,:));
legend({'mean', 'membrane median', 'std', 'eccentricity'})
title(nms{j});
xlabel('time')
end


figure;
nms=fieldnames(multichamber20180110);
cols=lines(20);
for j= 1:numel(nms)
subplot(numel(nms),1,j)
t=(1:size(multichamber20180110.(nms{j}).cellInf(2).membraneMedian, 2))*5/60
hold on
plot(t, multichamber20180110.(nms{j}).cellInf(2).mean', 'Color', cols(1,:));
hold on
plot(t,multichamber20180110.(nms{j}).cellInf(2).membraneMedian', 'Color', cols(2,:));
hold on
plot(t, multichamber20180110.(nms{j}).cellInf(2).membraneMax5', 'Color', cols(3,:));
hold on
plot(t, multichamber20180110.(nms{j}).cellInf(2).eccentricity', 'Color', cols(4,:));
legend({'median', 'membrane median', 'membrane max 5', 'eccentricity'})
title(nms{j});
xlabel('time')
end