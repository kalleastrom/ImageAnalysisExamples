function nrinl = inliers_2pt_circle(data,a_solution,ransac_t);
% 

res = a_solution'*[data;ones(1,size(data,2))];
nrinl = sum( abs(res)<ransac_t);
