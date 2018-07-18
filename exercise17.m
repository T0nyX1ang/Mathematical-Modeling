% Exercise 17 - Probability
% Edited by Tony Xiang
% Last Modified in 2018-7-18

N = 20000;
x = zeros(N, 1);
y = zeros(N, 1);
x(1) = 1000;
y(1) = 2000;
m = ...
[
    0.5 0 0 0.5 0 0;
    0.5 0 0 0.5 0.5 0;
    0 0.5 0 0.5 0.25 0.5;
];

a = m(randperm(3, 1), 1);
b = m(randperm(3, 1), 2);
c = m(randperm(3, 1), 3);
d = m(randperm(3, 1), 4);
e = m(randperm(3, 1), 5);
f = m(randperm(3, 1), 6);

for i = 1:N - 1
    x(i + 1) = a * x(i) + b * y(i) + e;
    y(i + 1) = c * x(i) + d * y(i) + f;
end

plot(x, y);