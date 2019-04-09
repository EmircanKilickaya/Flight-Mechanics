%This file is not a function, it is only to use functions to generate
%the graphics needed in atmosphere model part.You can run if you want to
%see the graphs and output values below.There are 8 graphs.
H= linspace(0,11000,5000);
[T,P,rho,a]=atm_model(H,0);
figure(1) 
plot(H,T)
title('Altitude-Temperature Graph(ISA)')
xlabel('H (Meters)')
ylabel('T (Kelvin)')
grid on 
figure(2) 
plot(H,rho)
title('Altitude-Density Graph(ISA)')
xlabel('H (Meters)')
ylabel('Rho (kg/m^3)')
grid on
figure(3)
plot(H,P)
title('Altitude-Pressure Graph(ISA)')
xlabel('H (Meters)')
ylabel('P (Pascal)') 
grid on
figure(4)
plot(H,a)
title('Altitude-Speed of Sound Graph(ISA)')
xlabel('H (Meters)') 
ylabel('a') 
grid on
[T1,P1,rho1,a1]=atm_model(H,-10);
figure(5) 
plot(H,T1)
title('Altitude-Temperature Graph(NON-ISA)')
xlabel('H (Meters)')
ylabel('T (Kelvin)')
grid on 
figure(6) 
plot(H,rho1)
title('Altitude-Density Graph(NON-ISA)')
xlabel('H (Meters)')
ylabel('Rho (kg/m^3)')
grid on
figure(7)
plot(H,P1)
title('Altitude-Pressure Graph(NON-ISA)')
xlabel('H (Meters)')
ylabel('P (Pascal)') 
grid on
figure(8)
plot(H,a1)
title('Altitude-Speed of Sound Graph(NON-ISA)')
xlabel('H (Meters)') 
ylabel('a') 
grid on