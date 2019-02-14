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
       (~isempty(lb) && ~isempty(ub) && ((size(lb, 2) ~= 1) || (size(ub, 2) ~= 1) || ...
       (size(lb, 2) ~= size(c, 2)) || (size(ub, 2) ~= size(c, 2))))
        error("Invalid matrix.");
    end
    
    % Integrate lowerbounds and upperbounds into constraints
    
end