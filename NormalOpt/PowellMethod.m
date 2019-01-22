function [xval, fval] = PowellMethod(funct, initial, dirMatrix, eps, step)
    % An implementation of Powell method.
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
        for i = 1:dimension
            dec_funct = @(lambda) funct(xval + lambda * dirMatrix(i, :));
            [start, stop] = searchValidInterval(dec_funct, 0, step);
            lambda = searchGoldenMean(dec_funct, start, stop, eps);
            xval = xval + lambda * dirMatrix(i, :);
            % Update dirMatrix at the same time
            if (i < dimension - 1)
                dirMatrix(i, :) = dirMatrix(i + 1, :);
            end
        end
            
        % Construct final search direction
        direction = xval - prev_xval;
        dec_funct = @(lambda) funct(xval + lambda * direction);
        [start, stop] = searchValidInterval(dec_funct, 0, step);
        lambda = searchGoldenMean(dec_funct, start, stop, eps);
        xval = xval + lambda * direction;
        % Update dirMatrix
        dirMatrix(dimension, :) = direction;
        if (norm(dirMatrix) < eps)
            warning("Direction matrix is badly conditioned, norm=" + norm(dirMatrix));
        end
    end
    
    fval = funct(xval);
end