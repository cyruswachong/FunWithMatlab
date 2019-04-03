function Translated_I= translate_image(I, Tx, Ty)

[rows, cols] = size(I);                     %Size of image I
Translated_I = double(zeros(size(I)+100));  %initializes image, all black

for x = 1:rows
    for y = 1:cols
        translatex = x + Tx;                %translated value of x
        translatey = y + Ty;                %translated value of y
        translation= bi_lin_interpolate(I, y, x);               %maps out value of I at that point to new graph
        Translated_I(translatex, translatey) = translation;
    end
end
end