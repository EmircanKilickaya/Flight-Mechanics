function cd = cd_calc(cl,cd0,cd2)
%Calculates cd---drag coefficient
%   Inputs are cl---lift coefficient and cd0,cd2 from aircraft OPF 
cd=cd0+cd2.*(cl.^2);
end

