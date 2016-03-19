function [ features ] = sample_normalize( I , I_size )
%SAMPLE_NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

% matrix = [];
count = 0;
rows = I_size(1);
cols = I_size(2);

I = double(I);
I = padarray(I,[2 2]);

for x = 3:size(I,1)-2
	for y = 3:size(I,2) - 2
		center = [x y];
		samples = I(x-2:x+2 , y-2:y+2);
		X = reshape(samples,[1 25]);
		count = count + 1;
		% matrix(count,:) = X/norm(X);
		features(count,:) = X/norm(X);
	end
end

features = features';

% for i = 1:25
	% features(:,:,i) = reshape(matrix(i,:) , [rows cols]);
% end

end