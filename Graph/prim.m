function [Min, Tree] = prim(GraphMatrix, StartPoint)
    % An implementation of Prim's Minimum Spanning Tree algorithm
    
    if size(GraphMatrix, 1) == size(GraphMatrix, 2)
        Size = size(GraphMatrix, 1);
    else
        error('Matrix length and width disagree.');
    end
    
    Min = 0;
    visited = zeros(Size, 1);
    visited(StartPoint) = 1;
    key = StartPoint;
    LengthMatrix = GraphMatrix(key, :);
    
    for i = 1:Size - 1
        MinLength = inf;    
        MinRoute = inf;
        % Find minimum length
        for j = 1:Size
            if ~visited(j) && MinLength > LengthMatrix(j)
                MinLength = LengthMatrix(j);
                key = j;
            end
        end
        
        % Record Tree
        for j = 1:Size
            if visited(j) && MinRoute > GraphMatrix(key, j)
                MinRoute = GraphMatrix(key, j);
                Tree(i, 1) = j;
            end
        end
        Tree(i, 2) = key;
        Tree
        % No points can be added
        if MinLength == inf
            break;
        end
        % update table
        Min = Min + MinLength;
        visited(key) = 1;
        % update minimum route
        for j = 1:Size
            if ~visited(j) && LengthMatrix(j) > GraphMatrix(key, j)
                LengthMatrix(j) = GraphMatrix(key, j);
                RouteMatrix(key) = j;
            end
        end
    end
    
end