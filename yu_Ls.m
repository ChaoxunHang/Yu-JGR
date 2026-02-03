function Ls_fun = yu_Ls(t)


Ls_fun = @(t) (28.34-0.00149.*t).*1e5;  % 《Handbook》（7.3）

Ls = Ls_fun(t);

 