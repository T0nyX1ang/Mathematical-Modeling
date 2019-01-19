function EulerPath = fleury(GraphMatrix)
    % An implementation of Fleury's Euler pathfinding problem.
    % Use matrix multiplication to show connectivity of a graph.
    
    if size(GraphMatrix, 1) == size(GraphMatrix, 2)
        Size = size(GraphMatrix, 1);
    else
        error('Matrix length and width disagree.');
    end    
    
    key = randi(Size);
    EulerPath = key;
    while norm(GraphMatrix) ~= 0
        wait = find(GraphMatrix(key, :) >= 1);
        for p = 1:size(wait, 2)
            temp = GraphMatrix;
            temp(key, wait(p)) = temp(key, wait(p)) - 1;
            temp(wait(p), key) = temp(wait(p), key) - 1;
            connect = Connect(temp);
            if connect
                % next point selected if not a bridge
                GraphMatrix = temp;
                key = wait(p);
                EulerPath = [EulerPath, key];
                break;
            end
        end
        if isempty(wait)
            EulerPath = inf;
            return;
            % error("No available route in this graph");
        elseif ~connect
            % bridge selection
            new = wait(randi(size(wait, 2)));
            GraphMatrix(key, new) = 0;
            GraphMatrix(new, key) = 0;
            key = new;
            EulerPath = [EulerPath, key];
        end
    end
    
    % Check graph connectivity
    function connectivity = Connect(Graph)
        GSize = size(Graph, 1);
        Single = eye(GSize);
        Test = zeros(size(Graph));
        for i = 1:GSize
            Single = Single * Graph;
            Test = Test + Single;
            if isempty(find(Test == 0, 1))
                connectivity = 1;
                return;
            end
        end
        connectivity = 0;
    end
end