% Chargement de l'image
img = imread('image_satellite.jpg');

% Conversion de l'image en niveaux de gris
gray_img = rgb2gray(img);

% Calcul de la valeur de seuil adaptatif
thresh = graythresh(gray_img);

% Binarisation de l'image en utilisant le seuil adaptatif
binary_img = im2bw(gray_img, thresh);

% Suppression des petits objets
binary_img = bwareaopen(binary_img, 100);

% Affichage de l'image binaire résultante
figure;
subplot(1,2,1);
imshow(binary_img);
title('Image binaire résultante');

% Affichage de l'image originale
subplot(1,2,2);
imshow(img);
title('Image originale');
 
% Calcul de la proportion de pixels blancs dans l'image binaire
white_pixels = sum(binary_img(:) == 1);
total_pixels = numel(binary_img);
proportion = white_pixels / total_pixels;

% Affichage de la proportion de pixels blancs
disp(['Proportion de pixels blancs : ' num2str(proportion)]);

