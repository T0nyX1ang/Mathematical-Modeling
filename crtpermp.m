function Chrom = crtpermp(Nind, Lind)
    % A function to CReaTe a PERMutational Population
    Chrom = zeros(Nind, Lind);
    for i = 1:Nind
        Chrom(i, :) = randperm(Lind);
    end
end