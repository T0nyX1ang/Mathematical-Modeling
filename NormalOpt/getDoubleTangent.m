function tanFunct = getDoubleTangent(funct, dimension)
    % A function to calculate the double tangent of a function symbolically.
    if (nargin == 1)
        dimension = 1;
    end
    
    tanFunct = cell(dimension, dimension);
    single = getTangent(funct, dimension);
    for i = 1:dimension
        double = getTangent(single{i}, dimension);
        for j = 1:dimension
            tanFunct{j, i} = double{j};
        end
    end
end