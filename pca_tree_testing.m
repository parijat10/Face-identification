name1 = './test_folder/2.jpg';
name2 = './test_folder/4.jpg';

disp(name1);
disp(name2);

I1 = imread(name1);
I2 = imread(name2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         OBTAIN THE TEST SAMPLES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[sample_lt_eye1, sample_rt_eye1, sample_lt_cheek1, sample_rt_cheek1, sample_nose1, sample_mouth1] = get_normalized_features( I1 );
[sample_lt_eye2, sample_rt_eye2, sample_lt_cheek2, sample_rt_cheek2, sample_nose2, sample_mouth2] = get_normalized_features( I2 );

if(numel(sample_lt_cheek1)>1 & numel(sample_lt_cheek2)>1 & numel(sample_lt_eye1)>1 &...
   numel(sample_lt_eye2)>1   & numel(sample_mouth1)>1    & numel(sample_mouth2)>1  &...
   numel(sample_nose1)>1     & numel(sample_nose2)>1     & numel(sample_rt_cheek1)>1 &...
   numel(sample_rt_cheek2)>1 & numel(sample_rt_eye1)>1   & numel(sample_rt_eye2)>1 )
		
		%% Loop for eyes of both images
		Code_lt_eye_1 = zeros(1,864);
		Code_lt_eye_2 = zeros(1,864);
		Code_rt_eye_1 = zeros(1,864);
		Code_rt_eye_2 = zeros(1,864);
		for i=1:864
			L1 = sample_lt_eye1(:,i);
			L2 = sample_lt_eye2(:,i);
			code1 = [];
			code2 = [];
			current_node1 = 1;
			current_node2 = 1;
			level1 = 0;
			level2 = 0;
			while level1 < 8 & level2 < 8
				current_thresh1 = threshLE(current_node1);
				current_thresh2 = threshLE(current_node2);
				dot_product1 = vecLE(current_node1,:)*L1;
				dot_product2 = vecLE(current_node2,:)*L2;
				
				if dot_product1 <= current_thresh1 & leftLE(current_node1) > 0
					code1 = [0 code1];
					current_node1 = leftLE(current_node1);
					level1 = level1 + 1;
				elseif dot_product1 > current_thresh1 & rightLE(current_node1) > 0
					code1 = [1 code1];
					current_node1 = rightLE(current_node1);
					level1 = level1 + 1;
				end
				
				if dot_product2 <= current_thresh2 & leftLE(current_node2) > 0
					code2 = [0 code2];
					current_node2 = leftLE(current_node2);
					level2 = level2 + 1;
				elseif dot_product2 > current_thresh2 & rightLE(current_node2) > 0
					code2 = [1 code2];
					current_node2 = rightLE(current_node2);
					level2 = level2 + 1;
				end
				
			end
			str_x1 = num2str(code1);
			str_x1(isspace(str_x1)) = '';
			str_x2 = num2str(code2);
			str_x2(isspace(str_x2)) = '';
			
			Code_lt_eye_1(i) = bin2dec(str_x1);
			Code_lt_eye_2(i) = bin2dec(str_x2);
		end
		Code_lt_eye_1 = reshape(Code_lt_eye_1, [24 36]);
		Code_lt_eye_2 = reshape(Code_lt_eye_2, [24 36]);
		Code_rt_eye_1 = reshape(Code_rt_eye_1, [24 36]);
		Code_rt_eye_2 = reshape(Code_rt_eye_2, [24 36]);


		%% Loop for cheeks of both images

		Code_lt_cheek_1 = zeros(1,1564);           Code_rt_cheek_1 = zeros(1,1564);
		Code_lt_cheek_2 = zeros(1,1564);           Code_rt_cheek_2 = zeros(1,1564);
		for i=1:1564
			LC1 = sample_lt_cheek(:,i);
			LC2 = sample_lt_cheek(:,i);
			RC1 = sample_lt_cheek(:,i);
			RC2 = sample_lt_cheek(:,i);
			codelc1 = [];
			coderc1 = [];
			codelc2 = [];
			coderc2 = [];
			current_nodelc1 = 1;
			current_nodelc2 = 1;
			current_noderc1 = 1;
			current_noderc2 = 1;
			levellc1 = 0;
			levellc2 = 0;
			levelrc1 = 0;
			levelrc2 = 0;
			while levellc1 < 8 & levellc2 < 8 & levelrc1 < 8 & levelrc2 < 8
				current_threshlc1 = threshLC(current_nodelc1);
				current_threshlc2 = threshLC(current_nodelc2);
				current_threshrc1 = threshRC(current_noderc1);
				current_threshrc2 = threshRC(current_noderc2);
				
				dot_productlc1 = vecLC(current_nodelc1,:)*LC1;
				if dot_productlc1 <= current_threshlc1 & leftLC(current_nodelc1) > 0
					codelc1 = [0 codelc1];
					current_nodelc1 = leftLC(current_nodelc1);
					levellc1 = levellc1 + 1;
				elseif dot_productlc1 > current_threshlc1 & rightLC(current_nodelc1) > 0
					codelc1 = [1 codelc1];
					current_nodelc1 = rightLC(current_nodelc1);
					levellc1 = levellc1 + 1;
				end
				
				dot_productlc2 = vecLC(current_nodelc2,:)*LC2;
				if dot_productlc2 <= current_threshlc2 & leftLC(current_nodelc2) > 0
					codelc2 = [0 codelc2];
					current_nodelc2 = leftLC(current_nodelc2);
					levellc2 = levellc2 + 1;
				elseif dot_productlc2 > current_threshlc2 & rightLC(current_nodelc2) > 0
					codelc2 = [1 codelc2];
					current_nodelc2 = rightLC(current_nodelc2);
					levellc2 = levellc2 + 1;
				end
				
				dot_productrc1 = vecRC(current_noderc1,:)*RC1;
				if dot_productrc1 <= current_threshrc1 & leftRC(current_noderc1) > 0
					coderc1 = [0 coderc1];
					current_noderc1 = leftRC(current_noderc1);
					levelrc1 = levelrc1 + 1;
				elseif dot_productrc1 > current_threshrc1 & rightRC(current_noderc1) > 0
					coderc1 = [1 coderc1];
					current_noderc1 = rightRC(current_noderc1);
					levelrc1 = levelrc1 + 1;
				end
				
				dot_productrc2 = vecLC(current_noderc2,:)*RC2;
				if dot_productrc2 <= current_threshrc2 & leftLC(current_noderc2) > 0
					coderc2 = [0 coderc2];
					current_noderc2 = leftLC(current_noderc2);
					levelrc2 = levelrc2 + 1;
				elseif dot_productrc2 > current_threshrc2 & rightLC(current_noderc2) > 0
					coderc2 = [1 coderc2];
					current_noderc2 = rightLC(current_noderc2);
					levelrc2 = levelrc2 + 1;
				end
				
			end
			str_xlc1 = num2str(codelc1);
			str_xlc1(isspace(str_xlc1)) = '';
			Code_lt_cheek_1(i) = bin2dec(str_xlc1);
			
			str_xlc2 = num2str(codelc2);
			str_xlc2(isspace(str_xlc2)) = '';
			Code_lt_cheek_2(i) = bin2dec(str_xlc2);
			
			str_xrc1 = num2str(coderc1);
			str_xrc1(isspace(str_xrc1)) = '';
			Code_rt_cheek_1(i) = bin2dec(str_xrc1);
			
			str_xrc2 = num2str(coderc2);
			str_xrc2(isspace(str_xrc2)) = '';
			Code_rt_cheek_2(i) = bin2dec(str_xrc2);
		end
		Code_lt_cheek_1 = reshape(Code_lt_cheek_1, [46 34]);
		Code_lt_cheek_2 = reshape(Code_lt_cheek_2, [46 34]);
		Code_rt_cheek_1 = reshape(Code_rt_cheek_1, [46 34]);
		Code_rt_cheek_2 = reshape(Code_rt_cheek_2, [46 34]);


		%% Loop for noses/mouths of both images
		Code_mouth_1 = zeros(1,1824);           Code_mouth_2 = zeros(1,1824);
		Code_nose_1 = zeros(1,1824);           Code_nose_2 = zeros(1,1824);
		for i=1:1824
			M1 = sample_mouth1(:,i);
			M2 = sample_mouth2(:,i);
			N1 = sample_nose1(:,i);
			N2 = sample_nose2(:,i);
			codem1 = [];
			codem2 = [];
			coden1 = [];
			coden2 = [];
			current_nodem1 = 1;
			current_nodem2 = 1;
			current_noden1 = 1;
			current_noden2 = 1;
			levelm1 = 0;
			levelm2 = 0;
			leveln1 = 0;
			leveln2 = 0;
			while levelm1 < 8 & levelm2 < 8 & leveln1 < 8 & leveln2 < 8
				current_threshm1 = threshM(current_nodem1);
				current_threshm2 = threshM(current_nodem2);
				current_threshn1 = threshN(current_noden1);
				current_threshn2 = threshN(current_noden2);
				
				dot_productm1 = vecM(current_nodem1,:)*M1;
				if dot_productm1 <= current_threshm1 & leftM(current_nodem1) > 0
					codem1 = [0 codem1];
					current_nodem1 = leftM(current_nodem1);
					levelm1 = levelm1 + 1;
				elseif dot_productm1 > current_threshm1 & rightM(current_nodem1) > 0
					codem1 = [1 codem1];
					current_nodem1 = rightM(current_nodem1);
					levelm1 = levelm1 + 1;
				end
				
				dot_productm2 = vecM(current_nodem2,:)*M2;
				if dot_productm2 <= current_threshm2 & leftM(current_nodem2) > 0
					codem2 = [0 codem2];
					current_nodem2 = leftM(current_nodem2);
					levelm2 = levelm2 + 1;
				elseif dot_productm2 > current_threshm2 & rightM(current_nodem2) > 0
					codem2 = [1 codem2];
					current_nodem2 = rightM(current_nodem2);
					levelm2 = levelm2 + 1;
				end
				
				dot_productn1 = vecN(current_noden1,:)*N1;
				if dot_productn1 <= current_threshn1 & leftN(current_noden1) > 0
					coden1 = [0 coden1];
					current_noden1 = leftN(current_noden1);
					leveln1 = leveln1 + 1;
				elseif dot_productn1 > current_threshn1 & rightN(current_noden1) > 0
					coden1 = [1 coden1];
					current_noden1 = rightN(current_noden1);
					leveln1 = leveln1 + 1;
				end
				
				dot_productn2 = vecM(current_noden2,:)*N2;
				if dot_productn2 <= current_threshn2 & leftN(current_noden2) > 0
					coden2 = [0 coden2];
					current_noden2 = leftN(current_noden2);
					leveln2 = leveln2 + 1;
				elseif dot_productn2 > current_threshn2 & rightN(current_noden2) > 0
					coden2 = [1 coden2];
					current_noden2 = rightN(current_noden2);
					leveln2 = leveln2 + 1;
				end
				
			end
			str_xm1 = num2str(codem1);
			str_xm1(isspace(str_xm1)) = '';
			Code_mouth_1(i) = bin2dec(str_xm1);
			
			str_xm2 = num2str(codem2);
			str_xm2(isspace(str_xm2)) = '';
			Code_mouth_2(i) = bin2dec(str_xm2);
			
			str_xn1 = num2str(coden1);
			str_xn1(isspace(str_xn1)) = '';
			Code_nose_1(i) = bin2dec(str_xn1);
			
			str_xn2 = num2str(coden2);
			str_xn2(isspace(str_xn2)) = '';
			Code_nose_2(i) = bin2dec(str_xn2);
		end
		Code_mouth_1 = reshape(Code_mouth_1, [24 76]);
		Code_mouth_2 = reshape(Code_mouth_2, [24 76]);
		Code_nose_1 = reshape(Code_nose_1, [76 24]);
		Code_nose_2 = reshape(Code_nose_2, [76 24]);


		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%               MAKE PATCH FROM TEST SAMPLES
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		% Nose ->   [76 24] -> patches are [19 12]
		patch_nose_1 = im2col(Code_nose_1,[19 12],'distinct');
		patch_nose_2 = im2col(Code_nose_2,[19 12],'distinct');

		% Mouth ->  [24 76] -> patches are [12 19]
		patch_mouth_1 = im2col(Code_mouth_1,[12 19],'distinct');
		patch_mouth_2 = im2col(Code_mouth_2,[12 19],'distinct');

		% Eyes  ->  [24 36] -> patches are [12 12]
		patch_left_eye_1 = im2col(Code_lt_eye_1,[12 12],'distinct');
		patch_left_eye_2 = im2col(Code_lt_eye_2,[12 12],'distinct');

		patch_right_eye_1 = im2col(Code_rt_eye_1,[12 12],'distinct');
		patch_right_eye_2 = im2col(Code_rt_eye_2,[12 12],'distinct');

		% Cheeks -> [46 34] -> patches are [23 17]
		patch_left_cheek_1 = im2col(Code_lt_cheek_1,[23 17],'distinct');
		patch_left_cheek_2 = im2col(Code_lt_cheek_2,[23 17],'distinct');

		patch_right_cheek_1 = im2col(Code_rt_cheek_1,[23 17],'distinct');
		patch_right_cheek_2 = im2col(Code_rt_cheek_2,[23 17],'distinct');


		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%            MAKE CONCATENATED HISTOGRAM FROM ABOVE PATCHES
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		cat_mouth_1 = make_hist(patch_mouth_1);
		cat_mouth_2 = make_hist(patch_mouth_2);

		cat_nose_1 = make_hist(patch_nose_1);
		cat_nose_2 = make_hist(patch_nose_2);

		cat_left_eye_1 = make_hist(patch_left_eye_1);
		cat_left_eye_2 = make_hist(patch_left_eye_2);

		cat_right_eye_1 = make_hist(patch_right_eye_1);
		cat_right_eye_2 = make_hist(patch_right_eye_2);

		cat_left_cheek_1 = make_hist(patch_left_cheek_1);
		cat_left_cheek_2 = make_hist(patch_left_cheek_2);

		cat_right_cheek_1 = make_hist(patch_right_cheek_1);
		cat_right_cheek_2 = make_hist(patch_right_cheek_2);

		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%               PCA ON THE HISTOGRAMS AND CALCULATION OF DISTANCE
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		% eigen_all_mouths = pca_hist(cat_all_mouths, 400);
		% eigen_all_noses = pca_hist(cat_all_noses, 400);
		% eigen_all_left_eyes = pca_hist(cat_all_left_eyes, 400);
		% eigen_all_right_eyes = pca_hist(cat_all_right_eyes, 400);
		% eigen_all_left_cheeks = pca_hist(cat_all_left_cheeks, 400);
		% eigen_all_right_cheeks = pca_hist(cat_all_right_cheeks, 400);

		%%%%%%%%%%%%%%%%%%%%%%%%%%    MOUTH    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		cat_mouths = [cat_mouth_1 ; cat_mouth_2];
		final_mouths = cat_mouths * eigen_all_mouths;

		%%%%%%%%%%%%%%%%%%%%%%%%%%    NOSE    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		cat_noses = [cat_nose_1 ; cat_nose_2];
		final_noses = cat_noses * eigen_all_noses;

		%%%%%%%%%%%%%%%%%%%%%%%%%%    LEFT EYE    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		cat_left_eyes = [cat_left_eye_1 ; cat_left_eye_2];
		final_left_eyes = cat_left_eyes * eigen_all_left_eyes;

		%%%%%%%%%%%%%%%%%%%%%%%%%%    RIGHT EYE    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		cat_right_eyes = [cat_right_eye_1 ; cat_right_eye_2];
		final_right_eyes = cat_right_eyes * eigen_all_right_eyes;

		%%%%%%%%%%%%%%%%%%%%%%%%%%    LEFT CHEEK    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		cat_left_cheeks = [cat_left_cheek_1 ; cat_left_cheek_2];
		final_left_cheeks = cat_left_cheeks * eigen_all_left_cheeks;

		%%%%%%%%%%%%%%%%%%%%%%%%%%    RIGHT CHEEK    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		cat_right_cheeks = [cat_right_cheek_1 ; cat_right_cheek_2];
		final_right_cheeks = cat_right_cheeks * eigen_all_right_cheeks;


		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%               NORMALIZE THE RESULT AND FIND DIFFERENCE
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

		for i = 1 : 2
			final_left_cheeks(i,:) = final_left_cheeks(i,:)/norm(final_left_cheeks(i,:));
			final_left_eyes(i,:) = final_left_eyes(i,:)/norm(final_left_eyes(i,:));
			final_mouths(i,:) = final_mouths(i,:)/norm(final_mouths(i,:));
			final_noses(i,:) = final_noses(i,:)/norm(final_noses(i,:));
			final_right_cheeks(i,:) = final_right_cheeks(i,:)/norm(final_right_cheeks(i,:));
			final_right_eyes(i,:) = final_right_eyes(i,:)/norm(final_right_eyes(i,:));
		end


		diff_mouths = sum((final_mouths(1,:) - final_mouths(2,:)).^2);
		diff_noses = sum((final_noses(1,:) - final_noses(2,:)).^2);
		diff_left_eyes = sum((final_left_eyes(1,:) - final_left_eyes(2,:)).^2);
		diff_right_eyes = sum((final_right_eyes(1,:) - final_right_eyes(2,:)).^2);
		diff_right_cheeks = sum((final_right_cheeks(1,:) - final_right_cheeks(2,:)).^2);
		diff_left_cheeks = sum((final_left_cheeks(1,:) - final_left_cheeks(2,:)).^2);


		norm([diff_mouths diff_noses diff_left_eyes diff_right_eyes diff_left_cheeks diff_right_cheeks])

end