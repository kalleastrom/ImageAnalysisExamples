function [xout,ok,res] = optim_edge(im,xin);
% xin has format [x0;y0;th];

x0=xin(1);
y0=xin(2);
th00 = xin(3);
%th=pi/2-th00;
th = th00;
xx0 = [x0;y0;th];

p0 = [x0;y0];
normal = [cos(th);sin(th)];
s = 0;
a = 2;
[m10,m2,m3]=subpixel_gaussderiv2(im,p0,th,a);
for j=1:10,
    p=p0+s*normal;
    %rita(p,'*');
    %     if punkts(2) < 0, keyboard; end;
    % OBS INGEN KONTROLL PA ATT M2/M3 BLIR STOR!!!
    [m1,m2,m3]=subpixel_gaussderiv2(im,p,th,a);
    s=s-max(min(m2/m3,0.3),-0.3);
    %[m1;m2;m3;s]
end;
if abs(m1)>abs(m10),
    % This is good, the norm of the gradient increased! Yeah!
    % Re-estimate the direction of the gradient
    [matx,maty,komplext,th]=subpixel_gradient(im,p,a);
    xout = [p;th];
    ok = 1;
else
    xout = [p0;th];
    ok = 0;
end
res = m2;