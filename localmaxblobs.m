%% Here is an image of gold atoms

addpath('imageanalysistools');
im = double(rgb2gray(imread(['data' filesep 'Sint_Au_865200X_19_cut.jpg'])));
%im = (imread(['data' filesep 'Sint_Au_865200X_19_cut.jpg']));
%im = double(imread('Sint_Au_865200X_19.tif'));
%im = im(1000:1100,1000:1100);
figure(1);
colormap(gray);
imagesc(im);

%% Detection of blobs by local maxima after smoothing with gaussian
% The centre of the gold atoms could be found 
% by finding local maxima in a smothed image
% To low threshold gives some false detections

a =  1;  % smoothing factor 4 pixels
th = 0;  % threshold 50 for height in pixels;
[points,out]=detect_gaussian_pixel(im,a,th);
figure(2);
colormap(gray);
imagesc(im);
hold on;
plot(points(1,:),points(2,:),'*');

%% Detection of blobs by local maxima after smoothing with gaussian
% The centre of the gold atoms could be found 
% by finding local maxima in a smothed image
% More smoothing (a=4, coarser scale) 
% combined with higher threshold (th=50) 
% gives fewer false detections.

a =   4; % smoothing factor 4 pixels
th = 50; % threshold 50 for height in pixels;
[points,out]=detect_gaussian_pixel(im,a,th);
figure(3);
colormap(gray);
imagesc(im);
hold on;
plot(points(1,:),points(2,:),'*');

%% Sub-pixel refinements of blob-peaks

[spoints,ok] = improve_gaussian_subpixel(im,points);

figure(4);
colormap(gray);
imagesc(im);
hold on;
%axis([1000 1100 1000 1100]);
plot(points(1,:),points(2,:),'*');
plot(spoints(1,:),spoints(2,:),'ro');
