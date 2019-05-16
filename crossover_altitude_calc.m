function [trans_altitude] = crossover_altitude_calc(mach,cas)
%This function calculates Mach/CAS transition altitude(crossover) as a function of Mach and CAS.
%The inputs are Mach number and CAS. CAS should be m/s! The output altitude is in ft! 
T_0=288.15; %:Constants for sea-level conditions
R=287.05287;
beta=-0.0065;
g_0=9.80665;
kappa=1.4; %Adiabatic index of air(gamma but using kappa for consistency)
a_0=340.3;
delta_1=((1+((kappa-1)/2).*((cas./a_0).^2)).^(kappa/(kappa-1)))-1; %First part
delta_2=((1+((kappa-1)/2).*(mach.^2)).^(kappa/(kappa-1)))-1; %Second part
delta_trans=delta_1./delta_2;
theta_trans=delta_trans.^((-beta*R)/g_0);
trans_altitude=(1000/(0.3048*6.5)).*(T_0.*(1-theta_trans));%Final answer

