function [final_val, enhanced_composite] = Composite_mask(Grayscaled, padded_image, Scalar_Factor)

[rows, cols] = size(Grayscaled); 
final_val = zeros(size(Grayscaled));

for i = 2:(rows-1)
    for j = 2:(cols-1)
        final_val(i,j) = Scalar_Factor*(padded_image(i-1,j) - 8*padded_image(i,j) + padded_image(i,j+1)...
            + padded_image(i+1,j) + padded_image(i,j-1) + padded_image(i+1,j+1) +...
            padded_image(i-1, j+1) + padded_image(i-1,j-1) + padded_image(i+1,j-1));
    end
end

enhanced_composite = Grayscaled - final_val;
rescale(enhanced_composite);
end