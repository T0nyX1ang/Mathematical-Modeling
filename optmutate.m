function NewChrom = optmutate(MUT_F, OPT_F, DIST_F, Data, OldChrom, MutOpt, SUBPOP)
    % This file is modified from the original mutation from gatbx.
    % It's called optmutate which means this can do local optimalization in
    % mutation, and thus saving time. We remove some checking here because
    % we need more parameters to check here.

    % Check parameter consistency
    if nargin < 2,  error('Not enough input parameters'); end

    % Identify the population size (Nind) and the number of variables (Nvar)
    Nind = size(OldChrom, 1);

    if (Nind/SUBPOP) ~= fix(Nind/SUBPOP), error('OldChrom and SUBPOP disagree'); end
    Nind = Nind/SUBPOP;  % Compute number of individuals per subpopulation

    % Select individuals of one subpopulation and call low level function
    NewChrom = [];
    for irun = 1:SUBPOP
        ChromSub = OldChrom((irun-1)*Nind+1:irun*Nind,:);
        NewChromSub = mutation(ChromSub, MUT_F, OPT_F, DIST_F, Data, MutOpt);
        NewChrom=[NewChrom; NewChromSub];
    end
    
end