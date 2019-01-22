function [xval, fval] = NewtonDecrease(funct, initial, epsilon)
    % An implementation of newton decrease method.
    % epsilon: error value
    if (nargin == 2)
        epsilon = 1e-6;
    end
    if (epsilon < 0)
        error("epsilon must be greater than 0");
    end
    
    dimension = size(initial, 2);
    xval = initial;
    tangent = getTangent(funct, dimension);
    doubletangent = getDoubleTangent(funct, dimension);
    tval = getTangentValue(tangent, xval);
    dtval = getTangentValue(doubletangent, xval);
    while (norm(tval) >= epsilon)
        if (norm(dtval) < epsilon)
            warning("Matrix is badly conditioned now.");
        end
        xval = xval - tval * dtval^(-1);
        tval = getTangentValue(tangent, xval);
        dtval = getTangentValue(doubletangent, xval);        
    end
    
    fval = funct(xval);
end