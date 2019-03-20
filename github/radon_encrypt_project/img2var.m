function u = img2var(imagefile)
a = imread(imagefile);
s = size(size(a));
if( s(2) > 2)
	a = rgb2gray(a);
end
u = double(a);
end

