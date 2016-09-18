function [matx,maty,komplext,th]=subpixel_gradient(bild,punkt,a);
% [matx,maty,komplext]=subpixel_gradient(bild,punkt,a);
% Input
%   bild  - input image
%   punkt - point
%   a     - amount of smoothing, should be greater than 1 (kind of)
% Output
%   matx - x-component of gradient
%   maty - y-component of gradient
%   komplext
%   th   - angle
x0=punkt(1);
y0=punkt(2);
[m,n]=size(bild);
NN=round(a*3);
cutx=max(round(x0)-NN,1):min(round(x0)+NN,n);
cuty=max(round(y0)-NN,1):min(round(y0)+NN,m);
cutbild=bild(cuty,cutx);
[x,y]=meshgrid(cutx,cuty);
filtx=2*(x-x0).*exp(- ((x-x0).^2 + (y-y0).^2)/a^2)/(a^4*pi);
filty=2*(y-y0).*exp(- ((x-x0).^2 + (y-y0).^2)/a^2)/(a^4*pi);
matx=sum(sum(filtx.*cutbild));
maty=sum(sum(filty.*cutbild));
komplext=matx+sqrt(-1)*maty;
th = atan2(maty,matx);


