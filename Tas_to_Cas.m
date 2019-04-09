function cas = Tas_to_Cas(tas,H)
%Converts TAS to CAS, inputs are TAS and the altitude(in meters)
%   TAS--True Airspeed and CAS---Calibrated Airspeed
nu=1/3.5;
P_0=101325;
rho_0=1.225; %density
[T,P,rho,a]=atm_model(H,0);
x=((1+(nu/2)*(rho/P)*(tas^2))^(1/nu))-1;%first subpart of the formula
y=((1+(P/P_0)*x)^nu)-1; %second subpart
cas=((2/nu)*(P_0/rho_0)*y)^0.5; %Final form
end

