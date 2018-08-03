function total = dist(x, Data)
    % This file is for calculating the distance of a city loop.
    % - Input -
    % x: traveling order
    % Data: distance data
    % method: euc, manh, max, geo, custom
    % - Output -
    % total: total distance
    %
    % NOTICE: 'geo' version will take much time. 
    %          You should take that into consideration.
    
    num = size(x, 1);
    total = 0;
    for i = 1:num
        if size(Data, 1) ~= size(Data, 2)
            error('Incompatible size. Row and Column should be the same.')
        else
            total = total + Data(x(i), x(mod(i, num) + 1));
        end
    end
    
end