function [xval, fval] = PowellSargentMethod(funct, initial, epsilon, step, dirMatrix)
    % An implementation of Powell-Sargent method.
    % dirMatrix: direction matrix of n-dimension line vectors
    % epsilon: error value
    % step: search step when finding a valid interval
    dimension = size(initial, 2);
    
    if (nargin == 2)
        epsilon = 1e-6;
        step = 1e-3;        
        dirMatrix = eye(dimension);
    elseif (nargin == 3)
        step = 1e-3;        
        dirMatrix = eye(dimension);
    elseif (nargin == 4)
        dirMatrix = eye(dimension);
    end
    if (norm(dirMatrix) == 0)
        error("Line vectors must be linear independent");
    elseif (epsilon <= 0)
        error("epsilon must be greater than 0");
    elseif (step <= 0)
        error("step must be greater than 0");
    end
    
    prev_xval = inf;
    xval = initial;
    while (norm(xval - prev_xval) >= epsilon)
        prev_xval = xval;
        max_dec = -inf;
        max_index = 0;
        for i = 1:dimension
            dec_funct = @(lambda) funct(xval + lambda * dirMatrix(i, :));
            lambda = UniversalSearch(dec_funct, 0, epsilon, step, 'goldenmean', 0, 1e15);
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
        lambda = UniversalSearch(dec_funct, 0, epsilon, step, 'goldenmean', 0, 1e15);
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
        
        if (norm(dirMatrix) < epsilon)
            warning("Direction matrix is badly conditioned, norm=" + norm(dirMatrix));
        end
    end
    
    fval = funct(xval);
end