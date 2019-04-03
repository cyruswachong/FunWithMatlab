function Output = Question_2(File)
I = imread(File);           %read in image
D = double(I);              %make double so picture is better quality

R = D(:,:,1);               %first 2D matrix represents R
G = D(:,:,2);               %''     ''      ''      ''  G
B = D(:,:,3);               %''     ''      ''      ''  B

Grayscale = (R+G+B)/3.0;            %sum RGB and divide by 3 do get grayscale
Grayscale = uint8(Grayscale);               %1 byte unsigned integers
figure; hold on;
imshow(Grayscale);                  %print our grayscale drawing
title('Figure\_Question2\_1')





