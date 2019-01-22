function [xval, fval] = DFPMethod(funct, initial, epsilon, step, initialMatrix)
    % An implementation of DFP(Davidon-Fletcher-Powell) method.
    % epsilon: error value
    % step: search step when finding a valid interval
    dimension = size(initial, 2);
    
    if (nargin == 2)
        epsilon = 1e-6;
        step = 1e-3;
        initialMatrix = eye(dimension);
    elseif (nargin == 3)
        step = 1e-3;
        initialMatrix = eye(dimension);
    elseif (nargin == 4)
        initialMatrix = eye(dimension);
    end
    if (epsilon < 0)
        error("epsilon must be greater than 0");
    end
    if (step <= 0)
        error("step must be greater than 0");
    end
    if (size(initialMatrix, 1) ~= dimension) || (norm(transpose(initialMatrix) - initialMatrix) ~= 0)
        error("Invalid initial matrix");
    end
    
    xval = initial;
    tangent = getTangent(funct, dimension);
    tval = getTangentValue(tangent, xval);
    Hval = initialMatrix;
    count = 0;
    while (norm(tval) >= epsilon)
        dval = -tval * Hval;
        dec_funct = @(lambda) funct(xval + lambda * dval);
        [start, stop] = searchValidInterval(dec_funct, 0, step);
        lambda = searchGoldenMean(dec_funct, start, stop, epsilon);
        if (count < dimension)
            prev_xval = xval;
            prev_tval = tval;
            xval = xval + lambda * dval;
            tval = getTangentValue(tangent, xval);
            pval = xval - prev_xval;
            qval = tval - prev_tval;
            % Apply update formula
            Hval = Hval + pval' * pval / (pval * qval') - Hval * qval' * qval * Hval / (qval * Hval * qval');
            count = count + 1;
        else
            count = 0;
            Hval = initialMatrix;
            tval = getTangentValue(tangent, xval);
        end
    end
    
    fval = funct(xval);
end