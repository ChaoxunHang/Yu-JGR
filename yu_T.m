function y = yu_T(t,P,Q,calmode)

% 24.05.31 完成
% 本文件用于计算绝对温度T、位温Tp、虚温Tv、虚位温Tvp（单位：K）
% 说明：1、需要前置数据：【摄氏温度t（°C）】、【气压P（milibar 或 hpa）】、【比湿Q（kg/kg）】

 % 函数
T = @(t) t+273.15;   
Tp = @(T,P) T.*(1000./P).^0.286;   % stull,1988 (1.5.1c)
Tv = @(T,Q) T.*(1+0.608.*Q);       % 《Handbook》 (3.8)
Tvp = @(Tp,Q) Tp.*(1+0.608.*Q);       % stull,1988 (1.5.1b)


 % 计算过程
switch calmode
    case "T"
        y = T(t);
    case "Tp"
        y = Tp(T(t),P);
    case "Tv"
        y = Tv(T(t),Q);
    case "Tvp"
        y = Tvp(Tp(T(t),P),Q);
end

