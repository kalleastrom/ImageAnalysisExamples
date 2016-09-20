function l = linefitting_2(x);
% x of size 2 x n
%   first row x-coordinates
%   second row y-coordinates
% Output: l = (a,b,c)^T, normalized so that a^2+b^2 = 1
% Method: Total least squares


mm = mean(x');
cc = cov(x');
[u,s,v]=svd(cc);
rr = u(:,1);
l2 = cross([mm';1],[rr;0]);
%
% Normalization
l = l2/norm(l2(1:2));
