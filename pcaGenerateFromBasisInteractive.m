%% Load the estimated mean image O and two basis images E1 and E2
% Think of this as the new origin O
% and two 'vectors' spanning a two-dimensional subspace of images
% P = O + x1 E1 + x2 E2
% with two coordinates (x1,x2)
% These have been estimated using principal component analysis from
% a number of images. 
% O is really the mean m
% and E1 and E2 are the two vectors corresponding to the two
% largest eigenvalues of the covariance matrix, (but reshaped as 
% images)

load(['data' filesep 'bildbas.mat']);


%% Example 1 - Let (x1,x2) = (s1*cos(th),s2*sin(th)),

figure(1);
subplot(1,3,1); 
colormap(gray);
imagesc(O);
axis xy
title('mean image O');
subplot(1,3,2); 
colormap(gray);
imagesc(E1);
axis xy
title('Eigen-image E1');
subplot(1,3,3); 
colormap(gray);
imagesc(E2);
axis xy
title('Eigen-image E2');


%% Example 1 - Let (x1,x2) = (s1*cos(th),s2*sin(th)),
% i.e. we move along an ellipse in the x1,x2 plane and 
% look at the synthesized images
% P(th) = O + x1(th) E1 + x2(th) E2

for th = 0:0.1:(2*pi);
    x = [s1*cos(th);s2*sin(th)]; % Coordinates
    P = O + x(1)*E1 + x(2)*E2;
    figure(2);
    imagesc(P);
    colormap(gray);
    axis xy
    title(['Theta: ' num2str(th)]);
    pause(0.1)
end

%% Example 1 - Let (x1,x2) = (s1*cos(th),s2*sin(th)),
% i.e. we move along an ellipse in the x1,x2 plane and 
% look at the synthesized images
% P(th) = O + x1(th) E1 + x2(th) E2

figure(3);
while 1,
    subplot(1,2,1);
    axis([-1 1 -1 1]);
    [x1,x2]=ginput(1);
    hold on;
    plot(x1,x2,'*');
    x = [s1*x1;s2*x2]; % Coordinates
    P = O + x(1)*E1 + x(2)*E2;
    subplot(1,2,2);
    hold off;
    imagesc(P);
    colormap(gray);
    axis xy
end;