function NewChrom = scramble(OldChrom)
    % This is a function for scramble mutation.
    len = size(OldChrom, 2);
    NewChrom = OldChrom;
    place = randperm(len, 2);
    range = min(place): max(place);
    shuffle = min(place) + randperm(size(range, 2)) - 1;
    NewChrom(range) = OldChrom(shuffle);

end