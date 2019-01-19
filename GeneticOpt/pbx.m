function [son1, son2] = pbx(parent1, parent2)
    % This is a function for position-based crossover.
    if length(parent1) ~= length(parent2)
        error('Incompatible parents.');
    else
        len = length(parent1);
    end
    
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