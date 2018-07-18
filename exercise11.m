% Exercise 11 - Roots & Solutions
% Edited by Tony Xiang
% Last Modified in 2018-7-17

syms x y
eqns = [x^2 * cos(2 * x) + y^2 * sin(2 * y) - 1 == 0, x^3 + y^3 - 6 * cos(2 * x * y) + 1 == 0];
vars = [x y];
[solx, soly] = vpasolve(eqns, vars, [-2 -2; 2 2]);
% Symbolic Functions Solutions
solx
soly
