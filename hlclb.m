function NewChrom = hlclb(OldChrom, MUT_F, DIST_F, Data)
    % A function for HiLl-CLmBing optimization.
    Iteration = 200;
    LocalOptimal = dist(OldChrom', Data, DIST_F);
    KeepBest = 0;
    for i = 1:Iteration
        NewChrom = feval(MUT_F, OldChrom);
        NewAnswer = dist(NewChrom', Data, DIST_F);
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