% Portions to add path
addpath('./Questions/Question1/')
addpath('./Questions/Question2/')
addpath('./Questions/Pictures/')
addpath('./Questions/Functions/')
close all;

%portion to grayscale inputted image
Grayscaled = grayit('./Questions/Pictures/myeye.jpg'); 

%Size of grayscaled image
sizeImg = size(Grayscaled);  

%Outputs grayscaled image
padding = zeros(277,341);
padding(1:227,1:291) = Grayscaled;

figure;
hold on;
imshow(padding);
title('Original Inputted Grayscale Image with padding');

%Example output of Question 1

fprintf('This is the output with a x+0.25 and y+0.35 to show how similar they are ');
Question_1(Grayscaled, 15, 40);
output2= bi_lin_interpolate(Grayscaled, 15, 40);
fprintf('This is the output without the change in x or y \n\n %f \n \n \n', output2);


%calls function that rotates the image
angle = 20;
Image1 = rotate_image(Grayscaled, angle, 0, 0);
figure;
imshow(Image1);
title(sprintf('Image Rotated by %d degrees', angle));

%calls function that translates image
Tx=90;
Ty=55;
Image2 = translate_image(Grayscaled, Tx, Ty);
figure
imshow(Image2)
title(sprintf('Image Translated by %d units down and %d units right', Tx, Ty));

%plots the d(x) and phi figures
plot_quiver_grid(20, sizeImg);

