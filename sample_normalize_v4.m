function [ features ] = sample_normalize_v4( I , I_size )
%SAMPLE_NORMALIZE Summary of this function goes here
%   Detailed explanation goes here

% matrix = [];
count = 0;
rows = I_size(1);
cols = I_size(2);

I = double(I);
I = padarray(I,[7 7]);

for x = 8:size(I,1)-7
	for y = 8:size(I,2) - 7
		center = [x y];
		samples = I(x-7:x+7 , y-7:y+7);
        a = samples(1,7:9);
        b = samples(4,7:9);
        c = samples(12,7:9);
        d = samples(15,7:9);
        e = samples(7:9,1);
        f = samples(7:9,4);
        g = samples(7:9,12);
        h = samples(7:9,15);
        X = [a b c d e' f' g' h'];
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

