function point = searchNewton(funct, initial, epsilon)
    % 1-d search with Newton method
    % function should be C-2 smooth
    if (epsilon <= 0)
        error("epsilon must be greater than 0.");
    end
    
    tangent = getTangent(funct);
    doubletangent = getDoubleTangent(funct);
    while (abs(tangent{1}(initial)) >= epsilon)
        if (doubletangent{1, 1}(initial) < epsilon)
            warning("ill conditioned tangent");
        end
        initial = initial - tangent{1}(initial) ./ doubletangent{1, 1}(initial);
    end
    
    point = initial;
end