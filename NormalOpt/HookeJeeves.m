function [xval, fval] = HookeJeeves(funct, initial, dirMatrix, delta, alpha, beta, eps)
    % An implementation of Hooke-Jeeves method.
    % dirMatrix: direction matrix of n-dimension line vectors
    % delta: initial step
    % alpha: step incremental factor
    % beta: step decremental factor
    % eps: error value
    dimension = size(initial, 2);
    
    if (nargin == 2)
        dirMatrix = eye(dimension);
        delta = 1;
        alpha = 2;
        beta = 1 / 2;
        eps = 1e-6;
    elseif (nargin == 3)
        delta = 1;
        alpha = 2;
        beta = 1 / 2;
        eps = 1e-6;        
    elseif (nargin == 4)
        alpha = 2;
        beta = 1 / 2;
        eps = 1e-6;         
    elseif (nargin == 5)
        beta = 1 / 2;
        eps = 1e-6;
    elseif (nargin == 6)
        eps = 1e-6;
    end
    if (size(dirMatrix, 1) ~= dimension || size(dirMatrix, 2) ~= dimension)
        error("Invalid direction matrix");
    elseif (delta <= 0)
        error("delta must be greater than 0");
    elseif (alpha < 1)
        error("alpha must be greater than 1");
    elseif (beta <= 0 || beta >= 1)
        error("beta must be between 0 and 1");
    elseif (eps < 0)
        error("eps must be greater than 0");
    end

    
    xval = initial;
    yval = xval;
    while (delta >= eps)
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