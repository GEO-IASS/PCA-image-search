%   X: data matrix, each row is one observation, each column is one feature
%   d: reduced dimension
%   Y: dimensionanlity-reduced data

function [redEig, Y] = PCA(X,d)

%% eigenvalue analysis
Sx=cov(X);
[V,D]=eig(Sx);
eigValue=diag(D);
[eigValue,IX]=sort(eigValue,'descend');
eigVector=V(:,IX);

%% normailization
norm_eigVector=sqrt(sum(eigVector.^2));
eigVector=eigVector./repmat(norm_eigVector,size(eigVector,1),1);

%% dimensionality reduction
redEig = eigVector(:, 1:d);
Y=X*redEig;
