function Noise_Image = Add_noise(Image, Mean, Variance)
Noisy_image = imnoise(Image,'gaussian', Mean, Variance);
end

