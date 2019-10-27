%%Glucose assay, raw values, averaged between both hxt4 replicates and GFP
%replicates
OD=[0.337799996 0.334300011 0.329899997 0.33829999 0.325300008 0.336600006 0.316599995 0.314900011 0.310299993 0.337199986 0.301400006 0.30219999;0.353599995 0.354600012 0.33860001 0.341399997 0.320899993 0.322600007 0.354499996 0.36469999 0.346199989 0.351599991 0.338999987 0.336100012;0.375499994 0.371800005 0.357899994 0.359100014 0.341100007 0.341600001 0.416700006 0.386700004 0.378300011 0.3741 0.359699994 0.363700002;0.406500012 0.405900002 0.413199991 0.4014 0.374599993 0.379400015 0.425799996 0.432700008 0.425199986 0.419099987 0.396100014 0.392800003;0.466899991 0.463499993 0.462599993 0.471100003 0.44780001 0.450399995 0.505400002 0.505699992 0.493099988 0.493499994 0.464399993 0.435600013;0.553900003 0.573000014 0.567200005 0.56220001 0.541999996 0.540000021 0.574999988 0.576499999 0.567600012 0.566999972 0.547900021 0.544700027;0.637600005 0.638300002 0.620100021 0.640200019 0.61589998 0.611699998 0.655799985 0.655700028 0.653400004 0.660300016 0.629400015 0.613499999;0.72329998 0.716300011 0.720899999 0.721800029 0.700100005 0.708599985 0.727800012 0.733299971 0.729099989 0.739899993 0.702499986 0.689300001;0.744700015 0.751699984 0.797100008 0.787899971 0.77609998 0.779399991 0.773899972 0.775699973 0.805599988 0.787800014 0.76789999 0.778100014;0.785399973 0.787 0.919799984 0.917599976 0.877200007 0.868499994 0.813899994 0.806400001 0.914799988 0.908200026 0.895099998 0.908500016;0.816200018 0.817700028 1.029600024 1.040799975 1.006399989 1.008900046 0.833599985 0.837499976 1.042899966 1.005599976 0.981999993 1.004799962;0.823199987 0.827000022 1.116799951 1.10650003 1.097100019 1.121899962 0.842700005 0.847899973 1.078099966 1.089400053 1.042299986 1.085500002;0.865800023 0.870299995 1.132400036 1.131299973 1.188500047 1.192199945 0.857599974 0.861100018 1.10860002 1.133100033 1.22179997 1.178799987;0.878400028 0.882099986 1.135200024 1.125499964 1.287799954 1.276800036 0.876600027 0.882300019 1.130300045 1.139999986 1.239199996 1.242799997;0.868200004 0.877600014 1.108899951 1.110700011 1.314900041 1.312899947 0.899200022 0.905600011 1.127300024 1.122400045 1.324900031 1.321400046;0.925800025 0.931400001 1.146199942 1.147600055 1.350000024 1.351699948 0.913299978 0.920099974 1.137799978 1.13349998 1.337100029 1.354400039]
glucoseAssay= [0.232700005 0.246900007 0.458099991 0.441399992 0.771399975 0.806699991 0.263900012 0.255899996 0.448100001 0.449099988 0.763899982 0.735800028;0.248899996 0.266099989 0.497799993 0.532999992 0.957400024 0.958800018 0.275200009 0.274399996 0.5079 0.499599993 0.878099978 0.886200011;0.273699999 0.267800003 0.487800002 0.500400007 0.910300016 0.920099974 0.2685 0.272500008 0.526000023 0.521099985 0.947300017 0.582799971;0.212500006 0.230499998 0.450800002 0.472900003 0.888599992 0.940100014 0.245399997 0.248199999 0.500100017 0.469999999 0.89230001 0.996599972;0.224700004 0.2245 0.444700003 0.442900002 0.892199993 0.892199993 0.220500007 0.230299994 0.4551 0.448900014 0.887300014 0.843900025;0.206200004 0.203700006 0.436500013 0.433200002 0.854900002 0.843200028 0.203199998 0.206100002 0.411300004 0.403499991 0.736100018 0.70450002;0.175799996 0.180000007 0.388300002 0.407599986 0.82130003 0.852500021 0.178399995 0.177399993 0.416900009 0.424299985 0.868700027 0.826200008;0.139500007 0.143900007 0.326900005 0.341600001 0.699999988 0.697000027 0.143000007 0.142800003 0.364600003 0.347499996 0.734499991 0.731299996;0.133100003 0.133599997 0.297600001 0.293199986 0.636900008 0.705799997 0.132699996 0.133200005 0.3134 0.310499996 0.72240001 0.802900016;0.133399993 0.133499995 0.240799993 0.240700006 0.569299996 0.586000025 0.133300006 0.135499999 0.241799995 0.240999997 0.576699972 0.610099971;0.132200003 0.134200007 0.179700002 0.1831 0.535099983 0.568199992 0.134100005 0.1347 0.189300001 0.183500007 0.518599987 0.485000014;0.134599999 0.135199994 0.137099996 0.1373 0.404399991 0.423299998 0.135700002 0.1347 0.138300002 0.137099996 0.444099993 0.412999988;0.133699998 0.133599997 0.132799998 0.134900004 0.3292 0.333700001 0.134599999 0.134800002 0.136099994 0.138300002 0.335000008 0.325100005;0.133599997 0.134599999 0.135299996 0.133699998 0.260800004 0.257499993 0.1338 0.134299994 0.135100007 0.135600001 0.295899987 0.289700001;0.135299996 0.134800002 0.134900004 0.137099996 0.159700006 0.154699996 0.1329 0.132300004 0.1338 0.1347 0.196400002 0.196700007;0.135000005 0.135199994 0.133900002 0.134499997 0.134299994 0.135000005 0.135199994 0.134299994 0.133699998 0.132300004 0.141599998 0.139599994]
gaFL=[2747 2683 2830 2804 2862 2822 1639 1620 1606 1742 1677 1598;2582 2622 2576 2640 2710 2685 1607 1587 1632 1626 1587 1607;2626 2657 2694 2677 2719 2686 1634 1692 1740 1671 1738 1660;2780 2742 2787 2716 2773 2724 1703 1723 1759 1718 1765 1789;3123 2985 2753 2812 2762 2787 1848 1815 1847 1881 1874 1900;3931 3671 3175 3173 2933 2970 2010 1978 2018 2000 2010 2035;5113 4645 3610 3607 2930 2989 2211 2290 2240 2236 2255 2257;6785 6161 4497 4656 3442 3458 2371 2351 2353 2385 2316 2468;6924 6920 6182 5917 4017 4096 2535 2574 2778 2718 2749 2829;5629 5762 8300 8407 5123 5144 2520 2567 3173 3110 3067 3085;5061 4969 11857 11888 6852 7179 2580 2562 3583 3658 3514 3652;4762 4466 14211 14168 9283 9731 2541 2521 3946 3856 3954 3982;4571 4453 13439 13489 11835 11950 2575 2563 3970 3903 4533 4569;4481 4405 11082 11093 14624 15226 2524 2573 3905 3875 4975 4998;4297 4220 8935 8995 17158 18143 2555 2560 3933 3898 5150 5351;4361 4324 7930 8013 17253 17629 2655 2646 3944 3937 5594 5600]

