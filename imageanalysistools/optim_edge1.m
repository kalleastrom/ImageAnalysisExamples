function [s,sigmas,toppar,mat,matp]=optim_edge1(inbild,punkt,normal,a,sintervall,troeskel);
% Line search in image
 theta=atan2(normal(2),normal(1));
 toppar=[];
 i=0;
 
 for s=sintervall,
   i=i+1;
   mat(i)=matgaussderiv(inbild,punkt+s*normal,theta,a);
   matp(i)=matgauss(inbild,punkt+s*normal,a);
 end;
 imax=size(sintervall,2);
 mat=abs(mat); % white->black or black->white dont matter
 for i=2:imax-1,
  if (mat(i) >= mat(i-1)) & ...
     (mat(i) >= mat(i+1)) & ...
     (mat(i) >  troeskel),
   s=sintervall(i);
    for j=1:5,
     punkts=punkt+s*normal;
%     if punkts(2) < 0, keyboard; end;
% OBS INGEN KONTROLL PA ATT M2/M3 BLIR STOR!!!
     [m1,m2,m3]=matgaussderiv2(inbild,punkts,theta,a);
     s=s-max(min(m2/m3,0.3),-0.3);
    end;
   toppar =  [toppar [s;m1]];
  end;
 end;
 antaltoppar=size(toppar,2);
 if antaltoppar>0,
%  [mbast,sbast] = min(abs(toppar(1,:)));
  [mbast,sbast] = max(abs(toppar(2,:)));
  s=toppar(1,sbast);
  [m1,m2,m3]=matgaussderiv2(inbild,punkt+s*normal,theta,a);
  vint=3^2;
  vnormal=vint*3/(16*a^6*pi)/(m3^2);
  sigmas=sqrt(vnormal);
 else
  s=NaN;
  toppar=[];
  sigmas=[];
 end;

