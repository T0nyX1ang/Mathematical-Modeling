function [xval, fval] = UniformSimplexConnector(c, A, b, Aeq, beq, lb, ub, eps)
    % Uniform simplex connector for simplex method.
    % Solves problem like:
    % min f = cx, such that A * x <= b, Aeq * x = beq, lb <= x <= ub
    % epsilon: error value when calculating a valid point
    % This program works in larger range than the core simplex method.

    % Autofill
    if (nargin == 3)
        Aeq = []; beq = []; lb = []; ub = []; eps = 1e-6;
    elseif (nargin == 5)
        lb = []; ub = []; eps = 1e-6;
    elseif (nargin == 7)
        eps = 1e-6;
    end
    
    % Validate
    if (size(c, 2) ~= size(A, 2)) || (size(c, 1) ~= 1) || ...
       (size(A, 1) ~= size(b, 1)) || (size(b, 2) ~= 1) || ...
       (~isempty(Aeq) && ~isempty(beq) && ((size(c, 2) ~= size(Aeq, 2)) || ...
       (size(Aeq, 1) ~= size(beq, 1)) || (size(beq, 2) ~= 1))) || ...
       (~isempty(lb) && ~isempty(ub) && ((size(lb, 1) ~= 1) || (size(ub, 1) ~= 1) || ...
       (size(lb, 2) ~= size(c, 2)) || (size(ub, 2) ~= size(c, 2))))
        error("Invalid matrix.");
    end
    
    % Integrate lowerbounds and upperbounds into constraints
    if (isempty(lb))
        lb = -inf(size(c));
    end
    if (isempty(ub))
        ub = +inf(size(c));
    end
    
    % create movement table
    % line 1 demonstrates movement type 
    % value 0 for x - u type + v - x type
    % value 1 for x - u type
    % value 2 for v - x type
    % value 3 for x1 - x2 type
    % line 2 demonstrates movement value
    % line 3 demonstrates movement place
    % value n for place n
    % value -1 for not taking a place
    movement_table = zeros(3, size(c, 2));
    place = size(c, 2) + 1;
    for i = 1: size(c, 2)
        if (ub(i) - lb(i) < 0)
            error("lowerbound is greater than upperbound.");
        end       
        if (lb(i) ~= -inf) && (ub(i) ~= +inf)
            movement_table(1, i) = 0;
            movement_table(2, i) = ub(i) - lb(i);
            movement_table(3, i) = place;
            place = place + 1;
        elseif (lb(i) ~= -inf) && (ub(i) == +inf)
            movement_table(1, i) = 1;
            movement_table(2, i) = -lb(i);
            movement_table(3, i) = -1;
        elseif (lb(i) == -inf) && (ub(i) ~= +inf)
            movement_table(1, i) = 2;
            movement_table(2, i) = ub(i);
            movement_table(3, i) = -1;
        elseif (lb(i) ~= -inf) && (ub(i) ~= +inf)
            movement_table(1, i) = 3;
            movement_table(2, i) = 0;
            movement_table(3, i) = place;
            place = place + 1;
        end
    end
    
    movement_table
end