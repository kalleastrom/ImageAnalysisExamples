%% Demo eigenvalue method TOA trilateration

%% Set up measurement data

r1 = [1;2];
r2 = [3;4];
d1 = 3;
d2 = 3;

%% Write the problem as system of polynomial equations

x = create_vars(2);
eqs(1,1) = (x-r1)'*(x-r1) - d1^2;
eqs(2,1) = (x-r2)'*(x-r2) - d2^2;

eqs2 = [eqs(1)*[1;x];eqs(2)*[1;x]];

[C,mon] = polynomials2matrix(eqs2);
C2 = rref(C);

M = -C2([4 6],[9 10])

[v,d]=eig(M);
v = v./repmat(v(2,:),2,1)

s = [d(1,1);v(1,1)];
s = [d(2,2);v(1,2)];
[d1 norm(s-r1)]
[d2 norm(s-r2)]
