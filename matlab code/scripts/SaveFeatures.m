%Script to extract features from images in given drectory and save feature
%vectors, indices, centroids, M and Cc.

folder_name = '..\\..\\images';

vector_size = 386; % number of features extracted.

disp('Extracting Features...');
% construct folder name foreach image type
pngImagesDir = fullfile(folder_name, '*.png');
jpgImagesDir = fullfile(folder_name, '*.jpg');
bmpImagesDir = fullfile(folder_name, '*.bmp');

% calculate total number of images

jpg_files = dir(jpgImagesDir);
png_files = dir(pngImagesDir);
bmp_files = dir(bmpImagesDir);

num_of_png_images = numel( png_files );
num_of_jpg_images = numel( jpg_files );
num_of_bmp_images = numel( bmp_files );
totalImages = num_of_png_images + num_of_jpg_images + num_of_bmp_images;
features = zeros(totalImages, vector_size); 

if ( ~isempty( jpg_files ) || ~isempty( png_files ) || ~isempty( bmp_files ) )
    % read jpg images from stored folder name
    % directory and construct the feature dataset
    jpg_counter = 0;
    png_counter = 0;
    bmp_counter = 0;
    for k = 1:totalImages
        
        if ( (num_of_jpg_images - jpg_counter) > 0)
            imgInfoJPG = imfinfo( fullfile( folder_name, jpg_files(jpg_counter+1).name ) );
            if ( strcmpi( imgInfoJPG.Format, 'jpg') == 1 )
                % read images
                sprintf('%s \n', jpg_files(jpg_counter+1).name)
                % extract features
                image = imread( fullfile( folder_name, jpg_files(jpg_counter+1).name ) );
                [~, name, ~] = fileparts( fullfile( folder_name, jpg_files(jpg_counter+1).name ) );
                image = imresize(image, [384 256]);
            end
            
            jpg_counter = jpg_counter + 1;
            
        elseif ( (num_of_png_images - png_counter) > 0)
            imgInfoPNG = imfinfo( fullfile( folder_name, png_files(png_counter+1).name ) );
            if ( strcmpi( imgInfoPNG.Format, 'png') == 1 )
                % read images
                sprintf('%s \n', png_files(png_counter+1).name)
                % extract features
                image = imread( fullfile( folder_name, png_files(png_counter+1).name ) );
                [~, name, ~] = fileparts( fullfile( folder_name, png_files(png_counter+1).name ) );
                image = imresize(image, [384 256]);
            end
            
            png_counter = png_counter + 1;
            
        elseif ( (num_of_bmp_images - bmp_counter) > 0)
            imgInfoBMP = imfinfo( fullfile( folder_name, bmp_files(bmp_counter+1).name ) );
            if ( strcmpi( imgInfoBMP.Format, 'bmp') == 1 )
                % read images
                sprintf('%s \n', bmp_files(bmp_counter+1).name)
                % extract features
                image = imread( fullfile( folder_name, bmp_files(bmp_counter+1).name ) );
                [~, name, ~] = fileparts( fullfile( folder_name, bmp_files(bmp_counter+1).name ) );
                image = imresize(image, [384 256]);
            end
            
            bmp_counter = bmp_counter + 1;
            
        end
       
        % add to the last column the name of image file we are processing at
        % the moment
        set = getFeatures(image);
        features(k, :) = [set str2num(name)];
        disp(k);
        % clear workspace
        clear('image', 'img', 'hsvHist', 'autoCorrelogram', 'color_moments', ...
            'gabor_wavelet', 'wavelet_moments', 'set', 'imgInfoJPG', 'imgInfoPNG', ...
            'imgInfoGIF');
    end
    
    save('..\\..\\vectors\\features.mat', 'features');
    
else
    disp('ERROR: Folder does not contain any images');
    exit();
end
disp('Extracting Features Complete');
clear;
