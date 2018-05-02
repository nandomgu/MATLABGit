multichamber=multichamber20180112
lth= min(size(cExperiment.metadata.logTimes,2), size(multichamber.wt.cellInf(3).mean,2))
figure;
subplot(2,1,1)
stairs(cExperiment.metadata.acq.switchParams.switchtimes/60, cExperiment.metadata.acq.switchParams.pumpflow')
xlim([0, mean(cExperiment.metadata.logTimes(:,lth))/60])
subplot(2,1,2)
plot(mean(cExperiment.metadata.logTimes(:,1:lth))/60, nonzeroColMean(multichamber.wt.cellInf(3).mean(:,1:lth)))



%%getting cy5 directly form experiment


cExperiment=d.cExperiment
med=experimentTimeAverageOmero(d.cExperiment, 'cy5', 1)

med2=normalizeTS(nonzeroColMean(med));

lth= min(size(cExperiment.metadata.logTimes,2), size(med,2))
figure;
subplot(2,1,1)
stairs(cExperiment.metadata.acq.switchParams.switchtimes/60, cExperiment.metadata.acq.switchParams.pumpflow')
title(strrep(cExperiment.metadata.date, '_', '-'))
xlim([0, mean(cExperiment.metadata.logTimes(:,lth))/60])
subplot(2,1,2)
%plot(mean(cExperiment.metadata.logTimes(:,1:lth))/60, med2(1:lth))
%in case there is only one trap
plot(cExperiment.metadata.logTimes(:,1:lth)/60, med2(1:lth))
