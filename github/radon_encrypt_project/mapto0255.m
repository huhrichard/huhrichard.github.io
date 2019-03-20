function x = mapto0255(input)

max_i = max(max(input));
min_i = min(min(input));

dif = max_i-min_i;

x = (input-min_i).*255./dif;

end