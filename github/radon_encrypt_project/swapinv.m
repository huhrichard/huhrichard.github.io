function A = swapinv(dim, key)

s = diag(ones(dim,1));
A = s(key,:);
A = A';

end