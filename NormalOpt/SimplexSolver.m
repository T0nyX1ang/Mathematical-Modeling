function [xval, fval] = SimplexSolver(c, A, b, Aeq, beq, lb, ub, epsilon)
    % Uniform simplex solver for simplex method.
    % Solves problem like:
    % min f = cx, such that A * x <= b, Aeq * x = beq, lb <= x <= ub
    % epsilon: error value when calculating a valid point
    % This program works in larger range than the core simplex method.

    % Autofill
    if (nargin == 3)
        Aeq = []; beq = []; lb = []; ub = []; epsilon = 1e-6;
    elseif (nargin == 5)
        lb = []; ub = []; epsilon = 1e-6;
    elseif (nargin == 6)
        ub = []; epsilon = 1e-6;
    elseif (nargin == 7)
        epsilon = 1e-6;
    end
    origC = c;
    
    % Validate
    if (~isempty(A) && ~isempty(b) && ... 
       ((size(c, 2) ~= size(A, 2)) || (size(c, 1) ~= 1) || ...
       (size(A, 1) ~= size(b, 1)) || (size(b, 2) ~= 1))) || ...
       (~isempty(Aeq) && ~isempty(beq) && ((size(c, 2) ~= size(Aeq, 2)) || ...
       (size(Aeq, 1) ~= size(beq, 1)) || (size(beq, 2) ~= 1))) || ...
       (~isempty(lb) && (size(lb, 2) ~= 1 || size(lb, 1) ~= size(c, 2))) || ...
       (~isempty(ub) && (size(ub, 2) ~= 1 || size(ub, 1) ~= size(c, 2)))
        error("Invalid matrix.");
    end
    
    % Integrate lowerbounds and upperbounds into constraints
    if (isempty(lb))
        lb = -inf(size(c))';
    end
    if (isempty(ub))
        ub = +inf(size(c))';
    end
    
    % create movement table for recovering the data later
    % line 1 demonstrates movement type 
    % value 0 for x - u type + v - x type
    % value 1 for x - u type
    % value 2 for v - x type
    % value 3 for x1 - x2 type
    % line 2 demonstrates movement place
    % value n for place n
    % value -1 for not taking a place
    
    movement_table = zeros(2, size(c, 2));
    place = size(c, 2) + 1;
    for i = 1: size(c, 2)
        if (ub(i) - lb(i) < 0)
            error("lowerbound is greater than upperbound.");
        end       
        if (lb(i) ~= -inf) && (ub(i) ~= +inf)
            movement_table(1, i) = 0;
            movement_table(2, i) = -1;
            % Add constraint for full bounded condition
            if (~isempty(A))
                b(:) = b(:) + A(:, i) * lb(i);
            end
            if (~isempty(Aeq))
                beq(:) = beq(:) + Aeq(:, i) * lb(i);
            end
            temprow = zeros(size(c));
            temprow(i) = 1;
            A = [A; temprow];
            b = [b; ub(i) - lb(i)];
        elseif (lb(i) ~= -inf) && (ub(i) == +inf)
            movement_table(1, i) = 1;
            movement_table(2, i) = -1;
            if (~isempty(A))
                b(:) = b(:) + A(:, i) * lb(i);
            end
            if (~isempty(Aeq))
                beq(:) = beq(:) + Aeq(:, i) * lb(i);
            end 
        elseif (lb(i) == -inf) && (ub(i) ~= +inf)
            movement_table(1, i) = 2;
            movement_table(2, i) = -1;
            c(i) = -c(i);
            if (~isempty(A))
                b(:) = b(:) - A(:, i) * ub(i);
                A(:, i) = -A(:, i);
            end
            if (~isempty(Aeq))
                beq(:) = beq(:) - Aeq(:, i) * ub(i);
                Aeq(:, i) = -Aeq(:, i);
            end
        elseif (lb(i) == -inf) && (ub(i) == +inf)
            movement_table(1, i) = 3;
            movement_table(2, i) = place;
            place = place + 1;
            % Add variable for unbounded condition
            c = [c, -c(i)];
            if (~isempty(A))
                A = [A, -A(:, i)];
            end
            if (~isempty(Aeq))
                Aeq = [Aeq, -Aeq(:, i)];
            end
        end
    end
    
    % Add surplus variables for inequalities and make it stardardized
    for i = 1: size(A, 1)
        tempcol = zeros(size(A, 1), 1);
        if b(i) < 0
            A(i, :) = -A(i, :);
            b(i) = -b(i);
            tempcol(i) = -1;
            A = [A, tempcol];
            c = [c, 0];
        else
            tempcol(i) = 1;
            A = [A, tempcol];
            c = [c, 0];
        end
        if (~isempty(Aeq))
            Aeq = [Aeq, zeros(size(Aeq, 1), 1)];
        end
    end
    
    % Make equality constraints startardized
    for i = 1: size(Aeq, 1)
        if (beq(i) < 0)
            Aeq(i, :) = -Aeq(i, :);
            beq(i) = -beq(i);
        end
    end
    
    % Solve the LP using the core simplex method module
    [tempxval, ~] = SimplexMethod(c, [A; Aeq], [b; beq], epsilon);

    xval = nan(size(origC, 2), 1);
    % From movement_table to recover final value
    for i = 1: size(movement_table, 2)
        switch (movement_table(1, i))
            case {0, 1}
                xval(i) = tempxval(i) + lb(i);
            case 2
                xval(i) = ub(i) - tempxval(i);
            case 3
                xval(i) = tempxval(i) - tempxval(movement_table(2, i));
        end
    end
    fval = origC * xval;
    
end