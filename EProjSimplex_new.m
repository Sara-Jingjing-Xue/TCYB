function [x ft] = EProjSimplex_new(v, k)

%
%% Problem
%
%  min  1/2 || x - v||^2
%  s.t. x>=0, 1'x=1
%

if nargin < 2
    k = 1;
end;

ft=1;
n = length(v);

v0 = v-mean(v) + k/n;
%vmax = max(v0);
vmin = min(v0);
if vmin < 0
    f = 1;
    lambda_m = 0;
    while abs(f) > 10^-10
        v1 = v0 - lambda_m;
        posidx = v1>0;% 把v1中大于0的值赋1，小于0的赋值0
        npos = sum(posidx);
        g = -npos;
        f = sum(v1(posidx)) - k;% v1所有非负元素之和-k
        lambda_m = lambda_m - f/g;
        ft=ft+1;
        if ft > 100 % 当迭代了100次后
            x = max(v1,0);% 计算v1，得到每一行的S
            break;
        end;
    end;
    x = max(v1,0);

else
    x = v0;
    
end;