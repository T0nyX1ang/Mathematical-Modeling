function [xval, fval] = PowellSargentMethod(funct, initial, dirMatrix, eps, step)
    % An implementation of Powell-Sargent method.
    % dirMatrix: direction matrix of n-dimension line vectors
    % eps: error value
    % step: search step when finding a valid interval
    dimension = size(initial, 2);
    
    if (nargin == 2)
        dirMatrix = eye(dimension);
        eps = 1e-6;
        step = 1e-3;
    elseif (nargin == 3)
        eps = 1e-6;
        step = 1e-3;
    elseif (nargin == 4)
        step = 1e-3;
    end
    if (norm(dirMatrix) == 0)
        error("Line vectors must be linear independent");
    elseif (eps <= 0)
        error("eps must be greater than 0");
    elseif (step <= 0)
        error("step must be greater than 0");
    end
    
    prev_xval = inf;
    xval = initial;
    while (norm(xval - prev_xval) >= eps)
        prev_xval = xval;
        max_dec = -inf;
        max_index = 0;
        for i = 1:dimension
            dec_funct = @(lambda) funct(xval + lambda * dirMatrix(i, :));
            [start, stop] = searchValidInterval(dec_funct, 0, step);
            lambda = searchGoldenMean(dec_funct, start, stop, eps);
            now_dec = funct(xval) - funct(xval + lambda * dirMatrix(i, :));
            if (now_dec > max_dec)
                max_dec = now_dec; % Record maximum decrement.
                max_index = i;
            end
            xval = xval + lambda * dirMatrix(i, :);
        end
            
        % Construct final search direction
        direction = xval - prev_xval;
        dec_funct = @(lambda) funct(xval + lambda * direction);
        [start, stop] = searchValidInterval(dec_funct, 0, step);
        lambda = searchGoldenMean(dec_funct, start, stop, eps);
        xval = xval + lambda * direction;
        % Update dirMatrix
        if (abs(lambda) > sqrt((funct(xval) - funct(prev_xval)) / (max_dec)))
            for i = max_index:dimension - 1
                dirMatrix(i, :) = dirMatrix(i + 1, :);
            end
            dirMatrix(dimension, :) = direction;
        else
            for i = 1:dimension - 1
                dirMatrix(i, :) = dirMatrix(i + 1, :);
            end
            dirMatrix(dimension, :) = direction;
        end
        
        if (norm(dirMatrix) < eps)
            warning("Direction matrix is badly conditioned, norm=" + norm(dirMatrix));
        end
    end
    
    fval = funct(xval);
end