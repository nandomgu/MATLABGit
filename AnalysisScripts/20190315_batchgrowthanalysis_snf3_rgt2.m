%% analysis of experiment on the week of 20180315
%six parallel cultures of HXT7-GFP WT, rgt2?(2), snf3?(2)
%raw ods minus medium
ods= [0.006300001 0.018800001 0.0095 0.006100002 0.012900001 0.011199999;0.051300003 0.0555 0.050999998 0.049500003 0.039400003 0.046499996;0.091999999 0.0938 0.073399997 0.053500003 0.0731 0.0696;0.171799994 0.179400004 0.135699994 0.099599994 0.125700004 0.117399997;0.300200007 0.26309999 0.251700006 0.223500005 0.339900008 0.215499989;0.45939999 0.400899998 0.453099988 0.495600007 0.443900011 0.360400013;0.70089998 0.624600015 0.635000012 0.710899971 0.495399973 0.603999994;0.994600019 1.005799971 0.885400019 0.892900012 0.846799991 0.839700005;1.149399958 1.137600026 1.057300053 1.07650002 1.067900023 1.011100016;1.271699986 1.289900026 1.304699979 1.341700039 1.304599962 1.276100001;1.270799956 1.309300027 1.309900007 1.294400058 1.263200006 1.264999948;1.285500011 1.256900034 1.288199983 1.311600051 1.302300057 1.314799986;1.247999988 1.23579999 1.306099973 1.311799965 1.307200036 1.287299953;1.264200053 1.235400043 1.293899975 1.329600058 1.32590004 1.251000009;1.2646 1.256300054 1.382000051 1.329199991 1.262999973 1.29099997]
%ods diluted in 2 minus medium times 2
ods22=[-1.99999999894729e-09 0.008799998 0.006400002 0.00319999999999999 0.00420000199999999 0.006800002;0.0182 0.020199998 0.019399998 0.020000002 0.013199998 0.021000004;0.047800002 0.039199998 0.03 0.023799998 0.0274 0.026799998;0.085399998 0.085600002 0.0652 0.048399998 0.061399994 0.055199994;0.193799986 0.142200006 0.138799994 0.102799994 0.204799994 0.1004;0.361399992 0.294599994 0.33319999 0.39479999 0.350400014 0.246799988;0.46699999 0.374600006 0.392600014 0.486999972 0.275199992 0.401999994;0.804800016 0.860999984 0.696600004 0.709600014 0.542399986 0.588600022;1.319999976 1.33199994 1.186800046 1.265199942 1.199399992 1.12299995;1.525999946 1.56839995 1.570599956 1.619 1.419600052 1.472399992;1.431199952 1.409199996 1.478599948 1.449999972 1.305400056 1.355799956;1.514200016 1.402599974 1.479200048 1.531199976 1.430400056 1.387000008;1.46340005 1.44639997 1.618799968 1.650800032 1.604999942 1.504200024;1.524400038 1.476599974 1.606400056 1.615199966 1.540200038 1.44760005;1.544600052 1.524599952 1.750199956 1.716800018 1.694799942 1.753600044]

%ods diluted in 4 minus medium times 4
ods44=[0.00799999600000001 0.016799996 0.012000004 0.00719999999999998 0.012000004 0.011200008;0.021600004 0.018399996 0.024 0.022799996 0.016799996 0.019199992;0.048000004 0.040399996 0.035999996 0.0248 0.026800004 0.030400004;0.071199996 0.067599992 0.057600004 0.048000004 0.051999996 0.054;0.150400008 0.108000008 0.108400012 0.099200008 0.166400012 0.092799988;0.283199992 0.236400004 0.280800012 0.315199996 0.279200012 0.2008;0.422400024 0.329199996 0.35880002 0.439600016 0.2608 0.365600016;0.758799996 0.7872 0.62039998 0.643200008 0.477600004 0.529599992;1.344400016 1.344400016 1.16519996 1.257199968 1.1568 1.056799976;1.529200044 1.581199972 1.623599972 1.672399964 1.405199972 1.481600012;1.380799976 1.373200024 1.459600056 1.405600036 1.23320004 1.286799992;1.506800024 1.403599944 1.453600016 1.542399968 1.394800032 1.367999996;1.563600028 1.554400052 1.729999984 1.800800052 1.721600024 1.621999944;1.700800028 1.64519998 1.766399948 1.8084 1.704400028 1.537999956;1.723999944 1.678799952 2.027999964 1.988799896 1.990799988 2.081199972]
%columns: 1-2 wild type, 3-4 rgt2,  5-6 snf3
figure; errorbar(repmat(tims, 1, 3), [mean(ods(:, 1:2), 2), mean(ods(:, 3:4),2), mean(ods(:, 5:6),2)], [std(ods(:, 1:2),[], 2), std(ods(:, 3:4),[], 2), std(ods(:, 5:6),[],2)])
rectangle('Position', [0,0, 12, 1.2], 'EdgeColor',[.6 .6 .6] )
figure; errorbar(repmat(tims, 1, 3), [mean(ods22(:, 1:2), 2), mean(ods22(:, 3:4),2), mean(ods22(:, 5:6),2)], [std(ods22(:, 1:2),[], 2), std(ods22(:, 3:4),[], 2), std(ods22(:, 5:6),[],2)])
rectangle('Position', [0,0, 12, 1.2], 'EdgeColor',[.6 .6 .6] )
figure; errorbar(repmat(tims, 1, 3), [mean(ods44(:, 1:2), 2), mean(ods44(:, 3:4),2), mean(ods44(:, 5:6),2)], [std(ods44(:, 1:2),[], 2), std(ods44(:, 3:4),[], 2), std(ods44(:, 5:6),[],2)])
rectangle('Position', [0,0, 12, 1.2], 'EdgeColor',[.6 .6 .6] )
