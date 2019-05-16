%This file is not a function.Its purpose is to create 3D graph for
%crossover altitude.
cas_space_knots= linspace(250,300,500);
cas_space_meters=cas_space_knots*0.514444444;
[X,Y]=meshgrid(0.73:.00005:0.78,128.611:154.3333);
Z=crossover_altitude_calc(Y,X)
figure
mesh(X,Y,Z,'FaceLighting','gouraud','LineWidth',0.1)
grid on
xlabel('Mach')
ylabel('CAS(m/s)')
zlabel('Crossover Altitude(Feet)')
alpha(0.5)