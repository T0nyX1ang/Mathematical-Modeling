function point = searchGoldenMean(funct, start, stop, epsilon)
    % 1-d search with Golden-Mean method
    % function must contain ONLY ONE MINIMUM.
    if (epsilon < 0)
        error("epsilon must be greater than 0.");
    end
    if (stop < start)
        error("stop must be greater than start.")
    end
    
    GoldenMean = (sqrt(5) - 1) / 2;
    
    lambda = start + (1 - GoldenMean) * (stop - start);
    mu = start + GoldenMean * (stop - start);
    while (stop - start >= epsilon)
        if (funct(lambda) > funct(mu))
            start = lambda;
            lambda = mu;
            mu = start + GoldenMean * (stop - start);
        else
            stop = mu;
            mu = lambda;
            lambda = start + (1 - GoldenMean) * (stop - start);
        end
    end
    
    point = (start + stop) / 2;
end