function h = h2(x);

h = zeros(size(x));
i = find( (x>-1) & (x<=0) );
h(i) = 1*(x(i)+1);
i = find( (x>0) & (x<=1) );
h(i) = -1*(x(i)-1);
