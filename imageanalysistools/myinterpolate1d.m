function W = myinterpolate1d(w,xlist,interpfun);
% W = myinterpolate1d(w,xlist,interpfun);

i = 1:length(w);
W = zeros(size(xlist));
for k = 1:length(xlist);
    x = xlist(k);
    W(k) = sum(feval(interpfun,x-i).*w);
    % W(x) = sum_i w(i) h(x-i)
end
