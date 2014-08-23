% perform clustering on both unreduced and reduced data and save the
% centroids and the clustered Vectors.

disp('clustering in progress...');

disp('clustering features...');
load('..\\..\\vectors\\features.mat');
totalImages = size(features, 1);
num_of_clusters = floor(sqrt(totalImages/2.0));
[clusteredVectors, centroids] = cluster(features, num_of_clusters);
save('..\\..\\vectors\\clustering\\clusteredVectors.mat', 'clusteredVectors');
save('..\\..\\vectors\\clustering\\centroids.mat', 'centroids');
disp('Done clustering features');

disp('Clustering PCA reduced features...');
load('..\\..\\vectors\\reduction\\ReducedVectors.mat');
[ReducedClusteredVectors, ReducedCentroids] = cluster(ReducedVectors, num_of_clusters);
save('..\\..\\vectors\\clustering\\ReducedClusteredVectors.mat', 'ReducedClusteredVectors');
save('..\\..\\vectors\\clustering\\ReducedCentroids.mat', 'ReducedCentroids');
disp('Done clustering PCA reduced features...');

disp('Clustering Dual-PCA reduced features...');
load('..\\..\\vectors\\reduction\\dpcaReducedVectors.mat');
[dpcaReducedClusteredVectors, dpcaReducedCentroids] = cluster(dpcaReducedVectors, num_of_clusters);
save('..\\..\\vectors\\clustering\\dpcaReducedClusteredVectors.mat', 'dpcaReducedClusteredVectors');
save('..\\..\\vectors\\clustering\\dpcaReducedCentroids.mat', 'dpcaReducedCentroids');
disp('Done clustering Dual-PCA reduced features...');

disp('Clustering Kernel-PCA reduced features...');
load('..\\..\\vectors\\reduction\\kpcaReducedVectors.mat');
[kpcaReducedClusteredVectors, kpcaReducedCentroids] = cluster(kpcaReducedVectors, num_of_clusters);
save('..\\..\\vectors\\clustering\\kpcaReducedClusteredVectors.mat', 'kpcaReducedClusteredVectors');
save('..\\..\\vectors\\clustering\\kpcaReducedCentroids.mat', 'kpcaReducedCentroids');
disp('Done clustering Kernel-PCA reduced features...');

disp('clustering complete');

clear;