function [matning]=matgauss(bild,punkt,a);

x0=punkt(1);
y0=punkt(2);
[m,n]=size(bild);
NN=round(a*3);
cutx=max(round(x0)-NN,1):min(round(x0)+NN,n);
cuty=max(round(y0)-NN,1):min(round(y0)+NN,m);
cutbild=bild(cuty,cutx);
[x,y]=meshgrid(cutx,cuty);
filter=exp(- ((x-x0).^2 + (y-y0).^2)/a^2)/(a^2*pi);
matning=sum(sum(filter.*cutbild));


