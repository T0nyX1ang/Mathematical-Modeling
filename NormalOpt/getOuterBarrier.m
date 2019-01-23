function outerBarrierFunct = getOuterBarrier(constraint, equality, dimension)
    % A function to get outer barrier function
    % constraint: a cell array of function_handle

    % Generate a syms array
    for i = 1:dimension
        symsarray(i) = sym("x" + num2str(i));
    end
    
    constraint_total = size(constraint, 2);
    equality_total = size(equality, 2);
    
    symbolic = sym("0");
    % Generate equality-symbolic
    for i = 1:equality_total
        funct = equality{i};
        sym_funct = funct(symsarray);
        symbolic = symbolic + abs(sym_funct) ^ 2;
    end
    
    % Generate constraint-outer-symbolic
    for i = 1:constraint_total
        funct = constraint{i};
        sym_funct = funct(symsarray);
        symbolic = symbolic + (sym_funct - abs(sym_funct)) ^ 2;
    end
    
    % Generate inner function handle
    outer_fh = matlabFunction(symbolic);
    % Convert to string
    outer_str = func2str(outer_fh);
    % Transfer from string to formatted function_handle
    pivot = 2;
    while (outer_str(pivot) ~= ')')
        pivot = pivot + 1;
    end
    outer_str = strrep(outer_str, outer_str(2:pivot), "(x)");
    for j = 1:dimension
        outer_str = strrep(outer_str, "x" + num2str(j), "x(" + num2str(j) + ")");
    end    
    
    outerBarrierFunct = str2func(outer_str);  
end