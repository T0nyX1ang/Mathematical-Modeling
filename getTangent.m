function tanFunct = getTangent(funct)
    % A function to calculate the tangent of a function symbolically.

    syms x;
    y = funct(x);
    z = diff(y);
    tanFunct = matlabFunction(z);
end