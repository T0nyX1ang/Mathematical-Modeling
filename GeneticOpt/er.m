function [son1, son2] = er(parent1, parent2)
    % This is a function for edge recombination crossover.
    if length(parent1) ~= length(parent2)
        error('Incompatible parents.');
    else
        len = length(parent1);
    end
    
    % Generate Neighbor Table
    neighbor = cell(len, 1);
    for i = 1:len
        place1 = find(parent1 == i); place2 = find(parent2 == i);
        neighbor{i} = [parent1(mod(place1 - 2, len) + 1), parent1(mod(place1, len) + 1), ...
                       parent2(mod(place2 - 2, len) + 1), parent2(mod(place2, len) + 1)];
        neighbor{i} = setdiff(sort(neighbor{i}), []);
    end
    % Choose first node from parents
    son1 = zeros(1, len); cycle = 1; first_key = randi(2); save_neighbor = neighbor;
    if first_key == 1, son1(1) = parent1(1); son2 = parent1;
    else, son1(1) = parent2(1); son2 = parent2; end
    reset = 0;
    % Loop to fill full a son
    while cycle < len
        HasEdge = neighbor{son1(cycle)};
        tempsize = zeros(1, size(HasEdge, 2));
        % Remove selected nodes from other nodes
        for i = 1:size(HasEdge, 2)
            neighbor{HasEdge(i)} = setdiff(neighbor{HasEdge(i)}, son1(cycle));
            tempsize(i) = size(neighbor{HasEdge(i)}, 2);
        end
        % Find nodes that have least edges
        minvalue = min(tempsize);
        % Find all the least edges if there are any
        least_edges = find(tempsize == minvalue);
        % Find a dead end, reset and cross over again
        if isempty(HasEdge)
            son1 = zeros(1, len); cycle = 1; first_key = randi(2);
            if first_key == 1, son1(1) = parent1(1); son2 = parent1;
            else, son1(1) = parent2(1); son2 = parent2; end
            neighbor = save_neighbor;
            reset = reset + 1;
            % Cross over exceeds reset limit
            if reset >= ceil(0.1 * len)
                if first_key == 1, son1 = parent2; else, son1 = parent1; end
                break;
            end
            continue;
        end
        % Select one node randomly;
        cycle = cycle + 1;
        son1(cycle) = HasEdge(least_edges(randi(size(least_edges, 2))));
    end
    
end