gaFLcorrected= gaFL- repmat([repmat(mean(gaFL(:, [7:8]),2),1,2), repmat(mean(gaFL(:, [9:10]) ,2),1,2) ,repmat(mean(gaFL(:, [11:12]) ,2), 1,2)] , 1,2)

FLOD= gaFLcorrected./OD
figure; errorbar(mean(glucoseAssay(:,[1,2,7,8])'), std(glucoseAssay(:,[1,2,7,8])'))
hold on; errorbar(mean(glucoseAssay(:,[3,4,9,10])'), std(glucoseAssay(:,[3,4,9,10])'))
hold on; errorbar(mean(glucoseAssay(:,[5,6,11,12])'), std(glucoseAssay(:,[5,6,11,12])'))

%%Glucose assay, scaled values such that top concentration is 2


gatime= hours(duration([00,00,00;
00,29,09;
00,58,40;
01,29,19;
01,59,19;
02,29,21;
02,59,19;
03,29,18;
03,59,19;
04,29,19;
04,59,20;
05,29,19;
05,59,19;
06,29,20;
06,59,18;
07,29,20;]));

glucoseAssayScaled=log10(glucoseAssay*2.3)
figure;
errorbar(gatime,mean(glucoseAssayScaled(:,[1,2,7,8])'), std(glucoseAssayScaled(:,[1,2,7,8])'))
hold on; errorbar(gatime, mean(glucoseAssayScaled(:,[3,4,9,10])'), std(glucoseAssayScaled(:,[3,4,9,10])'))
hold on; errorbar(gatime, mean(glucoseAssayScaled(:,[5,6,11,12])'), std(glucoseAssayScaled(:,[5,6,11,12])'))

