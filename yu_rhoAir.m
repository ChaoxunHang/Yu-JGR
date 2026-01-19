function rho_air = yu_rhoAir(P,T)

T0 = 273.15;  
P0 = 1013.25;  
rho0 = 1.2922; 

rho_dry_21 = @(T, P) rho0.*(T0./T).*(P/P0);   % 《Handbook》(2.1)

rho_air = rho_dry_21(T,P);



