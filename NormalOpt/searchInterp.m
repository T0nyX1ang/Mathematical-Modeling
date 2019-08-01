function point = searchInterp(funct, start, stop, epsilon)
    % 1-d search with interpolation method
    if (epsilon <= 0)
        error("epsilon must be greater than 0.");
    end
    
    tangent = getTangent(funct);
    if (stop < start) || (tangent{1}(start) >= 0) || (tangent{1}(stop) <= 0)
        error("Invalid initial condition");
    end
    
    while (abs(stop - start) >= epsilon)
        s = 3 * (funct(stop) - funct(start)) / (stop - start);
        z = s - tangent{1}(stop) - tangent{1}(start);
        w = sqrt(z .^ 2 - tangent{1}(start) .* tangent{1}(stop));
        next = start + (stop - start) * (1 - (tangent{1}(stop) + w + z) / (tangent{1}(stop) - tangent{1}(start) + 2 * w));
        if (tangent{1}(next) < 0)
            start = next;
        elseif (tangent{1}(next) > 0)
            stop = next;
        else
            break;
        end
    end
    
    point = next;
end