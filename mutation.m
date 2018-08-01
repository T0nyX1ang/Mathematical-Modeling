function NewChrom = mutation(OldChrom, method)
    % A function for generic MUTATION
    % 2 methods are included
    % swap
    % scramble
    % -- 2-opt, k-opt, LK -- will be future plans

    len = length(OldChrom);
   
    if method == "swap"
        place = randperm(len, 2);
        NewChrom = OldChrom;
        NewChrom(place(1)) = OldChrom(place(2));
        NewChrom(place(2)) = OldChrom(place(1));
    end
    
    if method == "scramble"
        place = randperm(len, 2);
        NewChrom = OldChrom;
        range = min(place): max(place);
        shuffle = min(place) + randperm(size(range, 2)) - 1;
        NewChrom(range) = OldChrom(shuffle);
    end
        
end