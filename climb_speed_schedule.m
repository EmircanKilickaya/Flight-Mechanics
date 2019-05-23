function [climb] = climb_speed_schedule(H)
%Calculates the speed schedule for climb
%    H in feet and climb in knots
V_cl_1=360; %Following 3 variables were given in the problem
V_cl_2=360;
M_cl=0.84;
C_v_min=1.3; %From BADA
list = {5,10,30,60,80};
[Vd_cl_1,Vd_cl_2,Vd_cl_3,Vd_cl_4,Vd_cl_5] = list{:}; %From BADA
V_stall_ic=148; %taken from OPF
V_min=V_stall_ic*C_v_min;
H_trans=crossover_altitude_calc(M_cl,V_cl_2*0.514444444) %Calculating H_trans,cas is m/s
if H>=H_trans %Bunch of if-else conditions to decide which formula to use from BADA
    climb_tas=Mach_to_Tas(M_cl,H*0.3048);
    climb=Tas_to_Cas(climb_tas,H*0.3048);
    climb=climb*1.943844;
elseif H>=10000 && H<H_trans
    climb=V_cl_2;
elseif H>=6000 && H<=9999
    climb=min(V_cl_1,250);
elseif H>=5000 && H<=5999
    climb=C_v_min*V_stall_ic+Vd_cl_5;
elseif H>=4000 && H<=4999
    climb=C_v_min*V_stall_ic+Vd_cl_4;
elseif H>=3000 && H<=3999
    climb=C_v_min*V_stall_ic+Vd_cl_3;
elseif H>=1500 && H<=2999
    climb=C_v_min*V_stall_ic+Vd_cl_2;
elseif H>=0 && H<=1499
    climb=C_v_min*V_stall_ic+Vd_cl_1;
end
if climb<V_min %Checking if speed from the schedule described above is lower than the minimum speed determined for the same conditions
    climb=V_min;
end
end

