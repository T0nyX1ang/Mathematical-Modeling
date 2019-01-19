function NewChrom = hlclb(OldChrom, MUT_F, DistTable, Iteration)
    % A function for HiLl-CLmBing optimization.
    LocalOptimal = dist(OldChrom', DistTable);
    KeepBest = 0;
    for i = 1:Iteration
        NewChrom = feval(MUT_F, OldChrom);
        NewAnswer = dist(NewChrom', DistTable);
        if NewAnswer < LocalOptimal
            OldChrom = NewChrom;
            LocalOptimal = NewAnswer;
            KeepBest = 0;
        else
            NewChrom = OldChrom;
            KeepBest = KeepBest + 1;
            if KeepBest >= 0.5 * Iteration, break; end
        end
    end
end