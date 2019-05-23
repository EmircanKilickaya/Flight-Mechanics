function thrust = descent_thrust(H)
%Calculates descent thrust according to altitude
%   Thrust is in Newtons and altitude is in feet.
H_des=.37128E+05; %feet,
max_climb=maxclimb_takeoff_thrust(H); %Calculating max_climb thrust
C_tdes_low=0.10131; %These are constant values, you can change for your aircraft
C_tdes_high=-0.1569; %From aircraft.opf
if H>H_des
    thrust=C_tdes_high.*max_climb;
    display(thrust)
elseif H<=H_des
    thrust=C_tdes_low.*max_climb;
end

end

