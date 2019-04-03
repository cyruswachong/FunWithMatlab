function [final_val, enhanced_laplacian] = Laplacian_mask(Grayscaled, padded_image, Scalar_Factor)

[rows, cols] = size(Grayscaled); 
final_val = zeros(size(Grayscaled));

for i = 2:(rows-1)
    for j = 2:(cols-1)
        final_val(i,j) = Scalar_Factor*(padded_image(i-1,j) - 4*padded_image(i,j) + padded_image(i,j+1)...
            + padded_image(i+1,j) + padded_image(i,j-1));
    end
end

enhanced_laplacian = Grayscaled - final_val;
rescale(enhanced_laplacian);
end