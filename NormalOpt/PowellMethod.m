function [xval, fval] = PowellMethod(funct, initial, epsilon, step, dirMatrix)
    % An implementation of Powell method.
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
        for i = 1:dimension
            dec_funct = @(lambda) funct(xval + lambda * dirMatrix(i, :));
            lambda = UniversalSearch(dec_funct, 0, epsilon, step, 'goldenmean', 0, 1e15);
            xval = xval + lambda * dirMatrix(i, :);
            % Update dirMatrix at the same time
            if (i < dimension - 1)
                dirMatrix(i, :) = dirMatrix(i + 1, :);
            end
        end
            
        % Construct final search direction
        direction = xval - prev_xval;
        dec_funct = @(lambda) funct(xval + lambda * direction);
        lambda = UniversalSearch(dec_funct, 0, epsilon, step, 'goldenmean', 0, 1e15);
        xval = xval + lambda * direction;
        % Update dirMatrix
        dirMatrix(dimension, :) = direction;
        if (norm(dirMatrix) < epsilon)
            warning("Direction matrix is badly conditioned, norm=" + norm(dirMatrix));
        end
    end
    
    fval = funct(xval);
end