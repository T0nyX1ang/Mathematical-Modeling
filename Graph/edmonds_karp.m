function [maxflow, FlowMatrix] = edmonds_karp(CapacityMatrix, Source, Sink)
    % An implementation of Edmonds-Karp's maximum network flow algorithm.
    % Simply use Dijkstra's shortest path algorithm.
    % Algorithm implementation is very slow.
    
    if size(CapacityMatrix, 1) == size(CapacityMatrix, 2)
        Size = size(CapacityMatrix, 1);
    else
        error('Matrix length and width disagree.');
    end
    
    maxflow = 0;
    FlowMatrix = zeros(Size, Size);
    
    % Construct connectivity matrix
    GraphMatrix = zeros(Size, Size);
    for i = 1:Size
        for j = i:Size
            if CapacityMatrix(i, j)
                GraphMatrix(i, j) = 1;
                GraphMatrix(j, i) = (Size + 1) * Size * Size; % Penalty Value
            else
                GraphMatrix(i, j) = inf;
                GraphMatrix(j, i) = inf;
            end
        end
    end
    
    while true
        % Get shortest path from the matrix
        [~, Route] = dijkstra(GraphMatrix, Source, Sink);
        % if not linked, break here -> exit of while-loop
        if Route == inf
            error("Minimum flow not found due to connectivity problems.");
        end
        
        % Find flow, construct residual network
        nowflow = inf;
        for i = 1:size(Route, 2) - 1
            nowflow = min(CapacityMatrix(Route(i), Route(i + 1)) - FlowMatrix(Route(i), Route(i + 1)), nowflow); 
        end
        
        % Update flow network 
        for i = 1:size(Route, 2) - 1
            FlowMatrix(Route(i), Route(i + 1)) = FlowMatrix(Route(i), Route(i + 1)) + nowflow;
            FlowMatrix(Route(i + 1), Route(i)) = FlowMatrix(Route(i + 1), Route(i)) - nowflow;
        end

        % Update maximum flow
        maxflow = maxflow + nowflow;
        
        % Augmenting path is found
        if size(Route, 2) == Size
            break;
        end
        
        % Update Graph Connectivity
        for i = 1:Size
            for j = i:Size
                if CapacityMatrix(i, j) - FlowMatrix(i, j) ~= 0
                    GraphMatrix(i, j) = 1;
                    GraphMatrix(j, i) = (Size + 1) * Size * Size; % Penalty Value
                else
                    GraphMatrix(i, j) = inf;
                    GraphMatrix(j, i) = inf;
                end
            end
        end
        
    end
    
    FlowMatrix = triu(FlowMatrix);
end