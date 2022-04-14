function [c] = verlity(a,b)
%声明可行域 判断 该点是否在可行域内，若在输出1，否则输出0；
%   此处显示详细说明
g1=25-a.^2-b.^2;
g2=a;
g3=a;
if (g1>=0 && g2>=0 && g3>=0)
    c=1;
else
    c=0;
end
end

