function point = searchTangent(funct, start, stop, epsilon)
    % 1-d search with tangent method
    if (epsilon < 0)
        error("epsilon must be greater than 0.");
    end
    if (stop < start)
        error("stop must be greater than start.")
    end
    
    tangent = getTangent(funct);
    while (abs(tangent(stop)) >= epsilon)
        temp = stop;
        stop = stop - (stop - start) / (tangent(stop) - tangent(start)) * tangent(stop);
        start = temp;
    end
    
    point = stop;
end