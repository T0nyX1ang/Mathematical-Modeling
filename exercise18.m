% Exercise 18 - Statistics
% Edited by Tony Xiang
% Last Modified in 2018-7-17

SCORE = ...
[
    93 75 83 93 91 85 84 82 77 76 ...
    77 95 94 89 91 88 86 83 96 81 ...
    79 97 78 75 67 69 68 84 83 81 ...
    75 66 85 70 94 84 83 82 80 78 ...
    74 73 76 70 86 76 90 89 71 66 ...
    86 73 80 94 79 78 77 63 53 55 ...
];

%% 1
mean(SCORE)
std(SCORE)
range(SCORE)
skewness(SCORE)
kurtosis(SCORE)
histogram(SCORE)

%% 2
alpha = 0.01;
[H, P, LSTAT, CV] = lillietest(SCORE, alpha) ;
% Pass Test

%% 3
[MUHAT, SIGMAHAT, MUCI, SIGMACI] = normfit(SCORE, alpha);
[h, sig, ci] = ttest(SCORE, MUHAT, alpha);
MUHAT
SIGMAHAT
% Pass Test