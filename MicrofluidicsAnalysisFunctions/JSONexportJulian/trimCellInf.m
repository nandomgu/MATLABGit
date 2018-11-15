function final=trimCellInf(cExperiment)
        %removes the non cell dependent parameters from the cellInf, 
        %which seem to be causing trouble in the exportJSON funtction.
        
        channels=numel(cExperiment.cellInf);
        %pass per value to avoid destroying the real object
        final=cExperiment; 
        try
            final.cellInf=rmfield(final.cellInf,  'extractionParameters')
        end
        try
            final.cellInf= rmfield(final.cellInf,'date')
        end
        try
             final.cellInf=rmfield(final.cellInf, 'times')
        end
        try
             final.cellInf=rmfield(final.cellInf, 'extractedTimepoints')
             
        end
        try
             final.cellInf=rmfield(final.cellInf, 'annotations')
             
        end
end