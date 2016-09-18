function [m1,m2,m3]=subpixel_gaussderiv2(bild,punkt,theta,a);

x0=punkt(1);
y0=punkt(2);
[m,n]=size(bild);
NN=round(a*3);
cutx=max(round(x0)-NN,1):min(round(x0)+NN,n);
cuty=max(round(y0)-NN,1):min(round(y0)+NN,m);
%
%[slask,sx]=size(cutx);
%[slask,sy]=size(cuty);
%if (sx*sy == 0),  m1=0; m2=0; m3=0; end;

cutbild=bild(cuty,cutx);
[x,y]=meshgrid(cutx,cuty);

filt1 = (2*(x-x0)*cos(theta)+2*(y-y0)*sin(theta))/(a^4*pi).*exp(-((x-x0).^2+(y-y0).^2)/(a^2));
filt2 = -(2*cos(theta).^2+2*sin(theta).^2)/(a^4*pi).*exp(-((x-x0).^2+(y-y0).^2)/(a^2))+ ...
         (-2*(x-x0)*cos(theta)-2*(y-y0)*sin(theta)).^2/(a^6*pi).*exp(-((x-x0).^2+(y-y0).^2)/(a^2));
filt3 = 3*(        2*cos(theta).^2+2*sin(theta).^2)/(a^6*pi)* ...
          (-2*(x-x0)*cos(theta)-2*(y-y0)*sin(theta)).*exp(-((x-x0).^2+(y-y0).^2)/(a^2)) ...
-(-2*(x-x0)*cos(theta)-2*(y-y0)*sin(theta)).^3/(a^8*pi).*exp(-((x-x0).^2+(y-y0).^2)/(a^2));
m1=sum(sum(filt1.*cutbild));
m2=sum(sum(filt2.*cutbild));
m3=sum(sum(filt3.*cutbild));



