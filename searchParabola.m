function point = searchParabola(funct, start, mid, stop, epsilon)
    % 1-d search with parabola function method
    % function must contain ONLY ONE MINIMUM.
    if (epsilon < 0)
        error("epsilon must be greater than 0.");
    end
    
    startVal = funct(start);
    midVal = funct(mid);
    stopVal = funct(stop);    
    minVal = min([startVal, midVal, stopVal]);
    if (minVal == startVal)
        swap(start, mid);
    elseif (minVal == stopVal)
        swap(stop, mid);
    end
    
    decVal = +inf;
    while (decVal >= epsilon)
        startVal = funct(start);
        midVal = funct(mid);
        stopVal = funct(stop);
        B1 = (mid .^2 - stop .^2) * startVal;
        B2 = (stop .^2 - start .^2) * midVal;
        B3 = (start .^2 - mid .^2) * stopVal;
        C1 = (mid - stop) * startVal;
        C2 = (stop - start) * midVal;
        C3 = (start - mid) * stopVal;
        nextX = (B1 + B2 + B3) / (C1 + C2 + C3) / 2;
        nextVal = funct(nextX);
        decVal = min([startVal, midVal, stopVal]) - nextVal;
        maxVal = max([startVal, midVal, stopVal]);
        if (maxVal == startVal)
            temp = mid;
            mid = nextX;
            start = temp;
        elseif (maxVal == stopVal)
            temp = mid;
            mid = nextX;
            stop = temp;
        else
            error("Invalid function.");
        end
    end
    
    point = nextX;
end