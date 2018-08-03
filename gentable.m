function NewTable = gentable(Data, method)
    % This file is for generating distance table
    % - Input -
    % Data: distance data
    % method: euc, manh, max, geo
    % - Output -
    % NewTable: generated distance table
    
    num = size(Data, 1);
    NewTable = zeros(num, num);
    for i = 1:num
        for j = i + 1:num
            if method == "euc" % Euclidean distance
                NewTable(i, j) = norm(Data(i, :) - Data(j, :)); 
            elseif method == "manh" % Manhattan distance
                NewTable(i, j) = norm((Data(i, :) - Data(j, :)), 1);
            elseif method == "max" % Maximum distance
                NewTable(i, j) = norm((Data(i, :) - Data(j, :)), inf);
            elseif method == "geo" % Geological distance
                NewTable(i, j) = deg2km(distance(Data(i,1), Data(i,2), Data(j,1), Data(j,2)));
            end
            NewTable(j, i) = NewTable(i, j);
        end
    end
    
end