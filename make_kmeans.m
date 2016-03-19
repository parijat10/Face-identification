disp('Left cheeks...');
[LCC, LCA] = vl_kmeans(Left_Cheeks, 256);
disp('Left cheeks done.');

disp('Right cheeks...');
[RCC, RCA] = vl_kmeans(Right_Cheeks, 256);
disp('Right cheeks done.');

disp('Left Eyes...');
[LEC, LEA] = vl_kmeans(Left_Eyes, 256);
disp('Left Eyes done.');

disp('Right Eyes...');   
[REC, REA] = vl_kmeans(Right_Eyes, 256);
disp('Right Eyes done.');   

disp('Noses...');
[NC, NA] = vl_kmeans(Noses, 256);
disp('Noses done.');

disp('Mouths...');
[MC, MA] = vl_kmeans(Mouths, 256);
disp('Mouths done.');