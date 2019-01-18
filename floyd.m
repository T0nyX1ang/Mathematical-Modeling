function [MinGraph, PathMatrix] = floyd(GraphMatrix)
    % An implementation of Floyd-Warshall Algorithm
    
    if size(GraphMatrix, 1) == size(GraphMatrix, 2)
        Size = size(GraphMatrix, 1);
    else
        error('Matrix length and width disagree.');
    end
    
    MinMatrix = cell(Size + 1, 1);
    MinMatrix{1} = GraphMatrix;
    PathMatrix = cell(Size);
    
    for i = 1:Size
        for j = 1:Size
            PathMatrix{i, j} = [i, j];
            if i == j, PathMatrix{i, j} = i; end
        end
    end
    
    for k = 2:Size + 1
        for i = 1:Size
            for j = 1:Size
                if MinMatrix{k - 1}(i, j) > MinMatrix{k - 1}(i, k - 1) + MinMatrix{k - 1}(k - 1, j)
                    MinMatrix{k}(i, j) = MinMatrix{k - 1}(i, k - 1) + MinMatrix{k - 1}(k - 1, j);
                    if i < j
                        PathMatrix{i, j} = [PathMatrix{i, k - 1}, j];
                    elseif i > j
                        PathMatrix{i, j} = [i, PathMatrix{k - 1, j}];
                    end
                else
                    MinMatrix{k}(i, j) = MinMatrix{k - 1}(i, j);
                end
            end
        end
        
        if MinMatrix{k} == MinMatrix{k - 1}
            break;
        end
    end
    
    MinGraph = MinMatrix{k};
    
end