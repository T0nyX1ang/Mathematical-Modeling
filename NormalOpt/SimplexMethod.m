function [xval, fval] = SimplexMethod(c, A, b)
% Simplex method for linear programming.
% This program is to solve functions like:
% min f = cx such that Ax = b, x >= 0, b >= 0

if (rank(A) ~= size(A, 1)) || (size(c, 2) ~= size(A, 2)) || ...
   (size(c, 1) ~= 1) || (size(A, 1) ~= size(b, 1)) || (size(b, 2) ~= 1)
    error("Invalid matrix.");
end

% Find a solution first.
extA = [A, eye(size(A, 1))];
extB = b;
extC = [zeros(size(c)), -ones(size(b')), 0];
table = [extA extB; extC]; % Generate a table
% Manipulate the table
for i = 1:size(A, 1)
    table(end, :) = table(end, :) + table(i, :);
end
% Pivot, step by step
[val, cind] = max(table(end, 1: end - 1));
while (val > 0)
    col = table(1:end - 1, end) ./ table(1: end - 1, cind);
    greater = find(col > 0);
    [~, row] = min(col(greater)); 
    rind = greater(row); % find row index
    point = table(rind, cind); % find the point
    table(rind, :) = table(rind, :) ./ point;
    % Elimination
    for i = 1:size(table, 1)
        if (i ~= rind)
            table(i, :) = table(i, :) - table(i, cind) .* table(rind, :); 
        end
    end
    [val, cind] = max(table(end, 1: end - 1));
end
table