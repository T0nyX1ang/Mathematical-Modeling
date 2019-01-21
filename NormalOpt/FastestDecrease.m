function [xval, fval] = FastestDecrease(funct, initial, eps, step)
    % An implementation of fastest decrease method.
    % eps: error value
    % step: search step when finding a valid interval
    if (nargin == 2)
        eps = 1e-6;
        step = 1e-3;
    elseif (nargin == 3)
        step = 1e-3;
    end    
    if (eps < 0)
        error("eps must be greater than 0");
    end
    if (step <= 0)
        error("step must be greater than 0");
    end
    
    dimension = size(initial, 2);
    xval = initial;
    tangent = getTangent(funct, dimension);
    tval = getTangentValue(tangent, xval);
    while (norm(tval) >= eps)
        dec_funct = @(lambda) funct(xval + lambda * tval);
        [start, stop] = searchValidInterval(dec_funct, 0, step);
        lambda = searchGoldenMean(dec_funct, start, stop, eps);
        xval = xval + lambda * tval;
        tval = getTangentValue(tangent, xval);
    end
    
    fval = funct(xval);
end