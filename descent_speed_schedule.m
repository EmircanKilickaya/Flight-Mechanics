function [descent] = descent_speed_schedule(H)
%Calculates the speed schedule for descent
%    H in feet and climb in knots
V_des_1=300;%Given in the problem
V_des_2=300;
M_des=0.84;
C_v_min=1.3;
V_stall_ld=122;%From aircraft.OPF
list = {5,10,20,50};
V_min=V_stall_ld*C_v_min;
H_trans=crossover_altitude_calc(M_des,V_des_2*0.514444444);%Calculating H_trans,cas is m/s
[Vd_des_1,Vd_des_2,Vd_des_3,Vd_des_4] = list{:};
if H>=H_trans%Bunch of if-else conditions to decide which formula to use from BADA
    descent_tas=Mach_to_Tas(M_des,H*0.3048);
    descent=Tas_to_Cas(descent_tas,H*0.3048);
    descent=descent*1.943844; %Converting back to knots
elseif H>=10000 && H<H_trans
    descent=V_des_2;
elseif H>=6000 && H<=9999
    descent=min(V_des_1,250);
elseif H>=3000 && H<=5999
    descent=min(V_des_1,220);
elseif H>=2000 && H<=2999
    descent=C_v_min*V_stall_ld+Vd_des_4;
elseif H>=1500 && H<=2999
    descent=C_v_min*V_stall_ld+Vd_des_3;
elseif H>=1000 && H<=1499
    descent=C_v_min*V_stall_ld+Vd_des_2;
elseif H>=0 && H<=999
    descent=C_v_min*V_stall_ld+Vd_des_1;
end
if descent<V_min%Checking if speed from the schedule described above is lower than the minimum speed determined for the same conditions
    descent=V_min;
end
end

