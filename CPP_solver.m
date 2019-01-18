function [MinLength, Route] = CPP_solver(GraphMatrix)
    % A solver for Chinese Postman Problem
    % This solver is for UNDIRECTED graph only!
    % These algorithm functions are needed here:
    % Floyd-Warshall, Kuhn-Munkres, Fleury. 
    
    if size(GraphMatrix, 1) == size(GraphMatrix, 2)
        Size = size(GraphMatrix, 1);
    elseif ~isempty(find(GraphMatrix <= 0, 1))
        error('Unsupported type: Containing negative weight.')
    else
        error('Matrix length and width disagree.');
    end
    
    RouteRepeat = zeros(Size);
    RouteRepeat(~isinf(GraphMatrix)) = 1;    
    
    % Step 1: get minimum route for each point
    [RouteMatrix, RouteDetail] = floyd(GraphMatrix);
    
    % Step 2: generate odd points
    PointDeg = zeros(1, Size);
    for i = 1:Size
        PointDeg(i) = sum(~isinf(GraphMatrix(i, :)));
    end
    OddPoint = find(mod(PointDeg, 2) == 1);
    OddMatrix = RouteMatrix(OddPoint, OddPoint);
    OddMatrix(logical(eye(size(OddMatrix, 1)))) = inf;
    
    % Step 3: minimize matching odd points
    [~, MatchMatrix] = kuhn_munkres(OddMatrix);
    if isinf(MatchMatrix)
        MinLength = inf;
        Route = inf;
    else
        % Step 4: draw additional edges
        for i = 1:size(MatchMatrix, 1)
            RouteRepeat(OddPoint(MatchMatrix(i, 1)), OddPoint(MatchMatrix(i, 2))) = ...
                RouteRepeat(OddPoint(MatchMatrix(i, 1)), OddPoint(MatchMatrix(i, 2))) + 1;       
        end
    end
    
    % Step 5: get euler route
    Route = fleury(RouteRepeat);
    if Route == inf
        MinLength = inf;
        return;
    end
    TempRoute = [];
    for i = 1:size(Route, 2) - 1
        ThisRoute = RouteDetail{Route(i), Route(i + 1)};
        TempRoute = [TempRoute, ThisRoute(1:end - 1)];
    end
    Route = [TempRoute, Route(end)];
    
    % Step 6: calculate minimum route
    MinLength = 0;
    for i = 1:size(Route, 2) - 1
        MinLength = MinLength + GraphMatrix(Route(i), Route(i + 1));
    end

end