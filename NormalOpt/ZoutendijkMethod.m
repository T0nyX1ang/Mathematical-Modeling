function [xval, fval] = ZoutendijkMethod(funct, initial, A, b, Aeq, beq, eps, step)
    % Zoutendijk method for NLP with linear constraints
    % Solving problem like:
    % min f(x) such that A x' >= b, Aeq x' = beq.
    % eps is overall error value
    % step: search step when finding a valid interval
    
    t_xval = initial';
    dimension = size(initial, 2);
    if (nargin == 4)
        Aeq = []; beq = []; eps = 1e-6; step = 1e-3;
    elseif (nargin == 6)
        eps = 1e-6; step = 1e-3;
    elseif (nargin == 7)
        step = 1e-3;
    end
    
    % Check conditions
    if (~isempty(A))
        shorter = A * t_xval < b;
        if (~isempty(find(shorter ~= 0, 1)))
            error("Invalid inequality condition.");
        end
    end
    if (~isempty(Aeq) && (Aeq * t_xval ~= beq))
        error("Invalid equality condition.");
    end

    tangent = getTangent(funct, dimension);
    tval = getTangentValue(tangent, t_xval');
    % decomposition
    greater = A * t_xval - b > eps;
    equal = abs(A * t_xval - b) <= eps;
    A2 = A(greater, :);
    b2 = b(greater, :);
    A1 = A(equal, :);
    %b1 = b(equal, :);
    % Solve LP to get d
    [d, ~] = SimplexSolver(tval, -A1, zeros(size(A1, 2), 1), Aeq, zeros(size(Aeq, 2), 1), ...
                           -ones(dimension, 1), ones(dimension, 1), eps);
    
    while (norm(tval * d) >= eps)
        % Calculate maximum step range
        b_bar = b2 - A2 * t_xval;
        d_bar = A2 * d;
        inf_col = ones(size(b_bar));
        inf_col(d_bar >= 0) = inf;
        lambda_max = min(b_bar ./ d_bar .* inf_col);
        % minimize function value
        dec_funct = @(lambda) funct(t_xval' + lambda * d');
        [start, stop] = searchValidInterval(dec_funct, 0, step);
        start = start * (start > 0);
        stop = lambda_max + (stop - lambda_max) * (stop < lambda_max);
        lambda = searchGoldenMean(dec_funct, start, stop, eps);
        t_xval = t_xval + lambda * d;
        tval = getTangentValue(tangent, t_xval');
        % decomposition
        greater = A * t_xval - b > eps;
        equal = abs(A * t_xval - b) <= eps;
        A2 = A(greater, :);
        b2 = b(greater, :);
        A1 = A(equal, :);
        %b1 = b(equal, :);
        % Solve LP to get d
        [d, ~] = SimplexSolver(tval, -A1, zeros(size(A1, 2), 1), Aeq, zeros(size(Aeq, 2), 1), ...
                               -ones(dimension, 1), ones(dimension, 1), eps);
    end
    
    xval = t_xval';
    fval = funct(xval);
end