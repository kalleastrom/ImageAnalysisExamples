function n=normangle(angle)
% n=normangle(angle)
% calculates angle modolu 2*pi. 
% normalizes angle in the interval [-pi,pi].

n = rem(angle+9*pi,2*pi)-pi;
