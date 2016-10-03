function nrinl = inliers_2pt_circle(data,a_solution,ransac_t);
% 

%
r = 0.2; % Assumes fixed radius

res = sqrt(sum( (data-repmat(a_solution,1,size(data,2))).^2 ))-r;
nrinl = sum( abs(res)<ransac_t);
