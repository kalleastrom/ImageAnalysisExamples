%% Interpolation and low pass smoothing
% Load in an image of gold atoms
% convert to grey-scale and to double precision
% floating point format (with double)

addpath('imageanalysistools');
im = imread(['data' filesep 'Sint_Au_865200X_19_cut.jpg']);
img = double(rgb2gray(im));
img = img(30:50,30:45);

%% Plot the original image

figure(1);
colormap(gray);
imagesc(img);
title('Original discrete image.');

%% Think of f as a discrete image
f = img;

%% Introduce a discrete coordinate system
% For this example we will let i be the integer coordinates
% in the x-direction
% and j be the integer coordinate in the y-direction

[i,j]=meshgrid(1:size(f,2),1:size(f,1));

%% interpolate at point (u,v)
% using the equation $F(u,v) = \sum_i \sum_j f(i,j) g(x-i,y-j)$
% where g is the interpolation function
% In matlab this is
% F(u,v) = sum(sum( f.*g(x-i,y-j) ))
% or F(u,v) = sum(sum( f.*h )), with h(i,j) = g(x-i,y-j);

x = 8.1;
y = 12.3;
sigma = 1.2;
h = 1/(2*pi*sigma^2) * exp( -( (x-i).^2 + (y-j).^2 )/(2*sigma^2) ); % Here: h(i,j) = g(x-i,y-j)
F   = sum(sum(f.*h));                                               % Here is the equation
disp(['The interpolated value F(8.1,12.3) = ' num2str(F)]);

%% The interpolated value at coordinates (x,y) = (8.1,12.3)
% is pretty close to the value at (x,y)=(8,12)
% of f convoluted with g

[xx,yy]=meshgrid(-5:5,-5:5);
gg = 1/(2*pi*sigma^2) * exp( -( xx.^2 + yy.^2 )/(2*sigma^2) );

fconv = conv2(f,gg,'same');
fconv(12,8)

disp(['The value of F(8,12) = ' num2str(F) ' is pretty close as it should be.']);

%% Image smoothed with Gaussian of width sigma = 1.2

figure(2);
colormap(gray);
imagesc(fconv);
title('Image smoothed with Gaussian of width sigma = 1.2');
