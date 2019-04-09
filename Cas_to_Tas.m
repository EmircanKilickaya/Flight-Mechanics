function [tas] = Cas_to_Tas(cas,H)
%Converts CAS values to TAS values with given inputs: CAS and the altitude
%H is the altitude in meters.
%  CAS--Calibrated Air Speed 
%  TAS--True Air Speed
nu=1/3.5;
P_0=101325;
rho_0=1.225;
[T,P,rho,a]=atm_model(H,0); %Getting atmosphere conditions for that altitude
x=((1+(nu/2).*(rho_0/P_0).*(cas.^2)).^(1/nu))-1; %First subpart of formula
y=((1+(P_0/P).*x).^nu)-1; %Second subpart
tas=((2/nu).*(P/rho).*y).^0.5; %Final form
end

