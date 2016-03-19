disp('Left cheeks...');
[vecLC,leftLC,rightLC,threshLC] = make_pca_tree1(Left_Cheeks(:,1:10000));
disp('Left cheeks done.');

disp('Right cheeks...');
[vecRC,leftRC,rightRC,threshRC] = make_pca_tree1(Right_Cheeks(:,1:10000));
disp('Right cheeks done.');

disp('Left Eyes...');
[vecLE,leftLE,rightLE,threshLE] = make_pca_tree1(Left_Eyes(:,1:10000));
disp('Left Eyes done.');

disp('Right Eyes...');   
[vecRE,leftRE,rightRE,threshRE] = make_pca_tree1(Right_Eyes(:,1:10000));
disp('Right Eyes done.');   

disp('Noses...');
[vecN,leftN,rightN,threshN] = make_pca_tree1(Noses(:,1:10000));
disp('Noses done.');

disp('Mouths...');
[vecM,leftM,rightM,threshM] = make_pca_tree1(Mouths(:,1:10000));
disp('Mouths done.');