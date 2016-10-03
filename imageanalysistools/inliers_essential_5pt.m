function nrinl = inliers_2pt_circle(data,a_solution,ransac_t);
%

u1 = data(1:3,:);
u2 = data(4:6,:);
E = reshape(a_solution,3,3);

res = diag(u1'*E*u2); % Bad implementation.
inlid = abs(res) < 0.0001;

nrinl = sum(inlid);
