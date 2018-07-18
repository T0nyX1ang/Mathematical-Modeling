% Exercise 9 - ODE Solving
% Edited by Tony Xiang
% Last Modified in 2018-7-13

solver

function solver
f = @(t) (t < 4 * pi) * 2 .* sin(t) + (t >= 4 * pi) .* 0;
g = @(t) (t < 3.5 * pi) .* 0 + (t >= 3.5 * pi) .* cos(t);
% Tip: Use a boolean to define a function.
options = odeset('RelTol',1e-12,'AbsTol',[1e-15 1e-15]);
[T,Y] = ode45(@rigid,[0 20],[1 2],options); % Solve the function
[N, ~] = size(Y);
F = zeros(N, 1);
for i = 1:N
    F(i) = Y(i,1) + Y(i,2); % Calculate F(t)
end
pp = spline(T, F);
fnplt(pp)
hold on
grid on
plot(xlim, [0, 0], 'k');
x = fnzeros(pp); % Solutions Here
f_zero = ppval(pp, x(1,:)); 
plot(x(1,:), f_zero, 'ko')
    function dy = rigid(t, y)
        dy = zeros(2, 1);
        dy(1) = y(2) - f(t);
        dy(2) = y(1) * g(t) - y(2);
    end
end