function [LocalMaxFitnV, LocalBestObjV, LocalBestIndividual] = eltselect(FitnV, Chrom, ObjV, SUBPOP)
    % A function for ELiTe SELECTion in original GA
    % - Input -
    %   FitnV: fitness value
    %   ObjV: object value
    %   Chrom: population
    %   SUBPOP: number of subpopulation
    %
    % - Output -
    %   LocalMaxFitnV: local maximum fitness value of each subpopulation
    %   LocalBestObjV: local best object value
    %   LocalBestIndividual: local best individual
    %   
    %   Author: Tony Xiang
    %   Time: 2018.07.29
    
    if nargin == 2
        SUBPOP = 1;
    elseif nargin == 1
        error('Insufficient variables.')
    end
    
    [col, row] = size(Chrom);
    NPop = col / SUBPOP;
    LocalMaxFitnV = zeros(SUBPOP, 1);
    LocalBestObjV = zeros(SUBPOP, 1);
    LocalBestIndividual = zeros(SUBPOP, row);    
    for i = 1:SUBPOP
        [LocalMaxFitnV(i), LocalMaxIndex] = max(FitnV(1 + (i - 1) * NPop: i * NPop));
        LocalBestObjV(i) = ObjV(LocalMaxIndex);
        LocalBestIndividual(i, :) = Chrom(LocalMaxIndex, :);
    end
end