%%
figure
errorbar(gatime,mean(gaFL(:,[1,2])'), std(gaFL(:,[1,2])'))
hold on; errorbar(gatime, mean(gaFL(:,[3,4])'), std(gaFL(:,[3,4])'))
hold on; errorbar(gatime, mean(gaFL(:,[5,6])'), std(gaFL(:,[5,6])'))

%%
figure
errorbar(gatime,mean(gaFL(:,[1,2])'), std(gaFL(:,[1,2])'))
hold on; errorbar(gatime, mean(gaFLcorrected(:,[3,4])'), std(gaFLcorrected(:,[3,4])'))
hold on; errorbar(gatime, mean(gaFLcorrected(:,[5,6])'), std(gaFLcorrected(:,[5,6])'))



%%
figure; plot( mean(glucoseAssay(:,[1,2,7,8])'), mean(gaFL(:,[1,2])'))
hold on; plot( mean(glucoseAssay(:,[3,4,9,10])'), mean(gaFL(:,[3,4])'))
hold on; plot( mean(glucoseAssay(:,[5,6,11,12])'), mean(gaFL(:,[5,6])') )

figure; scatter( stretchMatrix(glucoseAssay(1:9,[1,2])), stretchMatrix(gaFL(1:9,[1,2])))
hold on; scatter( stretchMatrix(glucoseAssay(1:12,[3,4])), stretchMatrix(gaFL(1:12,[3,4])))
hold on; scatter( stretchMatrix(glucoseAssay(:,[5,6])), stretchMatrix(gaFL(:,[5,6])) )


%% scatterplot with glucose quantification on x axis

figure; scatter( stretchMatrix(glucoseMeasure(1:9,[1,2])), stretchMatrix(gaFL(1:9,[1,2])), '^')
hold on; scatter( stretchMatrix(glucoseMeasure(1:12,[3,4])), stretchMatrix(gaFL(1:12,[3,4])), 'o')
hold on; scatter( stretchMatrix(glucoseMeasure(:,[5,6])), stretchMatrix(gaFL(:,[5,6])) ,  's')
xlabel('% Glucose')
ylabel('Raw GFP')

%% scatterplot with glucose quantification on x axis

figure; scatter( stretchMatrix(glucoseMeasure(1:9,[1,2])), stretchMatrix(gaFLcorrected(1:9,[1,2])))
hold on; scatter( stretchMatrix(glucoseMeasure(1:12,[3,4])), stretchMatrix(gaFLcorrected(1:12,[3,4])))
hold on; scatter( stretchMatrix(glucoseMeasure(:,[5,6])), stretchMatrix(gaFLcorrected(:,[5,6])) )



%% plotting OD
figure
errorbar(gatime,mean(OD(:,[1,2])'), std(OD(:,[1,2])'))
hold on; errorbar(gatime, mean(OD(:,[3,4])'), std(OD(:,[3,4])'))
hold on; errorbar(gatime, mean(OD(:,[5,6])'), std(OD(:,[5,6])'))

%% plotting FL per od

figure
errorbar(gatime,mean(FLOD(:,[1,2])'), std(FLOD(:,[1,2])'))
hold on; errorbar(gatime, mean(FLOD(:,[3,4])'), std(FLOD(:,[3,4])'))
hold on; errorbar(gatime, mean(FLOD(:,[5,6])'), std(FLOD(:,[5,6])'))


figure; scatter( stretchMatrix(glucoseAssay(1:9,[1,2])), stretchMatrix(FLOD(1:9,[1,2])))
hold on; scatter( stretchMatrix(glucoseAssay(1:12,[3,4])), stretchMatrix(FLOD(1:12,[3,4])))
hold on; scatter( stretchMatrix(glucoseAssay(:,[5,6])), stretchMatrix(FLOD(:,[5,6])) )


