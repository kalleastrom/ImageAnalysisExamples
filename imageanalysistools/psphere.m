function Xut=psphere(X);

[slask,n]=size(X);
for i=1:n,
  Xut(:,i)=X(:,i)/norm(X(:,i));
end;
