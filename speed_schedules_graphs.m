%This file is not a function, it is only to use functions to generate
%the graphics needed in speed schedules part.You can run if you want to
%see the graphs and output values below.
H= linspace(0,39000,39001); %Altitude space between 0 and 39000 feet
climb = zeros(1, 39001); %Inýtializing zero vectors for preallocating
cruise = zeros(1, 39001);
descent = zeros(1, 39001);
for i=1:39001 %looping through all altitude values
    x=H(i);
    climb(i)=climb_speed_schedule(x); %Assigning the speed values one by one
    cruise(i)=cruise_speed_schedule(x);
    descent(i)=descent_speed_schedule(x);
end
figure
plot(H,climb) 
title('V_n_o_m_i_n_a_l for Climb GRAPH')
xlabel('Altitude(feet)')
ylabel('CAS(knots)') 
axis([0 4.7*10^4 0 350]) %Axis range fix for a better view
grid on
figure
plot(H,cruise)
title('V_n_o_m_i_n_a_l for Cruise GRAPH')
xlabel('Altitude(feet)')
ylabel('CAS(knots)') 
grid on
axis([0 4.7*10^4 0 350])
figure
plot(H,descent) %Same plot codes with different parameters
title('V_n_o_m_i_n_a_l for Descent GRAPH')
xlabel('Altitude(feet)')
ylabel('CAS(knots)') 
grid on
axis([0 4.7*10^4 0 350])
