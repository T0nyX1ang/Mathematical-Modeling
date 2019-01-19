function [Color, ColorMatrix] = welch_powell(GraphMatrix)
    % An implementation of Welch-Powell's graph color problem.
    % GCP is an NP-Hard problem, so this algorithm is only approximate.
    % Use greedy algorithm.
    
    if size(GraphMatrix, 1) == size(GraphMatrix, 2)
        Size = size(GraphMatrix, 1);
    else
        error('Matrix length and width disagree.');
    end    
    
    DegreeMatrix = zeros(Size, 1);
    ColorMatrix = zeros(Size, 1);
    
    for i = 1:Size
        DegreeMatrix(i) = DegreeMatrix(i) + sum(~isinf(GraphMatrix(i, :)));
    end
    [~, Index] = sort(DegreeMatrix, 'descend');
    key = Index(1);
    counter = 1;
    while ~isempty(find(ColorMatrix == 0))
        % Find not connected edges
        SearchList = find(ColorMatrix(:) == 0);
        ColorList = SearchList(find(isinf(GraphMatrix(key, SearchList))));
        % Color those points
        ColorMatrix(ColorList) = counter;
        % Update next point according to the degree table
        key = Index(find(ColorMatrix(Index) == 0, 1));
        % Update color
        counter = counter + 1;
    end
    
    Color = counter - 1;
end