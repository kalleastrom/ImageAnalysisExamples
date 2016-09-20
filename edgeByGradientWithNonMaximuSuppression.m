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

figure(8);
colormap(gray);
imagesc(layer3(:,:,1));
title('The norm of the gradient of smoothed image');
axis([140 160 130 150]);

%% Non-maximum suppression. 
% Classify gradient in 8 sectors - 8 direction bins
% For each bin, keep an edge point if it is local maximum in 
% this direction. 

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
figure(9);
colormap(gray);
imagesc(sum(ok,3).*layer3(:,:,1))
axis([140 160 130 150]);


%% Plot histogram of log of norm of gradient. 
% Use this to choose threshold

tmp1 = sum(ok,3)>0;
gra = layer3(:,:,1);
th = layer3(:,:,2);
tmp = find( (tmp1) & (gra > exp(-5)) );
figure(10);
hist(log(gra(tmp)),-5:0.1:6)
title('Histogram of log of norm of gradients')

%% Combine non-maximum supression with thresholding. 
% result is a discrete set of pixels. 
% The edge is found to pixel precision.

T = exp(3);
newok = tmp1 & (gra>T);
figure(11);
colormap(gray);
imagesc(newok.*gra)
axis([140 160 130 150]);


%% Pixel precision edgelets
% At each edge point we also have an estiamate of the 
% orientation. Each pixel can thus be thought of as 
% a small edge-part, an edgelet. These are shown as
% small red lines. Notice that the orientetion is 
% quite well estimated, wheras the edge is only ok up
% to one pixel. 

[y,x]=find(newok);
tt = pi/2-th(newok);
edgelets = [x';y';tt'];

figure(12); clf;
colormap(gray);
imagesc(newok.*gra)
hold on
plot_edgelets(edgelets,'r');
axis([140 160 130 150]);
title('Each edge point with its direction shown as a small edgelet.');

%% Edgelets overlayed on original image.

figure(13); clf;
colormap(gray);
imagesc(im)
hold on
plot_edgelets(edgelets,'r');
axis([140 160 130 150]);
title('Edgelets overlayed on original image.');

%% Do sub-pixel refinement.
% Using local optimization and interpolation
% the edgelets can be refined to sub-pixel positions.

edgelets_sub = edgelets;
for k = 1:size(edgelets,2);
    edgelets_sub(:,k)=optim_edge(im,edgelets(:,k));
end

%% Plot edglets before (red) and after (yellow) sub-pixel refinement

figure(14);
clf
hold off
colormap(gray);
imagesc(im)
hold on
plot_edgelets(edgelets,'r');
plot_edgelets(edgelets_sub,'y');
title('Edglets before (red) and after (yellow) sub-pixel refinement');
axis([140 160 130 150]);

%% Connect edgelets
% Think of each edglelet as nodes/vertices in an graph
% and connect two of them if they are
% * Close to each other
% * have similar orientation
% * the first midpoint lie on the line defined by the second edgelet
% * and vice verca

T1 = 3; % Edgelets have to be within T1 from each other
T2 = 0.1; % Edgelets have to have an orientation difference less than T2 radians
T3 = 0.2; % Mid point must lie closer than T3 pixels from the line defined by
% other edglet.
ab = [cos(edgelets_sub(3,:));sin(edgelets_sub(3,:))];
c = -sum(ab.*edgelets_sub(1:2,:));
l = [ab;c];
N = size(edgelets_sub,2);
ph = [edgelets_sub(1:2,:);ones(1,N)];

I = [];
J = [];
for i = 1:N;
    jtmp = find( sqrt(sum( (edgelets_sub(1:2,:)-repmat(edgelets_sub(1:2,i),1,N)).^2 ) ) < T1 );
    ok2 =  (abs( normangle2(edgelets_sub(3,jtmp) - repmat(edgelets_sub(3,i),1,length(jtmp))) ) < T2) ...
        & ( abs( sum(ph(:,jtmp) .* repmat(l(:,i),1,length(jtmp))) ) < T3 );
    jj = setdiff(jtmp(find(ok2)),i);
    I = [I repmat(i,1,length(jj))];
    J = [J jj];
end

%% Form graph

G = sparse(I,J,ones(size(I)),N,N,length(I));

%% Find connected component in graph

[nrcomp,compind]=graphconncomp(G);

%% Plot all connected edgelet components with more than 2 elements
oklong = zeros(size(compind));
for k = 1:nrcomp,
    sel = find(compind==k);
    %length(sel)
    if length(sel)>5;
        oklong(sel)=ones(size(sel));
        figure(15);
        clf
        hold off
        colormap(gray);
        imagesc(im)
        hold on
        plot_edgelets(edgelets_sub(:,sel),'y');
        title(['Edglets of component: ' num2str(k) ' with ' num2str(length(sel)) ' elements.']);
        %pause;
    end
end

%% Plot edgelets of components with length longer than 5 elements

figure(16);
clf
hold off
colormap(gray);
imagesc(im)
hold on
plot_edgelets(edgelets_sub(:,find(oklong)),'y');
title(['Edglets of components with length longer than 5 elements.']);

%% Plot edgelets of components with length longer than 5 elements

figure(17);
clf
hold off
colormap(gray);
imagesc(im)
hold on
plot_edgelets(edgelets_sub(:,find(oklong)),'y');
title(['Edglets of components with length longer than 5 elements.']);
axis([130 170 120 160]);

