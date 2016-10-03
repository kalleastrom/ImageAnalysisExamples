function [nreal,realsols,allsols] = solver_2pt(z);

z = [z;ones(1,2)];
sol = null(z');
sol = sol/norm(sol(1:2));
nreal = 1;
realsols = sol;
allsols = sol;
