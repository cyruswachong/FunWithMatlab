clear all;close all;clc;addpath('./Questions/Pictures/');addpath('./Questions/Functions/');
sat_rings = imread('./Questions/Pictures/SaturnRingsWithRandomNoise.png');
[final_value, noise] = remove_cos_noise(sat_rings);
output= median_filter(final_value,3);
figure, subplot(2,2,1), set(gcf, 'Position', get(0, 'Screensize')),imshow(sat_rings),title('Original Image');subplot (2,2,2),imshow(final_value,[]),title('Sinusoidal noise filtered from image');subplot(2,2,3), imshow(output,[]), title('Fully Filtered image');subplot(2,2,4), imshow(noise,[]), title('Sinusoidal noise that was removed from image');

output = padarray(output, [1 1], 0, 'post');
freq_eye = fft2(output);

HPF_size = 225;
ideal_high_pass = low_pass_filter(HPF_size,HPF_size,size(output,1),size(output,2),1);  
eye_HPF = freq_eye.*ideal_high_pass;
eye_HPFed = abs(ifft2(eye_HPF));

figure, imshow(eye_HPFed);
