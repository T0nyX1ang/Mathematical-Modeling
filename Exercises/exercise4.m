% Exercise 4 - Advanced Functions
% Edited by Tony Xiang
% Last Modified in 2018-7-13

%% Anonymous Functions
f1 = @(x) sum(x.^2);
f2 = @(x, y) sin(x) .* cos(y);
a = [1 2 3];
b = [3 4 5];
v1 = f1(a)
v2 = f2(a, b)
v3 = class(f1)

%% Change Anonomity
fun = @(x, c) 1 ./ (x.^3 - 2 * x - c);
c = 5;
fun1 = @(x) fun(x, c);
V = integral(fun1, 0, 2)

%% Multiple Anonymous Functions
g = @(x)@(y) sin(x .* y);
x = [1, 2, 3; 3, 4, 5];
g1 = g(x)
y = [3 4 5; 6 7 8];
Value = g1(y)

%% Array Functions
z = @(x, y) exp(-x ^ 2 - y ^ 2);
[x0, y0] = meshgrid(-10:0.1:10);
z0 = arrayfun(@(x, y)z(x, y), x0, y0); % Calculate z0 at (x0, y0)
mesh(x0, y0, z0)

%% Function in Functions
function_loop % Call Function First
function m = function_loop % Define Function Later
w = [pi/2, pi, 3*pi/2];
N = [pi/2 - 1, -2, -3*pi/2 - 1];
    function y = objfun(m)
        y = (quadl(@(t) t.^m.*cos(t), 0, m) - N(1)).^2 + ...
            (quadl(@(t) t.^m.*cos(t), 0, m * w(2)) - N(2)).^2 + ...
            (quadl(@(t) t.^m.*cos(t), 0, w(3)) - N(3)).^2;
    end
m = fminbnd(@objfun, 0, 2) % Minimum Value 
end