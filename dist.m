function total = dist(x, Data)
    % This file is for calculating the distance of a city loop.
    % - Input -
    % x: traveling order
    % Data: distance data
    % - Output -
    % total: total distance
    
    num = size(x, 1);
    total = 0;
    for i = 1:num - 1
        total = total + Data(x(i), x(i + 1)); % Remove 'mod' function
    end
    total = total + Data(x(num), x(1)); % Save time
    
end