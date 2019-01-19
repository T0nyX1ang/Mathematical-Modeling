function [son1, son2] = cx(parent1, parent2)
    % This is a function for cyclic crossover.
    if length(parent1) ~= length(parent2)
        error('Incompatible parents.');
    else
        len = length(parent1);
    end

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