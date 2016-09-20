%% How to fit a line to a set of points
% Read in some data

im = double(imread('data/klossar.pgm'));
figure(1);
clf;
colormap(gray);
imagesc(im);

%% Load edge detection data

load(['data' filesep 'klossar_edgelets.mat']);

%% First fit a line to all data

x = edgelets_sub(1:2,:);
l1 = linefitting_1(x);
figure(2);
clf;
colormap(gray);
imagesc(im);
hold on
rita(x,'r*');
rital(l1,'r-');
title('Fitting a line to all points might not be meaningful.');

%% RANSAC
% Using ransac to hypothesize a line and then fitting a line
% to the points that are considered to be inliers

x = edgelets_sub(1:2,:);
l1 = linefitting_1(x);
figure(2);
clf;
colormap(gray);
imagesc(im);
hold on
rita(x,'r*');
rital(l1,'r-');
title('Fitting a line to all points might not be meaningful.');

