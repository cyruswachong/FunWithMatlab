function [Final] = Question_2(Grayscaled, ang, center_x, center_y)

R = [cos((pi.*ang/180)) -sin((pi.*ang/180)); sin((pi.*ang/180)) cos((pi.*ang/180))];  %Matrix to rotate by inputted theta
[rows, cols] = size(Grayscaled);                        %Acquires size of image
Final=0.15.*double(ones(size(Grayscaled)));              %final matrix, fills initially with 1's (black)

for x = 1:rows
    for y = 1:cols
        current_pos =[x-center_x;y-center_y];           %current position in respect to center of rotation 
        rotated = R * current_pos;                      %rotates the current point                        
        rotated = int16(rotated);                          
        newx = rotated(1,1);
        newy = rotated(2,1);
            if newx+center_x<=rows && newx+center_x > 0 && newy+center_y<=cols && newy+center_y > 0 
            Final(newx+center_x,newy+center_y) = Grayscaled(x,y);
            end
    end
end
figure
imshow(Final)
title('Rotated Grayscale Image')
end
        
        
        
        
%     intensity = Grayscaled(x,y);                %gets current intensity at point x,y
%     current_pos = [x,y]';                       %gets the current position to manipulate it
%     new_pos = R*current_pos;
%     new_matrix(new_pos(1),new_pos(2)) = intensity;%not sure how to deal with the negative
