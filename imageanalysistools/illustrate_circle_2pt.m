function  illustrate_circle_2pt(data,a_solution,ransac_t);

r = 0.2;

figure(1); clf; hold off;
rita(data,'*');
axis equal
axis([0 1 0 1]);
hold on;

if nargin==2,
    ritac2(a_solution,r,'g');
end

if nargin==3,
    ritac2(a_solution,r-ransac_t,'g');
    ritac2(a_solution,r+ransac_t,'g');
end
