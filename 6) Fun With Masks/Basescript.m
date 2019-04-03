%Code to add path
clear all;close all;clc;addpath('./Questions/Pictures/');addpath('./Questions/Functions/');
Grayscale = grayit('./Questions/Pictures/myeye.jpg');
%% Part 2
Mean = 0.005;
Variance = 0.015;
Noisy_image = imnoise(Grayscale,'gaussian', Mean, Variance);
figure, subplot (2,2,1), set(gcf, 'Position', get(0, 'Screensize')),imshow(Noisy_image);title(sprintf('Gaussian noise, mean=%.4f, variance= %.4f',Mean, Variance));

mask_size=5;
final = constant_mask(Noisy_image, mask_size);
subplot (2,2,2), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i constant mask applied to gaussian noise mean=%.4f, variance= %.4f',mask_size,mask_size,Mean, Variance));

mask_size=10;
final = constant_mask(Noisy_image, mask_size);
subplot (2,2,3), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i constant mask applied to gaussian noise mean=%.4f, variance= %.4f',mask_size,mask_size,Mean, Variance));

mask_size=20;
final = constant_mask(Noisy_image, mask_size);
subplot (2,2,4), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i constant mask applied to gaussian noise mean=%.4f, variance= %.4f',mask_size,mask_size,Mean, Variance));

%% Part 3
%Low density SnP noise portion
d=0.2;
SnP = imnoise(Grayscale,'salt & pepper',d);
figure, subplot (2,2,1), set(gcf, 'Position', get(0, 'Screensize')),imshow(SnP);title(sprintf('Image with dens=%.2f SnP noise', d));

mask_size=3;
final = median_filter(SnP, mask_size);
subplot (2,2,2), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('Image with %ix%i median filter, dens=%.2f',mask_size,mask_size,d));

mask_size=5;
final = median_filter(SnP, mask_size);
subplot (2,2,3), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('Image with %ix%i median filter, dens=%.2f',mask_size,mask_size,d));

mask_size=7;
final = median_filter(SnP, mask_size);
subplot (2,2,4), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('Image with %ix%i median filter, dens=%.2f',mask_size,mask_size,d));

%High density SnP noise output
d=0.7;
SnP = imnoise(Grayscale,'salt & pepper',d);
figure, subplot (2,2,1), set(gcf, 'Position', get(0, 'Screensize')),imshow(SnP);title(sprintf('Image with dens=%.2f SnP noise', d));

mask_size=3;
final = median_filter(SnP, mask_size);
subplot (2,2,2), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('Image with %ix%i median filter, dens=%.2f',mask_size,mask_size,d));

mask_size=5;
final = median_filter(SnP, mask_size);
subplot (2,2,3), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('Image with %ix%i median filter, dens=%.2f',mask_size,mask_size,d));

mask_size=7;
final = median_filter(SnP, mask_size);
subplot (2,2,4), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('Image with %ix%i median filter, dens=%.2f',mask_size,mask_size,d));

%SnP noise removal with uniform mask
d=0.3;
SnP1 = imnoise(Grayscale,'salt & pepper',d);
figure, subplot (2,3,1), set(gcf, 'Position', get(0, 'Screensize')),imshow(SnP1);title(sprintf('Image with dens=%.2f SnP noise',d));

mask_size=5;
final = constant_mask(SnP1, mask_size);
subplot(2,3,2), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i constant mask applied to SnP noise dens =%.2f',mask_size,mask_size,d));

mask_size=10;
final = constant_mask(SnP1, mask_size);
subplot(2,3,3), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i constant mask applied to SnP noise dens =%.2f',mask_size,mask_size,d));

d=0.6;
SnP1 = imnoise(Grayscale,'salt & pepper',d);
subplot (2,3,4), set(gcf, 'Position', get(0, 'Screensize')),imshow(SnP1);title(sprintf('Image with dens=%.2f SnP noise', d));

mask_size=5;
final = constant_mask(SnP1, mask_size);
subplot(2,3,5), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i constant mask applied to SnP noise dens =%.2f',mask_size,mask_size,d));

mask_size=10;
final = constant_mask(SnP1, mask_size);
subplot(2,3,6), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i constant mask applied to SnP noise dens =%.2f',mask_size,mask_size,d));

%Gaussian noise removal with median filter

figure, subplot (1,3,1), set(gcf, 'Position', get(0, 'Screensize')),imshow(Noisy_image);title(sprintf('Gaussian noise, mean=%.4f, variance= %.4f',Mean, Variance));
mask_size=5;
final = constant_mask(Noisy_image, mask_size);
subplot(1,3,2), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i median filter applied to Gaussian noise',mask_size,mask_size));

