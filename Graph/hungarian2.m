function [MaxMatch, MatchMatrix] = hungarian2(GraphMatrix)
    % Another implementation of Edmonds' Hungarian Algorithm.
    % For bipartite graphs max matching problem.
    MatchMatrix = [];
    Target = 1:size(GraphMatrix, 1);
    while true
        % Step 1
        if isempty(Target)
            % Output
            MaxMatch = size(MatchMatrix, 1);
            return;
        else
            x = Target(1);
            S = x;
            T = [];
            Route = [];
                       
            while true
                % Step 2
                Neighbor = neighbor(S, GraphMatrix);
                if all(ismember(Neighbor, T))
                    Target = setdiff(Target, x);
                    break;
                else
                    Choice = setdiff(Neighbor, T);
                    y = Choice(1);
                end

                % Step 3
                if isempty(MatchMatrix)
                    MatchMatrix = [x, y];
                    Target = setdiff(Target, MatchMatrix(1));
                    break;
                else
                    z = find(MatchMatrix(:, 2) == y);
                end
                
                if ~isempty(z)
                    S = [S, z];
                    T = [T, y];
                    Route = [Route, y, z];
                else
                    Route = [x, Route, y, Route(end:-1:1)];
                    Route = reshape(Route', 2, size(Route, 2) / 2)';
                    MatchMatrix = setxor(MatchMatrix, Route, 'rows');
                    Target = setdiff(Target, Route(1));
                    break;
                end
            end
            
        end
    end
    
    function Neighbor = neighbor(Set, Graph)
        Neighbor = [];
        for i = 1:size(Set, 2)
            friends = find(Graph(Set(i), :) == 1);
            Neighbor = union(Neighbor, friends);
        end
    end
    
end