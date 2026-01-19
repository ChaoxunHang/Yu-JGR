
clear
load("L3_MC_good.mat")
load('N_MOSAiC_var_L1.mat')
level_num = 3;

%% 

OBS_0_MC_2_MOSAiC_L1 = A2_summary_gd2(:,N_MOSAiC_var_L1);

OBS_0_MOSAiC = struct();
OBS_0_MOSAiC.value0 = OBS_0_MC_2_MOSAiC_L1;

clearvars N_* OBS_0_MC_2_* A0_matname A1_varname_gd2 A2_summary_gd2


%% 

z_z = repmat(2,38880,1);

OBS_0_MOSAiC.time = time1;
OBS_0_MOSAiC.lat = OBS_0_MOSAiC.value0(:,1);
OBS_0_MOSAiC.lon = OBS_0_MOSAiC.value0(:,2);
OBS_0_MOSAiC.z = z_z;
OBS_0_MOSAiC.t = OBS_0_MOSAiC.value0(:,13);
OBS_0_MOSAiC.t_sfc = OBS_0_MOSAiC.value0(:,37);
OBS_0_MOSAiC.p = OBS_0_MOSAiC.value0(:,16);
OBS_0_MOSAiC.U = OBS_0_MOSAiC.value0(:,25);
OBS_0_MOSAiC.wdir = OBS_0_MOSAiC.value0(:,26);
OBS_0_MOSAiC.q = OBS_0_MOSAiC.value0(:,22)./1000;  % unit：kg/kg

OBS_0_MOSAiC.downLong = OBS_0_MOSAiC.value0(:,38);   % unit：W/m^2
OBS_0_MOSAiC.upLong = OBS_0_MOSAiC.value0(:,39);
OBS_0_MOSAiC.downShort = OBS_0_MOSAiC.value0(:,40);
OBS_0_MOSAiC.upShort = OBS_0_MOSAiC.value0(:,41);

OBS_0_MOSAiC.zeta = OBS_0_MOSAiC.value0(:,48);
OBS_0_MOSAiC.ustar = OBS_0_MOSAiC.value0(:,46);
OBS_0_MOSAiC.Hs = OBS_0_MOSAiC.value0(:,42);   % unit：W/m^2
OBS_0_MOSAiC.Rib = OBS_0_MOSAiC.value0(:,75);   % unit：W/m^2

%% Tvp Tvp_sfc（单位：K）

OBS_0_MOSAiC.Tvp = yu_T(OBS_0_MOSAiC.t,OBS_0_MOSAiC.p,OBS_0_MOSAiC.q,"Tvp");
OBS_0_MOSAiC.Tvp_sfc = yu_T(OBS_0_MOSAiC.t_sfc,OBS_0_MOSAiC.p,OBS_0_MOSAiC.q,"Tvp");


%% Rib_GLGS

z_z = OBS_0_MOSAiC.z;
z_U = OBS_0_MOSAiC.U;
z_Tref = OBS_0_MOSAiC.Tvp;
z_Tr = OBS_0_MOSAiC.Tvp;
z_Ts = OBS_0_MOSAiC.Tvp_sfc;

OBS_0_MOSAiC.Rib_GLGS = yu_Rib(z_z,z_U,z_Tref,z_Tr,z_Ts,"GLGS");


%% wt

z_p = OBS_0_MOSAiC.p;
z_t = OBS_0_MOSAiC.t;
z_Flux = OBS_0_MOSAiC.Hs;

OBS_0_MOSAiC.wt = yu_wtAndwq(z_p,z_t,z_Flux,"wt");

clearvars z_*

%% zeta

OBS_0_MOSAiC.zeta_sur = yu_zeta(OBS_0_MOSAiC.z,OBS_0_MOSAiC(1).ustar,OBS_0_MOSAiC(1).Tvp,OBS_0_MOSAiC(1).wt);
OBS_0_MOSAiC.zeta1 = yu_zeta(OBS_0_MOSAiC.z,OBS_0_MOSAiC.ustar,OBS_0_MOSAiC(1).Tvp,OBS_0_MOSAiC(1).wt);
OBS_0_MOSAiC.zeta2 = yu_zeta(OBS_0_MOSAiC.z,OBS_0_MOSAiC(1).ustar,OBS_0_MOSAiC(1).Tvp,OBS_0_MOSAiC.wt);
OBS_0_MOSAiC.zeta_loc = yu_zeta(OBS_0_MOSAiC.z,OBS_0_MOSAiC.ustar,OBS_0_MOSAiC(1).Tvp,OBS_0_MOSAiC.wt);


%% save
save("OBS_0_MOSAiC_3Ls.mat","OBS_0_MOSAiC")

