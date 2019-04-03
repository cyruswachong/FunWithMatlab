function Noise_Image = Add_noise(Image, Mean, Variance)
Noisy_image = imnoise(Grayscale,'gaussian', Mean, Variance);
end

