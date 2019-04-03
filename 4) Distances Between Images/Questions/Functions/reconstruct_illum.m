function [] = reconstruct_illum()

%To make your life easy, it would be best if yaleB11 and yaleB12 are
%loaded, as this is what I tested the code with.

figure
%Please input file number (E.g yaleB11, FILE_NUMBER = 11); 
FILE_NUMBER = 11;

Location = sprintf('./Questions/Pictures/yaleB%i/', FILE_NUMBER);
c = zeros(307200,9);

for i = 0:8 
    file_name = sprintf('%syaleB%i_P0%iA+000E+00.pgm', Location,FILE_NUMBER, i);
    image=getpgmraw(file_name);
    image = image(:);
    c(:,i+1) = image;
    subplot(1, 10, i+1);
    set(gcf, 'Position', get(0, 'Screensize'));
    imshow(uint8(getpgmraw(file_name)));
    title(sprintf('Subject #%i', i+1)); 
    hold on
end

FILE_NUMBER1 =12;
Location = sprintf('./Questions/Pictures/yaleB%i/', FILE_NUMBER1);
file_name1 = sprintf('%syaleB%i_P05A+000E+00.pgm', Location,FILE_NUMBER1);

A = [c(:,1) c(:,2) c(:,3) c(:,4) c(:,5) c(:,6) c(:,7) c(:,8) c(:,9)];
b = getpgmraw(file_name1);
tmp1 = b;

figure
set(gcf, 'Position', get(0, 'Screensize'));
imshow(uint8(b));
title(sprintf('Image to reconstruct')); 
   set(gcf, 'Position', get(0, 'Screensize'));
hold on

b = b(:);
y = mldivide(A,b); 
result = y(1)*c(:,1)+y(2)*c(:,2)+y(3)*c(:,3)+y(4)*c(:,4) + y(5)*c(:,5) + y(6)*c(:,6)...
+ y(7)*c(:,7) +y(8)*c(:,8) + y(9)*c(:,9);

figure
result = reshape(result, size(tmp1));
set(gcf, 'Position', get(0, 'Screensize'));
imshow(uint8(result));
title(sprintf('Reconstructed Image')); 
xlabel(sprintf('The c values are the coefficient of each image used to reproduce the desired image.\nc1=%f, c2=%f, c3=%f, c4=%f, c5=%f, \nc6=%f, c7=%f, c8=%f, c9=%f,',...
y(1), y(2), y(3), y(4), y(5), y(6), y(7), y(8), y(9)));
set(gcf, 'Position', get(0, 'Screensize'));