mask_size=10;
final = constant_mask(Noisy_image, mask_size);
subplot(1,3,3), set(gcf, 'Position', get(0, 'Screensize')),imshow(final);title(sprintf('%ix%i median filter applied to Gaussian noise',mask_size,mask_size));

%% Part 4
%Cosine output with no vertical shift (having some negative values)
M = 32; N = 32; A=1; shift=0;

u0(1)=0;v0(2)=0;
n(:,:,1) = cos_graph_shifted(u0(1),v0(1),M,N,A,shift);
figure, subplot(2,2,1), set(gcf, 'Position', get(0, 'Screensize')), imshow(n(:,:,1), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, no shift', u0(1), v0(1), M, N)),xlabel('X value'), ylabel('Y value');

u0(2)=M/4;v0(2)=0;
n(:,:,2) = cos_graph_shifted(u0(2),v0(2),M,N,A,shift);
subplot(2,2,2), set(gcf, 'Position', get(0, 'Screensize')),imshow(n(:,:,2), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, no shift', u0(2), v0(2), M, N)),xlabel('X value'), ylabel('Y value');

u0(3)=0;v0(3)=N/2;
n(:,:,3) = cos_graph_shifted(u0(3),v0(3),M,N,A,shift);
subplot(2,2,3), set(gcf, 'Position', get(0, 'Screensize')),imshow(n(:,:,3), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, no shift', u0(3), v0(3), M, N)),xlabel('X value'), ylabel('Y value');

u0(4)=M/2;v0(4)=N/4;
n(:,:,4) = cos_graph_shifted(u0(4),v0(4),M,N,A,shift);
subplot(2,2,4), set(gcf, 'Position', get(0, 'Screensize')),imshow(n(:,:,4), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, no shift', u0(4), v0(4), M, N)),xlabel('X value'), ylabel('Y value');

% Cosine function with vertical shift
u0(5)=0;v0(5)=0; shift=1; 
n(:,:,5) = cos_graph_shifted(u0(5),v0(5),M,N,A,shift);
figure, subplot(2,2,1), set(gcf, 'Position', get(0, 'Screensize')), imshow(n(:,:,5), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, shifted up 1', u0(5), v0(5), M, N)),xlabel('X value'), ylabel('Y value');

u0(6)=M/4;v0(6)=0; 
n(:,:,6) = cos_graph_shifted(u0(6),v0(6),M,N,A,shift);
subplot(2,2,2), set(gcf, 'Position', get(0, 'Screensize')),imshow(n(:,:,6), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, shifted up 1', u0(6), v0(6), M, N)),xlabel('X value'), ylabel('Y value');

u0(7)=0;v0(7)=N/2;
n(:,:,7) = cos_graph_shifted(u0(7),v0(7),M,N,A,shift);
subplot(2,2,3), set(gcf, 'Position', get(0, 'Screensize')),imshow(n(:,:,7), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, shifted up 1', u0(7), v0(7), M, N)), xlabel('X value'), ylabel('Y value');

u0(8)=M/2;v0(8)=N/4; 
n(:,:,8) = cos_graph_shifted(u0(8),v0(8),M,N,A,shift);
subplot(2,2,4), set(gcf, 'Position', get(0, 'Screensize')),imshow(n(:,:,8), []),title(sprintf('Cosine u0=%i, v0=%i, M=%i, N=%i, shifted up 1', u0(8), v0(8), M, N)), xlabel('X value'), ylabel('Y value');
%preallocation of fourier_cos value for speed
fourier_cos = zeros(M,N,size(n,3));
fft_cos_center = zeros(M,N,size(n,3));

%% Part 5
M = 64; N = 64;
r = rect_graph(M,N,255);
%% Part 6
figure
%loop to display fourier transforms of cosines
for q = 1:size(n,3)
fourier_cos(:,:,q) = fft2(n(:,:,q));
    if q<=4
    subplot(2,4,q), set(gcf, 'Position', get(0, 'Screensize')),imshow(fourier_cos(:,:,q)),title(sprintf('FT of non-shifted cosine #%i',q)), xlabel(sprintf('U frequency, U0=%i',u0(q))), ylabel(sprintf('V frequency, V0=%i', v0(q)));
    %add scaled version here
    else
    subplot(2,4,q), set(gcf, 'Position', get(0, 'Screensize')),imshow(fourier_cos(:,:,q)),title(sprintf('FT of shifted cosine #%i',q-4)), xlabel(sprintf('U frequency, U0=%i', u0(q))), ylabel(sprintf('V frequency, V0=%i', v0(q)));
    %add scaled version here
    end
end

%% Part 7
figure
for q = 1:size(n,3)
fft_cos_center(:,:,q) = fftshift(fourier_cos(:,:,q));
    if q<=4
    subplot(2,4,q), set(gcf, 'Position', get(0, 'Screensize')),imshow(fft_cos_center(:,:,q)),title(sprintf('centered FT of non-shifted cosine #%i',q)), xlabel(sprintf('U frequency, U0=%i', u0(q))), ylabel(sprintf('V frequency, V0=%i', v0(q)));
    else
    subplot(2,4,q), set(gcf, 'Position', get(0, 'Screensize')),imshow(fft_cos_center(:,:,q)),title(sprintf('centered FT of shifted cosine #%i',q-4)), xlabel(sprintf('U frequency, U0=%i', u0(q))), ylabel(sprintf('V frequency, V0=%i', v0(q)));
    end
end

%fourier and centered fourier transforms of the rect
fourier_rect = fft2(r);
fft_rect_center = fftshift(fourier_rect);

figure, subplot(2,3,1), set(gcf, 'Position', get(0, 'Screensize')), imshow(r),title(sprintf('Rect function size %ix%i', M, N)),xlabel('X value'), ylabel('Y value');
subplot(2,3,2), set(gcf, 'Position', get(0, 'Screensize')), imshow(fourier_rect),title('Fourier of rect function'),xlabel('U frequency'), ylabel('V frequency');
subplot(2,3,3), set(gcf, 'Position', get(0, 'Screensize')), imshow(fft_rect_center),title('Centered fourier of rect function'),xlabel('U frequency'), ylabel('V frequency');

subplot(2,3,4), set(gcf, 'Position', get(0, 'Screensize')), imshow(log(r)),title(sprintf('Rect function size %ix%i (Log scaled)', M, N)),xlabel('X value'), ylabel('Y value');
subplot(2,3,5), set(gcf, 'Position', get(0, 'Screensize')), imshow(log(fourier_rect)),title('Fourier of rect function (Log scaled)'),xlabel('U frequency'), ylabel('V frequency');
subplot(2,3,6), set(gcf, 'Position', get(0, 'Screensize')), imshow(log(fft_rect_center)),title('Centered fourier of rect function(Log scaled)'),xlabel('U frequency'), ylabel('V frequency');

%% Part 8
LPF_size = 100;
LPF_size_1 = 10;
ideal_low_pass = low_pass_filter(LPF_size,LPF_size,size(Grayscale,1),size(Grayscale,2),1);  
ideal_LPF_1 = low_pass_filter(LPF_size_1,LPF_size_1,size(Grayscale,1),size(Grayscale,2),1);  
figure, imshow(ideal_low_pass),set(gcf, 'Position', get(0, 'Screensize')),title('Low pass filter');

%% Part 9
figure
%fourier transform Grayscale
freq_eye = fft2(Grayscale);
%shift so we can apply LPF
freq_eye = fftshift(freq_eye);
%apply LPF to eye
eye_LPF = freq_eye.*ideal_low_pass;
eye_LPF_1 = freq_eye.*ideal_LPF_1;
%shift image back to get original
eye_LPF = fftshift(eye_LPF);
eye_LPF_1 = fftshift(eye_LPF_1);
%display image
eye_LPFed = abs(ifft2(eye_LPF));
eye_LPFed_1=abs(ifft2(eye_LPF_1));
%display image
subplot(1,3,1),set(gcf, 'Position', get(0, 'Screensize')),imshow(eye_LPFed_1, []), title(sprintf('LPF Image (%ix%i LPF)', LPF_size_1, LPF_size_1)); 
subplot(1,3,2),set(gcf, 'Position', get(0, 'Screensize')),imshow(eye_LPFed, []), title(sprintf('LPF Image (%ix%i LPF)', LPF_size, LPF_size)); 
subplot(1,3,3),set(gcf, 'Position', get(0, 'Screensize')),imshow(Grayscale), title('Original Image');

%% Part 10
freq_eye = fft2(Grayscale);

HPF_size = 200;
HPF_size_1 = 50;
ideal_high_pass = low_pass_filter(HPF_size,HPF_size,size(Grayscale,1),size(Grayscale,2),1);  
ideal_HPF = low_pass_filter(HPF_size_1,HPF_size_1,size(Grayscale,1),size(Grayscale,2),1);  
eye_HPF = freq_eye.*ideal_high_pass;
eye_HPF_1 = freq_eye.*ideal_HPF;
eye_HPFed = abs(ifft2(eye_HPF));
eye_HPFed_1 = abs(ifft2(eye_HPF_1));

figure,subplot(1,3,1),imshow(Grayscale), title('Original Image');
subplot(1,3,2),set(gcf, 'Position', get(0, 'Screensize')),imshow(eye_HPFed, []), title(sprintf('HPF Image (%ix%i HPF)', HPF_size, HPF_size));
subplot(1,3,3),set(gcf, 'Position', get(0, 'Screensize')),imshow(eye_HPFed_1, []), title(sprintf('HPF Image (%ix%i HPF)', HPF_size_1, HPF_size_1));

