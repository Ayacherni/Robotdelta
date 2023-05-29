I = imread('toys_candy.jpg');
imshow(I);

Igray = rgb2gray(I);
imshow(Igray);

rmat = I(:, :, 1);
gmat = I(:, :, 2);
bmat = I(:, :, 3);

levelr = 0.63;
levelg = 0.5;
levelb = 0.4;
i1 = im2bw(rmat, levelr);
i2 = im2bw(gmat, levelg);
i3 = im2bw(bmat, levelb);
Isum = (i1 & i2 & i3);

subplot(2, 2, 1), imshow(i1);
title('Plan rouge');
subplot(2, 2, 2), imshow(i2);
title('Plan vert');
subplot(2, 2, 3), imshow(i3);
title('Plan bleu');
subplot(2, 2, 4), imshow(Isum);
title('Somme de tous les plans');

Icomp = imcomplement(Isum);
Ifilled = imfill(Icomp, 'holes');
figure, imshow(Ifilled);

se = strel('disk', 4);
Iopenned = imopen(Ifilled, se);
imshow(Iopenned);

[labeled, numObjects] = bwlabel(Iopenned, 4);
stats = regionprops(labeled, 'Eccentricity', 'Area', 'BoundingBox', 'centroid');

imshow(I);
hold on

totalObjects = 0;
circularObjects = 0;
nonCircularObjects = 0;

for idx = 1:numObjects
    area = stats(idx).Area;
    bbox = stats(idx).BoundingBox;
    centroid = stats(idx).Centroid;
    
    % Check if the object is circular
    circularity = 4*pi*area/bbox(3)^2;
    if circularity > 0.7
        plot(centroid(1), centroid(2), 'w+', 'MarkerSize', 10, 'LineWidth', 2);
        text(centroid(1) + 10, centroid(2), num2str(idx), 'Color', 'white', 'FontSize', 14);
        circularObjects = circularObjects + 1;
    else
        nonCircularObjects = nonCircularObjects + 1;
    end
    
    totalObjects = totalObjects + 1;
    
    % Print coordinates for object 1, 5, 8 and 12
    if ismember(idx, [1 5 8 12])
        disp(['Object ' num2str(idx) ' coordinates: (' num2str(centroid(1)) ', ' num2str(centroid(2)) ')'])
    end
end

disp(['Nombre total de objets : ' num2str(totalObjects)])