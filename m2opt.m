function NewChrom = m2opt(OldChrom)
    % This is a function for 2-opt mutation.
    len = size(OldChrom, 2);
    NewChrom = OldChrom;
    place = randperm(len, 2);
    place1 = min(place);
    place2 = max(place);
    NewChrom(place1: place2) = OldChrom(place2: -1: place1);
end