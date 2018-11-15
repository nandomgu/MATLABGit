function [] = PREGATEDPLOT(Data, NewData, x, y, rfp, yfp,info)
% PLOT DE LOS PARAMETROS YA CON GATE

figure()
clf


subplot(1,2,1)
plot((Data(:,x)), (Data(:,y)),'.','MarkerSize', 0.5)
hold on
plot((NewData(:,x)), (NewData(:,y)),'.r','MarkerSize', 1)
xlabel(info.par(x).name); ylabel(info.par(y).name)
%xlabel('fsc-a'); ylabel('ssc-a')
xlim([0 300000])
grid on

subplot(1,2,2)
plot((log10(Data(:,rfp))),log10((Data(:,yfp))),'.','MarkerSize', 0.5)
hold on
plot(log10(NewData(:,rfp)), (log10(NewData(:,yfp))),'.r','MarkerSize', 1)
xlabel(info.par(rfp).name); ylabel(info.par(yfp).name)
grid on

end