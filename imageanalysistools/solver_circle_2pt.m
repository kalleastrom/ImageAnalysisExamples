function [nreal,realsols,allsols] = solver_2pt(z);

r = 0.2;
% Equations 
% (u-xi)^2 + (v-yi)^2 = r^2
% (u^2+v^2) -2uxi - 2vyi = r^2-xi^2-yi^2
x = z(1,:)';
y = z(2,:)';
e = ones(2,1);
C = [e (-2*x) (-2*y) (x.^2+y.^2-r^2*e)];
C = rref(C);

% Parametrization
% v=t;
% u=a*t+b;
a = -C(2,3);
b = -C(2,4);
c = C(1,3);
d = C(1,4);
% equation u^2+v^2 + c*v + d*1 = 0;
% t^2 + a^2*t^2 + 2*a*b*t + b^2 + c*a*t + c*b + d = 0
% (1+a^2)*t^2 + (2*a*b + c*a)*t + (b^ + c*b + d) = 0;
% t^2 + a^2*t^2 + 2*a*b*t + b^2 + c*t + d = 0
% (1+a^2)*t^2 + (2*a*b + c*)*t + (b^ + d) = 0;
pp = [(1+a^2) (2*a*b + c) (b^2 + d)];
tsol = roots(pp);
if isreal(tsol),
    nreal = 2;
    realsols = [a*tsol'+b*ones(1,2);tsol'];
    allsols = realsols;
else
    nreal = 0;
    realsols = [];
    allsols = [a*tsol'+b*ones(1,2);tsol'];
end;


