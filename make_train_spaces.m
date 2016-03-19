close all;
clear;

files = dir('./mytrain/*.jpg');

Left_Eyes = [];
Right_Eyes = [];
Left_Cheeks = [];
Right_Cheeks = [];
Noses = [];
Mouths = [];

for i = 1:size(files,1)
	disp(files(i).name);
	I = imread(strcat('./mytrain/',files(i).name));
	[sample_lt_eye, sample_rt_eye, sample_lt_cheek, sample_rt_cheek, sample_nose, sample_mouth] = get_normalized_features(I);
	
	%% Add samples to train set only if they are a matrix of size more than 1 (because improper samples are always single element - zero)
	
	if( size(sample_lt_eye,1) > 1 )
		Left_Eyes = [Left_Eyes sample_lt_eye];
	end
	
	if(size(sample_rt_eye,1) > 1)
		Right_Eyes = [Right_Eyes sample_rt_eye];
	end
	
	if(size(sample_lt_cheek,1) > 1)
		Left_Cheeks = [Left_Cheeks sample_lt_cheek];
	end
	
	if(size(sample_rt_cheek,1) > 1)
		Right_Cheeks = [Right_Cheeks sample_rt_cheek];
	end
	
	if(size(sample_nose,1) > 1)
		Noses = [Noses sample_nose];
	end
	
	if(size(sample_mouth,1) > 1)
		Mouths = [Mouths sample_mouth];
	end
end

