function l = linefitting_1(x);
% x of size 2 x n
% first row x-coordinates
% second row y-coordinates
% Output: l = (a,b,c)^T, normalized so that a^2+b^2 = 1

N = size(x,2);
xh = [x;ones(1,N)]; % Homogeneous coordinates
xx = x(1,:);
yy = x(2,:);
ee = xh(3,:);
p1 = [xx' ee']\[yy']; % least squares
l1 = [p1(1) -1 p1(2)]'; % change to l = [a b c] format
%
% Normalization
l = l1/norm(l1(1:2));
