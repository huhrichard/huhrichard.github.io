%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input image u
% output encrypted image v, key
% Encryption Algorithm:
%	map to a large square	   radon transform		swap column vector and generate key
% u ----------------------> U -----------------> I -----------------------------------> I_swapped
%																							|
%																inverse radon transform		|
% 											output v and key <------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [v, key] = encrypt(input, sentname)

% input image u and transform to gray image
u = img2var(input);
s_u = size(u);

% map image to square matrix first
u = map2square(u); %*(1)

s = max(size(u));
% perform radon transform
theta_0 = 0;
theta_rate = 1.5; %*(2)
theta_end = 180;

theta = theta_0:theta_rate:theta_end;
I = radon(u,theta);

dim_i = size(I);

% generating swap column matrix C and key
[C, key] = swap_matrix(dim_i(2));

% generate the whole key for decryption, add more key: the mean of
% original image, size of sq, size of original image
key = [theta_0, theta_rate, theta_end, mean(mean(u)), s, s_u, key];

% % Perform swapping
I_swapped = I*C;

% inverse radon transform:
v = iradon(I_swapped,theta,'pchip', 'Hamming', 1, s); 
% make sure the size of output is correct, then size of radon transformed data is fit to dimension of key

 x = iradon(I,theta,'pchip', 'Hamming', 1, s);
 r = key(6);
 c = key(7);
 x = x((s-r)/2:(s+r)/2, (s-c)/2:(s+c)/2);
 
var2img(v, sentname);

figure(1);
imshow(x,[]), title('original image recovered by inverse radon transform');
figure(2);
imshow(v,[]), title('sent image after encryption');

end