function [Min, Path] = dijkstra(GraphMatrix, StartPoint, EndPoint)
    % An implementation of Dijkstra's Shortest-Path Algorithm
    
    if size(GraphMatrix, 1) == size(GraphMatrix, 2)
        Size = size(GraphMatrix, 1);
    elseif ~isempty(find(GraphMatrix < 0))
        error('Unsupported type: Containing negative weight.')
    else
        error('Matrix length and width disagree.');
    end
    
    % Initializing
    LengthMatrix = inf(1, Size);
    S = StartPoint;
    T = setdiff(1:Size, S);
    key = S;
    LengthMatrix(key) = 0;
    TraceRoute = zeros(Size, 1);
    
    for i = 1:Size - 1
        for j = 1:size(T, 2)
            % calculating length matrix from $key$ to items in set T
            if LengthMatrix(T(j)) > LengthMatrix(key) + GraphMatrix(key, T(j))
                LengthMatrix(T(j)) = LengthMatrix(key) + GraphMatrix(key, T(j));
                % update rote
                TraceRoute(T(j)) = key;
            end
        end
        % finding minimum length
        [~, ind] = min(LengthMatrix(T));
        % find the index of the item in non-selected set
        key = T(ind);
        % popping minimum item to selected set S
        S = [S, key];
        % pushing minimum item from not-selected set T
        T = setdiff(T, key);  
    end
    % get shortest path
    Min = LengthMatrix(EndPoint);
    % if not linked, break here
    if Min == inf
        Path = inf;
        return;
    end
    % get route
    next = EndPoint;
    Path = EndPoint;
    while next ~= StartPoint
        next = TraceRoute(next);
        Path = [next, Path];
    end
    
end