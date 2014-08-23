function [sortedImgs, dist] = L1(queryImageFeatureVector, dataset)
% input:
%   numOfReturnedImages : num of images returned by query
%   queryImageFeatureVector: query image in the form of a feature vector
%   dataset: the whole dataset of images transformed in a matrix of
%   features
% 
% output: 
%   plot: plot images returned by query

% extract image fname from queryImage and dataset
dataset_image_names = dataset(:, end);

% we dont want image file names to be one of the features!! hence the below
% lines
queryImageFeatureVector(:, end) = [];
dataset(:, end) = [];

% compute manhattan distance
manhattan = zeros(size(dataset, 1), 1);
for k = 1:size(dataset, 1)
%     manhattan(k) = sum( abs(dataset(k, :) - queryImageFeatureVector) );
    % ralative manhattan distance
    manhattan(k) = sum( abs(dataset(k, :) - queryImageFeatureVector) ./ ( 1 + abs(dataset(k, :)) + abs(queryImageFeatureVector )) );
end

% add image fnames to manhattan
manhattan = [manhattan dataset_image_names];



% sort them according to smallest distance
[sortedDist, ~] = sortrows(manhattan);
sortedImgs = sortedDist(:, 2);
dist = sortedDist(:, 1);

% clear axes
arrayfun(@cla, findall(0, 'type', 'axes'));
end