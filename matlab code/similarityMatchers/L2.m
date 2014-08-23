function [sortedEuclidImgs, dist] = L2(queryImageFeatureVector, dataset, metric)
% input:
%   numOfReturnedImages : num of images returned by query
%   queryImageFeatureVector: query image in the form of a feature vector
%   dataset: the whole dataset of images transformed in a matrix of
%   features
%
% output:
%   plot: plot images returned by query

% extract image fname from queryImage and dataset

dataset_img_names = dataset(:, end);

queryImageFeatureVector(:, end) = [];
dataset(:, end) = [];
euclidean = zeros(size(dataset, 1), 1);

if (metric == 2)
    % compute euclidean distance
    for k = 1:size(dataset, 1)
        euclidean(k) = sqrt( sum( power( dataset(k, :) - queryImageFeatureVector, 2 ) ) );
    end
elseif (metric == 3)
    euclidean = pdist2(dataset, queryImageFeatureVector, 'cosine');
elseif (metric == 4) % compute mahalanobis distance
    weights = nancov(dataset);
    [T, flag] = chol(weights);
    if (flag ~= 0)
        errordlg('The matrix is not positive semidefinite. Please choose another similarity metric!');
        return;
    end
    weights = T \ eye(size(dataset, 2)); %inv(T)
    del = bsxfun(@minus, dataset, queryImageFeatureVector(1, :));
    dsq = sum((del/T) .^ 2, 2);
    dsq = sqrt(dsq);
    euclidean = dsq;
end

% add image fnames to euclidean
euclidean = [euclidean dataset_img_names];

% sort them according to smallest distance
[sortEuclidDist, ~] = sortrows(euclidean);
sortedEuclidImgs = sortEuclidDist(:, 2);
dist = sortEuclidDist(:, 1);

% clear axes
arrayfun(@cla, findall(0, 'type', 'axes'));
end