function [ features ] = sample_normalize_v3( I , I_size )
%SAMPLE_NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

% matrix = [];
count = 0;
rows = I_size(1);
cols = I_size(2);

I = double(I);
I = padarray(I,[3 3]);

for x = 4:size(I,1)-3
	for y = 4:size(I,2) - 3
		center = [x y];
		samples = I(x-3:x+3 , y-3:y+3);
        a = samples(1,:);
        b = samples(2:end,end);
        c = samples(end,end-1:-1:1);
        d = samples(end-1:-1:2,1);
        X = [a b' c d'];
		%X = reshape(samples,[1 25]);
        %X = [samples(1,:);samples(end,:);samples(:,1);samples(:,end)];
        X = reshape(X,[1 24]);
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
