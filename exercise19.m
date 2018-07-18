% Exercise 19 - Statistics
% Edited by Tony Xiang
% Last Modified in 2018-7-17

A = [119 117 115 116 112 121 115 122 116 118 109 112 119 112 117 113 114 109 109 118];
B = [118 119 115 122 118 121 120 122 128 116 120 123 121 119 117 119 128 126 118 125];

%% 1
mean(A)
std(A)
% January Pass
mean(B)
std(B)
% Feburary Fail

%% 2
alpha = 0.01;
[MUHAT1, SIGMAHAT1, MUCI1, SIGMACI1] = normfit(A, alpha);
[MUHAT2, SIGMAHAT2, MUCI2, SIGMACI2] = normfit(B, alpha);
[h1, sig1, ci1] = ttest(A, 115, alpha); % Pass
[h2, sig2, ci2] = ttest(B, 115, alpha); % Fail

%% 3
[MUHAT, SIGMAHAT, MUCI, SIGMACI] = normfit(A - B, alpha);
[h, sig, ci] = ttest(A - B, MUHAT, alpha);