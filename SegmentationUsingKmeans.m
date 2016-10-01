%% Segmentation Using K-Means clustering
% load an image

im = double(imread('data/klossar.pgm'));
figure(1);
colormap(gray);
imagesc(im);

%% First attempt, use gray-levels as features

K = 10;
[m,n]=size(im);
imf = im(:);
[idx,C] = kmeans(imf,K)

for i = 1:K,
    mask = reshape(idx==i,m,n);
    figure(2);
    subplot(1,2,1);
    colormap(gray);
    imagesc(im);
    subplot(1,2,2);
    colormap(gray);
    imagesc(im.*mask);
    title(['Segment nr: ' num2str(i) ' out of ' num2str(K)]);
    pause;
end

%% Second attempt, use gray-levels and pixel position as features

K = 10;
[m,n]=size(im);
[ii,jj]=meshgrid(1:n,1:m);
data = cat(3,im,ii,jj);
imf = reshape(data,m*n,3);
[idx,C] = kmeans(imf,K)

for i = 1:K,
    mask = reshape(idx==i,m,n);
    figure(3);
    subplot(1,2,1);
    colormap(gray);
    imagesc(im);
    subplot(1,2,2);
    colormap(gray);
    imagesc(im.*mask);
    title(['Segment nr: ' num2str(i) ' out of ' num2str(K)]);
    pause;
end

%% Third attempt, use gray-levels and pixel position as features
% Use different weighting

w = 0.3;
K = 10;
[m,n]=size(im);
[ii,jj]=meshgrid(1:n,1:m);
data = cat(3,im,w*ii,w*jj);
imf = reshape(data,m*n,3);
[idx,C] = kmeans(imf,K)

for i = 1:K,
    mask = reshape(idx==i,m,n);
    figure(3);
    subplot(1,2,1);
    colormap(gray);
    imagesc(im);
    subplot(1,2,2);
    colormap(gray);
    imagesc(im.*mask);
    title(['Segment nr: ' num2str(i) ' out of ' num2str(K)]);
    pause;
end


