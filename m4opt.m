function NewChrom = m4opt(OldChrom)
    % This is a function for 4-opt mutation.
    len = size(OldChrom, 2);
    NewChrom = OldChrom;
    place = sort(randperm(len, 4));   

    rand_key = randi(8);
    switch rand_key
        case 1
            % normal form #1
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(3) + 1: place(4));
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(2) + 1: place(3));
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(1) + 1: place(2));
        case 2
            % reverse form #1
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(4): -1: place(3) + 1);
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(2) + 1: place(3));
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(1) + 1: place(2));
        case 3
            % reverse form #2
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(3) + 1: place(4));
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(3): -1 :place(2) + 1);
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(1) + 1: place(2));
        case 4
            % reverse form #3
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(3) + 1: place(4));
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(2) + 1: place(3));
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(2): -1: place(1) + 1);
        case 5
            % reverse form #4
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(4): -1: place(3) + 1);
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(3): -1 :place(2) + 1);
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(1) + 1: place(2));
        case 6
            % reverse form #5
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(4): -1: place(3) + 1);
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(2) + 1: place(3));
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(2): -1: place(1) + 1);
        case 7
            % reverse form #6
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(3) + 1: place(4));
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(3): -1 :place(2) + 1);
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(2): -1: place(1) + 1);
        case 8
            % reverse form #7
            NewChrom(place(1) + 1: place(1) + place(4) - place(3)) = OldChrom(place(4): -1: place(3) + 1);
            NewChrom(place(1) + place(4) - place(3) + 1: place(1) + place(4) - place(2)) = OldChrom(place(3): -1 :place(2) + 1);
            NewChrom(place(1) + place(4) - place(2) + 1: place(4)) = OldChrom(place(2): -1: place(1) + 1);
    end
    
end