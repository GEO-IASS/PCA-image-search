function features = getFeatures( image )
%GETFEATURES Summary of this function goes here
%   Detailed explanation goes here

hsvHist = hsvHistogram(image);
autoCorrelogram = colorAutoCorrelogram(image);
color_moments = colorMoments(image);
% for gabor filters we need gary scale image
img = double(rgb2gray(image))/255;
[meanAmplitude, msEnergy] = gaborWavelet(img, 4, 6); % 4 = number of scales, 6 = number of orientations
wavelet_moments = waveletTransform(image);
features = [hsvHist autoCorrelogram color_moments meanAmplitude msEnergy wavelet_moments];
end

