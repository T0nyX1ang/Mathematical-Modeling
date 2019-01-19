% Exercise 13 - Probability
% Edited by Tony Xiang
% Last Modified in 2018-7-17

N = 9;
total = 50;
G = zeros(9, 1);
for n = 1:total
    a = N ^ n;
    b = num2str(a);
    c = int32(str2double(b(1)));
    G(c) = G(c) + 1; 
end

P = G / sum(G)

% p1,30% > p2,17% > p3,12% > p4,9% > p5,8% > p6,7% > p7,6% > p8,5% > p9,4%