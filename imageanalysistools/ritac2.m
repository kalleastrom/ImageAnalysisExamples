function ritac2(uv,r,plotst);

if nargin<3,
    plotst = '-';
end

C1 = (diag([1 1 -r^2]));
T = [eye(2) -uv;0 0 1];
%C1(1:2,3) = -uv;
%C1(3,1:2) = -uv';
ritac(T'*C1*T,plotst);

