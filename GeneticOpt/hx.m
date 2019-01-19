function [son1, son2] = hx(parent1, parent2, DistTable)
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
    end
    
    son1 = zeros(1, len);
    key = randi(len);
    son1(1) = key;
    
    for i = 2:len
        % Generate Candidate Sets
        candidate_set = unique(neighbor{son1(i - 1)});
        delete = [];
        size_cand = size(candidate_set, 2);
        for j = 1:size_cand
            if size(unique([son1(1:i - 1), candidate_set(j)]), 2) ~= size([son1(1:i - 1), candidate_set(j)], 2)
                delete = [delete candidate_set(j)];
            end
        end
        record = candidate_set;
        candidate_set = setdiff(candidate_set, delete);
        
        % Generate Distance Table in candidate_set
        resize_cand = size(candidate_set, 2);
        Dist = DistTable(son1(i - 1), candidate_set);
        
        switch resize_cand
            case 0
                % if no elements left, extend the route in nearest neighbors
                [~, NNList] = sort(DistTable(son1(i - 1), :));
                for k = 1:len
                    if size(unique([son1(1:i - 1), NNList(k)]), 2) == size([son1(1:i - 1), NNList(k)], 2)
                        son1(i) = NNList(k); break;
                    end
                end
            case 1
                % if only 1 element left, select it
                son1(i) = candidate_set(1);
            case {2, 3, 4}
                % if 2/3/4 elements left, find out the following:
                % if original size is 2/4, find the minimum in candidate sets
                % if original size is 3, find the mutual element
                intersection = intersect(neighbor{son1(i - 1)}(1:2), neighbor{son1(i - 1)}(3:4));
                if size_cand == 3 && isempty(find(record == intersection))
                    son1(i) = intersection;
                else
                    [~, index] = min(Dist);
                    son1(i) = candidate_set(index);
                end
        end
    end
    son2 = parent1;
    
end