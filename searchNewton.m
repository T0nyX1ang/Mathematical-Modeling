function point = searchNewton(funct, initial, epsilon)
    % 1-d search with Newton method
    % function should be C-2 smooth
    if (epsilon < 0)
        error("epsilon must be greater than 0.");
    end
    
    tangent = getTangent(funct);
    doubletangent = getTangent(tangent);
    while (abs(tangent(initial)) >= epsilon)
        if (doubletangent(initial) < epsilon)
            warning("Bad conditioned tangent");
        end
        initial = initial - tangent(initial) ./ doubletangent(initial);
    end
    
    point = initial;
end