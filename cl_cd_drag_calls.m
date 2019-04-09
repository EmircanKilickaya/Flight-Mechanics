%This file is not a function, it is only to use functions to generate
%the graphics needed in cl and cd-drag part.You can run if you want to
%see the graphs and output values below.
altitude=33000*0.3048;
cas=0.514*290;
cl=cl_calc(altitude,cas);
tas=Cas_to_Tas(cas,altitude);
cd0_cr=0.022913;
cd2_cr=0.042347;
cd=cd_calc(cl,cd0_cr,cd2_cr);
display(cl)
display(cd)
surf=427.82;
[T,P,rho,a]=atm_model(altitude,0);
drag_force=cd*rho*(tas^2)*surf*0.5;
display(drag_force)
altitude2=35000*0.3048;
stall_cas=178*0.514;
cl_max=cl_calc(altitude2,stall_cas);
display(cl_max)
cl_space= linspace(0,cl_max,100);
cd_space=cd_calc(cl_space,cd0_cr,cd2_cr);
figure(1)
plot(cl_space,cd_space)
title('CL-CD GRAPH')
xlabel('Cl')
ylabel('Cd') 
grid on
[T1,P1,rho1,a1]=atm_model(25000*0.3048,0);
[T2,P2,rho2,a2]=atm_model(altitude,0);
cas_general=linspace(0,300,1000);
tas_general=Cas_to_Tas(cas_general,25000*0.3048);
tas_general2=Cas_to_Tas(cas_general,altitude);
cl1=cl_calc(25000*0.3048,cas_general);
cl2=cl_calc(altitude,cas_general);
cd1=cd_calc(cl1,cd0_cr,cd2_cr);
cd2=cd_calc(cl2,cd0_cr,cd2_cr);
drag_general=cd1.*rho1.*(tas_general.^2).*surf.*0.5;
drag_general2=cd2.*rho2.*(tas_general2.^2).*surf.*0.5;
display(drag_general)
figure(2)
plot(cas_general,drag_general)
title('V-D GRAPH')
xlabel('Speed(m/s)')
ylabel('Drag(Newtons)') 
hold on
plot(cas_general,drag_general2)
legend('25,000 feet','33,000 feet')
grid on