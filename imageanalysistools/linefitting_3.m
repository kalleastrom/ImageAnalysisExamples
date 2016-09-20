function l = linefitting_3(x);
% x of size 2 x n
%   first row x-coordinates
%   second row y-coordinates
% Output: l = (a,b,c)^T, normalized so that a^2+b^2 = 1
% Method: the 'svd' trick

N = size(x,2);
xh = [x;ones(1,N)]; % Homogeneous coordinates
[u,s,v]=svd(xh');
l3 = v(:,3);
%
% Normalization
l = l3/norm(l3(1:2));
