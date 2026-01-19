function cp = yu_cp(t,cal_mode)

cp_dry_61 = @(t) 1005.60+0.017211.*t+0.000392.*(t.^2);   % 《Handbook》 (6.1)
cp_vapor_62 = @(t) 1858.60+0.3820.*t+0.0004220.*(t.^2)-1.996e-7.*(t.^3);  % 《Handbook》 (6.2)

switch cal_mode
    case "dry"
       cp = cp_dry_61(t); 
    case "vapor"
       cp = cp_vapor_62(t);

end