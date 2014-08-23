% reduce the feaure vectors and save them.

disp('Reducing Dimensions using PCA');

reduced_dimensions = 35;
load('..\\..\\vectors\\features.mat');
dataset_image_names = features(:, end);
features(:, end) = [];
[Multiplier, ReducedVectors] = PCA(features, reduced_dimensions);
ReducedVectors = [ReducedVectors dataset_image_names];
save('..\\..\\vectors\\reduction\\Multiplier.mat', 'Multiplier');
save('..\\..\\vectors\\reduction\\ReducedVectors.mat', 'ReducedVectors');
size(features)
size(Multiplier)
size(ReducedVectors)

disp('Dimension Reduction using PCA complete');
clear;