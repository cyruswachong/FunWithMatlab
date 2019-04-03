function [final_val, noise] = remove_cos_noise(I)
%Take fourier of the image in spatial domain
fourier = fft2(I);

%r is used to remove noise
r= zeros(size(I,1),1);
dc = fourier(1,1);

%calculate the noise variables, remove DC, and fourier transform it
noise = fourier(:,1);
noise(1,1)=0;
onesmat = ones(size(I));
onesmat(:,1)=noise;
noise = ifft2(onesmat);

%Removes noise, except for DC value
fourier(:,1) =r;
fourier(1,1) = dc;
final_val = ifft2(fourier);
end

