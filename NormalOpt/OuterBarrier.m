function [xval, fval] = OuterBarrier(funct, initial, constraint, equality, sigma, epsilon, step)
    % An implementation of outer barrier method
    % constraint: a cell array of inequality like g(x) >= 0
    % equality: a cell array of equality like h(x) = 0
    % epsilon: error value
    % step: search step when finding a valid interval
    if (nargin == 4)
        sigma = 1000;
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
    end
    if (epsilon < 0)
        error("epsilon must be greater than 0");
    elseif (sigma <= 0)
        error("sigma must be greater than 0");
    end
    
    dimension = size(initial, 2);
    xval = initial;
    outerBarrierFunct = getOuterBarrier(constraint, equality, dimension);
    while (sigma * outerBarrierFunct(xval) >= epsilon)
        prev_outer = outerBarrierFunct(xval);
        prev_xval = xval;
        opt_funct = @(x) funct(x) + sigma * outerBarrierFunct(x);
        [xval, ~] = ConjugateGradient(opt_funct, xval, epsilon, step);
        % adaptive factor
        decrease = prev_outer - outerBarrierFunct(xval);
        factor = 5 + floor(log10(decrease) / 3);
        if (factor < 1)
            factor = 1;
            step = step / 10;
        end
        sigma = sigma * factor;
        if (norm(xval - prev_xval) < epsilon)
            warning("x value is not decreasing, but termination condition not reached yet.");
            break;
        end
    end
    
    fval = funct(xval);
end