function [MaxMatch, MatchMatrix] = hungarian(GraphMatrix)
    % An implementation of Edmonds' Hungarian Algorithm.
    % For bipartite graphs max matching problem.
    
    MaxMatch = 0;
    VisitedMatrix = zeros(size(GraphMatrix, 2), 1);
    for i = 1:size(GraphMatrix, 1)
        % Broaden path method
        MaxMatch = MaxMatch + findpoint(i);
    end
    
    function find_answer = findpoint(i)
        % Finding a valid linking point.
        target = find(VisitedMatrix == 0);
        key = find(GraphMatrix(i, target) == 1, 1);
        
        if ~isempty(key)
            % If find, set visited matrix to true.
            find_answer = 1;
            VisitedMatrix(target(key)) = 1;
            % Distinguish linked edges.
            GraphMatrix(i, target(key)) = 2;
            return;
        else
            % If not, it's time to broaden the path.
            waiting = find(GraphMatrix(i, :) == 1);
            for k = 1:size(waiting, 2)          
                next = find(GraphMatrix(:, waiting(k)) == 2);
                if next >= i || isempty(next)
                    continue;
                elseif findpoint(next) == 1
                    find_answer = 1;
                    % Recover the route tag
                    GraphMatrix(next, waiting(k)) = 1;
                    GraphMatrix(i, waiting(k)) = 2;
                    return;
                end
            end
        end
        find_answer = 0;    
    end
    
    [row, col] = find(GraphMatrix == 2);
    MatchMatrix = sortrows([row, col]);
end