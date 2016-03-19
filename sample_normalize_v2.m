function [ features ] = sample_normalize_v2( I , I_size )
%SAMPLE_NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

% matrix = [];
count = 0;
rows = I_size(1);
cols = I_size(2);

I = double(I);
I = padarray(I,[1 1]);

for x = 2:size(I,1)-1
	for y = 2:size(I,2) - 1
		center = [x y];
		samples = I(x-1:x+1 , y-1:y+1);
		X = reshape(samples,[1 9]);
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

