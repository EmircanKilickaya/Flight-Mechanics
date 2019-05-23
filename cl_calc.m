function cl = cl_calc(H,cas,bank,m)
%Calculates the lift coefficient Cl for given conditions:altitude and CAS
%m_ref=290.3*1000; %Reference mass from the Aircraft OPF 
g_0=9.80665;
surf=427.82; %m^2
tas=Cas_to_Tas(cas,H); %Converting cas to tas 
[T,P,rho,a]=atm_model(H,0); %Getting atmosphere conditions for this altitude
cl=(2*m*g_0)./(rho.*(tas.^2).*surf*cosd(bank)); %Cl formula from BADA Manual
end

