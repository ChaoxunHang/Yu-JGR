
% clear

%% load data

% load('OBS_0_MOSAiC.mat')
struct1 = rmfield(OBS_0_MOSAiC, 'time');

  

%% 

z_1 = find(struct1.ustar < 0.01);
struct1 = structfun(@(x) yu_setnan(x,z_1,[]), struct1,"UniformOutput",false);

z_1 = find(struct1.wt > -0.0005);   
struct1 = structfun(@(x) yu_setnan(x,z_1,[]),struct1,"UniformOutput",false);

z_1 = find(struct1.zeta < 0);   
struct1 = structfun(@(x) yu_setnan(x,z_1,[]),struct1,"UniformOutput",false);

z_1 = find(struct1.Rib < 0);   
struct1 = structfun(@(x) yu_setnan(x,z_1,[]),struct1,"UniformOutput",false);


clearvars z_1 

%% save
renamevar struct1 OBS_4_MOSAiC

OBS_4_MOSAiC.time = OBS_0_MOSAiC.time;

save("OBS_4_MOSAiC.mat", "OBS_4_MOSAiC")

   