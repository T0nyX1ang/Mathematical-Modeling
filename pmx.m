function NewChrom = pmx(OldChrom, Px)

    Nind = size(OldChrom, 1);
    Xops = floor(Nind/2);
    DoCross = rand(Xops,1) < Px;
    odd = 1:2:Nind-1;
    even = 2:2:Nind;
    NewChrom = OldChrom;
    
    for i = 1:Xops
        if DoCross(i)
            [NewChrom(odd(i), :), NewChrom(even(i),:)] = intercross(OldChrom(odd(i), :), OldChrom(even(i), :), "pmx");   
        end
    end
    
end