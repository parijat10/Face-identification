function [sample_lt_eye, sample_rt_eye, sample_lt_cheek, sample_rt_cheek, sample_nose, sample_mouth] = get_normalized_features( I )

% clc;
% close all;

%%%%%%%%%%Detect objects using Viola-Jones Algorithm %%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%% To detect Face %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FDetect = vision.CascadeObjectDetector;
BB = step(FDetect,I);

% Crop photo only if face is present
if(size(BB,1))
	mymax = 0;
	for i=1:size(BB,1)
		if(BB(i,3)*BB(i,4) > mymax)
			BBfaceorig = BB(i,:);
			mymax = BB(i,3)*BB(i,4);
		end
	end
	I = imcrop(I,BBfaceorig);
else
	disp('Bad photo.');
	sample_lt_eye 	= 0;
	sample_rt_eye 	= 0;
	sample_lt_cheek = 0;
	sample_rt_cheek = 0;
	sample_nose 	= 0;
	sample_mouth 	= 0;
	return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   To detect Nose   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NoseDetect = vision.CascadeObjectDetector('Nose','MergeThreshold',1);
BBnose=step(NoseDetect,I);

% Find nose indices only if nose detected
if(size(BBnose,1))
	nosesx = BBnose(:,1)+0.5*BBnose(:,3) - 0.5*size(I,2);
	nosesy = BBnose(:,2)+0.5*BBnose(:,4) - 0.5*size(I,1);
	nosesx = nosesx.^2;
	nosesy = nosesy.^2;
	dist = sqrt(nosesx + nosesy);
	[valnose indnose] = min(dist);
	BBnoseorig = BBnose(indnose,:);
	nosex = BBnoseorig(1)+0.5*BBnoseorig(3);
	nosey = BBnoseorig(2)+0.5*BBnoseorig(4);
else
	BBnoseorig = [];
	disp('Bad nose.');
	nosex = 0;
	nosey = 0;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% To detect Mouth %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MouthDetect = vision.CascadeObjectDetector('Mouth','MergeThreshold',10);
BBmouth=step(MouthDetect,I);

% Find mouth indices only if mouth detected
if(size(BBmouth,1))
	[val ind]= max(BBmouth(:,2));
	BBmouthorig = BBmouth(ind,:);
	mouthxleft = BBmouthorig(2)+0.5*BBmouthorig(4);
	mouthyleft = BBmouthorig(1);
	mouthxright = BBmouthorig(2)+0.5*BBmouthorig(4);
	mouthyright = BBmouthorig(1)+BBmouthorig(3);
else
	BBmouthorig = [];
	disp('Bad mouth');
end
%%%%%%%%%%%%%%%%%%%%%% To detect Eyes %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Eyes = vision.CascadeObjectDetector('RightEye');
BBeyes = step(Eyes,I);

% Find eyes only if detected
if(size(BBeyes,1))
	[valreye indreye]= max(BBeyes(:,1));
	[valleye indleye]= min(BBeyes(:,1));
	BBlefteye = BBeyes(indleye,:);
	BBrighteye = BBeyes(indreye,:);
	BBlefteye_row = BBlefteye(2) + 0.5*BBlefteye(4);
	BBlefteye_col = BBlefteye(1) + 0.5*BBlefteye(3);
	BBrighteye_row = BBrighteye(2) + 0.5*BBrighteye(4);
	BBrighteye_col = BBrighteye(1) + 0.5*BBrighteye(3);
else
	BBlefteye = [];
	BBrighteye = [];
	disp('ghanta eyes');
end

%%%%%%%%%%%% window for left eye %%%%%%%%%%%%%%%%%%%

% crop eye only if bounding box exists
if(size(BBlefteye,1))
	left_eye = imresize(rgb2gray(imcrop(I,BBlefteye)), [24 36] );
	DoG_Lt_Eye = DoG_filter(left_eye,1,10);
	sample_lt_eye = sample_normalize(DoG_Lt_Eye,size(DoG_Lt_Eye));
