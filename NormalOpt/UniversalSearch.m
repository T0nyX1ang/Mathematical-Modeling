function point = UniversalSearch(funct, initial, epsilon, step, method, lb, ub)
    % Universal 1-d search for a function.
    if (nargin == 4)
        method = 'goldenmean';
        lb = -inf;
        ub = +inf;
    elseif (nargin == 5)
        lb = -inf;
        ub = +inf;
    elseif (nargin == 7) 
        if ((isinf(lb) || isinf(ub)) && ~strcmp(method, 'goldenmean'))
            error('Bounded search must use Golden Mean Method.')
        end
    end
    
    [start, stop] = searchValidInterval(funct, initial, step);
    if (stop < lb)
        start = lb; stop = ub;
    elseif (start > ub)
        start = lb; stop = ub;
    end
    if (start < lb)
        start = lb;
    end
    if (stop > ub)
        stop = ub;
    end
    if (strcmp(method, 'goldenmean'))
        point = searchGoldenMean(funct, start, stop, epsilon);
    elseif (strcmp(method, 'tangent'))
        point = searchTangent(funct, start, stop, epsilon);
    elseif (strcmp(method, 'newton'))
        point = searchNewton(funct, (start + stop) / 2, epsilon);
    elseif (strcmp(method, 'parabola'))
        if (funct(start) >= funct(stop))
            [mid, stop] = searchValidInterval(funct, stop, step);
        else
            [start, mid] = searchValidInterval(funct, start, step);
        end
        point = searchParabola(funct, start, mid, stop, epsilon);
    elseif (strcmp(method, 'interp'))
        point = searchInterp(funct, start, stop, epsilon);
    else
        error('Undefined searching method.')
    end
    
end