function NewChrom = swap(OldChrom)
    % This is a function for swap mutation.
    len = size(OldChrom, 2);
    NewChrom = OldChrom;
    place = randperm(len, 2);
    NewChrom(place(1)) = OldChrom(place(2));
    NewChrom(place(2)) = OldChrom(place(1));
end