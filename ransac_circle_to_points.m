%% Ransac illustration. Fit circles of known radius to points

r = 0.2;
nc = 3;
cs = rand(2,nc);
no = 100;
ni = 100;

%% Generate data

ptso = rand(2,no);
for k = 1:ni,
    ic = randi(nc);
    th = rand(1,1)*2*pi;
    x = cs(1,ic) + cos(th)*r;
    y = cs(2,ic) + sin(th)*r;
    ptsi(:,k)=[x;y];
end

p = [ptso ptsi];
ok = find( (p(1,:)>0) & (p(1,:)<1) & (p(2,:)>0) & (p(2,:)<1) );
p = p(:,ok);

%% Plot data 

figure(1); clf; hold off;
rita(p,'*');
axis equal
axis([0 1 0 1]);
hold on;

%%

ransac_n = 100;
ransac_t = 0.01;
max_nr_inliers=0;
bestuv = NaN;
for k = 1:ransac_n,
    isel = randperm(size(p,2),2);
    [n_real_sol,realsols,allsols] = solver_2pt(p(:,isel));
    if n_real_sol>0,
        for k = 1:n_real_sol,
            uv = realsols(:,k);
            res = sqrt(sum( (p-repmat(uv,1,size(p,2))).^2 ))-r;
            nrinl = sum( abs(res)<ransac_t);
            if nrinl>max_nr_inliers,
                max_nr_inliers = nrinl
                bestuv = uv;
                bestisel = isel;
            end
        end
    end
end

ritac2(bestuv,r,'b');


%%
n_real_sol = 0;
while n_real_sol==0,
    isel = randperm(size(p,2),2);
    [n_real_sol,realsols,allsols] = solver_2pt(p(:,isel));
    n_real_sol
    iselbad = isel;
end
%%

mbox = [0 1 1 0 0;0 0 1 1 0];

%%

figure(1);
clf;
rita(p,'b.');
axis equal
axis([0 1 0 1]);
hold on;
axis off
rita(mbox,'b');

%%
figure(2);
clf;
rita(p,'b.');
axis equal
axis([0 1 0 1]);
hold on;

isel = iselbad;
[n_real_sol,realsols,allsols] = solver_2pt(p(:,isel));
rita(p(:,isel),'ro');
rita(p(:,isel),'r*');
ritac2(realsols(:,1),r-ransac_t,'r');
ritac2(realsols(:,1),r+ransac_t,'r');
ritac2(realsols(:,2),r-ransac_t,'r--');
ritac2(realsols(:,2),r+ransac_t,'r--');

isel = bestisel;
[n_real_sol,realsols,allsols] = solver_2pt(p(:,isel));
rita(p(:,isel),'go');
rita(p(:,isel),'g*');
ritac2(realsols(:,1),r-ransac_t,'g-');
ritac2(realsols(:,1),r+ransac_t,'g-');
ritac2(realsols(:,2),r-ransac_t,'g--');
ritac2(realsols(:,2),r+ransac_t,'g--');

axis off
rita(mbox,'b');


%%

figure(3);
clf;
rita(p,'b.');
axis equal
axis([0 1 0 1]);
hold on;

isel = bestisel;
[n_real_sol,realsols,allsols] = solver_2pt(p(:,isel));
rita(p(:,isel),'go');
rita(p(:,isel),'g*');
ritac2(realsols(:,1),r-ransac_t,'g-');
ritac2(realsols(:,1),r+ransac_t,'g-');

axis off
rita(mbox,'b');



%%

if 1,
    figure(1),
    print -dpdf ransac_circle_1.pdf
    figure(2),
    print -dpdf ransac_circle_2.pdf
    figure(3),
    print -dpdf ransac_circle_3.pdf
    
    
    figure(1),
    print -djpeg ransac_circle_1.jpg
    figure(2),
    print -djpeg ransac_circle_2.jpg
    figure(3),
    print -djpeg ransac_circle_3.jpg
    
    
end

