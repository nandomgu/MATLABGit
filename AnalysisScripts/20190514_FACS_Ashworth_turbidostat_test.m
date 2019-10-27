%%
facs=struct;
facs.titration.sample1.rfp=99.5
facs.titration.sample1.cfp=.11
facs.titration.wtrgt2.sample1.rfp=99.5;
facs.titration.wtrgt2.sample1.cfp=0.11;
facs.titration.wtrgt2.sample2.cfp=0.58;
facs.titration.wtrgt2.sample2.rfp=0.395;
facs.titration.wtrgt2.sample1.rfp=.995;
facs.titration.wtrgt2.sample1.cfp=0.011;
facs.titration.wtrgt2.sample3.cfp=.793;
facs.titration.wtrgt2.sample3.rfp=.178;
facs.titration.wtrgt2.sample4.cfp=.885;
facs.titration.wtrgt2.sample4.rfp=.0837;
facs.titration.wtrgt2.sample5.cfp=.93;
facs.titration.wtrgt2.sample5.rfp=.0411;
facs.titration.wtrgt2.sample6.cfp=.944;
facs.titration.wtrgt2.sample6.rfp=.0213;
facs.titration.wtrgt2.sample6.cfp=.956;
facs.titration.wtrgt2.sample6.cfp=.944;
facs.titration.wtrgt2.sample7.cfp=.958;
facs.titration.wtrgt2.sample7.rfp=.0111;
facs.titration.wtrgt2.sample8.cfp=.958;
facs.titration.wtrgt2.sample8.rfp=.007;
facs.samples.wtwt.cfp=58.1
facs.samples.wtwt.rfp=41.1
facs.samples.wtwt.cfp=.581
facs.samples.wtwt.rfp=.411
facs.samples.wtwrgt2.cfp=.0191
facs.samples.wtwrgt2.rfp=.977
rat= @(st)  st.rfp/ (st.cfp +st.rfp)
figure;
axes('position', [.1, .6, .3, .3])
plot(structfun(rat, facs.titration.wtrgt2))
ylabel('RFP/(RFP+CFP)')
xlabel('dilutions (by halves)')
title('Serial dilutions')
g=axes('position', [.6, .3, .3, .6])
h=bar(structfun(rat, facs.samples))
g.XTickLabels={'wt_R_F_P vs \newline wt_C_F_P', 'rgt2_R_F_P vs \newline wt_C_F_P'}
ylabel('RFP/(RFP+CFP)')
title('turbidostat')
axes('position', [.1, .1, .3, .3])
plot(log2(structfun(rat, facs.titration.wtrgt2)))
ylabel('log 2 RFP/(RFP+CFP)')
ylabel('RFP/CFP')
xlabel('dilutions (by halves)')
title('Serial dilutions')
addVLine([2,3,4,5,6,7])
addHLine([-6])
addHLine([-4])
addHLine([-2])
addHLine([-3])
addHLine([-5])
addHLine([-1])
addHLine([-7])
ylabel('RFP/(RFP+CFP)')


