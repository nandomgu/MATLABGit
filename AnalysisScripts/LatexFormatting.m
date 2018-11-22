%script to write models into latex


syms VHXT Vloc basaldeg maxdegMT KdegMT hilldegMT maxdegST KrepMTST hillrepMTST KdegST hilldegST basaldegST KinhSMG deloc KrepHMG hillHMG KrepHMT hillrepHMT KrepHST hillrepHST KMG hillMG VdegHXT threshdegHXT hilldegHXT basaldegM2 KrepSTM2 KrepHM2 hillrepHM2 KinhSM2 KrepM2MT hillrepM2MT VinactGM2 KinactGM2 hillinactGM2

latex(maxdegMT*(g)^hilldegMT /(KdegMT^hilldegMT+g^hilldegMT))

degST= latex(maxdegST*(Glucose)^hilldegST /(10^hilldegST+Glucose^hilldegST))
deg= latex(VdegHXT/(1+ (Glucose/threshdegHXT)^hilldegHXT)+basaldeg);
DMTH1= latex(1/ (1 + (MIG2/KrepM2MT)^hillrepM2MT)  - (degMT+ basaldegMT)*MTH1 )
DMIG1= latex(Vloc*cytMIG1*(Glucose/KMG)^hillMG/(1 + (Glucose/KMG)^hillMG) -deloc*MIG1 -KinhSMG*STD1*MIG1);
DSTD1= latex(1/(1+(MTH1/KrepMTST)^hillrepMTST) - (degST+ basaldegST)*STD1 );
DMIG2= latex(1/(1+ (MTH1/KrepSTM2)^hillrepSTM2) -KinhSM2*STD1*MIG2 -basaldegM2*MIG2   -  (VinactGM2 / (1 + (Glucose/KinactGM2)^hillinactGM2))*MIG2); 
DHXT=latex(VHXT/ (1+ (MIG1/KrepHMG)^hillHMG +(MTH1/KrepHMT)^hillHMT +(MIG2/KrepHM2)^hillrepHM2 +(STD1/KrepHST)^hillrepHST) - deg*HXT);

%% making values in normal scale  rather than log.
nms=fieldnames(ps);
for f = 1:numel(nms)
    psnormal.(nms{f})= exp(ps.(nms{f}));
end

%making a table from the parameter structure
tab= struct2table(psnormal)
%making a 2 column table with the parameter values
paramtable=table(tab.Properties.VariableNames',  tab{1, :}', 'VariableNames', {'Parameter', 'Value'})

%making units for each parameter.

   VHXT: 6.9078
            Vloc: 0.0847
        basaldeg: 0.1823
        maxdegMT: 1.3863
          KdegMT: -4.6052
       hilldegMT: 1.3863
      basaldegMT: 0
        maxdegST: 1.3863
        KrepMTST: -0.5108
     hillrepMTST: 1.3863
          KdegST: -0.6931
       hilldegST: 0
      basaldegST: -2.9957
         KinhSMG: 3.9120
           deloc: 1.0986
         KrepHMG: -9.9035
         hillHMG: 0
         KrepHMT: -3.9120
         hillHMT: 0.5423
         KrepHST: 0.4055
      hillrepHST: 1.0986
             KMG: -2.3026
          hillMG: 0
         VdegHXT: -1.2040
    threshdegHXT: -4.6052
      hilldegHXT: 0
      basaldegM2: 0.4055
        KrepSTM2: -1.6094
     hillrepSTM2: 1.3863
         KrepHM2: -3.9120
      hillrepHM2: 1.0986
         KinhSM2: 2.9957
       VinactGM2: 2.3026
       KinactGM2: -2.3026
    hillinactGM2: 1.3863
      hillrepHMT: 0
      hillrepHMG: 0
        KrepM2MT: -2.8134
     hillrepM2MT: 0.6931
