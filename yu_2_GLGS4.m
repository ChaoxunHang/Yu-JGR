
%% load data
load("OBS_4_MOSAiC.mat")
OBS = OBS_4_MOSAiC;

  
%% 
z_r = OBS.z;
z_U = OBS.U;
z_Tvp_s = OBS.Tvp_sfc;
z_Tvp_r = OBS.Tvp;
z_Ri_b = OBS.Rib_GLGS;
z_results = yu_GLGS(z_r,z_U,z_Tvp_s,z_Tvp_r,z_Ri_b);
GLGS.ustar2 = z_results.ustar.*z_results.ustar;
GLGS.ustar = z_results.ustar;
GLGS.wt = z_results.wt;
GLGS.Hs = yu_wtAndwq(OBS.p,OBS.t,z_results.wt,"Hs");

clearvars z_*

%% 

z_1(1,1) = length(find(~isnan(GLGS.ustar2)));
z_1(1,2) = length(find(~isnan(GLGS.wt)));
GLGS.dataAmount = z_1;


clearvars z_*

%%

 % ustar^2

z_CalVar = GLGS.ustar2;
z_OBSVar = OBS.ustar.*OBS.ustar;  
GLGS.Rr_ustar2_mean = yu_Error(z_CalVar,z_OBSVar,"MRE");
GLGS.Rr_ustar2_median = yu_Error(z_CalVar,z_OBSVar,"Rr-median");
GLGS.Ra_ustar2_mean = yu_Error(z_CalVar,z_OBSVar,"MAE");
GLGS.Ra_ustar2_median = yu_Error(z_CalVar,z_OBSVar,"Ra-median");
GLGS.RMSE_ustar2 = yu_Error(z_CalVar,z_OBSVar,"RMSE");

GLGS.Rr_ustar2 = yu_Error(z_CalVar,z_OBSVar,"Rr");
GLGS.Ra_ustar2 = yu_Error(z_CalVar,z_OBSVar,"Ra");


 % ustar
z_CalVar = GLGS.ustar;
z_OBSVar = OBS.ustar;  
GLGS.Rr_ustar_mean = yu_Error(z_CalVar,z_OBSVar,"MRE");
GLGS.Rr_ustar_median = yu_Error(z_CalVar,z_OBSVar,"Rr-median");
GLGS.Ra_ustar_mean = yu_Error(z_CalVar,z_OBSVar,"MAE");
GLGS.Ra_ustar_median = yu_Error(z_CalVar,z_OBSVar,"Ra-median");
GLGS.RMSE_ustar = yu_Error(z_CalVar,z_OBSVar,"RMSE");

GLGS.Rr_ustar = yu_Error(z_CalVar,z_OBSVar,"Rr");
GLGS.Ra_ustar = yu_Error(z_CalVar,z_OBSVar,"Ra");

 % wt

z_CalVar = GLGS.wt;
z_OBSVar = OBS.wt;
GLGS.Rr_wt_mean = yu_Error(z_CalVar,z_OBSVar,"MRE");
GLGS.Rr_wt_median = yu_Error(z_CalVar,z_OBSVar,"Rr-median");
GLGS.Ra_wt_mean = yu_Error(z_CalVar,z_OBSVar,"MAE");
GLGS.Ra_wt_median = yu_Error(z_CalVar,z_OBSVar,"Ra-median");
GLGS.RMSE_wt = yu_Error(z_CalVar,z_OBSVar,"RMSE");
GLGS.Rr_wt = yu_Error(z_CalVar,z_OBSVar,"Rr");
GLGS.Ra_wt = yu_Error(z_CalVar,z_OBSVar,"Ra");


 % Hs（W/m2） 
z_CalVar = GLGS.Hs;
z_OBSVar = OBS.Hs;
GLGS.Rr_Hs_mean = yu_Error(z_CalVar,z_OBSVar,"MRE");
GLGS.Rr_Hs_median = yu_Error(z_CalVar,z_OBSVar,"Rr-median");
GLGS.Ra_Hs_mean = yu_Error(z_CalVar,z_OBSVar,"MAE");
GLGS.Ra_Hs_median = yu_Error(z_CalVar,z_OBSVar,"Ra-median");
GLGS.RMSE_Hs = yu_Error(z_CalVar,z_OBSVar,"RMSE");
GLGS.Rr_Hs = yu_Error(z_CalVar,z_OBSVar,"Rr");
GLGS.Ra_Hs = yu_Error(z_CalVar,z_OBSVar,"Ra");


clearvars i z_* 

%% save
renamevar GLGS GLGS_4_MOSAiC
save('GLGS_4_MOSAiC.mat',"GLGS_4_MOSAiC")

  