%% transforming the glucose assay into glucose units
%values of known starting glucose concentrations
lineX= [zeros(12,1), repmat([0.4, 0.4, 1,1,2,2]', 2,1)]
%%values of the first timepoint. used as a standard
lineY=[glucoseAssay(end,:)', glucoseAssay(1, :)']
%%values of the second timepoint. just to prove that it is also a line
lineY2=[glucoseAssay(end,:)', glucoseAssay(2, :)']

b=[ones(24,1), stretchMatrix(lineX)]\stretchMatrix(lineY);
intercept= b(1);
slope= b(2);

b2=[ones(24,1), stretchMatrix(lineX)]\stretchMatrix(lineY2);
intercept2= b2(1);
slope2= b2(2);

figure; 
scatter(stretchMatrix(lineX), stretchMatrix(lineY), 'MarkerEdgeColor', 'blue');
hold on; plot(stretchMatrix(lineX),[ones(24,1), stretchMatrix(lineX)]*b, 'color', 'blue');
hold on; scatter(stretchMatrix(lineX), stretchMatrix(lineY2), 'MarkerEdgeColor', 'red');
hold on; plot(stretchMatrix(lineX),[ones(24,1), stretchMatrix(lineX)]*b2, 'color', 'red');



glucoseMeasure= ((glucoseAssay-intercept)/slope);


figure; 
errorbar(mean(glucoseMeasure(:,[1,2,7,8])'), std(glucoseMeasure(:,[1,2,7,8])'), '-^', 'MarkerFaceColor', 'blue' )
yyaxis right
%errorbar(mean(OD(:,[1,2,7,8])'), std(OD(:,[1,2,7,8])'), '-o', 'MarkerFaceColor', 'magenta' )
errorbar(mean(gaFL(:,[1,2])'), std(gaFL(:,[1,2])'), '-s', 'MarkerFaceColor', [0,0.7, 0.7],'MarkerEdgeColor', [0,0.7, 0.7], 'Color',  [0,0.7, 0.7] )



figure; 
subplot(3,1,1)
errorbar( gatime, mean(glucoseMeasure(:,[1,2,7,8])'), std(glucoseMeasure(:,[1,2,7,8])'), '-^', 'MarkerFaceColor', 'blue' )
ylim([0, 0.5])
yyaxis right
%errorbar(mean(OD(:,[1,2,7,8])'), std(OD(:,[1,2,7,8])'), '-o', 'MarkerFaceColor', 'magenta' )
errorbar(gatime, mean(gaFL(:,[1,2])'), std(gaFL(:,[1,2])'), '-s', 'MarkerFaceColor', [0,0.7, 0.7],'MarkerEdgeColor', [0,0.7, 0.7], 'Color',  [0,0.7, 0.7] )

subplot(3,1,2)
errorbar(gatime, mean(glucoseMeasure(:,[3,4,9,10])'), std(glucoseMeasure(:,[3,4,9,10])'), '-^', 'MarkerFaceColor', 'blue' )
ylim([0, 1.2])
yyaxis right
%errorbar(mean(OD(:,[1,2,7,8])'), std(OD(:,[1,2,7,8])'), '-o', 'MarkerFaceColor', 'magenta' )
errorbar(gatime, mean(gaFL(:,[3,4])'), std(gaFL(:,[3,4])'), '-s', 'MarkerFaceColor', [0,0.7, 0.7],'MarkerEdgeColor', [0,0.7, 0.7], 'Color',  [0,0.7, 0.7] )

subplot(3,1,3)
errorbar(gatime,mean(glucoseMeasure(:,[5,6,11,12])'), std(glucoseMeasure(:,[5,6,11,12])'), '-^', 'MarkerFaceColor', 'blue' )
ylim([0, 3])
yyaxis right
%errorbar(mean(OD(:,[1,2,7,8])'), std(OD(:,[1,2,7,8])'), '-o', 'MarkerFaceColor', 'magenta' )
errorbar(gatime, mean(gaFL(:,[5,6])'), std(gaFL(:,[5,6])'), '-s', 'MarkerFaceColor', [0,0.7, 0.7],'MarkerEdgeColor', [0,0.7, 0.7], 'Color',  [0,0.7, 0.7] )


hold on; errorbar(mean(glucoseMeasure(:,[3,4,9,10])'), std(glucoseMeasure(:,[3,4,9,10])'), '^', 'MarkerFaceColor', 'blue')
hold on; errorbar(mean(glucoseMeasure(:,[5,6,11,12])'), std(glucoseMeasure(:,[5,6,11,12])'), '^', 'MarkerFaceColor', 'blue')





