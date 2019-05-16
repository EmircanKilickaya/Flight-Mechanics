function [f] = descent_fuel_consumption(H)
%Fuel consumption during descent
%   H in feet and f in kg/min
Cf_3=34.6;
Cf_4=0.62907*10^5; %Values from aircraft.opf file
f=Cf_3*(1-(H/Cf_4)); %Formula from BADA
end

