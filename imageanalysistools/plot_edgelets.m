function plot_edgelets(xyth,plotst);
%

for k = 1:size(xyth,2);
    x = xyth(1,k);
    y = xyth(2,k);
    th = xyth(3,k);
    
    n = [cos(th);sin(th)];
    t = [-sin(th);cos(th)];
    plot([x-0.45*t(1) x+0.45*t(1)],[y-0.45*t(2) y+0.45*t(2)],plotst);
    %plot(x,y,'r.');
end
