
%plotting all independent fits
figure; hind=bar([[slopeGroup0{:}]; [slopeGroup2{:}]; [slopeGroup4{:}]; [slopeGroup5{:}]])


% bars as a handle, plotting mean
figure; h=bar([mean([slopeGroup0{:}]); mean([slopeGroup2{:}]); mean([slopeGroup4{:}]); mean([slopeGroup5{:}])])


figure; bar(log([mean([slopeCollection0{:}]); log(mean([slopeCollection2{:}])); log(mean([slopeCollection4{:}])); log(mean([slopeCollection6{:}]))])



[slopes, intercepts, rs, xs]=multiClickSlope(4,10, 5); hxt2slope=slopes;
[slopes, intercepts, rs, xs]=multiClickSlope(4,10, 5); hxt4slope=slopes;
[slopes, intercepts, rs, xs]=multiClickSlope(4,10, 5); hxt7slope=slopes;

%%%scatter plot of the slopes
figure; scatter([mean([slopeCollection0{:}]), mean([slopeCollection2{:}]),mean([slopeCollection4{:}]),mean([slopeCollection6{:}])], fliplr([hxt4slope{:}]), 50 , [1,0,0], '*')
hold on; scatter([mean([slopeCollection0{:}]), mean([slopeCollection2{:}]),mean([slopeCollection4{:}]),mean([slopeCollection6{:}])], fliplr([hxt7slope{:}]),50 , [0,0.6,0], 's', 'filled')
hold on; scatter([mean([slopeCollection0{:}]), mean([slopeCollection2{:}]),mean([slopeCollection4{:}]),mean([slopeCollection6{:}])], fliplr([hxt2slope{:}]), 50 , [0,0,.6], '^', 'filled')



%%%scatter plot by ramp duration
figure; scatter([mean([slopeCollection0{:}]), mean([slopeCollection2{:}]),mean([slopeCollection4{:}]),mean([slopeCollection6{:}])], fliplr([hxt4slope{:}]), 50 , [1,0,0], '*')
hold on; scatter([mean([slopeCollection0{:}]), mean([slopeCollection2{:}]),mean([slopeCollection4{:}]),mean([slopeCollection6{:}])], fliplr([hxt7slope{:}]),50 , [0,0.6,0], 's', 'filled')
hold on; scatter([mean([slopeCollection0{:}]), mean([slopeCollection2{:}]),mean([slopeCollection4{:}]),mean([slopeCollection6{:}])], fliplr([hxt2slope{:}]), 50 , [0,0,.6], '^', 'filled')
