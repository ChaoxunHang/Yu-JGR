function y = yu_setnan(Var,m,n)

y = Var;

if isempty(m) & isempty(n)
   
elseif isempty(m) & ~isempty(n)
    y(:,n) = NaN;
elseif ~isempty(m) & isempty(n)
    y(m,:) = NaN;
elseif ~isempty(m) & ~isempty(n)
    y(m,n) = NaN;
else
    error("出错了，请检查函数文件！/ Error! Please chect the function code");
end

