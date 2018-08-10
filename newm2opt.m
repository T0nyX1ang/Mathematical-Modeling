function NewChrom = newm2opt(OldChrom, DistTable, Iteration, count)
    % This is a function for new-2-opt mutation. Under Development.
    len = size(OldChrom, 2);
    NewChrom = OldChrom;
    delta = -inf;
    counter = 0;
    while delta < -1e-6
        if counter >= ceil((0.5 * exp(-count / Iteration) * Iteration)), NewChrom = OldChrom; return; end
        place = randperm(len, 2);
        i = min(place);
        j = max(place);
        delta = DistTable(OldChrom(i), OldChrom(mod(i, len) + 1)) + ...
                DistTable(OldChrom(j), OldChrom(mod(j, len) + 1)) - ...
                DistTable(OldChrom(i), OldChrom(j)) - ...
                DistTable(OldChrom(mod(i, len) + 1), OldChrom(mod(j, len) + 1));
        counter = counter + 1;
    end
    NewChrom(i + 1: j) = OldChrom(j: -1: i + 1);
end