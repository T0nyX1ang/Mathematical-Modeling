% Exercise 10 - Optimizations
% Edited by Tony Xiang
% Last Modified in 2018-7-17

% fsolve can't solve bad-formed equations
N = 50;
alpha0 = zeros(N, 1);
options = optimset;
options.TolFun = 1.0e-8;
options.Tolx = 1.0e-8;
options.MaxFunEvals = N * 10000;
options.MaxIter = N * 4000;
alpha = fsolve(@(alpha) equation(N, alpha), alpha0, options);
equation(N, alpha)

function y = generic_func(k, N, alpha)
    y = 0;
    for iter = 1:N
        y = y + (-1)^(iter) * cos(k * alpha(iter)); 
    end
    y = y + 1;
end

function z = equation(N, alpha)
    for i = 1:N
        z(i) = generic_func(i, N, alpha);
    end
end
