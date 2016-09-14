%% Demo of histogram equalization

%% Read in an image

addpath('imageanalysistools');
inbild = double(imread(['data' filesep 'mkalle.gif']));
lag = 0;
hog = 255;

%% Round to the nearest integer
bild=round(inbild);
% Make sure that no intensities are outside the range
bild=min(max(bild,lag),hog);
% Transform the range from [lag,hog] to [1,M]
bild=bild+ones(size(bild))*(1-lag);
M=hog-lag+1;

%% Calculate the histogram
[hist1,nn1]=hist(bild(:),1:M);
% Calculate the cumulative histogram
chist1=cumsum(hist1);
% chist1 is in principle the gray-scale transformation 
% we are going to use. We just have to rescale it
hh=M*chist1/chist1(M);
% and round to nearest integer
transf=ceil(hh);

%% OK. Now we will perform the gray-scale Transformation
utbild=zeros(size(bild));
utbild(:)=transf(bild);

%% Plot the results
subplot(2,3,1);
plot(1:M,1:M);
axis([0 M 0 M]);
title('The original gray-scales');

subplot(2,3,2);
image(bild);
colormap(gray(M));
title('gives this image');

subplot(2,3,3);
plot(chist1);
axis([0 M 0 max(chist1)]);
title('and this cumulative histogram');

subplot(2,3,4);
plot(transf);
axis([0 M 0 M]);
title('This gray-scale transformation');

subplot(2,3,5);
image(utbild);
colormap(gray(M));
title('gives this image');

[hist2,nn2]=hist(utbild(:),1:M);
chist2=cumsum(hist2);
subplot(2,3,6);
plot(chist2);
axis([0 M 0 max(chist2)]);
title('and this cumulative histogram.');


