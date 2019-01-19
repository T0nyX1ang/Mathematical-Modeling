% Exercise 5 - Basic Structure
% Edited by Tony Xiang
% Last Modified in 2018-7-13

t0 = cputime;
for x = 1:1000000
    org_str = num2str(x);
    square_str = num2str(x^2);
    chk_str = square_str(end - length(org_str) + 1:end);
    if chk_str == org_str
        x
    end
end
t1 = cputime;
t = t1 - t0
% Output:1, 5, 6, 25, 76, 376, 625, 9376, 90625, 109376, 890625