function tas = Mach_to_Tas(mach,H)
%Converts Mach to TAS---True Airspeed
%   Inputs are Mach number and the altitude(meters)
[T,P,rho,a]=atm_model(H,0);
tas=mach.*a;
end

