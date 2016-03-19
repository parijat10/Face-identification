function [ DoG_image ] = DoG_filter( im1 , sigma1 , sigma2 )
%DOG_FILTER Summary of this function goes here
%   Detailed explanation goes here

Gauss1 = fspecial('gaussian',sigma1);
Gauss2 = fspecial('gaussian',sigma2);

blur1 = imfilter(im1,Gauss1);
blur2 = imfilter(im1,Gauss2);

if(sigma1 > sigma2)
	DoG_image = double(blur2) - double(blur1);
else
	DoG_image = double(blur1) - double(blur2);
end


end