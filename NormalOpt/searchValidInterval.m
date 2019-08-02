function [start, stop] = searchValidInterval(funct, initial, step)
    % A function to calcualte a valid interval.
    if (step == 0)
        error("Step can't be 0.");
    end
    
    start = initial;
    stop = initial + step;
    
    if (funct(stop) >= funct(start))
        step = -step; % change direction of step
        [start, stop] = swap(start, stop); % change direction of interval
    end
    
    mid = start;
    while (funct(stop) < funct(mid)) && (abs(step) <= 1e10)
        start = mid;
        mid = stop;
        step = step * 2;
        stop = mid + step;
    end
    
    if (abs(step) > 1e10) % handle monotone
        start = -inf;
        stop = +inf;
    end
    
    if (start > stop)
        [start, stop] = swap(start, stop);
    end
    
end