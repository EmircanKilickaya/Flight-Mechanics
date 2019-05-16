function [thrust] = maxclimb_takeoff_thrust(H)
%Calculates maximum climb and take-off thrust according to altitude
%   Altitude is in feet and thrust is in Newtons.
C_tc_1=0.57419*10^6; 
C_tc_2=0.57932*10^5;%Parameters taken from aircraft.OPF file
C_tc_3=0.85249*10^(-11);
thrust=C_tc_1.*(1-(H./C_tc_2)+C_tc_3.*(H.^2)); %Formula from BADA
end

