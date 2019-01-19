% Exercise 12 - Constraints
% Edited by Tony Xiang
% Last Modified in 2018-7-15

F = @(x) 2 * x(1) ^ 2 - 2 * x(1) * x(2) + 2 * x(2) ^ 2 - 6 * x(1);

A = [3 4; -1 4];
B = [6; 2];
lb = zeros(2, 1);
x0 = [2 2];

[x, FVAL, EXITFLAG, OUTPUT] = fmincon(F, x0, A, B, [], [], lb, []);
x