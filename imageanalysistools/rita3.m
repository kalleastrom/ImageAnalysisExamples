function slask=rita3(bild,st)
if nargin == 1,
    st='-';
end;
if 0,
    t=linspace(0,1,size(bild,2));
    %clf;
    for j=1:size(bild,2);
        plot3(bild(1,j),bild(2,j),bild(3,j),'Color',[t(j) 0 1-t(j)],'MarkerSize',10,'Marker','.');hold on;
    end;
end;
if strcmp(st,'-')
    %t
    %plot3(bild(1,:),bild(2,:),bild(3,:),'Color',[1 0 0],'LineStyle',st,'LineWidth',3);
    plot3(bild(1,:),bild(2,:),bild(3,:),'Color',[0 0 1],'LineStyle',st,'LineWidth',3);
   %     plot3(bild(1,j),bild(2,j),bild(3,j),'LineStyle',st,'LineWidth',5);hold on;
else
    for j=1:size(bild,2);
        plot3(bild(1,j),bild(2,j),bild(3,j),'Color',[0 0 1],'MarkerSize',1,'Marker',st,'LineWidth',1);hold on;
    end;
end;
%hold off;
if 0,
    plot3(bild(1,:),bild(2,:),bild(3,:),st);
    slask=[];
end;