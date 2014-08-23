function return_vectors = getClusterVectors( centroids, clusteredVectors, queryImageFeatureVector, numOfClusters)
%GETCLUSTERVECTORS Return the vectors in the cluster that input vector is
%closest to.
%   Pseudocode:
%   1) calculate distance of input vector to centroids.
%   2) Find the index of closest centroid.
%   3) retrieve vectors in that cluster.
    
% remove filename from query vector    
    queryImageFeatureVector(:, end) = [];
    
% calculate euclidean distances of query_vector from each centroid.
    euclidean = zeros(size(centroids, 1), 1);
    for k = 1:size(centroids, 1)
        euclidean(k,1) = sqrt( sum( power( centroids(k, :) - queryImageFeatureVector, 2 ) ) );
    end
    
% get index of cluster centroids closest to query_vector
    [~, I] = sort(euclidean);
    
    top = min(numOfClusters, length(I));
    % get empty flags for empty cells in Cluster Vectors
    em = cellfun(@isempty, clusteredVectors);
% get all those vectors in that cluster and put it in cluster_vectors.
    for i = 1 : top% take the top ranking vectors
        k = 1;
        for j = 1:size(clusteredVectors, 2)
            if(em(I(i), j) == 0)% if jth vector in cluster I(i) is empty
                return_vectors(k,:) = clusteredVectors{I(i), j};
                k = k + 1;
            end
        end
    end
end


    