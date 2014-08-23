function reducedVector = pcaReduction(queryVector, Multiplier)
%QUERYREDUCTION Reduce the query Vector using direct PCA

%remove file name from query feature vector
file_name = queryVector(:, end);
queryVector(:, end) = [];
% reduce query feature vector
size(queryVector)
size(Multiplier)
queryVector = queryVector * Multiplier;
% put the filename back.
reducedVector = [queryVector file_name];


end

