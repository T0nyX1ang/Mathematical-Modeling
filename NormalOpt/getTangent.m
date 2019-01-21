function tanFunct = getTangent(funct, dimension)
    % A function to calculate the tangent of a function symbolically.
    if (nargin == 1)
        dimension = 1;
    end
    
    tanFunct = cell(1, dimension);
    
    % Generate a syms array
    for i = 1:dimension
        symsarray(i) = sym("x" + num2str(i));
    end
    
    % Generate symbolic function
    symbolic = funct(symsarray);
    
    for i = 1:dimension
        % Generate differential -> convert to function_handle
        diff_fh = matlabFunction(diff(symbolic, symsarray(i)));
        % Convert to string
        diff_str = func2str(diff_fh);
        % Transfer from string to formatted function_handle
        pivot = 2;
        while (diff_str(pivot) ~= ')')
            pivot = pivot + 1;
        end
        diff_str = strrep(diff_str, diff_str(2:pivot), "(x)");
        for j = 1:dimension
            diff_str = strrep(diff_str, "x" + num2str(j), "x(" + num2str(j) + ")");
        end
        tanFunct{i} = str2func(diff_str);
    end
    
end