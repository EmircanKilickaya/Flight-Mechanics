%This file is not a function, it is only to use functions to generate
%the graphics needed in cas_tas and mach part.You can run if you want to
%see the graphs and output values below.
cas= linspace(0,200,1000);
mach= linspace(0,1,1000);
tas=Cas_to_Tas(cas,6096);
figure(1) 
plot(cas,tas)
title('CAS-TAS')
xlabel('CAS (m/s)')
ylabel('TAS (m/s)')
grid on
tas1=Mach_to_Tas(mach,6096);
figure(2) 
plot(mach,tas1)
title('MACH-TAS')
xlabel('Mach Number')
ylabel('TAS (m/s)')
grid on