function final_image = transform_img(non_smile_image, u_x, u_y)

cols = size(non_smile_image,2);rows = size(non_smile_image,1);
final_image = zeros(rows,cols);

for i = 1:rows 
    for j = 1:cols 
        final_image(i,j) = non_smile_image(round(i-u_y(i,j)),round(j-u_x(i,j)));
    end
end

end
