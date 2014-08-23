%   X: data matrix, each row is one observation, each column is one feature
%   d: reduced dimension
%   type: type of kernel, can be 'simple', 'poly', or 'gaussian'
%   para (input): parameter for computing the 'poly' kernel, for 'simple'
%       and 'gaussian' it will be ignored
%   Y: dimensionanlity-reduced data
%   eigVector: eigen-vector, will later be used for pre-image
%       reconstruction
%   para (output): automatically selected Gaussian kernel parameter

function [reducedEigVector, Y]=kPCA(X,d,type,para)

%% parameters
N=size(X,1);

%% kernel PCA
K0=kernel(X, X', type,para);
oneN=ones(N,N)/N;
K=K0-oneN*K0-K0*oneN+oneN*K0*oneN;

%% eigenvalue analysis
[V,D]=eig(K/N);
eigValue=diag(D);
[eigValue,IX]=sort(eigValue,'descend');
eigVector=V(:,IX);

%% normailization
norm_eigVector=sqrt(sum(eigVector.^2));
eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

%% dimensionality reduction
reducedEigVector = eigVector(:,1:d);
Y=K0*reducedEigVector;


