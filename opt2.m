function NewChrom = opt2(OldChrom, Iteration, Data, DIST_Function)
    % A function for 2-opt process.
    len = size(OldChrom, 2);
    LocalOptimal = dist(OldChrom', Data, DIST_Function);
    KeepBest = 0;
    NewChrom = OldChrom;
    for i = 1:Iteration
        place = randperm(len, 2); place1 = min(place); place2 = max(place);
        NewChrom(place1: place2) = OldChrom(place2: -1: place1);
        NewAnswer = dist(NewChrom', Data, DIST_Function);
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