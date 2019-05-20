% State initialization
N = 1000;
x = zeros(N, 1);
y = zeros(N, 1);
h = zeros(N, 1);
Vtas = zeros(N,1);
heading = zeros(N,1);
mass = zeros(N,1);
t = zeros(N,1);
dt = 0.1;
i = 1;

Thrust = zeros(N,1);
Drag = zeros(N,1);

% Initial Values
x(1) = 0;
y(1) = 0;
h(1) = 27000; % ft
Vtas(1) = climb_speed_schedule(h(1))*0.514444444; % m/s
heading(1) = 0;
mass(1) = 290.3*10^3;

C_tc_r=0.95;

% Drag Parameters
cd0 = 0.0229;
cd2 = 0.0433;
S = 427.82;
C_T_deslow = .10131;

% Phase 1: Climb from 27,000 ft to 33,000 ft
tic;
while true
    bank(i)=0;
    gamma(i)=2.1 ;% deg
    y(i)=0;
    % Calculate Atmosphere
    [T,P,rho,a]=atm_model(h(i)*0.3048,0);
    cas=Tas_to_Cas(Vtas(i),h(i)*0.3048);
    
    % Calculate Lift Coefficient
    Cl = cl_calc(h(i)*0.3048,cas,bank(i),mass(i));
    
    % Calculate Drag Coefficient
    Cd = cd_calc(Cl,cd0,cd2);
    
    % Calculate Drag
    Drag(i) = Cd * rho * Vtas(i)^2 * S / 2;
    
    % Calculate Thrust
    Thrust(i) = maxclimb_takeoff_thrust(h(i));
    
    % Calculate Fuel Flow
    F = climb_fuel_consumption(h(i),Vtas(i)*1.94384449);
    % Calculate States
    Vtas(i+1) =  Vtas(i) + ((Thrust(i)-Drag(i))/(mass(i)) - 9.81 * sind(gamma(i))) * dt;
    h(i+1) = h(i) + (Vtas(i) * (sind(gamma(i)) / 0.3048)) * dt;
    mass(i+1) = mass(i) - (F/60) * dt;
    x(i+1)=x(i)+(Vtas(i)*cosd(0)*cosd(gamma(i)))*dt;
    
    % Break condition
    if abs(h(i+1) - 33000) < 10
        break
    else
        t(i+1) = t(i) + dt;
        i = i + 1;
    end
    
end
% Cruise Flight for 3 min
t(i+1) = t(i) + dt;
i=i+1;
for j=i:i+1801
    gamma(i)=0;
    bank(i)=0;
    heading(i)=0;
    y(i)=0;
    [T,P,rho,a]=atm_model(h(i)*0.3048,0);
    cas=Tas_to_Cas(Vtas(i),h(i)*0.3048);
    
    % Calculate Lift Coefficient
    Cl = cl_calc(h(i)*0.3048,cas,bank(i),mass(i));
    
    % Calculate Drag Coefficient
    Cd = cd_calc(Cl,cd0,cd2);
    
    % Calculate Drag
    Drag(i) = Cd * rho * Vtas(i)^2 * S / 2;
     
    % Calculate Thrust
    Thrust(i)= Drag(i);
    
    % Calculate Fuel Flow
    F =cruise_fuel_consumption(h(i),Vtas(i),mass(i));
    
    % Calculate States
    Vtas(i+1) =  Vtas(i) + ((Thrust(i)-Drag(i))/(mass(i)) - 9.81 * sind(gamma(i))) * dt;
    h(i+1) = h(i) + (Vtas(i) * (sind(gamma(i)) / 0.3048)) * dt;
    mass(i+1) = mass(i) - (F/60) * dt;
    x(i+1)=x(i)+(Vtas(i)*cosd(0)*cosd(gamma(i)))*dt;
    
    t(i+1) = t(i) + dt;
    i=i+1;
