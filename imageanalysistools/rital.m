function slask=rital(linjer,st)
if nargin == 1,
 st='-';
end;
if size(linjer)==0,
  slask=[];
else
  [slask,nn]=size(linjer);
  rikt=psphere([linjer(2,:);-linjer(1,:);zeros(1,nn)]);
  punkter=pflat(cross(rikt,linjer));
  for i=1:nn;
   plot([punkter(1,i)-4000*rikt(1,i) punkter(1,i)+4000*rikt(1,i)], ...
        [punkter(2,i)-4000*rikt(2,i) punkter(2,i)+4000*rikt(2,i)],st);
  end;
  slask=[];
end;
