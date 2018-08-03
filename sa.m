function NewChrom = sa(OldChrom, MUT_F, DIST_F, Data)
    % A function for Simulated Annealing optimization.
    LocalOptimal = dist(OldChrom', Data, DIST_F);   
    
    OriginalTemp = 10000; % Needs to be handled for different types of Optimazations.
    NowTemp = OriginalTemp;
    TargetTemp = 1e-3;
    DownSpeed = 0.9;
    
    % Change the route, use MetroPolis rules.
    while (NowTemp > TargetTemp)
        NewChrom = feval(MUT_F, OldChrom);
        NewAnswer = dist(NewChrom', Data, DIST_F);
        D_Energy = NewAnswer - LocalOptimal;
        if D_Energy < 0  % Accept at once 
            LocalOptimal = NewAnswer;
            OldChrom = NewChrom;
        elseif (exp(-D_Energy / NowTemp) >= rand) && (exp(-D_Energy/NowTemp) <= 1) % Accept at 'temperature' prob
            LocalOptimal = NewAnswer;
            OldChrom = NewChrom;            
        else % reject
            NewChrom = OldChrom;
        end
        NowTemp = DownSpeed * NowTemp;
    end
    
end