 function NewChrom = REC_Template(OldChrom, Px)
    % This is the connector for intercross module. To use it, change ALL the 'REC_Template' to the methods you want to use.
    % Available: pmx, cx, ox, obx, pbx, er.
    
    Nind = size(OldChrom, 1);
    Xops = floor(Nind/2);
    DoCross = rand(Xops,1) < Px;
    odd = 1:2:Nind-1;
    even = 2:2:Nind;
    NewChrom = OldChrom;
    
    for i = 1:Xops
        if DoCross(i)
            [NewChrom(odd(i), :), NewChrom(even(i),:)] = intercross(OldChrom(odd(i), :), OldChrom(even(i), :), "REC_Template");   
        end
    end
    
end
