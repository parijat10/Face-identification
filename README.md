# Face-identification

Based on “ Face Recognition with Learning-based Descriptor” by Zhimin Cao, Qi Yin, Xiaoou Tang and Jian Sun. 


TRAINING PROCRDURE :
Generate_train_data_new.m :- Generates concatenated histograms for all train images. It iterates over all images in the training set and finds features of the images, computes code images for each feature, divides them into patches, constructs histogram at the patch level, and finally computes the concatenated histograms from each of the training samples.

TESTING PROCEDURE :
Testing_script_new.m :- Takes two images and calculates facial features, makes patches from obtained code images, computes concatenated histograms, 	and finally finds the learning-encoded descriptor for a particular face. Then the code finds the euclidean distance between the  descriptors and based on a threshold, classifies them as same or different people. Note that this uses K-means to cluster the individual features.


Pca_tree_testing.m :- Same as above, except it uses PCA-Trees.
