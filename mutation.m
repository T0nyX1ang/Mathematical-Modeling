function NewChrom = mutation(OldChrom, MUT_F, OPT_F, Data, Pm)
    % A function for generic MUTATION and local/global optimization.
    % 4 mutation methods are included
    % swap
    % scramble
    % m2opt (mutation for 2-opt)
    % m3opt (mutation for 3-opt)
    % -- LK -- will be future plans
    
    Nind = size(OldChrom, 1);
    DoMutate = rand(Nind, 1) < Pm;
    NewChrom = OldChrom;
    
    for i = 1:Nind
        % If mutate, then to the local best value. Use optimization skills.
        if DoMutate(i)
            NewChrom(i, :) = feval(OPT_F, OldChrom(i, :), MUT_F, Data);
        end
    end
        
end