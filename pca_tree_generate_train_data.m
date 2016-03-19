
files = dir('./pca_mytrain/*.jpg');

files = {files.name};

cat_all_mouths = [];
cat_all_noses = [];
cat_all_left_eyes = [];
cat_all_right_eyes = [];
cat_all_left_cheeks = [];
cat_all_right_cheeks = [];
temp = [];

for idx = 1 : size(files,2)

	disp(idx);
	I = imread(strcat('./mytrain/',files{idx}));
	
	[sample_lt_eye, sample_rt_eye, sample_lt_cheek, sample_rt_cheek, sample_nose, sample_mouth] = get_normalized_features( I );
	
	
%----------Left Eye----------------------------------
	
	if( size(sample_lt_eye,1) > 1 )
		Code_lt_eye_1 = zeros(1,864);
		for i=1:864
			L1 = sample_lt_eye(:,i);
			code = [];
			current_node = 1;
			level = 0;
			while level < 8
				current_thresh = threshLE(current_node);
				dot_product = vecLE(current_node,:)*L1;
				if dot_product <= current_thresh & leftLE(current_node) > 0
					code = [0 code];
					current_node = leftLE(current_node);
					level = level + 1;
				elseif dot_product > current_thresh & rightLE(current_node) > 0
					code = [1 code];
					current_node = rightLE(current_node);
					level = level + 1;
				end
			end
			str_x = num2str(code);
			str_x(isspace(str_x)) = '';
			Code_lt_eye_1(i) = bin2dec(str_x);
		end
		Code_lt_eye_1 = reshape(Code_lt_eye_1, [24 36]);
		
		patch_left_eye_1 = im2col(Code_lt_eye_1,[12 12],'distinct');
		
		cat_left_eye_1 = make_hist(patch_left_eye_1);
		
		cat_all_left_eyes = [cat_all_left_eyes ; cat_left_eye_1];
	end
	
%--------------Right Eye-------------------------------
	
	if(size(sample_rt_eye,1) > 1)
		Code_rt_eye_1 = zeros(1,864);
		for i=1:864
			R1 = sample_rt_eye(:,i);
			code = [];
			current_node = 1;
			level = 0;
			while level < 8
				current_thresh = threshRE(current_node);
				dot_product = vecRE(current_node,:)*R1;
				if dot_product <= current_thresh & leftRE(current_node) > 0
					code = [0 code];
					current_node = leftRE(current_node);
					level = level + 1;
				elseif dot_product > current_thresh & rightRE(current_node) > 0
					code = [1 code];
					current_node = rightRE(current_node);
					level = level + 1;
				end
			end
			str_x = num2str(code);
			str_x(isspace(str_x)) = '';
			Code_rt_eye_1(i) = bin2dec(str_x);
		end
		Code_rt_eye_1 = reshape(Code_rt_eye_1, [24 36]);
		
		patch_right_eye_1 = im2col(Code_rt_eye_1,[12 12],'distinct');

		cat_right_eye_1 = make_hist(patch_right_eye_1);
		
		cat_all_right_eyes = [cat_all_right_eyes ; cat_right_eye_1];
	end

%------------Left Cheek----------------------------------------

	if(size(sample_lt_cheek,1) > 1)
		Code_lt_cheek_1 = zeros(1,1564);
		for i=1:1564
			LC1 = sample_lt_cheek(:,i);
			code = [];
			current_node = 1;
			level = 0;
			while level < 8
				current_thresh = threshLC(current_node);
				dot_product = vecLC(current_node,:)*LC1;
				if dot_product <= current_thresh & leftLC(current_node) > 0
					code = [0 code];
					current_node = leftLC(current_node);
					level = level + 1;
				elseif dot_product > current_thresh & rightLC(current_node) > 0
					code = [1 code];
					current_node = rightLC(current_node);
					level = level + 1;
				end
			end
			str_x = num2str(code);
			str_x(isspace(str_x)) = '';
			Code_lt_cheek_1(i) = bin2dec(str_x);
		end
		Code_lt_cheek_1 = reshape(Code_lt_cheek_1, [46 34]);

		patch_left_cheek_1 = im2col(Code_lt_cheek_1,[23 17],'distinct');
		
		cat_left_cheek_1 = make_hist(patch_left_cheek_1);
		
		cat_all_left_cheeks = [cat_all_left_cheeks ; cat_left_cheek_1];
	end
	
