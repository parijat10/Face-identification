function [ bases ] = pca_hist( input , num_comp )

mymean = mean(input);
sub_input = input - repmat(mymean,[size(input,1) 1]);
tdev = std(input);

for i = 1:size(tdev,2)
    if(tdev(i) > 0)
        sub_input(:,i) = sub_input(:,i)./tdev(i);
    else
        sub_input(:,i) = sub_input(:,i)./size(input,1);
    end
end

S = (sub_input')*sub_input;

[eigvec val] = eig(S);
eigval = diag(val);

final_eigvec = eigvec(:,end:-1:1);

bases = final_eigvec(:,1:num_comp);

% Data is along rows and bases are along columns
% output = bases' * input' ;

% out_mean = mean(output,2);
% sub_mean = output - repmat(out_mean,[1 2]);
% out_std = std(output,0,2);

% for i = 1:size(out_std,1)
    % if(out_std(i) > 0)
        % sub_mean(i,:) = sub_mean(i,:)./out_std(i);
    % else
        % sub_mean(i,:) = sub_mean(i,:)./size(output,2);
    % end
% end

% output_normalised = sub_mean;

end