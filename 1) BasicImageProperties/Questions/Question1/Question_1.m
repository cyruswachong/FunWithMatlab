function Output = Question_1(File)

I = imread(File);

size_pic = size(I);                         %returns the dimensions of the picture, where rows and columns are pixels, and third value is 3 images R G and B
Y = size_pic(1);                            %returns number of rows in the matrix
X = size_pic(2);                            %   ''      ''  '' columns ''    ''
disk_val = imfinfo(File);          %used to get size of image on disk in BYTES
disk_size = (disk_val.FileSize)*8;          %disk size in BITS
R = whos('I');                              %gives size of actual image in BYTES
real_size = R.bytes*8;                      %gives size of actual image in BITS
bits_per_samp = real_size/(X*Y*3);          %total bits for each pixel
bits_per_channel = real_size/size_pic(3);   %total bits of info in image
comp_ratio = disk_size/real_size;            % actual size/compressed size
          

fprintf('Number of samples in x dimension is %i\n', X)
fprintf('Number of samples in y dimension is %i\n', Y)
fprintf('Number of bits used per sample is %i\n', bits_per_samp)
fprintf('total bits required to store the image is %i \n', real_size)
fprintf('Actual size of image on disk %i bits\n', disk_size)
fprintf('compression ratio is %i \n', comp_ratio)   

figure; hold on;
imshow(I);                                  %displays image stored in I
title('Figure\_Question1\_1')
end

