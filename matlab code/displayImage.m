function displayImage( query_image_name, sortedImgs, sortedDist, thresh)
%DISPLAYIMAGE Summary of this function goes here=
% displays image on the panel
%   Instead of repeating this on L1.m L2.m and relativedeviation.m
% we are defining it once here.

    str_name = int2str(query_image_name);
    queryImage = imread( strcat('..\images\', str_name, '.jpg') );
    subplot(5, 4, 1);
    imshow(queryImage, []);
    title('Query Image', 'Color', [1 0 0]);
    
    len = min(size(sortedDist), 15);
    sortedDist = sortedDist(1:len);
    meanDist = mean(sortedDist);

    % display images returned by query
    blankImage = imread('..\blank.jpg');
    for m = 1:len
        subplot(5, 4, m + 4);
        imshow(blankImage);
        title('-', 'Color', [0 0 0]);
    end
    for m = 1:len
        if ((thresh == 0) || (sortedDist(m) < meanDist))
            img_name = sortedImgs(m);
            img_name = int2str(img_name);
            str_name = strcat('..\images\', img_name, '.jpg');
            returnedImage = imread(str_name);
            subplot(5, 4, m + 4);
            imshow(returnedImage, []);
            title(sortedDist(m), 'Color', [0 0 0]);
        else
            break;
        end;
    end
end

