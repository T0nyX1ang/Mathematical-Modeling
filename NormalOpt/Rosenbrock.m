function [xval, fval] = Rosenbrock(funct, initial, dirMatrix, delta, alpha, beta, epsilon)
    % An implementation of Rosenbrock method.
    % dirMatrix: direction matrix of n-dimension line vectors
    % delta: initial step vector
    % alpha: step incremental factor
    % beta: step decremental factor
    % epsilon: error value
    dimension = size(initial, 2);
    
    if (nargin == 2)
        dirMatrix = eye(dimension);
        delta = ones(size(initial));
        alpha = 2;
        beta = -1 / 2;
        epsilon = 1e-6;
    elseif (nargin == 3)
        delta = ones(size(initial));
        alpha = 2;
        beta = -1 / 2;
        epsilon = 1e-6;        
    elseif (nargin == 4)
        alpha = 2;
        beta = -1 / 2;
        epsilon = 1e-6;         
    elseif (nargin == 5)
        beta = -1 / 2;
        epsilon = 1e-6;
    elseif (nargin == 6)
        epsilon = 1e-6;
    end
    if (norm(dirMatrix' * dirMatrix - eye(dimension)) ~= 0)
        error("Invalid direction matrix");
    elseif (norm(size(delta) - size(initial)) ~= 0)
        error("delta and initial don't agree");
    elseif (alpha < 1)
        error("alpha must be greater than 1");
    elseif (beta <= -1 || beta >= 0)
        error("beta must be between -1 and 0");
    elseif (epsilon < 0)
        error("epsilon must be greater than 0");
    end
    
    xval = initial;
    yval = xval;
    initial_step = delta;
    while (norm(delta) >= epsilon)
        prev_xval = xval;
        prev_yval = yval;
        for i = 1:dimension
            next = yval + delta(i) * dirMatrix(i, :);
            if (funct(next) < funct(yval))
                yval = next;
                delta(i) = alpha * delta(i);
            else
                delta(i) = beta * delta(i);
            end
        end
        
        if (funct(yval) == funct(prev_yval) && funct(yval) < funct(xval))
            xval = yval;
            direction = xval - prev_xval;
            lambda = zeros(size(initial));
            for j = 1:dimension
                lambda(j) = direction * dirMatrix(j, :)' / norm(dirMatrix(j, :));
            end
            new_dir = zeros(size(dirMatrix));
            for j = 1:dimension
                if (lambda(j) == 0)
                    new_dir(j, :) = dirMatrix(j, :);
                else
                    for i = j:dimension
                        new_dir(j, :) = new_dir(j, :) + lambda(i) * dirMatrix(i, :);
                    end
                end
            end
            
            % Orthogonalization
            for i = 1:dimension
                if (i == 1)
                    dirMatrix(i, :) = new_dir(i, :);
                else
                    dirMatrix(i, :) = new_dir(i, :);
                    for j = 1:i - 1
                        dirMatrix(i, :) = dirMatrix(i, :) - (dirMatrix(j, :) * new_dir(i, :)') / (dirMatrix(j, :) * dirMatrix(j, :)') * dirMatrix(i, :);
                    end
                end
            end
            delta = initial_step;
        end
    end
    
    fval = funct(xval);
end