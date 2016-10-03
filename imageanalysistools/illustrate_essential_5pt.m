function  illustrate_circle_2pt(data,a_solution,ransac_t);

if 0,
    figure(1); clf; hold off;
    subplot(1,2,1);
    rita(data(1:2,:),'.');
    axis equal
    axis([-0.5 0.5 -0.7 0.5]);
    hold on;
    axis ij
    subplot(1,2,2);
    rita(data(4:5,:),'.');
    axis equal
    axis([-0.5 0.5 -0.7 0.5]);
    hold on;
    axis ij
end

if nargin==1,
    figure(1); clf; hold off;
    hold on;
    for k = 1:size(data,2);
        rita([data(1:2,k) data(4:5,k)],'b');
    end
    axis([-0.5 0.5 -0.7 0.5]);
    axis ij
elseif nargin>=2,
    u1 = data(1:3,:);
    u2 = data(4:6,:);
    E = reshape(a_solution,3,3);
    res = diag(u1'*E*u2); % Bad implementation.
    inlid = abs(res) < ransac_t;
    
    figure(1); clf; hold off;
    hold on;
    for k = 1:size(data,2);
        if inlid(k),
            rita([data(1:2,k) data(4:5,k)],'g');
        else
            rita([data(1:2,k) data(4:5,k)],'r');
        end
    end
    axis([-0.5 0.5 -0.7 0.5]);
    axis ij
end

% if nargin>=2,
%     % Normalize line so that a^2+b^2 = 1
%     a_solution = a_solution/norm(a_solution(1:2));
%     rital(a_solution,'g');
% end
%
% if nargin==3,
%     ee = [0;0;1];
%     rital(a_solution+ransac_t*ee,'g');
%     rital(a_solution-ransac_t*ee,'g');
% end
