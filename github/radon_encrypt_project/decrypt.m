%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% input image v and key
% output decrypted image
% Encryption Algorithm:
%	radon transform	   decrypted with key  			inverse radon transform
% v ---------------> f -----------------> f_decrypt -----------------------> u'
%																			 |
%								Low pass filter then crop the original size  |
%  				decrypted image <--------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = decrypt(received_image, key, recovered_image)

% deconv

v = img2var(received_image);

% radon transform with deconv image
theta = key(1):key(2):key(3);
f = radon(v,theta);

dim_f = size(f);

%Rinv = swapinv(dim_f(1), key1);
key_size = max(size(key));

Cinv = swapinv(dim_f(2), key(8:key_size));

f = f*Cinv;

s = key(5);
r = key(6);
c = key(7);

output = iradon(f,theta,'pchip','Hamming',1,s);
output = gauss_low(output, max(r)*min(r)/(mean(r))/10); %denoise some 'noise'
output = output((s-r)/2:(s+r)/2, (s-c)/2:(s+c)/2); % fit to original size
% minus the mean of origin image to darken the recover, 
% since inverse radon tends to enlarge the mean (whiter)
output = output - mean(mean(output)) + key(4);


% then normalize it to 0~255
max_i = max(max(output));
min_i = min(min(output));
dif = max_i - min_i;
output = (output - min_i).*255./dif;

var2img(output, recovered_image);

figure(4);
imshow(output,[]); title('recovered');


end