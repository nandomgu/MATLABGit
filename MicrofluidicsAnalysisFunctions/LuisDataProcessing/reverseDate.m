function out=reverseDate()

out= strjoin({num2str(year(date)) num2str(sprintf('%02d', month(date))) num2str(sprintf('%02d', day(date)))}, '');

end