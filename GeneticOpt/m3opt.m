function NewChrom = m3opt(OldChrom)
    % This is a function for 3-opt mutation.
    len = size(OldChrom, 2);
    NewChrom = OldChrom;
    place = sort(randperm(len, 3));
    
    rand_key = randi(4);
    switch rand_key
        case 1
            % normal form #1
            NewChrom(place(1) + 1: place(1) + place(3) - place(2)) = OldChrom(place(2) + 1: place(3));
            NewChrom(place(1) + place(3) - place(2) + 1: place(3)) = OldChrom(place(1) + 1: place(2));
        case 2
            % reverse form #1
            NewChrom(place(1) + 1: place(1) + place(3) - place(2)) = OldChrom(place(3): -1: place(2) + 1);
            NewChrom(place(1) + place(3) - place(2) + 1: place(3)) = OldChrom(place(2): -1: place(1) + 1);
        case 3
            % reverse form #2
            NewChrom(place(1) + 1: place(1) + place(3) - place(2)) = OldChrom(place(2) + 1: place(3));
            NewChrom(place(1) + place(3) - place(2) + 1: place(3)) = OldChrom(place(2): -1: place(1) + 1);
        case 4
            % reverse form #3
            NewChrom(place(1) + 1: place(1) + place(3) - place(2)) = OldChrom(place(3): -1: place(2) + 1);
            NewChrom(place(1) + place(3) - place(2) + 1: place(3)) = OldChrom(place(1) + 1: place(2));
    end
    
end