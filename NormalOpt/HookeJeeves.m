function [xval, fval] = HookeJeeves(funct, initial, epsilon, dirMatrix, delta, alpha, beta)
    % An implementation of Hooke-Jeeves method.
    % epsilon: error value    
    % dirMatrix: direction matrix of n-dimension line vectors
    % delta: initial step
    % alpha: step incremental factor
    % beta: step decremental factor
    dimension = size(initial, 2);
    
    if (nargin == 2)
        epsilon = 1e-6;
        dirMatrix = eye(dimension);
        delta = 1;
        alpha = 2;
        beta = 1 / 2;
    elseif (nargin == 3)
        dirMatrix = eye(dimension);
        delta = 1;
        alpha = 2;
        beta = 1 / 2;       
    elseif (nargin == 4)
        delta = 1;
        alpha = 2;
        beta = 1 / 2;       
    elseif (nargin == 5)
        alpha = 2;
        beta = 1 / 2;
    elseif (nargin == 6)
        beta = 1 / 2;
    end
    if (size(dirMatrix, 1) ~= dimension || size(dirMatrix, 2) ~= dimension)
        error("Invalid direction matrix");
    elseif (delta <= 0)
        error("delta must be greater than 0");
    elseif (alpha <= 1)
        error("alpha must be greater than 1");
    elseif (beta <= 0 || beta >= 1)
        error("beta must be between 0 and 1");
    elseif (epsilon <= 0)
        error("epsilon must be greater than 0");
    end

    
    xval = initial;
    yval = xval;
    while (delta >= epsilon)
        prev_xval = xval;
        for i = 1:dimension
            upval = yval + delta * dirMatrix(i, :);
            downval = yval - delta * dirMatrix(i, :);
            if (funct(upval) < funct(yval))
                yval = upval;
            elseif (funct(downval) < funct(yval))
                yval = downval;
            end
        end
        if (funct(yval) < funct(xval))
            xval = yval;
            yval = xval + alpha * (xval - prev_xval);
        else
            delta = beta * delta;
            yval = xval;
        end
    end
    
    fval = funct(xval);
end