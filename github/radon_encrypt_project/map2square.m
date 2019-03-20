function square_image = map2square(input)
s_in = size(input);
s_sq = 1.5*max(s_in);


z_row = floor((s_sq-s_in(1))/2);
z_col = floor((s_sq-s_in(2))/2);
z = zeros(z_row, z_col);

square_image = blkdiag(z,input,z);
%s_sq = size(square_image);

% if s_sq(1) > s_sq(2)
% 	% fill in column
% 	square_image = [input ones(s_sq(1),s_sq(1)-s_sq(2))];
% else
% 	% fill in row
% 	square_image = [input; ones(s_sq(2)-s_sq(1), s_sq(2))];
% end	

end