%% This script generates concatenated histograms for all train images, and applies pca to them.

files = dir('./mytrain/*.jpg');

files = {files.name};

cat_all_mouths = [];
cat_all_noses = [];
cat_all_left_eyes = [];
cat_all_right_eyes = [];
cat_all_left_cheeks = [];
cat_all_right_cheeks = [];
temp = [];

for i = 1 : size(files,2)

	i
	I = imread(strcat('./mytrain/',files{i}));
	
	[sample_lt_eye, sample_rt_eye, sample_lt_cheek, sample_rt_cheek, sample_nose, sample_mouth] = get_normalized_features( I );
	
	%%%%%%%%%   Add concatenated histograms only if samples exist
	
%----------Left Eye----------------------------------
	
	if( size(sample_lt_eye,1) > 1 )
		Code_lt_eye_1 = zeros(1,864);
		for i = 1:864
			% Left eye
			L1 = sample_lt_eye(:,i);
			diff1 = LEC - repmat(L1,[1 256]);
			vals1 = sum(diff1.^2,1);
			[val1 ind1] = max(vals1);
			Code_lt_eye_1(i) = ind1;
		end
		Code_lt_eye_1 = reshape(Code_lt_eye_1, [24 36]);
		
		patch_left_eye_1 = im2col(Code_lt_eye_1,[12 12],'distinct');
		
		cat_left_eye_1 = make_hist(patch_left_eye_1);
		
		cat_all_left_eyes = [cat_all_left_eyes ; cat_left_eye_1];
	end
	
%--------------Right Eye-------------------------------
	
	if(size(sample_rt_eye,1) > 1)
		Code_rt_eye_1 = zeros(1,864);
		for i = 1:864
			% Right eyes
			R1 = sample_rt_eye(:,i);
			diff1 = REC - repmat(R1,[1 256]);
			vals1 = sum(diff1.^2,1);
			[val1 ind1] = max(vals1);
			Code_rt_eye_1(i) = ind1;
		end
		Code_rt_eye_1 = reshape(Code_rt_eye_1, [24 36]);
		
		patch_right_eye_1 = im2col(Code_rt_eye_1,[12 12],'distinct');

		cat_right_eye_1 = make_hist(patch_right_eye_1);
		
		cat_all_right_eyes = [cat_all_right_eyes ; cat_right_eye_1];
	end

%------------Left Cheek----------------------------------------

	if(size(sample_lt_cheek,1) > 1)
		Code_lt_cheek_1 = zeros(1,1564);
		for i = 1:1564
			% Left cheeks
			L1 = sample_lt_cheek(:,i);
			diff1 = LCC - repmat(L1,[1 256]);
			vals1 = sum(diff1.^2,1);
			[val1 ind1] = max(vals1);
			Code_lt_cheek_1(i) = ind1;
		end
		Code_lt_cheek_1 = reshape(Code_lt_cheek_1, [46 34]);

		patch_left_cheek_1 = im2col(Code_lt_cheek_1,[23 17],'distinct');
		
		cat_left_cheek_1 = make_hist(patch_left_cheek_1);
		
		cat_all_left_cheeks = [cat_all_left_cheeks ; cat_left_cheek_1];
	end
	
%---------------Right Cheek-----------------------------------
	
	if(size(sample_rt_cheek,1) > 1)
		Code_lt_cheek_1 = zeros(1,1564);
		for i = 1:1564
			% Right eyes
			R1 = sample_rt_cheek(:,i);
			diff1 = RCC - repmat(R1,[1 256]);
			vals1 = sum(diff1.^2,1);
			[val1 ind1] = max(vals1);
			Code_rt_cheek_1(i) = ind1;
		end
		Code_rt_cheek_1 = reshape(Code_rt_cheek_1, [46 34]);
		
		patch_right_cheek_1 = im2col(Code_rt_cheek_1,[23 17],'distinct');
		
		cat_right_cheek_1 = make_hist(patch_right_cheek_1);
		
		cat_all_right_cheeks = [cat_all_right_cheeks ; cat_right_cheek_1];
	end
	
%------------Nose----------------------------------------------
	
	if(size(sample_nose,1) > 1)
		Code_nose_1 = zeros(1,1824);
		for i = 1:1824
			N1 = sample_nose(:,i);
			diff1 = NC - repmat(N1,[1 256]);
			vals1 = sum(diff1.^2,1);
			[val1 ind1] = max(vals1);
			Code_nose_1(i) = ind1;
		end
		Code_nose_1 = reshape(Code_nose_1, [76 24]);
		
		patch_nose_1 = im2col(Code_nose_1,[19 12],'distinct');
		
		cat_nose_1 = make_hist(patch_nose_1);
		
		cat_all_noses = [cat_all_noses ; cat_nose_1];
	end

%------------------Mouth-----------------------------------------
	
	if(size(sample_mouth,1) > 1)
		Code_mouth_1 = zeros(1,1824);
		for i = 1:1824
			M1 = sample_mouth(:,i);
			diff1 = MC - repmat(M1,[1 256]);
			vals1 = sum(diff1.^2,1);
			[val1 ind1] = max(vals1);
			Code_mouth_1(i) = ind1;
		end
		Code_mouth_1 = reshape(Code_mouth_1, [24 76]);
		
		% Mouth ->  [24 76] -> patches are [12 19]
		patch_mouth_1 = im2col(Code_mouth_1,[12 19],'distinct');

		cat_mouth_1 = make_hist(patch_mouth_1);
		
		cat_all_mouths = [cat_all_mouths ; cat_mouth_1];
	end
	
%------------------------------------------------------------------------------------------
	
end