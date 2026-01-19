function y_sep = yu_sep_stability(zeta)

unstable = find(zeta < 0);
stable_n = find(zeta > 0 & zeta <= 0.1);
stable_ws = find(zeta > 0.1 & zeta <= 1);
class1z = find(zeta > 1);
y_sep(1).class = "unstable";
y_sep(2).class = "0_0.1";
y_sep(3).class = "0.1_1";
y_sep(4).class = ">1";

y_sep(1).idx = unstable;
y_sep(2).idx = stable_n;
y_sep(3).idx = stable_ws;
y_sep(4).idx = class1z;

y_sep(1).allnonNaN = length(find(~isnan(zeta)));
y_sep(2).allnonNaN = length(find(~isnan(zeta)));
y_sep(3).allnonNaN = length(find(~isnan(zeta)));
y_sep(4).allnonNaN = length(find(~isnan(zeta)));


