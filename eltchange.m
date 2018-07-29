function [GlobalMaxFitnV, Chrom, ObjV] = eltchange(Chrom, ObjV, GlobalMaxFitnV, LocalMaxFitnV, LocalBestObjV, LocalBestIndividual, SUBPOP)
    % A function for ELiTe SELECTion in original GA
    % - Input -
    %   Chrom: population
    %   ObjV: object value
    %   GlobalMaxFitnV: global maximum fitness value
    %   LocalMaxFitnV: local maximum fitness value
    %   LocalBestObjV: local best object value
    %   LocalBestIndividual: local best individual
    %   SUBPOP: number of subpopulation
    %
    % - Output -
    %   GlobalMaxFitnV: updated global maximum fitness value
    %   Chrom: updated population
    %   ObjV: updated object value
    %   
    %   Author: Tony Xiang
    %   Time: 2018.07.29
    
    if nargin == 6
        SUBPOP = 1;
    elseif nargin < 4
        error('Insufficient variables.')
    end
    
    col = size(Chrom, 1);
    NPop = col / SUBPOP;
    
    for i = 1:SUBPOP
        if LocalMaxFitnV(i) >= GlobalMaxFitnV(i)
            GlobalMaxFitnV(i) = LocalMaxFitnV(i);
            FitnVNew = ranking(ObjV(1 + (i - 1) * NPop: i * NPop), 2, SUBPOP);
            [~, LocalMinIndex] = min(FitnVNew);
            ObjV(LocalMinIndex) = LocalBestObjV(i);
            Chrom(LocalMinIndex, :) = LocalBestIndividual(i, :);
        end
    end
end