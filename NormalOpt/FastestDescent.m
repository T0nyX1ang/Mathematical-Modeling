function [xval, fval] = FastestDescent(funct, initial, epsilon, step)
    % An implementation of fastest descent method.
    % epsilon: error value
    % step: search step when finding a valid interval
    if (nargin == 2)
        epsilon = 1e-6;
        step = 1e-3;
    elseif (nargin == 3)
        step = 1e-3;
    end
    if (epsilon <= 0)
        error("epsilon must be greater than 0");
    end
    if (step <= 0)
        error("step must be greater than 0");
    end
    
    dimension = size(initial, 2);
    xval = initial;
    tangent = getTangent(funct, dimension);
    tval = -getTangentValue(tangent, xval);
    lambda = +inf;
    while (norm(tval) >= epsilon) && (lambda > 0)
        dec_funct = @(lambda) funct(xval + lambda * tval);
        lambda = UniversalSearch(dec_funct, 0, epsilon, step, 'goldenmean', 0, +inf);
        xval = xval + lambda * tval;
        tval = -getTangentValue(tangent, xval);
    end
    
    fval = funct(xval);
end