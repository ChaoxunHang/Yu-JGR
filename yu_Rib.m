function y = yu_Rib(z,U,Tref,Tr,Ts,calfun)

% 24.05.31 完成
% 本文件用于按【103】Gryanik 2020 式（22）计算 bulk Richardson Number
% 需要输入变量：【高度 z（单位：m/s）】【水平风速 U（单位：m/s）】
%            【粗糙度长度 z0 zt】
%            【某参考高度虚位温或近地层平均温度 Tref（单位：K）】【高度z处的虚位温 Tr（单位：K）】
%            【地面处的虚位温 Ts（单位：K）】


%% 输入变量
z_z = z;               % 高度
z_U = U;               % 水平风速

z0 = 3.3e-4;         % 【GLGS】roughness length scales for momentum（选用文中参数）
zt = 0.2.*z0;        % 【GLGS】roughness length scales for heat（选用文中参数）

theta = Tref;        % 【GLGS】either the virtual potential temperature at some reference level or the average surface-layer temperature.
                     % 【Stull】the average surface-layer temperature
theta_r = Tr;        % temperature at level z（取虚位温）
theta_s = Ts;        % temperature at surface（取虚位温）


c_g = 9.8;             % 重力加速度（N/kg）

%% 计算过程
switch calfun
    case "GLGS"
        %【103】Gryanik 2020 式（22）
        Ri_b_GLGS = @(g,z,U,zt,z0,theta,theta_v,theta_s) g./theta .* ((theta_v-theta_s)./(z-zt)) ./ ((U.^2)./(z-z0).^2);

        y = Ri_b_GLGS(c_g,z_z,z_U,zt,z0,theta,theta_r,theta_s);

    case "Stull"
        % Stull,1988 式（5.6.3）
        Ri_b = @(g,z,U,theta,theta_r,theta_s)  (g.*z./theta).*(theta_r - theta_s)./(U.^2);

        y = Ri_b(c_g, z_z, z_U,theta,theta_r,theta_s);

end


