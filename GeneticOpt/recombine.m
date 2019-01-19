function NewChrom = recombine(REC_F, Chrom, RecOpt, SUBPOP)
    % Select individuals of one subpopulation and call low level function.
    % Modified from the original GA Toolbox(gatbx).
    Nind = size(Chrom, 1);
    if (Nind/SUBPOP) ~= fix(Nind/SUBPOP), error('Chrom and SUBPOP disagree'); end
    Nind = Nind/SUBPOP;  % Compute number of individuals per subpopulation
    NewChrom = [];
    for irun = 1:SUBPOP
        ChromSub = Chrom((irun-1)*Nind+1:irun*Nind,:);
        NewChromSub = intercross(REC_F, ChromSub, RecOpt);
        NewChrom=[NewChrom; NewChromSub];
    end
end