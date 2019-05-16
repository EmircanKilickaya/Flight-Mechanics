function [f] = climb_fuel_consumption(H)
%Fuel consumption during climb
%    H in feet and f in kg/min
Cf_1=0.54124;
Cf_2=0.85842*10^3;
climb = climb_speed_schedule(H); %Collecting the necessary speed in climb
climb=Cas_to_Tas(climb*0.514444444,H*0.3048); %Cas_To_Tas takes inputs as meters and m/s
V_tas=climb*1.94384449;%Converting it back to knots
nu=Cf_1*(1+(V_tas/Cf_2));
Thrust=maxclimb_takeoff_thrust(H)/1000; %Thrust is in kN due to the formula
f=Thrust*nu;
end

