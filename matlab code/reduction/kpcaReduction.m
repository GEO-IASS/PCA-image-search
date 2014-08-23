function reducedVector = kpcaReduction(queryVector, Multiplier, features)
%QUERYREDUCTION Summary of this function goes here
%   Detailed explanation goes here
method = 'poly';
para = 0.8;
%remove file name from query feature vector
file_name = queryVector(:, end);
queryVector(:, end) = [];
features(:, end) = [];
% reduce query feature vector
queryVector = kernel(queryVector, features', method, para);
queryVector = queryVector * Multiplier;
% put the filename back.
reducedVector = [queryVector file_name];

end


