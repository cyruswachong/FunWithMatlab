%Code to add path
clear all;
close all
clc;
addpath('./Questions/Pictures/')
addpath('./Questions/Functions/')

I = imread('./Questions/Pictures/myimage.jpg');

%Used to grayscale image
Grayscaled = rgb2gray(I);
Grayscaled = mat2gray(Grayscaled);

%Pads image
padded_image = pad_mat(Grayscaled,1,1);

%% Sobel Mask
sobel_const = 1;
[final_val, enhanced_sobel] = Sobel_mask(Grayscaled, padded_image,sobel_const);
% Plot Original
figure
subplot (1,3,1)
set(gcf, 'Position', get(0, 'Screensize'));
imshow(padded_image);
title('Original Image');

%Plot Sobel Mask
subplot(1,3,2);
imshow(final_val);
title('Edges found with Sobel mask');

%Plot enhanced image
subplot (1,3,3);
imshow(enhanced_sobel)
title('Enhanced image by subtracting Sobel mask edges from original image');

%% Laplacian Mask
laplacian_const = 1;
[final_val, enhanced_laplacian] = Laplacian_mask(Grayscaled, padded_image,laplacian_const);

% Plot Original
figure
subplot (1,3,1)
set(gcf, 'Position', get(0, 'Screensize'));
imshow(padded_image);
title('Original Image');

% Plot Laplacian Mask
subplot (1,3,2)
imshow(final_val);
title('Edges found with Laplacian mask');

% Plot enhanced image by laplacian mask
subplot (1,3,3)
imshow(enhanced_laplacian)
title('Enhanced image by subtracting Laplacian mask edges from original image');

%% Composite Mask
composite_const=0.25;
[final_val, enhanced_composite] = Composite_mask(Grayscaled, padded_image,composite_const);

% Plot Original
figure
subplot (1,3,1)
set(gcf, 'Position', get(0, 'Screensize'));
imshow(padded_image);
title('Original Image');

% Plot Laplacian Mask
subplot (1,3,2)
imshow(final_val);
title('Edges found with Composite mask');

% Plot enhanced image by laplacian mask
subplot (1,3,3)
imshow(enhanced_composite)
title('Enhanced image by subtracting Composite mask edges from original image');

% figure
% imshow((enhanced_sobel + enhanced_composite + enhanced_laplacian)/3);
% set(gcf, 'Position', get(0, 'Screensize'));
% title('Combination of all filters passed over original image');

