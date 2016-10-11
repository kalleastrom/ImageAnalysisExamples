%% Simulate points

U = [randn(3,10); ones(1,10)];
U(3,:)=zeros(1,10);

figure(1);
rita3(U,'*');

%% Cameras

P1 = [randrot() randn(3,1)];
P2 = [randrot() randn(3,1)];

%% Projection equation lamba*u = P*U
 
[u1,lambda1] = pflat(P1*U);
[u2,lambda2] = pflat(P2*U);

figure(2);
subplot(1,2,1);
rita(u1,'*');
subplot(1,2,2);
rita(u2,'*');

%%

M = [P1 u1(:,1) zeros(3,1);P2 zeros(3,1) u2(:,1)]
v = [U(:,1);-lambda1(1);-lambda2(1)]

%%

Egt = P2F(P1,P2);

data = [u1(:,1:5);u2(:,1:5)];

[nreal,realsols,allsols] = solver_essential_5pt(data);
%sols = solver_relpose_5p(data(:))

psphere(realsols)
tmp = Egt(:);
E_ground_truth_vector_normalized = tmp/norm(tmp)

%% Notice that E_ground_truth_vector_normalized
