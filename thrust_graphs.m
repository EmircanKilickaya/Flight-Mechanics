%This file is not a function, it is only to use functions to generate
%the graphics needed in max climb thrust and descent thrust part.You can run if you want to
%see the graphs and output values below.
H= linspace(0,39000,39001);
T_climb=maxclimb_takeoff_thrust(H);
T_descent = zeros(1, 39001);
for i=1:39001
    x=H(i);
    T_descent(i)=descent_thrust(x);
end
figure
plot(H,T_climb)
title('Max Climb Thrust- Altitude')
xlabel('Altitude(feet)')
ylabel('Thrust(Newtons)') 
grid on
figure
plot(H,T_descent)
title('Descent Thrust- Altitude')
xlabel('Altitude(feet)')
ylabel('Thrust(Newtons)') 
grid on