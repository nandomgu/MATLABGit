function finalmatr=whereDoCellsPeakPercentile(range, window, cellchan, bgchan,expnames, varargin)
numel(varargin)
if numel(window)==1
    
    repmat(window, 1, numel(varargin));
end



for ii=1:numel(varargin)
    
    
    
[cellval, cellerr, timehr,ind,celltimes]=ratePeakTimes(range, varargin{ii},cellchan,2);



[upval, uperr, uptimes, upShiftTime]=ratePeakTimes(range, varargin{ii}, bgchan,2);
[downval, downerr, downtimes, downShiftTime]=rateValleyTimes(range, varargin{ii}, bgchan,2);

upcells=(sum(celltimes>upShiftTime &celltimes<upShiftTime+window(ii)))/numel(celltimes);
downcells=(sum(celltimes>downShiftTime &celltimes<downShiftTime+window(ii)))/numel(celltimes);
restcells=1- (upcells+downcells);


finalmatr(ii, :)= [upcells downcells restcells];

end

figure; 

bar(finalmatr*100, 'stacked');

set(gca,'XTickLabel',expnames);

legend({'% cells that respond to upshift','%cells that respond to downShift','% cells that respond elsewhere'});





%now we find the cells that 



