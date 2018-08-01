function [son1, son2] = intercross(parent1, parent2, method)
    % intercross function designed for tsp
    % 6 methods are included
    % pmx: Partially Mapping Crossover
    % cx: Cyclic Crossover
    % ox: Order Crossover
    % obx: Order-Based Crossover
    % pbx: Position-Based Crossover
    % er: Edge Recombination
    % -- hx, mx -- will be future plans

    if length(parent1) ~= length(parent2)
        error('Incompatible parents.');
    else    
        len = length(parent1);
    end
     
    if method == "pmx"
        randint = randperm(len, 2);
        son1 = parent1; son2 = parent2;
        place1 = min(randint); place2 = max(randint);
        for i = place1: place2
            son1last = son1; son2last = son2;
            son1(i) = parent2(i); son2(i) = parent1(i);
            equal1 = find(son1 == son1(i)); equal2 = find(son2 == son2(i));
            equal1 = equal1(equal1 ~= i); equal2 = equal2(equal2 ~= i);
            if ~isempty(equal1), son1(equal1) = son1last(i); end
            if ~isempty(equal2), son2(equal2) = son2last(i); end
        end
    end
    
    if method == "cx"
        mark = zeros(1, len); cycle = 1; id = 1; NotZeros = find(mark == 0);
        while ~isempty(NotZeros)
            mark(id) = cycle; start_id = id;
            while true
                temp = parent2(id); id = find(parent1 == temp); mark(id) = cycle;
                if start_id == id, break; end
            end
            while (mark(id) == cycle)
                id = mod(id, len) + 1;
            end
            cycle = cycle + 1;
            NotZeros = find(mark == 0);
        end
        son1 = parent1; son2 = parent2;
        son1(find(mod(mark, 2))) = parent2(find(mod(mark, 2)));
        son2(find(mod(mark, 2))) = parent1(find(mod(mark, 2)));
    end
    
    if method == "ox"
        randint = randperm(len, 2);
        son1 = zeros(1, len); son2 = zeros(1, len);
        place1 = min(randint); place2 = max(randint);
        son1(place1: place2) = parent1(place1: place2);
        son2(place1: place2) = parent2(place1: place2);
        p1 = mod(place2, len) + 1; p2 = mod(place2, len) + 1;
        for i = 1:len
            Pnow = mod((place2 + i - 1), len) + 1;
            if isempty(find(son1(place1: place2) == parent2(Pnow)))
                son1(p1) = parent2(Pnow); p1 = mod(p1, len) + 1;
            end
            if isempty(find(son2(place1: place2) == parent1(Pnow)))
                son2(p2) = parent1(Pnow); p2 = mod(p2, len) + 1;
            end
        end
    end
    
    if method == "obx"
        totalCX = randi([floor(len * 0.25), ceil(len * 0.75)]);
        randint = sort(randperm(len, totalCX));
        place1 = randint; place2 = zeros(1, totalCX);
        son1 = parent1; son2 = parent2;
        for i = 1:totalCX
            place2(i) = find(parent2 == parent1(place1(i)));
        end
        place2 = sort(place2);
        son1(place1) = parent2(place2); son2(place2) = parent1(place1);
    end
    
    if method == "pbx"
        totalCX = randi([floor(len * 0.25), ceil(len * 0.55)]);
        randint = sort(randperm(len, totalCX));
        place1 = randint; place2 = zeros(1, totalCX);
        son1 = parent1; son2 = parent2;
        for i = 1:totalCX
            place2(i) = find(parent2 == parent1(place1(i)));
        end
        place1 = setdiff(1:8, place1); place2 = setdiff(1:8, place2);
        son1(place1) = parent2(place2); son2(place2) = parent1(place1);
    end
    
    if method == "er"
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
    
end