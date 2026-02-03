function y_rounded2 = yu_Error(z_CalVar,z_OBSVar,calmode)

switch calmode
    case "Ra"
        y = z_CalVar - z_OBSVar;
        y_rounded = round(y, 4, 'significant');
        y_rounded2 = round(y, 4);
    case "MAE"
        Ra = z_CalVar - z_OBSVar;
        y = mean(abs(Ra),'omitmissing');
        y_rounded = round(y, 4, 'significant');
        y_rounded2 = round(y, 4);
    case "Ra-median"
        Ra = z_CalVar - z_OBSVar;
        y = median(abs(Ra),'omitmissing');
        y_rounded = round(y, 4, 'significant');
        y_rounded2 = round(y, 4);
    case "Rr"
        y = (z_CalVar - z_OBSVar)./z_OBSVar;
        y_rounded = round(y, 4, 'significant');
        y_rounded2 = round(y, 4);
    case "MRE"
        Rr = (z_CalVar - z_OBSVar)./z_OBSVar;
        y = mean(abs(Rr),'omitmissing');
        y_rounded = round(y, 4, 'significant');
        y_rounded2 = round(y, 4);
    case "Rr-median"
        Rr = (z_CalVar - z_OBSVar)./z_OBSVar;
        y = median(abs(Rr),'omitmissing');   
        y_rounded = round(y, 4, 'significant');
        y_rounded2 = round(y, 4);
    case "RMSE"
        y = sqrt(mean((z_CalVar - z_OBSVar).^2,'omitmissing'));
        y_rounded = round(y, 4, 'significant');
        y_rounded2 = round(y, 4);
    case "all"       
        y_rounded2.Rr = yu_Error(z_CalVar,z_OBSVar,"Rr");
        y_rounded2.Rr_mean = yu_Error(z_CalVar,z_OBSVar,"MRE");
        y_rounded2.Rr_median = yu_Error(z_CalVar,z_OBSVar,"Rr-median");
        y_rounded2.Ra = yu_Error(z_CalVar,z_OBSVar,"Ra");
        y_rounded2.Ra_mean = yu_Error(z_CalVar,z_OBSVar,"MAE");
        y_rounded2.Ra_median = yu_Error(z_CalVar,z_OBSVar,"Ra-median");
        y_rounded2.RMSE = yu_Error(z_CalVar,z_OBSVar,"RMSE");
        y_rounded2.nonNaNerror = length(find(~isnan(y_rounded2.Rr)));
end
