function [x,meanOut,medOut,stdOut,varOut] = scalableSeries(in,numChunk,options)


    arguments
        in
        numChunk {mustBeNonempty,mustBeReal,mustBeNonnegative,mustBeFinite}
        options.Mean = [];
        options.Median  = [];
        options.STD  = [];  
        options.Variance = [];
    end
    
    x = buffer(in,numChunk);
    
    if options.Mean == "true"
        meanOut = mean(x);
        meanOut = transpose(meanOut);   
    end
    if options.Median == "true"
        medOut = median(x);
        medOut = transpose(medOut);
    end
    if options.STD == "true"
        stdOut = std(x);
        stdOut = transpose(stdOut);
    end
    if options.Variance == "true"
    varOut = (std(x)).^2;
    varOut = transpose(varOut);
    end


end