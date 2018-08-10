function NewChrom = newhlclb(OldChrom, MUT_F, DistTable, Iteration)
    % A function for NEW-HiLl-CLmBing optimization. Under Development now.
    for i = 1:Iteration
        NewChrom = feval(MUT_F, OldChrom, DistTable, Iteration, i);
        OldChrom = NewChrom; % Update Chromosome ... Important here.
    end
    
end