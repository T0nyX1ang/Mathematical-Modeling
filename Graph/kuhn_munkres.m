function [BestMatch, MatchMatrix] = kuhn_munkres(GraphMatrix, options)
    % A matrix version of implementation of Kuhn-Munkres' Hungarian
    % algorithm.    

    Backup = GraphMatrix; % do a back up here
    BackupSize = size(GraphMatrix, 1);
    
    if nargin == 2
        % Maximize the matrix
        if options == "maximize"
            max_val = max(max(GraphMatrix));
            GraphMatrix = max_val - GraphMatrix;
        end
    end

    % Step 0: add dummy rows or columns with zeros in matrix
    add_num = size(GraphMatrix, 1) - size(GraphMatrix, 2);
    if add_num > 0
        GraphMatrix = [GraphMatrix, zeros(size(GraphMatrix, 1), add_num)];
    elseif add_num < 0
        GraphMatrix = [GraphMatrix; zeros(-add_num, size(GraphMatrix, 2))];
    end
    Size = size(GraphMatrix, 1); 
    
    % Step 1: subtraction row minimum of matrix.
    sub_row = min(transpose(GraphMatrix))';
    GraphMatrix = GraphMatrix - sub_row;
    
    % Step 2: subtraction column minimum of matrix.
    sub_col = min(GraphMatrix);
    GraphMatrix = GraphMatrix - sub_col;
    
    while true
        % Step 3: Cover all zeros with a minimum number of lines.
        [CoverLines, CoverMatrix] = cover(GraphMatrix);
        if CoverLines == Size
            break;
        end
        
        % Step 4: Create additional zeros.
        NzeroMatrix = GraphMatrix;
        NzeroMatrix(GraphMatrix == 0) = inf;
        NzeroMatrix(CoverMatrix ~= 0) = inf;
        sub_all = min(min(NzeroMatrix));
        for m = 1:Size
            for n = 1:Size
                if (CoverMatrix(m, n) == 0)
                    GraphMatrix(m, n) = GraphMatrix(m, n) - sub_all;
                elseif (CoverMatrix(m, n) == 2)
                    GraphMatrix(m, n) = GraphMatrix(m, n) + sub_all;
                end
            end
        end
    end
    
    % Step 5: get optimal assignment
    BestMatch = 0;
    MatchMatrix = zeros(BackupSize, 2);
    for iter = 1:BackupSize
        zerofinalrow = zeros(1, size(GraphMatrix, 1));
        zerofinalcol = zeros(1, size(GraphMatrix, 1));
        for k = 1:size(GraphMatrix, 1)
            zerofinalrow(k) = size(find(GraphMatrix(k, :) == 0), 2);
            zerofinalcol(k) = size(find(GraphMatrix(:, k) == 0), 1);
        end
        nzerofinal = [zerofinalrow, zerofinalcol];
        nzerofinal(nzerofinal == 0) = inf;
        [~, min_zero] = min(nzerofinal);
        
        if min_zero <= Size
            key = find(GraphMatrix(min_zero, :) == 0, 1);
            % Deal with infinite conditions
            if isempty(key)
                BestMatch = inf;
                MatchMatrix = inf;
                return;
            end
            BestMatch = BestMatch + Backup(min_zero, key);
            MatchMatrix(iter, 1) = min_zero;
            MatchMatrix(iter, 2) = key;
            GraphMatrix(min_zero, :) = inf;
            GraphMatrix(:, key) = inf;
        elseif min_zero <= 2 * Size
            min_zero = min_zero - Size;
            key = find(GraphMatrix(:, min_zero) == 0, 1);
            % Deal with infinite conditions
            if isempty(key)
                BestMatch = inf;
                MatchMatrix = inf;
                return;
            end            
            BestMatch = BestMatch + Backup(key, min_zero);
            MatchMatrix(iter, 2) = min_zero;
            MatchMatrix(iter, 1) = key;
            GraphMatrix(:, min_zero) = inf;
            GraphMatrix(key, :) = inf;
        end

    end
    
    MatchMatrix = sortrows(MatchMatrix);
    
    function [CoverLines, CoverMatrix] = cover(Graph)
        CoverMatrix = zeros(size(Graph));
        CoverPoint = 0;
        % Substep 1: assign as many as possible
        while (~isempty(find(Graph == 0, 1)))
            zerorow = zeros(1, size(Graph, 1));
            zerocol = zeros(1, size(Graph, 2));
            for i = 1:size(Graph, 1)
                % An easy way to calculate
                zerorow(i) = sum(Graph(i, :) == 0);
                zerocol(i) = sum(Graph(:, i) == 0);
            end
            
            nzero = [zerorow, zerocol];
            nzero(nzero == 0) = inf; 
            [~, ind] = min(nzero);
            % first deal with rows/columns with only 1 zero
            % then deal with multiple zeros
            
            if ind <= size(Graph, 1)
                % row action
                element = find(Graph(ind, :) == 0, 1);
                Graph(ind, element) = nan;
                Graph(Graph(:, element) == 0, element) = -inf;
            elseif ind <= 2 * size(Graph, 1)
                % column action
                ind = ind - size(Graph, 1);
                element = find(Graph(:, ind) == 0, 1);
                Graph(element, ind) = nan;
                Graph(element, Graph(element, :) == 0) = -inf;
            end

            CoverPoint = CoverPoint + 1;
            if CoverPoint == size(Graph, 1)
                CoverLines = size(Graph, 1);
                CoverMatrix = ones(size(Graph));
                return;
            end
            
        end
        
        % Substep 2: use least line to cover all zeros.
        TickRow = zeros(1, size(Graph, 1));
        TickColumn = zeros(1, size(Graph, 2));
        NewTickRow = ones(1, size(Graph, 1));
        NewTickColumn = ones(1, size(Graph, 2));
        
        for i = 1:size(Graph, 1)
            if isempty(find(isnan(Graph(i, :)) == 1, 1))
                TickRow(i) = 1;
            end
        end
        while ~(isequal(TickRow, NewTickRow) && isequal(TickColumn, NewTickColumn))
            NewTickRow = TickRow;
            NewTickColumn = TickColumn;
            for i = 1:size(Graph, 1)
                if TickRow(i)
                    TickColumn((Graph(i, :) == -inf)') = 1;
                end
            end
            for j = 1:size(Graph, 2)
                if TickColumn(j)
                    TickRow(isnan(Graph(:, j)) == 1) = 1;
                end
            end
        end
        
        FinalRow = [];
        FinalColumn = [];
        for i = 1:size(Graph, 1)
            if TickRow(i) == 0
                FinalRow = [FinalRow, i];
            end
            if TickColumn(i) == 1
                FinalColumn = [FinalColumn, i];
            end
        end
        CoverLines = size(FinalRow, 2) + size(FinalColumn, 2);
        CoverMatrix(FinalRow, :) = CoverMatrix(FinalRow, :) + 1;
        CoverMatrix(:, FinalColumn) = CoverMatrix(:, FinalColumn) + 1;
    end
    
        
end