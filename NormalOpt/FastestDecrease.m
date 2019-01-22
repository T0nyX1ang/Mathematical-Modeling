function [xval, fval] = FastestDecrease(funct, initial, epsilon, step)
    % An implementation of fastest decrease method.
    % epsilon: error value
    % step: search step when finding a valid interval
    if (nargin == 2)
        epsilon = 1e-6;
        step = 1e-3;
    elseif (nargin == 3)
        step = 1e-3;
    end    
    if (epsilon < 0)
        error("epsilon must be greater than 0");
    end
    if (step <= 0)
        error("step must be greater than 0");
    end
    
    dimension = size(initial, 2);
    xval = initial;
    tangent = getTangent(funct, dimension);
    tval = -getTangentValue(tangent, xval);
    while (norm(tval) >= epsilon)
        dec_funct = @(lambda) funct(xval + lambda * tval);
        [start, stop] = searchValidInterval(dec_funct, 0, step);
        lambda = searchGoldenMean(dec_funct, start, stop, epsilon);
        xval = xval + lambda * tval;
        tval = -getTangentValue(tangent, xval);
    end
    
    fval = funct(xval);
end