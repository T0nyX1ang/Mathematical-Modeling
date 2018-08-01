function NewChrom = MUT_Template(OldChrom, Pm, ~)
    % This is a connector for mutation module. To use it, change ALL the 'MUT_Template' to the methods you want to use.
    % Available: swap, scramble.

    Nind = size(OldChrom, 1);
    DoMutate = rand(Nind, 1) < Pm;
    NewChrom = OldChrom;
    
    for i = 1:Nind
        if DoMutate(i)
            NewChrom(i) = mutation(OldChrom(i), "MUT_Template");
        end
    end
end