else
	left_eye = 0;
	sample_lt_eye = 0;
end

%%%%%%%%%%%%% window for right eye %%%%%%%%%%%%

% crop eye only if bounding box exists
if(size(BBrighteye,1))
	right_eye = imresize(rgb2gray(imcrop(I,BBrighteye)), [24 36] );
	DoG_Rt_Eye = DoG_filter(right_eye,1,10);
	sample_rt_eye = sample_normalize(DoG_Rt_Eye,size(DoG_Rt_Eye));
else
	right_eye = 0;
	sample_rt_eye = 0;
end

%%%%%%%%%%%%% window for mouth %%%%%%%%%%%%%%%

% crop mouth only if bounding box exists
if(size(BBmouthorig,1))
	mouth = imresize(rgb2gray(imcrop(I,BBmouthorig)), [24 76] );
	DoG_Mouth = DoG_filter(mouth,1,10);
	sample_mouth = sample_normalize(DoG_Mouth,size(DoG_Mouth));
else
	mouth = 0;
	sample_mouth = 0;
end

%%%%%%%%%%% window for nose %%%%%%%%%%%%%%%

% crop nose only if bounding box exists for nose, and both eyes
if(size(BBlefteye,1) && size(BBrighteye,1) && size(BBnoseorig,1))
	nose_top_row = min(BBlefteye_row , BBrighteye_row);
	nose_left_col = BBnoseorig(1);
	bottom_row = nosey;
	ht = abs(bottom_row - nose_top_row);
	wdth = BBnoseorig(3);
	BBnose_new = [nose_left_col nose_top_row wdth ht];
	nose = imresize(rgb2gray(imcrop(I,BBnose_new)), [76 24]);
	DoG_Nose = DoG_filter(nose,1,10);
	sample_nose = sample_normalize(DoG_Nose,size(DoG_Nose));
else
	nose = 0;
	sample_nose = 0;
end

%%%%%%%%%% window for left cheek %%%%%%%%%%%%%%%%%%

% crop cheek only if bounding box exists for nose and eye
if(size(BBlefteye,1) && nosex && nosey)
	lt_cheek_top_row = BBlefteye_row;
	lt_cheek_left_col = BBlefteye(1);
	lt_cheek_ht = abs(nosey - lt_cheek_top_row);
	lt_cheek_wdth = abs(nosex - lt_cheek_left_col);
	lt_cheek = imresize(rgb2gray(imcrop(I, [lt_cheek_left_col lt_cheek_top_row lt_cheek_wdth lt_cheek_ht])), [46 34] );
	DoG_Lt_Cheek = DoG_filter(lt_cheek,1,10);
	sample_lt_cheek = sample_normalize(DoG_Lt_Cheek,size(DoG_Lt_Cheek));
else
	lt_cheek = 0;
	sample_lt_cheek = 0;
end

%%%%%%%%%%%%%% window for right cheek %%%%%%%%%%%%%%%%

% crop cheek only if bounding box exists for nose and eye
if(size(BBrighteye,1) && nosex && nosey)
	rt_cheek_top_row = BBrighteye_row;
	rt_cheek_left_col = nosex;
	rt_cheek_ht = abs(nosey - BBrighteye_row);
	rt_eye_extreme = BBrighteye(1) + BBrighteye(3);
	rt_cheek_wdth = abs(nosex - rt_eye_extreme);
	rt_cheek = imresize(rgb2gray(imcrop(I, [rt_cheek_left_col rt_cheek_top_row rt_cheek_wdth rt_cheek_ht])), [46 34]);
	DoG_Rt_Cheek = DoG_filter(rt_cheek,1,10);
	sample_rt_cheek = sample_normalize(DoG_Rt_Cheek,size(DoG_Rt_Cheek));
else
	rt_cheek = 0;
	sample_rt_cheek = 0;
end
