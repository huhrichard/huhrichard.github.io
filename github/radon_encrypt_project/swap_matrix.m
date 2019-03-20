function [A, key] = swap_matrix(dim)

s = diag(ones(dim,1));
% q = 20;
% n = floor(dim/q);
% r = rem(dim,q);


key = randperm(dim);
A = s(key,:);

end