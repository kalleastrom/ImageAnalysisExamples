%%
%addpath tools
%addpath visionary



% im1c = imread(['data' filesep 'IMG_3399.jpg']);
% im2c = imread(['data' filesep 'IMG_3400.jpg']);
% im1c = imrotate(im1c,270);
% im2c = imrotate(im2c,270);
im1c = imread(['data' filesep 'IMG_6056.jpg']);
im2c = imread(['data' filesep 'IMG_6057.jpg']);
im1 = rgb2gray(im1c);
im2 = rgb2gray(im2c);


points1 = detectSURFFeatures(im1);
points2 = detectSURFFeatures(im2);

[features_I1, points_I1] = extractFeatures(im1, points1);
[features_I2, points_I2] = extractFeatures(im2, points2);

indexPairs = matchFeatures(features_I1, features_I2);

matchedPoints1 = points_I1(indexPairs(:, 1), :);
matchedPoints2 = points_I2(indexPairs(:, 2), :);

[ff1, pp1] = extractFeatures(im1, matchedPoints1);
[ff2, pp2] = extractFeatures(im2, matchedPoints2);

%%

%showMatchedFeatures(im1,im2,matchedPoints1,matchedPoints2,'montage');
%showMatchedFeatures(im1,im2,matchedPoints1,matchedPoints2);

[m,n]=size(im1);
x0 = n/2;
y0 = m/2;
f = 2800;

%aaa = load('cameraParams.mat');
%K=aaa.cameraParams.IntrinsicMatrix';
K = [f 0 x0;0 f y0;0 0 1];

nn = length(matchedPoints1);
u1 = double(inv(K)*[matchedPoints1.Location'; ones(1,nn)]);
u2 = double(inv(K)*[matchedPoints2.Location'; ones(1,nn)]);

%%
imseqfull1 = {imagedata(im1,K*u1),imagedata(im2,K*u2)};
figure(1); clf;
plot(imseqfull1{1},'numbered')
title('Detected features image 1, before RANSAC')
figure(2); clf;
plot(imseqfull1{2},'numbered')
title('Detected features image 2, before RANSAC')



% %%
% figure(1);
% hold off;
% image(im1c);
% hold on;
% rita(pflat(K*u1),'*');
% title('Detected features image 1, before RANSAC')
% 
% figure(2);
% hold off;
% image(im2c);
% hold on;
% rita(pflat(K*u2),'*');
% title('Detected features image 2, before RANSAC')


%%
data = [u1;u2];
maxnrinl = 0;
bestE = zeros(3,3);
bestinlid = NaN;

for kk = 1:1000;
    blubb = randperm(nn);
    blubb = blubb(1:5);
    [nreal,Evec,allsols] = solver_essential_5pt(data(:,blubb));
    
    for k = 1:size(Evec,2);
        E = reshape(Evec(:,k),3,3);
        res = diag(u1'*E*u2);
        %figure(3); plot(sort(abs(res)),'.'); axis([0 200 0 0.1]); pause;
        inlid = abs(diag(u1'*E*u2)) < 0.0005;
        nrinl = sum( inlid); % Långsam kod
        if nrinl > maxnrinl,
            blubb
            bestE = E;
            maxnrinl = nrinl
            bestinlid = find(inlid);
        end
    end;
end

%%
E = bestE*sqrt(2);
[u,s,v]=svd(E);
if det(u*v')<0,
    v(:,3) = -v(:,3);
end
W = [0 -1 0;1 0 0 ;0 0 1];
Z = [0 1 0;-1 0 0; 0 0 0];
P2 = [eye(3) zeros(3,1)];
P11 = [u*W*v' u(:,3)];
P12 = [u*W'*v' u(:,3)];
P13 = [u*W*v' -u(:,3)];
P14 = [u*W'*v' -u(:,3)];

% E
% F = P2F(P11,P2)
% F = P2F(P12,P2)
% F = P2F(P13,P2)
% F = P2F(P14,P2)

%% Test the four cases with triangulation

P1s = {P11,P12,P13,P14};

sss = zeros(6,0);
for iii = 1:4,
    iii
    P1 = P1s{iii};
    noll = zeros(3,1);
    zzk = [];
    sss = [];
    for kki = 1:length(bestinlid');
        kk = bestinlid(kki);
        M = [P1 u1(:,kk) noll;P2 noll u2(:,kk)];
        [uu,ss,vv]=svd(M);
        sss(:,kki)=diag(ss);
        zz = vv(:,6);
        zz = zz/zz(4);
        zzk(:,kki)=zz;
%         [pflat(P1*zz(1:4)) u1(:,kk)]
%         [pflat(P2*zz(1:4)) u2(:,kk)] 
%         pause;
    end
    ssss{iii}=sss;
    zzks{iii}=zzk;
    poang(iii)=sum(all(zzk(5:6,:)>0));
end;

[~,maxi]=max(poang);
P1 = P1s{maxi};
zzk = zzks{maxi};

%%
% P2 = P1;
% P1 = P2s{maxi};

%%
okpunktid = find(all(zzk(5:6,:)>0));

inlid = bestinlid(okpunktid);
U = zzk(1:4,okpunktid);


[pflat(P1*U);u1(:,inlid)]
[pflat(P2*U);u2(:,inlid)]

% figure(3);
% hold off
% rita3(U,'.');
% hold on;
% rita3(pflat(null(P1)),'o');
% rita3(pflat(null(P2)),'o');

%%
imseqfull2 = {imagedata(im1,K*u1(:,inlid)),imagedata(im2,K*u2(:,inlid))};
mfull2 = motion({K*P1,K*P2});
s2=intseclinear(mfull2,imseqfull2);
figure(3); clf;
reproject(s2,mfull2,imseqfull2,1,'numbered')
title('Detected features image 1, after RANSAC')
figure(4); clf;
reproject(s2,mfull2,imseqfull2,2,'numbered')
title('Detected features image 2, after RANSAC')
rms1=rmspoints(s2,mfull2,imseqfull2);


% %%
% figure(3);
% hold off;
% image(im1c);
% hold on;
% rita(pflat(K*u1(:,inlid)),'r*');
% rita(pflat(K*P1*U),'ro');
% title('Detected features image 1, after RANSAC')
% 
% figure(4);
% hold off;
% image(im2c);
% hold on;
% rita(pflat(K*u2(:,inlid)),'r*');
% rita(pflat(K*P2*U),'ro');
% title('Detected features image 2, after RANSAC')
% 
