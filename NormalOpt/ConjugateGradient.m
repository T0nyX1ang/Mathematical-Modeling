function [xval, fval] = ConjugateGradient(funct, initial, epsilon, step)
    % An implementation conjugate gradient (CG-FR) method.
    % epsilon: error value
    % step: search step when finding a valid interval
    if (nargin == 2)
        epsilon = 1e-6;
        step = 1e-3;
    elseif (nargin == 3)
        step = 1e-3;
    end
    if (epsilon < 0)
        error("epsilon must be greater than 0");
    end
    if (step < 0)
        error("step must be greater than 0");
    end
    
    dimension = size(initial, 2);
    xval = initial;
    tangent = getTangent(funct, dimension);
    tval = -getTangentValue(tangent, xval);
    while (norm(tval) >= epsilon)
        % Doing multiple fastest decrease direction.
        yval = xval;
        tyval = tval;
        count = 0;
        while (norm(tyval) >= epsilon) && (count < dimension)
            % Define decrease function and search for a point
            dec_funct = @(lambda) funct(yval + lambda * tyval);
            [start, stop] = searchValidInterval(dec_funct, 0, step);
            lambda = searchGoldenMean(dec_funct, start, stop, epsilon);
            % Update yval here
            prev_yval = yval;
            yval = yval + lambda * tyval;
            % Update tyval here
            beta = norm(getTangentValue(tangent, yval)) ^ 2 / norm(getTangentValue(tangent, prev_yval)) ^ 2;
            tyval = -getTangentValue(tangent, yval) + beta * tyval;
            if (getTangentValue(tangent, yval) * tyval' >= 0)
                break; % restart calculation when meeting with a increasing direction
            end
            count = count + 1;
        end
        xval = yval;
        tval = -getTangentValue(tangent, xval);
    end
    
    fval = funct(xval);
end