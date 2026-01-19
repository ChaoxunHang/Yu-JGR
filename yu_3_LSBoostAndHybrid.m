
clear
load("OBS_4_MOSAiC.mat")

%% prepare idx
zeta = OBS_4_MOSAiC.zeta;
sep1 = yu_sep_stability(zeta);
idx{1} = sep1(4).idx;

U = OBS_4_MOSAiC.U;
idx{2} = find(U>8);

sep2 = yu_sep_date((1:38880)',OBS_4_MOSAiC.time);
idx{3} = sep2(3).idx;

%% lsboost model
 [ls1, ~, ~, ~, ~, ~] = yu_LSBoost(OBS_4_MOSAiC,idx{1},38880,ustar2);
 [ls2, ~, ~, ~, ~, ~] = yu_LSBoost(OBS_4_MOSAiC,idx{1},38880,ustar2);
 [ls3, ~, ~, ~, ~, ~] = yu_LSBoost(OBS_4_MOSAiC,idx{1},38880,ustar2);
 LSBoost_ustar2 = struct();
 LSBoost_ustar2.strong_stable = ls1;
 LSBoost_ustar2.strong_wind = ls2;
 LSBoost_ustar2.autumn = ls3;

 [ls4, ~, ~, ~, ~, ~] = yu_LSBoost(OBS_4_MOSAiC,idx{1},38880,wt);
 [ls5, ~, ~, ~, ~, ~] = yu_LSBoost(OBS_4_MOSAiC,idx{1},38880,wt);
 [ls6, ~, ~, ~, ~, ~] = yu_LSBoost(OBS_4_MOSAiC,idx{1},38880,wt);

 LSBoost_Hs = struct();
 LSBoost_Hs.strong_stable = yu_wtAndwq(OBS_4_MOSAiC.p,OBS_4_MOSAiC.t,ls4,"Hs");
 LSBoost_Hs.strong_wind =  yu_wtAndwq(OBS_4_MOSAiC.p,OBS_4_MOSAiC.t,ls5,"Hs");
 LSBoost_Hs.autumn =  yu_wtAndwq(OBS_4_MOSAiC.p,OBS_4_MOSAiC.t,ls6,"Hs");

%% Hybrid 
hybrid_ustar2 = GLGS_4_MOSAiC.ustar2;
hybrid_ustar2(idx{3},1) = ls1;
hybrid_ustar2(idx{2},1) = ls2;
hybrid_ustar2(idx{1},1) = ls3;

hybrid_wt = GLGS_4_MOSAiC.wt;
hybrid_wt(idx{3},1) = ls4;
hybrid_wt(idx{2},1) = ls5;
hybrid_wt(idx{1},1) = ls6;

hybrid_Hs = yu_wtAndwq(OBS_4_MOSAiC.p,OBS_4_MOSAiC.t,hybrid_wt,"Hs");

%% save
save("LSBoost_results.mat","LSBoost_ustar2","LSBoost_Hs");
save("Hybrid_results.mat","hybrid_ustar2","hybrid_Hs");


