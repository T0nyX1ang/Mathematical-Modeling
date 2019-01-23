function [xval, fval] = InnerBarrier(funct, initial, constraint, type, beta, epsilon, step)
    % An implementation of inner barrier method
    % constraint: a cell array of inequality like g(x) >= 0
    % type: inner barrier function type
    % epsilon: error value
    % step: search step when finding a valid interval
    % WARNING: This feature is deprecated due to some critical errors.
    if (nargin == 3)
        type = 1;
        beta = 1e-2;
        epsilon = 1e-6;
        step = 1e-3;        
    elseif (nargin == 4)
        beta = 0.5;
        epsilon = 1e-6;
        step = 1e-3;
    elseif (nargin == 5)
        epsilon = 1e-6;
        step = 1e-3;
    elseif (nargin == 6)
        step = 1e-3;
    end
    if (step <= 0)
        error("step must be greater than 0");
    elseif (type ~= 1 && type ~= 2)
        error("type must be 1 or 2");
    elseif (epsilon < 0)
        error("epsilon must be greater than 0");
    elseif (beta <= 0 || beta > 1)
        error("sigma must be greater than 0");
    end
    
    dimension = size(initial, 2);
    xval = initial;
    innerBarrierFunct = getInnerBarrier(constraint, dimension);
    while (beta * innerBarrierFunct(xval) >= epsilon)
        prev_outer = innerBarrierFunct(xval);
        prev_xval = xval;
        opt_funct = @(x) funct(x) + beta * innerBarrierFunct(x);
        [xval, ~] = ConjugateGradient(opt_funct, xval, epsilon, step);
        % adaptive factor
        decrease = prev_outer - innerBarrierFunct(xval);
        factor = 1 / (5 + floor(log10(decrease) / 3));
        if (factor > 1)
            factor = 1;
            step = step / 10;
        end
        beta = beta * factor;
        if (norm(xval - prev_xval) < epsilon)
            warning("x value is not decreasing, but termination condition not reached yet.");
            break;
        end
    end
    
    fval = funct(xval);
end