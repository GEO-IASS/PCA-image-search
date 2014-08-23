
disp('Reducing Dimesions using KPCA');

para = 0.8;
method = 'poly';
reduced_dimensions = 35;
load('..\\..\\vectors\\features.mat');
dataset_image_names = features(:, end);
features(:, end) = [];
[kpcaMultiplier, kpcaReducedVectors] = kPCA(features, reduced_dimensions, method, para);
kpcaReducedVectors = [kpcaReducedVectors dataset_image_names];
save('..\\..\\vectors\\reduction\\kpcaMultiplier.mat', 'kpcaMultiplier');
save('..\\..\\vectors\\reduction\\kpcaReducedVectors.mat', 'kpcaReducedVectors');

disp('Dimension Reduction using KPCA complete');
clear;