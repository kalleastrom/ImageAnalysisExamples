% Illustrate deep learning for character recognition
% Example data and deep learnt net from exercise 4 
% in matconvnet practical tutorial
% See: 
% http://github.com/vlfeat/matconvnet/
% and 
% http://www.robots.ox.ac.uk/~vgg/practicals/cnn/
% 
% http://cs.stanford.edu/people/karpathy/convnetjs/


%% Load the data
load(['data' filesep 'ex4data']);

%% Visualize one image
close all;
figure(1);
colormap(gray);
imagesc(im);
axis equal

%% The last layer here gives the response before softmax
% rows are the 26 classes 'a' to 'z'
% colums are positions (x) along the image

blubb = squeeze(res(8).x)';
figure(2);
colormap(gray);
imagesc(blubb);

%% Do softmax on the response.
% rows are the 26 classes 'a' to 'z'
% colums are positions (x) along the image

blubb2 = exp(blubb)./repmat(sum(exp(blubb),1),26,1);
figure(3);
colormap(gray);
imagesc(blubb2);

%% Get the classification as the class with the maximal value after softmax

[maxv,maxi]=max(blubb2);
alfabet = 'abcdefghijklmnopqrstuvwxyz';

%% This is the ocr result after sweeping across the image

alfabet(maxi)
