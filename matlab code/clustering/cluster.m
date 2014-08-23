function [clusteredVectors, centroids] = cluster( dataset, num_of_clusters )
%CLUSTER perform clustering on the feature vectors and save the index and
%centroids.
%  input: dataset of image features and number of clusters
%  effect: centroids are saved and vectors are stored respective to their
%  clusters.
    
    %remove filenames from dataset
    file_names = dataset(:, end);
    dataset(:, end) = [];
    %perform k means and get 
    %indices = denoting which cluster the row of the dataset belongs to. 
    %centroids = get num_of_clusters centroids.
    [indices, centroids] = kmeans(dataset, num_of_clusters);
    
    %counter for number of vectors in each cluster
    k = ones(num_of_clusters, 1);
    numOfImages = length(indices);
    
    for i = 1:numOfImages
        % add the feature vector and filename to clustered vectors cell.
        clusteredVectors{indices(i), k(indices(i))} = [dataset(i, :) file_names(i)];
        % increment the count of the number of vectors in that cluster.
        k(indices(i)) = k(indices(i)) + 1;
    end
end

