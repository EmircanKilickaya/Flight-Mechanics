function [f] = cruise_fuel_consumption(H,cruise,m)
%Fuel consumption during climb
%   H in feet and f in kg/min
Cf_cr=0.86812;
Cf_1=0.54124; %From aircraft.opf file
Cf_2=0.85842*10^3;
surf=427.82; %Surface
[T,P,rho,a]=atm_model(H*0.3048,0); %Calling atm_model to calculate rho
%cruise =cruise_speed_schedule(H); %Taking the speed of cruise in altitude that we are on.
%cruise=Cas_to_Tas(cruise*0.514444444,H*0.3048); %Converting to TAS but careful with units
cl=cl_calc(H*0.3048,cruise,0,m);
tas=cruise*1; 
cd0_cr=0.022913;
cd2_cr=0.042347;
cd=cd_calc(cl,cd0_cr,cd2_cr);
Thrust=cd*rho*(tas^2)*surf*0.5/1000; %Thrust=Drag 
nu=Cf_1*(1+(tas/Cf_2));
f=Thrust*Cf_cr*nu;
end

