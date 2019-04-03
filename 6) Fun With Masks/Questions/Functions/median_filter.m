function final_val = median_filter(I,sizeMask)

%setting up values, and output
Image = pad_mat(I,sizeMask, sizeMask);
[rows, cols] = size(Image);  
final_val = zeros(size(I));

%im2col only grabs pi
im_col = im2col(Image, [sizeMask sizeMask], 'sliding');
sorted_cols = sort(im_col, 1, 'ascend');
medianVect = sorted_cols(floor(sizeMask^2/2) + 1, :);
final_val = col2im(medianVect, [sizeMask sizeMask], size(Image), 'sliding');

%cropping padded values from final answer
final_val = imcrop(final_val,[sizeMask/2 sizeMask/2 (cols-(2*sizeMask)) (rows-(2*sizeMask))]);

end