end 
%Turn 20 degrees
i=i-1;
display(i)
while true
    bank(i)=20;
    gamma(i)=0;
    y(i)=0;
    [T,P,rho,a]=atm_model(h(i)*0.3048,0);
    cas=Tas_to_Cas(Vtas(i),h(i)*0.3048);
    
     % Calculate Lift Coefficient
    Cl = cl_calc(h(i)*0.3048,cas,bank(i),mass(i));
    
    % Calculate Drag Coefficient
    Cd = cd_calc(Cl,cd0,cd2);
    
     % Calculate Drag
    Drag(i) = Cd * rho * Vtas(i)^2 * S / 2;
    
    % Calculate Thrust
    Thrust(i)= Drag(i);
    
    % Calculate Fuel Flow
    F =cruise_fuel_consumption(h(i),Vtas(i),mass(i));
    
    % Calculate States
    Vtas(i+1) =  Vtas(i) + ((Thrust(i)-Drag(i))/(mass(i)) - 9.81 * sind(gamma(i))) * dt;
    h(i+1) = h(i);
    mass(i+1) = mass(i) - (F/60) * dt;
    x(i+1)=x(i)+(Vtas(i)*cosd(0)*cosd(gamma(i)))*dt;
    heading(i + 1) = heading(i) +((9.81*(((1/cosd(bank(i))^2)-1))^0.5)/(Vtas(i)))*dt;
    %heading(i+1)=heading(i)-((Cl*rho*0.5*S*Vtas(i))/mass(i))*sind(bank(i))*dt;
    y(i+1)=y(i)+(Vtas(i)*sind(heading(i))*cosd(gamma(i)))*dt;
    if abs(heading(i+1)) > 60
        break
    else
        t(i+1) = t(i) + dt;
        i = i + 1;
    end
end 
% Cruise Flight for 2 min
t(i+1) = t(i) + dt;
i=i+1;
display(i)
for j=i:i+1201
    gamma(i)=0;
    bank(i)=0;
    heading(i)=0;
    y(i)=0;
    [T,P,rho,a]=atm_model(h(i)*0.3048,0);
    cas=Tas_to_Cas(Vtas(i),h(i)*0.3048);
    
    % Calculate Lift Coefficient
    Cl = cl_calc(h(i)*0.3048,cas,bank(i),mass(i));
    
    % Calculate Drag Coefficient
    Cd = cd_calc(Cl,cd0,cd2);
    
    % Calculate Drag
    Drag(i) = Cd * rho * Vtas(i)^2 * S / 2;
     
    % Calculate Thrust
    Thrust(i)= Drag(i);
    % Calculate Fuel Flow
    F =cruise_fuel_consumption(h(i),Vtas(i),mass(i));
    
    % Calculate States
    Vtas(i+1) =  Vtas(i) + ((Thrust(i)-Drag(i))/(mass(i)) - 9.81 * sind(gamma(i))) * dt;
    h(i+1) = h(i) + (Vtas(i) * (sind(gamma(i)) / 0.3048)) * dt;
    mass(i+1) = mass(i) - (F/60) * dt;
    x(i+1)=x(i)+(Vtas(i)*cosd(0)*cosd(gamma(i)))*dt;
    
    t(i+1) = t(i) + dt;
    i=i+1;
end
% Phase: Descent from 33,000 ft to 30,000 ft
i=i-1;
while true
    bank(i)=0;
    y(i)=0;
    gamma(i)=-2.8;% deg
    heading(i)=0;
    % Calculate Atmosphere
    [T,P,rho,a]=atm_model(h(i),0);
    cas=Tas_to_Cas(Vtas(i),h(i)*0.3048);
    % Calculate Lift Coefficient
    Cl = cl_calc(h(i)*0.3048,cas,bank(i),mass(i));
    
    % Calculate Drag Coefficient
    Cd = cd_calc(Cl,cd0,cd2);
    
    % Calculate Drag
    Drag(i) = Cd * rho * Vtas(i)^2 * S / 2;
    
    % Calculate Thrust
    Thrust(i) = descent_thrust(h(i));
    
    % Calculate Fuel Flow
    F = descent_fuel_consumption(h(i));
    
    % Calculate States
    Vtas(i+1) =  Vtas(i) + ((Thrust(i)-Drag(i))/(mass(i)) - 9.81 * sind(gamma(i))) * dt;
    h(i+1) = h(i) + (Vtas(i) * (sind(gamma(i)) / 0.3048)) * dt;
    mass(i+1) = mass(i) - (F/60) * dt;
    x(i+1)=x(i)+(Vtas(i)*cosd(0)*cosd(gamma(i)))*dt;
    
    % Break condition
    if abs(h(i+1) - 30000) < 10
        break
    else
        t(i+1) = t(i) + dt;
        i = i + 1;
    end
    
