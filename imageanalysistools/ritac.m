function ritac(u,plotst);

if nargin<2,
 plotst='-';
end;

%CC=inv(v2m(u));
%CC = inv(u);
CC=u;
if mean(eig(CC(1:2,1:2))) < 0,
 CC=-CC;
end;
A=chol(CC(1:2,1:2));
b=inv(A')*CC(1:2,3);
c=sqrt(b'*b-CC(3,3));
T=[A/c b/c;0 0 1];
%T'*diag([1 1 -1])*T*c^2;
phi=(0:100)*2*pi/100;
x=[cos(phi);sin(phi);ones(size(phi))];
y=inv(T)*x;
rita(y,plotst);
