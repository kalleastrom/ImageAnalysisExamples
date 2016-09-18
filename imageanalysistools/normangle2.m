function n=normangle2(angle)
% n=normangle2(angle)
% calculates angle modolu pi. 
% normalizes angle in the interval [-pi/2,pi/2].

n = rem(angle+8*pi+pi/2,pi)-pi/2;
