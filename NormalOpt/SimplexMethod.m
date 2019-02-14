function [xval, fval] = SimplexMethod(c, A, b)
    % Simplex method for linear programming.
    % This program is to solve functions like:
    % min f = cx such that Ax = b, x >= 0, b >= 0

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
    while (val > 0)
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
    if (extTable(end, end) ~= 0)
        error("Unable to find a valid initial point.");
    else
        tempX = zeros(size(extTable, 2), 1);
        tempX(inX) = extTable(1: end - 1, end);
        initX = tempX(1: size(c, 2)); % get initial point of original LP
    end
    initX 
end