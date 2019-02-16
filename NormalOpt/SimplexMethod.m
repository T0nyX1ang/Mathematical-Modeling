function [xval, fval] = SimplexMethod(c, A, b, epsilon)
    % Simplex method for linear programming.
    % This program is to solve functions like:
    % min f = cx such that Ax = b, x >= 0, b >= 0
    % c, A, b: equation above
    % epsilon: error value when calculating a valid point
    
    if (nargin == 3)
        epsilon = 1e-6;
    end

    if (size(c, 2) ~= size(A, 2)) || (size(c, 1) ~= 1) || ...
       (size(A, 1) ~= size(b, 1)) || (size(b, 2) ~= 1)
        error("Invalid matrix.");
    end

    % Find a solution first.
    extA = [A, eye(size(A, 1))];
    extB = b;
    extC = [zeros(size(c)), -ones(size(b')), 0];
    inX = size(c, 2) + 1: size(c, 2) + size(A, 1);
    extTable = [extA extB; extC]; % Generate a table
    % Manipulate the table
    for i = 1:size(A, 1)
        extTable(end, :) = extTable(end, :) + extTable(i, :);
    end
    % Pivot, step by step
    [val, cind] = max(extTable(end, 1: end - 1));
    while (val >= epsilon)
        minval = inf;
        for i = 1:size(extTable, 1) - 1
            if (extTable(i, cind) >= 0)
                val = extTable(i, end) / extTable(i, cind);
                if (val < minval)
                    minval = val;
                    rind = i; % find row index
                end
            end
        end
        if (isinf(minval))
            error("Unable to find a valid initial point.");
        end
        point = extTable(rind, cind); % find the point
        inX(rind) = cind; % calculate inner columns at the same time
        extTable(rind, :) = extTable(rind, :) ./ point;
        % Elimination
        for i = 1:size(extTable, 1)
            if (i ~= rind)
                extTable(i, :) = extTable(i, :) - extTable(i, cind) .* extTable(rind, :); 
            end
        end
        [val, cind] = max(extTable(end, 1: end - 1));
    end
    if (abs(extTable(end, end)) >= epsilon)
        error("Unable to find a valid initial point.");
    else
        tempX = zeros(size(extTable, 2), 1);
        tempX(inX) = extTable(1: end - 1, end);
        initX = tempX(1: size(c, 2)); % get initial point of original LP
    end
    % change extTable to let useful vectors in
    for i = 1: size(A, 1)
        if (inX(i) > size(c, 2)) % move condition
            ckey = find(extTable(i, 1: size(c, 2)) ~= 0, 1);
            if (~isempty(ckey)) % get the key, apply the change
                point = extTable(i, ckey);
                inX(i) = ckey;
                extTable(i, :) = extTable(i, :) ./ point;
                % Elimination without the bottom
                for j = 1:size(extTable, 1) - 1
                    if (j ~= i)
                        extTable(j, :) = extTable(j, :) - extTable(j, ckey) .* extTable(i, :); 
                    end
                end
            else % don't get the key, remove the line
                warning("Surplus condition found. Removing it.")
                inX(i) = -1; % Tag the key
            end
        end
    end
    table = extTable(inX > 0, [1: size(A, 2), end]); % construct table
    % re-calculate conditional number
    table = [table; zeros(1, size(table, 2))]; % make room first
    table(end, end) = c * initX;
    inX = inX(inX > 0);
    w = c(inX) / table(1: end - 1, inX); % get factor w
    for j = 1: size(table, 2) - 1
        table(end, j) = w * table(1: end - 1, j) - c(j);
    end
    % Pivot, step by step
    [val, cind] = max(table(end, 1: end - 1));
    while (val >= epsilon)
        minval = inf;
        for i = 1:size(table, 1) - 1
            if (table(i, cind) >= 0)
                val = table(i, end) / table(i, cind);
                if (val < minval)
                    minval = val;
                    rind = i; % find row index
                end
            end
        end
        if (isinf(minval))
            error("This problem is unbounded.")
        end
        point = table(rind, cind); % find the point
        inX(rind) = cind; % calculate inner columns at the same time
        table(rind, :) = table(rind, :) ./ point;
        % Elimination
        for i = 1:size(table, 1)
            if (i ~= rind)
                table(i, :) = table(i, :) - table(i, cind) .* table(rind, :); 
            end
        end
        [val, cind] = max(table(end, 1: end - 1));
    end
    tempX = zeros(size(table, 2), 1);
    tempX(inX) = table(1: end - 1, end);
    xval = tempX(1: size(c, 2)); % get initial point of original LP
    fval = table(end, end);
end