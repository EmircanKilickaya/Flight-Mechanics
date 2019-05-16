%This file is not a function, it is only to use functions to generate
%the graphics needed in fuel consumption part.You can run if you want to
%see the graphs and output values below.There are 3 graphs.
H= linspace(0,39000,39001);
f1 = zeros(1, 39001);
f2 = zeros(1, 39001); %Preallocating for faster compilation
f3 = zeros(1, 39001);
for i=1:39001 %Looping through all altitude values
    x=H(i);
    f1(i)=climb_fuel_consumption(x);
    f2(i)= cruise_fuel_consumption(x);
    f3(i)= descent_fuel_consumption(x);
end
figure
plot(H,f1)
title('Climb Fuel Consumption')
xlabel('Altitude(feet)')
ylabel('Fuel Flow(kg/min)') 
grid on
figure
plot(H,f2)
title('Cruise Fuel Consumption')
xlabel('Altitude(feet)')
ylabel('Fuel Flow(kg/min)') 
grid on
figure
plot(H,f3)
title('Descent Fuel Consumption')
xlabel('Altitude(feet)')
ylabel('Fuel Flow(kg/min)') 
grid on