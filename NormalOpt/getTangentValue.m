function tval = getTangentValue(tanFunct, point)
    % A function to get tangent value at a certain point
    tval = zeros(size(tanFunct));

    for i = 1:size(tanFunct, 1)
        for j = 1:size(tanFunct, 2)
            tval(i, j) = tanFunct{i, j}(point);    
        end
    end
    
end