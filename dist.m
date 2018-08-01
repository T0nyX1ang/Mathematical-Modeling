function total = dist(x, Data, method)
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
        if method == "euc" % Euclidean distance
            total = total + norm(Data(x(mod(i, num) + 1), :) - Data(x(i), :));
        elseif method == "manh" % Manhattan distance
            total = total + norm(Data(x(mod(i, num) + 1), :) - Data(x(i), :), 1);
        elseif method == "max" % Maximum distance
            total = total + norm(Data(x(mod(i, num) + 1), :) - Data(x(i), :), inf);
        elseif method == "geo" % Geological distance
            total = total + deg2km(distance(Data(x(i),1), Data(x(i),2), ...
                                   Data(x(mod(i, num) + 1),1), Data(x(mod(i, num) + 1),2)));
        elseif method == "custom" % Custom distance table
            if size(Data, 1) ~= size(Data, 2)
                error('Incompatible size. Row and Column should be the same.')
            else
                total = total + Data(x(i), x(mod(i, num) + 1));
            end
        end
    end
    
end