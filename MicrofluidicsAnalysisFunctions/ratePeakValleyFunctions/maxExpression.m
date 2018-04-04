function [val, err]=maxExpression(range, cExperiment)
%gets the max level of the mean of each cell and returns the mean and sem
%for all cells. range is the subsection of timepoints to use for this.

val=mean(max(cExperiment.cellInf(2).mean(:, range)'))
err=std(max(cExperiment.cellInf(2).mean(:, range)'))/sqrt(size(cExperiment.cellInf(2).mean(:, range), 1))

end




