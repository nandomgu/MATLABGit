load('/Users/s1259407/Dropbox/Fitness Cyt 2018SepOct/20180930_RawData.mat')

strains=fieldnames(Muts)
ratios=struct;
for j=1:numel(strains)
    

for cond=2:numel(MediaIntegrated)
mt=MediaIntegrated(cond).nCFP./MediaIntegrated(cond).nRFP;
ratios.(strains{j}).(MediaIntegrated(cond).sname)= mt(:, Muts.(strains{j}));
end
end


condnames=fieldnames(ratios.Refs)

for j=1:numel(condnames)
    mt=ratios.snf3.(condnames{j});
figure; plot(log(mt./ repmat(mt(1,:), 5,1)));
title(condnames{j})
end






