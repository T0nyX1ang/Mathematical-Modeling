% Exercise 6 - Array Functions and Spot
% Edited by Tony Xiang
% Last Modified in 2018-7-13

int_fun = @(t) (1 - t .^ 2) .^ (2/3);
x = linspace(0, 4 * pi);
y = arrayfun(@(x) integral(int_fun, 0, sin(x)), x);
plot(x, y)
