function [ out_hist ] = make_hist( input )

temp = zeros(256, size(input,2));

for i = 1 : size(input,2)
	col = input(:,i);
	col_hist = accumarray(col(:)+1,1);
	col_hist = [col_hist ; zeros(256 - numel(col_hist),1)];
	temp(:,i) = col_hist;
	% out_hist = [out_hist ; col_hist];
end

out_hist = reshape(temp,[1 numel(temp)]);
out_hist = out_hist - 1;

end