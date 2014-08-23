% reduce the feaure vectors and save them.

disp('Reducing Dimensions using DPCA');

reduced_dimensions = 35;
load('..\\..\\vectors\\features.mat');
dataset_image_names = features(:, end);
features(:, end) = [];
[dpcaMultiplier, dpcaReducedVectors] = DPCA(features, reduced_dimensions);
dpcaReducedVectors = [dpcaReducedVectors dataset_image_names];
save('..\\..\\vectors\\reduction\\dpcaMultiplier.mat', 'dpcaMultiplier');
save('..\\..\\vectors\\reduction\\dpcaReducedVectors.mat', 'dpcaReducedVectors');

disp('Dimension Reduction using DPCA complete');
clear;