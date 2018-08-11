function NewChrom = newm3opt(OldChrom, DistTable, Iteration, count)
    % This is a function for new-3-opt mutation. Under Development.
    len = size(OldChrom, 2);
    NewChrom = OldChrom;
    delta = -inf;
    counter = 0;
    while delta < -1e-6
        if counter >= ceil((0.5 * exp(-count / Iteration) * Iteration)), NewChrom = OldChrom; return; end
        place = sort(randperm(len, 3));
        i = place(1);
        j = place(2);
        k = place(3);
        delta = DistTable(OldChrom(i), OldChrom(mod(i, len) + 1)) + ...
                DistTable(OldChrom(j), OldChrom(mod(j, len) + 1)) + ...
                DistTable(OldChrom(k), OldChrom(mod(k, len) + 1)) - ...
                DistTable(OldChrom(i), OldChrom(mod(j, len) + 1)) - ...
                DistTable(OldChrom(j), OldChrom(mod(k, len) + 1)) - ...
                DistTable(OldChrom(k), OldChrom(mod(i, len) + 1));
        counter = counter + 1;
    end
    sub_mat = [j + 1:k, i + 1:j];
    NewChrom(i + 1: k) = OldChrom(sub_mat);
end