%% Generate a few points

N = 100;
x = randn(2,N);
th = 0.1;
R = [cos(th) sin(th);-sin(th) cos(th)];
x = R*[10 0;0 100]*x;
T = 10;
x = x + repmat([T;0],1,N);
xh = [x;ones(1,N)];
    
figure(1); clf;
rita(x,'*');
axis([T-100 T+100 -200 200])

%% Ordinary least squares

% y = p1(1)*x + p1(2);
% l = [p1(1) -1 p1(2)]
%
% Algorithm 1
%
xx = x(1,:);
yy = x(2,:);
ee = xh(3,:);
p1 = [xx' ee']\[yy']; % least squares
l1 = [p1(1) -1 p1(2)]'; % change to l = [a b c] format
%
% Normalization
l1n = l1/norm(l1(1:2));

% plot
figure(2); clf;
rita(x,'*');
axis([T-100 T+100 -200 200])
hold on
rital(l1n,'r');

% calculate error
e1 = sqrt(sum( (l1n'*xh).^2 ))

%% Total least squares

% Algorithm 2
%
mm = mean(x');
cc = cov(x');
[u,s,v]=svd(cc);
rr = u(:,1);
l2 = cross([mm';1],[rr;0]);
%
% Normalization
l2n = l2/norm(l2(1:2));


% plot
figure(3); clf;
rita(x,'*');
axis([T-100 T+100 -200 200])
hold on
rital(l1n,'r');
rital(l2n,'g');

% calculate error
e2 = sqrt(sum( (l2n'*xh).^2 ))

%% SVD hacket

% Algorithm 3
%
[u,s,v]=svd(xh');
l3 = v(:,3);
%
% Normalization
l3n = l3/norm(l3(1:2));

% plot
figure(4); clf;
rita(x,'*');
axis([T-100 T+100 -200 200])
hold on
rital(l1n,'r');
rital(l2n,'g');
rital(l3n,'k');

% calculate error
e3 = sqrt(sum( (l3n'*xh).^2 ))

%% Summary

disp('Errors measured in orthonogal direction. Tried three algorithms');
disp(['Error using algorithm 1: ' num2str(e1) ' minimizing least squares (error in y-direction)'])
disp(['Error using algorithm 2: ' num2str(e2) ' minimizing total least squares (error in orthogonal direction)'])
disp(['Error using algorithm 3: ' num2str(e3) ' using svd-trick'])



