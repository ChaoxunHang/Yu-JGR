function H = yu_wtAndwq(P,t,Flux,cal_mode)

T = yu_T(t, [], [],"T");
rho_air = yu_rhoAir(P,T);

switch cal_mode
    case "wt"
        cp_dry = yu_cp(t,"dry");
    case "Hs"
        cp_dry = yu_cp(t,"dry");
    case "wq"
        Ls = yu_Ls(t);
    case "Hl"
        Ls = yu_Ls(t);
end


wT = @(rho_air,cp_dry,Hs)  Hs./rho_air./cp_dry;   % 《Handbook》式(6.4)
wq = @(rho_air,Ls,Hl)  Hl./rho_air./Ls;           %  Andrea，2010，式(2.1c)

Hs = @(rho_air,cp_dry,wt)  wt.*rho_air.*cp_dry;
Hl = @(rho_air,Ls,Hl)  wq.*rho_air.*Ls; 


switch cal_mode
    case "wt"
        H = wT(rho_air,cp_dry,Flux);
    case "wq"
        H = wq(rho_air,Ls,Flux);
    case "Hs"
        H = Hs(rho_air,cp_dry,Flux);
    case "Hl"
        H = Hl(rho_air,Ls,Flux);
end
