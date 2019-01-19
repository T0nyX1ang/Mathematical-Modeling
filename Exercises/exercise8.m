% Exercise 8 - Fitting
% Edited by Tony Xiang
% Last Modified in 2018-7-13
% -> More Files at D:\001 My things\009 Books and Essays\国赛建模\MATLAB培训程序\拟合1.m

Data = [
0.0000 5.8955
0.1000 3.5639
0.2000 2.5173
0.3000 1.9790
0.4000 1.8990
0.5000 1.3938
0.6000 1.1359
0.7000 1.0096
0.8000 1.0343
0.9000 0.8435
1.0000 0.6856
1.1000 0.6100
1.2000 0.5392
1.3000 0.3946
1.4000 0.3903
1.5000 0.5474
1.6000 0.3459
1.7000 0.1370
1.8000 0.2211
1.9000 0.1704
2.0000 0.2636];
t = Data(:,1);
y = Data(:,2);

% General model Exp2:
%      f(x) = a*exp(b*x) + c*exp(d*x)
% Coefficients (with 95% confidence bounds):
%        a =       3.007  (2.549, 3.465)
%        b =      -10.59  (-13.48, -7.692)
%        c =       2.889  (2.46, 3.318)
%        d =        -1.4  (-1.59, -1.21)
% 
% Goodness of fit:
%   SSE: 0.1477
%   R-square: 0.9961
%   Adjusted R-square: 0.9955
%   RMSE: 0.09322