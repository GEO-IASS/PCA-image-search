function reducedVector = dpcaReduction(queryVector, Multiplier)
%QUERYREDUCTION Summary of this function goes here
%   Detailed explanation goes here

%remove file name from query feature vector
file_name = queryVector(:, end);
queryVector(:, end) = [];
% reduce query feature vector
queryVector = Multiplier * queryVector';
queryVector = queryVector';
% put the filename back.
reducedVector = [queryVector file_name];

end

