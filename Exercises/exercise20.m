% Exercise 20 - Statistics
% Edited by Tony Xiang
% Last Modified in 2018-7-17

mu = 300;
sigma = 35;

%% 1
a = 1 - cdf('norm', 250, mu, sigma)

%% 2
b = icdf('norm', 0.95, mu, sigma)