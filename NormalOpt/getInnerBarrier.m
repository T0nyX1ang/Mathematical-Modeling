function innerBarrierFunct = getInnerBarrier(constraint, dimension, type)
    % A function to get inner barrier function
    % constraint: a cell array of function_handle
    % type: 1 -> 1/g(x); 2 -> log(g(x))
    if (nargin == 2)
        type = 1;
    end
    if (type ~= 1 && type ~= 2)
        error("Invalid type");
    end
    
    % Generate a syms array
    for i = 1:dimension
        symsarray(i) = sym("x" + num2str(i));
    end
    
    constraint_total = size(constraint, 2);
    symbolic = sym("0");
    % Generate symbolic function
    for i = 1:constraint_total
        funct = constraint{i};
        sym_funct = funct(symsarray);
        if (type == 1)
            symbolic = symbolic + 1 / sym_funct;
        elseif (type == 2)
            symbolic = symbolic - log(sym_funct);
        end
    end
    
    % Generate inner function handle
    inner_fh = matlabFunction(symbolic);
    % Convert to string
    inner_str = func2str(inner_fh);
    % Transfer from string to formatted function_handle
    pivot = 2;
    while (inner_str(pivot) ~= ')')
        pivot = pivot + 1;
    end
    inner_str = strrep(inner_str, inner_str(2:pivot), "(x)");
    for j = 1:dimension
        inner_str = strrep(inner_str, "x" + num2str(j), "x(" + num2str(j) + ")");
    end
    
    innerBarrierFunct = str2func(inner_str);  
end