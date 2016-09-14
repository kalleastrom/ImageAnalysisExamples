function Xut=pflat(X);

Xut(1,:)=X(1,:)./X(3,:);
Xut(2,:)=X(2,:)./X(3,:);
Xut(3,:)=X(3,:)./X(3,:);
