function [son1, son2] = ox(parent1, parent2)
    % This is a function for order crossover.
    if length(parent1) ~= length(parent2)
        error('Incompatible parents.');
    else
        len = length(parent1);
    end
    
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