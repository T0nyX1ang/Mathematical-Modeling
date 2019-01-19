function point = searchInterp(funct, start, stop, epsilon)
    % 1-d search with interpolation method
    if (epsilon < 0)
        error("epsilonilon must be greater than 0.");
    end
    
    tangent = getTangent(funct);
    if (stop < start) || (tangent(start) >= 0) || (tangent(stop) <= 0)
        error("Invalid initial condition");
    end
    
    while (abs(stop - start) > epsilon)
        s = 3 * (funct(stop) - funct(start)) / (stop - start);
        z = s - tangent(stop) - tangent(start);
        w = sqrt(z .^ 2 - tangent(start) .* tangent(stop));
        next = start + (stop - start) * (1 - (tangent(stop) + w + z) / (tangent(stop) - tangent(start) + 2 * w));
        if (tangent(next) < 0)
            start = next;
        elseif (tangent(next) > 0)
            stop = next;
        else
            break;
        end
    end
    
    point = next;
end