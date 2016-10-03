function  illustrate_circle_2pt(data,a_solution,ransac_t);

r = 0.2;

figure(1); clf; hold off;
rita(data,'.');
axis equal
axis([-5 5 -5 5]);
hold on;

if nargin>=2,
    % Normalize line so that a^2+b^2 = 1
    a_solution = a_solution/norm(a_solution(1:2));
    rital(a_solution,'g');
end

if nargin==3,
    ee = [0;0;1];
    rital(a_solution+ransac_t*ee,'g');
    rital(a_solution-ransac_t*ee,'g');
end
