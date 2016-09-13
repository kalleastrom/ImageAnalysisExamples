%% Getting started with images in matlab
% the function imread can be used to read images in e g jpg format to
% matlab. Several other formats are also supported. Write 'help imread' for
% more information

im = imread(['data' filesep 'dsc_0260.jpg']);

%% 
% It is common that images are in colour and that each colour intensity
% is coded as a number between 0 and 255 (8 bits). 

size(im)

% Notice that the size is 4816 rows and 2880 columns and three
% colour channels (red, green blue)
% Lets look at the upper left 3x5 pixels. 

im(1:3,1:5,:)

% Notice that the pixels have less intensity in the red channel, 
% medium intensity in the green channel and quite a lot of intensity
% in the blue channel. 

%% Viewing images
% Images can be viewed using image or imagesc command. 

figure(1);
image(im(1:3,1:5,:));
title('It does look blue doesn''t it');

%%
% Let's look at the whole image

figure(2);
image(im);
title('The whole image');

%% Image coordinate system
% Image coordinate systems can be confusing. 
% The standard coordinate system for images is to have the
% (1,1) pixel in the upper left corner. 
% This is similar to matrices which are usually written so that
% the first element of the first row is in the upper left corner.

A = [1 2 3;4 5 6;2 9 2];

A(1,1)

% The (1,1) element of A has value 1. When we print the matrix
% we usually put the (1,1) element in the upper left corner. 

A

% It is possible to change from this matrix convention 'ij'
% to more standard 'xy'-coordinate system convention using
% axis xy
% axis ij

figure(3);
image(im);
axis xy
title('The whole image in xy coordinate convention');

%% 
% Another common cause of misunderstanding is that the first index
% of a matrix is used to denote the row.
% But the row is usually considered to be the y-coordinate, which 
% usually is considered to be the 'second' coordinate. 

%% Converting to gray-scale
% In the image analysis course we will often study gray-scale images
% It is possible to convert from rgb to grayscale using the
% function rgb2gray
% grayscale images can also be viewed using 'image' or 'imagesc'
% functions. The function 'imagesc' first calculates tha lowest ('darkest')
% value and the highest ('brightest') value and then scales the
% image before displaying it. 
% The standard color representation in matlab is, however, 
% a pseudo-colour scale from low ('cold') values in blue to
% high ('varm') values in red. 

img = rgb2gray(im);

% The size is now 4816 x 2880

size(img)
img(1:3,1:5)
figure(4);
imagesc(img);
colorbar

%% colour-maps 
% In the image analysis course it will many times be more appropriate
% to choose a grey-scale colour-map from dark to bright.


figure(5);
imagesc(img);
colormap(gray(256));
colorbar


