function [B] = gauss_low(A, D0)

[m,n,k] = size(A);
if k>1
    A = rgb2gray(A);  %Convert to grayscale if necessary.
end
A = double(A);

%Calculate the distance matrix D.
%for u=1:m
%    for v=1:n
%        D(u,v) = sqrt( (u-m/2)^2 + (v-n/2)^2 );
%    end
%end
[u,v]=meshgrid(1:n,1:m);
D=sqrt( (u-m/2).^2+(v-n/2).^2 );

%Calculate the filter H.
H = exp(-1*(D/D0)/2);

%The convolution theorem says we just use pointwise multiplication.
F_A = fftshift(fft2(A));
B = abs( ifft2( F_A .* H ));

%Convert to 8-bit and display the images.
figure(3);
subplot(121); imshow(A,[]); title('Original');
subplot(122); imshow(B,[]); title('Filtered'); 
colormap gray;

