%% Edge detection using magnitude of gradient

im = double(imread('data/klossar.pgm'));
figure(1);
colormap(gray);
imagesc(im);

%% Generate convolution kernels 

a = 2; % level of smoothing, i.e. choice of scale in scale-space.
N = ceil(a*4); % Since the exponential degreas fast. Taking 4*scale
               % is good enough, we hope.
[x,y]=meshgrid(-N:N,-N:N); % Generate grid

%% First the one representing smoothing + taking derivative w r t x

ddx = -(1/(2*pi*a^2))*2*x.*exp( -(x.^2+y.^2)/(2*a^2) );
figure(2);
colormap(gray);
imagesc(ddx);
title('Kernel representing derivative w r t x + smoothing');

%% First the one representing smoothing + taking derivative w r t y

ddy = -(1/(2*pi*a^2))*2*y.*exp( -(x.^2+y.^2)/(2*a^2) );
figure(3);
colormap(gray);
imagesc(ddy);
title('Kernel representing derivative w r t y + smoothing');

%% Put these two together in a small bank of filters
% This seems really unneccessary for this simple example
% but might be useful thinking for examples later in the course.

filterbank(1:(2*N+1),1:(2*N+1),1) = ddx;
filterbank(1:(2*N+1),1:(2*N+1),2) = ddy;

%% Go from image -> result of filterbank;

layer2 = zeros(size(im,1),size(im,2),size(filterbank,3));
for k = 1:size(filterbank,3);
    layer2(:,:,k)=conv2(im,filterbank(:,:,k),'same');
end

%% Display channel 1 of the layer1, the smoothed d(im)/dx

figure(4);
colormap(gray);
imagesc(layer2(:,:,1));
title('The derivative of im w r t x + smoothing');

%% Display channel 2 of the layer1, the smoothed d(im)/dy

figure(5);
colormap(gray);
imagesc(layer2(:,:,2));
title('The derivative of im w r t y + smoothing');

%% Genarate layer 3, 
% This usually only has one channel, i.e. 
%   the norm of the gradient at each pixel.
% But you might also calculate the angle of the gradient
%   and store this as a second channel.

layer3(:,:,1) = sqrt(layer2(:,:,1).^2 + layer2(:,:,2).^2 );
layer3(:,:,2) = atan2(layer2(:,:,1),layer2(:,:,2));

%% The angle of the gradient of smoothed image

figure(7);
colormap(hot);
imagesc(layer3(:,:,2));
title('The angle of the gradient of smoothed image');
colorbar

%% The norm of the gradient of smoothed image

figure(6);
colormap(gray);
imagesc(layer3(:,:,1));
title('The norm of the gradient of smoothed image');

%% Classify gradient in 8 sectors - 8 direction bins

dirbin = mod(round(layer3(:,:,2)*8/(2*pi)),8);
dx = [0 1 1 1 0 -1 -1 -1];
dy = [1 1 0 -1 -1 -1 0 1];
[m,n]=size(im);
imid = 2:(m-1);
jmid = 2:(m-1);
ok = zeros(m,n,8);
for k = 1:8;
    ok(imid,jmid,k)= (dirbin(imid,jmid)==(k-1)) & ...
        (layer3(imid,jmid,1) >= layer3(imid+dy(k),jmid+dx(k),1)) &  ...
        (layer3(imid,jmid,1) >= layer3(imid-dy(k),jmid-dx(k),1)) ;
end

figure(1);
colormap(gray);
imagesc(sum(ok,3).*layer3(:,:,1))

%% Do sub-pixel refinement. 



