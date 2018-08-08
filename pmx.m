function [son1, son2] = pmx(parent1, parent2)
    % This is a function for partially-mapped crossover.
    if length(parent1) ~= length(parent2)
        error('Incompatible parents.');
    else
        len = length(parent1);
    end
    
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