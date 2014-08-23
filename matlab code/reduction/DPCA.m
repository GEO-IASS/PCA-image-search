function [Multiplier, ReducedVectors] = DPCA( dataset, numDims )
%GETEIGENVECTORS Summary of this function goes here
% dataset = image feature vectors.
% numDims = number of reduced dimensions.
%   Detailed explanation goes here
%   returns Multiplier = inv(Sk) * Uk'
%       and ReducedVectors = Multiplier*vectors

% SVD part
vectors = dataset';
[feature_to_concept, sigma, ~] = svd(vectors);
Sk = sigma(1:numDims, 1:numDims);
Uk = feature_to_concept(:, 1:numDims);
Multiplier = Sk\Uk'; % same as inv(Sk) * Uk' but faster run time
ReducedVectors = Multiplier * vectors;
ReducedVectors = ReducedVectors';
% SVD part


end

