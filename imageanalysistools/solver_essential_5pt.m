function [nreal,realsols,allsols] = solver_essential_5pt(u1u2);

% The five points in image 1
u1 = u1u2(1:3,:);
% and image 2
u2 = u1u2(4:6,:);

% There are linear constraints on the essential matrix
% u1(:,k)'*E*u2(:,k) = 0

M = kron(u2,ones(3,1)).*kron(ones(3,1),u1);

[u,s,v]=svd(M');

Espace = v(:,6:9);

sols = solver_relpose_5p(Espace(:));

allsols = Espace*[ones(1,size(sols,2));sols];

realsolsid = zeros(1,size(allsols,2));
for k = 1:size(allsols,2);
    realsolsid(k) = isreal(allsols(:,k));
end

nreal = sum(realsolsid);
realsols = allsols(:,find(realsolsid));