%---------------Right Cheek-----------------------------------
	
	if(size(sample_rt_cheek,1) > 1)
		Code_rt_cheek_1 = zeros(1,1564);
		for i=1:1564
			RC1 = sample_rt_cheek(:,i);
			code = [];
			current_node = 1;
			level = 0;
			while level < 8
				current_thresh = threshRC(current_node);
				dot_product = vecRC(current_node,:)*RC1;
				if dot_product <= current_thresh & leftRC(current_node) > 0
					code = [0 code];
					current_node = leftRC(current_node);
					level = level + 1;
				elseif dot_product > current_thresh & rightRC(current_node) > 0
					code = [1 code];
					current_node = rightRC(current_node);
					level = level + 1;
				end
			end
			str_x = num2str(code);
			str_x(isspace(str_x)) = '';
			Code_rt_cheek_1(i) = bin2dec(str_x);
		end
		Code_rt_cheek_1 = reshape(Code_rt_cheek_1, [46 34]);
		
		patch_right_cheek_1 = im2col(Code_rt_cheek_1,[23 17],'distinct');
		
		cat_right_cheek_1 = make_hist(patch_right_cheek_1);
		
		cat_all_right_cheeks = [cat_all_right_cheeks ; cat_right_cheek_1];
	end
	
%------------Nose----------------------------------------------
	
	if(size(sample_nose,1) > 1)
		Code_nose_1 = zeros(1,1824);
		for i=1:1824
			N1 = sample_nose(:,i);
			code = [];
			current_node = 1;
			level = 0;
			while level < 8
				current_thresh = threshN(current_node);
				dot_product = vecN(current_node,:)*N1;
				if dot_product <= current_thresh & leftN(current_node) > 0
					code = [0 code];
					current_node = leftN(current_node);
					level = level + 1;
				elseif dot_product > current_thresh & rightN(current_node) > 0
					code = [1 code];
					current_node = rightN(current_node);
					level = level + 1;
				end
			end
			str_x = num2str(code);
			str_x(isspace(str_x)) = '';
			Code_nose_1(i) = bin2dec(str_x);
		end
		Code_nose_1 = reshape(Code_nose_1, [76 24]);
		
		patch_nose_1 = im2col(Code_nose_1,[19 12],'distinct');
		
		cat_nose_1 = make_hist(patch_nose_1);
		
		cat_all_noses = [cat_all_noses ; cat_nose_1];
	end

%------------------Mouth-----------------------------------------
	
	if(size(sample_mouth,1) > 1)
		Code_mouth_1 = zeros(1,1824);
		for i=1:1824
			M1 = sample_mouth(:,i);
			code = [];
			current_node = 1;
			level = 0;
			while level < 8
				current_thresh = threshM(current_node);
				dot_product = vecM(current_node,:)*M1;
				if dot_product <= current_thresh & leftM(current_node) > 0
					code = [0 code];
					current_node = leftM(current_node);
					level = level + 1;
				elseif dot_product > current_thresh & rightM(current_node) > 0
					code = [1 code];
					current_node = rightM(current_node);
					level = level + 1;
				end
			end
			str_x = num2str(code);
			str_x(isspace(str_x)) = '';
			Code_mouth_1(i) = bin2dec(str_x);
		end
		Code_mouth_1 = reshape(Code_mouth_1, [24 76]);
		
		patch_mouth_1 = im2col(Code_mouth_1,[12 19],'distinct');

		cat_mouth_1 = make_hist(patch_mouth_1);
		
		cat_all_mouths = [cat_all_mouths ; cat_mouth_1];
	end
	
%------------------------------------------------------------------------------------------
end	