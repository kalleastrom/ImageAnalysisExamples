function [P1,P2]=F2P(F);

[U,S,V]=svd(F);
S(3,3)=0;
F=U*S*V';
t = null(F);
T = [0 -t(3) t(2); t(3) 0 -t(1);-t(2) t(1) 0];
b= null(F);
A = rand(3,1)*b'+F*pinv(T);
P1= inv(A')*[eye(3) -t];
P2= [eye(3) zeros(3,1)];
