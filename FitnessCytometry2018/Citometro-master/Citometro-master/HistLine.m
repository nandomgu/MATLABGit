function [] = HistLine(histbin, histcount, color)
% proviene del master de BW del SpringerLab
% [histcount, histbin] = hist( data );
         
        histcountPdf = smooth(histcount, 'moving');
      
%histcountPdf = histcountPdf/sum(histcountPdf)/(histbin(2)-histbin(1));
        
        p=plot(histbin, histcountPdf, '-');
        set(p,'Color', color)

%     Así lo hacía antes
%     n=length(centers);    w=centers(2)-centers(1);
%     t=linspace(centers(1)-w/2,centers(end)+w/2, n+1);
%     p = fix(n/2);     
%     hold off
%     dt = diff(t);
%     Fvals = cumsum([0,heights.*dt]);
%     F = spline(t, [0, Fvals, 0]);
%     DF = fnder(F);  % computes its first derivative
%     h.String = 'h(i)';
%     tL.String = 't(i)';
%     tR.String = 't(i+1)';    
%     hold on
%     fnplt(DF, 'g', 2);
    
    
    
end