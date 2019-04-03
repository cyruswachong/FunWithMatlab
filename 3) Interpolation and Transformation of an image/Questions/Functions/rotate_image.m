function Final = rotate_image(I, angle, Xc, Yc)

R = [cosd(-angle) -sind(-angle); sind(-angle) cosd(-angle)];  %Matrix to rotate by inputted theta
[rows, cols] = size(I);                                       %Acquires size of image
Final = double(zeros(size(I)+200));                           %Size f final image is increased to fit rotated image
[rows1,cols1] = size(Final);
    
for y= 1:(cols-1)
    for x= 1: (rows-1)
        current_pos = [y-Yc; x-Xc];             %position in matrix,in reference to center
        rotated_val = R*current_pos;            %Rotates current values by angle degrees
        rotated_val = int16(rotated_val);       %Turns graph into integers
        Xnew = rotated_val(2,1) +100;           %Values of X post rotation, shifted so that drawing is not cut off
        Ynew = rotated_val(1,1) +100;           %Values of Y post rotation, shifted so that drawing is not cut off
        Intensity = I(x, y);                    %Temporary variable to hold intensity at original position
        Final(Xnew, Ynew) = Intensity;          %assigns temporary into Final matrix
    end
end
for i = 2:rows1-1
      for j = 2:cols1-1
        if Final(i, j) == 0
            Final(i, j) = (Final(i+1,j-1) + Final(i-1,j-1) + Final(i+1, j+1) + Final(i-1,j+1))/4;
        end
      end
    end
end