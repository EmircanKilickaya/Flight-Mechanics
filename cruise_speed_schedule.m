function [cruise] = cruise_speed_schedule(H)
%Calculates the speed schedule for cruise
%   H in feet and climb in knots
V_cr_1=310;%Given in the problem
V_cr_2=310;
M_cr=0.84;
C_v_min=1.3;
V_stall_cr=178;%From OPF
V_min=V_stall_cr*C_v_min;
H_trans=crossover_altitude_calc(M_cr,V_cr_2*0.514444444);
if H>=H_trans %Bunch of if-else conditions to decide which formula to use from BADA
    cruise_tas=Mach_to_Tas(M_cr,H*0.3048);%These functions takes inputs in meters
    cruise=Tas_to_Cas(cruise_tas,H*0.3048);
    cruise=cruise*1.943844;%Converting back to knots due to the output which was in m/s
elseif H>=14000 && H<H_trans
    cruise=V_cr_2;
elseif H>=6000 && H<=13999
    cruise=min(V_cr_1,250);
elseif H>=3000 && H<=5999
    cruise=min(V_cr_1,220);
elseif H>=0 && H<=2999
    cruise=min(V_cr_1,170);
end
if cruise<V_min%Checking if speed from the schedule described above is lower than the minimum speed determined 
    cruise=V_min;
end
end


