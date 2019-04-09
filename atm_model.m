function [T,P,rho,a]=atm_model(H,delta_t)
%This function computes atmosphere properties for the given conditions,
%which are altitude(in meters) and delta_t(non-zero for non-ISA conditions).If it's used
%to calculate for ISA conditions,delta_t should be set to zero.
beta=-0.0065;
T_0=288.15;
P_0=101325;
g_0=9.80665;
R=287.05287;
kappa=1.4;
T=T_0+delta_t+beta.*H; %Temperature calculation
P=P_0*((T-delta_t)./T_0).^(-g_0/(beta*R)); %Pressure
rho=P./(R.*T); %Density
a=sqrt(kappa*R.*T); %Speed of Sound
end
