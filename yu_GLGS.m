function results = yu_GLGS(z_r,z_U,z_Tvp_s,z_Tvp_r,z_Ri_b)

% Gryanik 2020 noniterative parameterization for SHEBA
% 仅适用于 Rib>0 的数据, Rib < 0 的数据会被替换为 NaN。               
% 输入变量：高度r（单位：m）
%         水平风速 U（单位：m/s）
%         地表处虚位温 θs（Tvp_s）（单位：K）
%         r 处虚位温 θr（Tvp_r）（单位：K）
%         总体理查森数 z_Ri_b
% 参数：   动量粗糙度长度 z_z0
%         热量粗糙度长度 z_zt

% Gryanik 2020 noniterative parameterization for SHEBA
% Only applicable under Rib > 0, or it will be replaced by NaN.
% Inputs：height r（m）
%         mean wind speed U（m/s）
%         virtual potential temperature at surface Tvp_s（K）
%         virtual potential temperature at height Tvp_r（K）
%         bulk Richardson number z_Ri_b
% Parameter：roughness length for momentum z_z0
%            roughness length for heat  z_zt



%% 
[~, level_num] = size(z_Ri_b);

index = cell(level_num);
for i = 1:level_num
    index{i} = find(z_Ri_b(:,i) <= 0);
end

A = [z_U,z_Tvp_s,z_Tvp_r,z_Ri_b];

for i = 1:level_num
    A(index{i},[i,level_num+i,2*level_num+i,3*level_num+i]) = NaN;
end

z_U = A(:,1:level_num);
z_Tvp_s = A(:,level_num+1:2*level_num);
z_Tvp_r = A(:,2*level_num+1:3*level_num);
z_Ri_b = A(:,3*level_num+1:4*level_num);

%% parameters
coe_k = 0.4;        % von Karman constant
coe_Pr0 = 1;        % neutral-limit turbulent Prandtl number

z_Ri_b_hat = z_Ri_b./coe_Pr0;
z_z0 = 7.7e-4;      
z_zt = 5.4e-4;
z_em = z_r./z_z0;
z_et = z_r./z_zt;

%% 定义匿名函数

 A = @(em, et) (log(em)+23.5).^5.25./(181.3.*(log(et)+16.67).^2.625)...
     .*((log(em)+23.50).^2./(log(et)+16.67)-log(em.^2)./(log(et)));      % formula（54) in Gryanik, 2020 

 C_Dr = @(em, et, Ri_b_hat)     coe_k.^2./((log(em)+50.0.*((1+0.3.*(...
     ((log(em)).^2)./log(et).*Ri_b_hat + A(em, et).*Ri_b_hat.^3.625)).^(1/3)-1)).^2);   % formula（57) in Gryanik, 2020 
 
 C_Hr = @(em, et, Ri_b_hat, C_Dr)     coe_k.*sqrt(C_Dr)./...
     (log(et)+12.5.*log(1+0.4.*((log(et).^2)./log(et).*Ri_b_hat + A(em, et).*Ri_b_hat.^3.625)));    % formula（58) in Gryanik, 2020 
  
 ustar = @(C_Dr, U) sqrt(C_Dr).*U;
 wt = @(C_Hr, U, T_s, T_r) C_Hr.*U.*(T_s-T_r);


%% calculate ustar(tao) wt (noniterative)

 GLGS_1_C_Dr = C_Dr(z_em, z_et, z_Ri_b_hat);
 GLGS_2_ustar = ustar(GLGS_1_C_Dr,z_U);

 GLGS_1_C_Hr = C_Hr(z_em, z_et, z_Ri_b_hat, GLGS_1_C_Dr);
 GLGS_2_wt = wt(GLGS_1_C_Hr, z_U, z_Tvp_s, z_Tvp_r);

%% results
results = struct();
results.ustar = GLGS_2_ustar;
results.wt = GLGS_2_wt;
results.C_Dr = GLGS_1_C_Dr;
results.C_Hr = GLGS_1_C_Hr;









