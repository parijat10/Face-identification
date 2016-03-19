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

%% Loop for eyes of both images

Code_lt_eye_1 = zeros(1,864);           Code_rt_eye_1 = zeros(1,864);
Code_lt_eye_2 = zeros(1,864);           Code_rt_eye_2 = zeros(1,864);
for i = 1:864
    % Left eyes
    L1 = sample_lt_eye1(:,i);
    L2 = sample_lt_eye2(:,i);
    diff1 = LEC - repmat(L1,[1 256]);
    diff2 = LEC - repmat(L2,[1 256]);
    vals1 = sum(diff1.^2,1);
    vals2 = sum(diff2.^2,1);
    [val1 ind1] = min(vals1);
    [val2 ind2] = min(vals2);
    Code_lt_eye_1(i) = ind1;
    Code_lt_eye_2(i) = ind2;
    % Right eyes
    R1 = sample_rt_eye1(:,i);
    R2 = sample_rt_eye2(:,i);
    diff1 = REC - repmat(R1,[1 256]);
    diff2 = REC - repmat(R2,[1 256]);
    vals1 = sum(diff1.^2,1);
    vals2 = sum(diff2.^2,1);
    [val1 ind1] = min(vals1);
    [val2 ind2] = min(vals2);
    Code_rt_eye_1(i) = ind1;
    Code_rt_eye_2(i) = ind2;
end
Code_lt_eye_1 = reshape(Code_lt_eye_1, [24 36]);
Code_lt_eye_2 = reshape(Code_lt_eye_2, [24 36]);
Code_rt_eye_1 = reshape(Code_rt_eye_1, [24 36]);
Code_rt_eye_2 = reshape(Code_rt_eye_2, [24 36]);


%% Loop for cheeks of both images

Code_lt_cheek_1 = zeros(1,1564);           Code_rt_cheek_1 = zeros(1,1564);
Code_lt_cheek_2 = zeros(1,1564);           Code_rt_cheek_2 = zeros(1,1564);
for i = 1:1564
    % Left cheeks
    L1 = sample_lt_cheek1(:,i);
    L2 = sample_lt_cheek2(:,i);
    diff1 = LCC - repmat(L1,[1 256]);
    diff2 = LCC - repmat(L2,[1 256]);
    vals1 = sum(diff1.^2,1);
    vals2 = sum(diff2.^2,1);
    [val1 ind1] = min(vals1);
    [val2 ind2] = min(vals2);
    Code_lt_cheek_1(i) = ind1;
    Code_lt_cheek_2(i) = ind2;
    % Right eyes
    R1 = sample_rt_cheek1(:,i);
    R2 = sample_rt_cheek2(:,i);
    diff1 = RCC - repmat(R1,[1 256]);
    diff2 = RCC - repmat(R2,[1 256]);
    vals1 = sum(diff1.^2,1);
    vals2 = sum(diff2.^2,1);
    [val1 ind1] = min(vals1);
    [val2 ind2] = min(vals2);
    Code_rt_cheek_1(i) = ind1;
    Code_rt_cheek_2(i) = ind2;
end
Code_lt_cheek_1 = reshape(Code_lt_cheek_1, [46 34]);
Code_lt_cheek_2 = reshape(Code_lt_cheek_2, [46 34]);
Code_rt_cheek_1 = reshape(Code_rt_cheek_1, [46 34]);
Code_rt_cheek_2 = reshape(Code_rt_cheek_2, [46 34]);


%% Loop for noses/mouths of both images
Code_mouth_1 = zeros(1,1824);           Code_mouth_2 = zeros(1,1824);
Code_nose_1 = zeros(1,1824);           Code_nose_2 = zeros(1,1824);
for i = 1:1824
    % Left cheeks
    M1 = sample_mouth1(:,i);
    M2 = sample_mouth2(:,i);
    diff1 = MC - repmat(M1,[1 256]);
    diff2 = MC - repmat(M2,[1 256]);
    vals1 = sum(diff1.^2,1);
    vals2 = sum(diff2.^2,1);
    [val1 ind1] = min(vals1);
    [val2 ind2] = min(vals2);
    Code_mouth_1(i) = ind1;
    Code_mouth_2(i) = ind2;
    % Right eyes
    N1 = sample_nose1(:,i);
    N2 = sample_nose2(:,i);
    diff1 = NC - repmat(N1,[1 256]);
    diff2 = NC - repmat(N2,[1 256]);
    vals1 = sum(diff1.^2,1);
    vals2 = sum(diff2.^2,1);
    [val1 ind1] = min(vals1);
    [val2 ind2] = min(vals2);
    Code_nose_1(i) = ind1;
    Code_nose_2(i) = ind2;
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