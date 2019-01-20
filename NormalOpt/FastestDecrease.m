function [xval, fval] = FastestDecrease(funct, initial, eps, step)
    % An implementation of fastest decrease method.
    % eps: error value
    % step: search step
    if (eps < 0)
        error("eps must be greater than 0");
    end
    if (step <= 0)
        error("step must be greater than 0");
    end
    
    
end