end
t(i+1) = t(i) + dt;
%i=i+1;
%Loiter 360
display(i)
while true
    bank(i)=20;
    gamma(i)=0;
    [T,P,rho,a]=atm_model(h(i)*0.3048,0);
    cas=Tas_to_Cas(Vtas(i),h(i)*0.3048);
    
     % Calculate Lift Coefficient
    Cl = cl_calc(h(i)*0.3048,cas,bank(i),mass(i));
    
    % Calculate Drag Coefficient
    Cd = cd_calc(Cl,cd0,cd2);
    
     % Calculate Drag
    Drag(i) = Cd * rho * Vtas(i)^2 * S / 2;
    
    % Calculate Thrust
    Thrust(i)= Drag(i);
    
    % Calculate Fuel Flow
    F =cruise_fuel_consumption(h(i),Vtas(i),mass(i));
    
    % Calculate States
    Vtas(i+1) =  Vtas(i);
    h(i+1) = h(i) + (Vtas(i) * (sind(gamma(i)) / 0.3048)) * dt;
    mass(i+1) = mass(i) - (F/60) * dt;
    x(i+1)=x(i)+(Vtas(i)*cosd(0)*cosd(gamma(i)))*dt;
    heading(i + 1) = heading(i) +((tand(bank(i))*9.81/Vtas(i)))*dt;
    %heading(i+1)=heading(i)-((Cl*rho*0.5*S*Vtas(i))/mass(i))*sind(bank(i))*dt;
    y(i+1)=y(i)+(Vtas(i)*sind(heading(i))*cosd(gamma(i)))*dt;
    if abs(heading(i+1)) > 359
        break
    else
        t(i+1) = t(i) + dt;
        i = i + 1;
    end
end 
t(i+1) = t(i) + dt;
i=i+1;
display(i)
% Phase: Descent from 30,000 ft to 26,000 ft
while true
    bank(i)=0;
    gamma(i)=-2.9 ;% deg
    heading(i)=0;
    y(i)=0;
    % Calculate Atmosphere
    [T,P,rho,a]=atm_model(h(i)*0.3048,0);
    cas=Tas_to_Cas(Vtas(i),h(i)*0.3048);
    
    % Calculate Lift Coefficient
    Cl = cl_calc(h(i)*0.3048,cas,bank(i),mass(i));
    
    % Calculate Drag Coefficient
    Cd = cd_calc(Cl,cd0,cd2);
    
    % Calculate Drag
    Drag(i) = Cd * rho * Vtas(i)^2 * S / 2;
    
    % Calculate Thrust
    Thrust(i) = descent_thrust(h(i));
    
    % Calculate Fuel Flow
    F = descent_fuel_consumption(h(i));
    
    % Calculate States
    Vtas(i+1) =  Vtas(i) + ((Thrust(i)-Drag(i))/(mass(i)) - 9.81 * sind(gamma(i))) * dt;
    h(i+1) = h(i) + (Vtas(i) * (sind(gamma(i)) / 0.3048)) * dt;
    mass(i+1) = mass(i) - (F/60) * dt;
    x(i+1)=x(i)+(Vtas(i)*cosd(0)*cosd(gamma(i)))*dt;
    
    % Break condition
    if abs(h(i+1) - 26000) < 10
        break
    else
        t(i+1) = t(i) + dt;
        i = i + 1;
    end
    
end


toc;
t(i+1) = t(i) + dt;
i=i+1;
y(i)=y(i-1);
figure;plot(t,Vtas);ylabel("V_tas(m/s)");xlabel("time(m)");grid on
figure;plot(t(1:length(t)-1),heading);ylabel("Heading Angle(deg)");xlabel("time(m)");grid on
figure;plot(t,mass);ylabel("mass(kg)");xlabel("time(m)");grid on
figure;plot(t(1:length(t)-1),Thrust);ylabel("Thrust(N)");xlabel("time(m)");grid on
figure;plot(t(1:length(t)-1),gamma);ylabel("Flight Path Angle (deg)");xlabel("time(m)");grid on
figure;plot(t(1:length(t)-1),bank);ylabel("Bank Angle (deg)");xlabel("time(m)");grid on
plot3(x,y,h,'o-')
grid on
xlabel('X')
ylabel('Y')
zlabel('Altitude(Feet)')
alpha(0.5)



