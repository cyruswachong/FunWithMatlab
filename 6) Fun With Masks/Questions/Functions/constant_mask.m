function final_val = constant_mask(I,sizeMask)

%setting up values, and output
Image = pad_mat(I,sizeMask, sizeMask);
[rows, cols] = size(Image);  
final_val = zeros(size(I));

%coefficient for every value except middle
coef = 1/(sizeMask^2);
matrix = coef*ones(sizeMask, sizeMask);
%Can be used for edge detection
%matrix(ceil(sizeMask/2),ceil(sizeMask/2))= 1;

%Two loops for either odd or even size of matrices
if mod(sizeMask,2) == 1
for i = sizeMask:(rows-(sizeMask-1))
    for j = sizeMask:(cols-(sizeMask-1))
        currentval = sum(sum(matrix.*Image( i-floor(sizeMask/2):i+floor(sizeMask/2), j-floor(sizeMask/2):j+floor(sizeMask/2))));
        final_val(i,j) = currentval;
    end
end

else
for i = sizeMask:(rows-(sizeMask-1))
    for j = sizeMask:(cols-(sizeMask-1))
        currentval = sum(sum(matrix.*Image( i-(sizeMask/2):i+((sizeMask/2)-1), j-(sizeMask/2):j+((sizeMask/2)-1))));
        final_val(i,j) = currentval;
    end
end

end

final_val = imcrop(final_val,[sizeMask sizeMask cols rows]);

end
% 
% enhanced_sobel = Grayscaled - final_val;
% rescale(enhanced_sobel);

