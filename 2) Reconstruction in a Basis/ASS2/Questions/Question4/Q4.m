function Q4(img1, img2, img3, img4, img5, img6) 
close all;
img1 = grayit(img1);    %converts to grayscale
img2 = grayit(img2);
img3 = grayit(img3);
img4 = grayit(img4);
img5 = grayit(img5);
img6 = grayit(img6);

temp = img1;            %hold matrix size
img1 = img1(:);         %converts to column
img2 = img2(:);         %converts to column
img3 = img3(:);
img4 = img4(:);
img5 = img5(:);
img6 = img6(:);

%4.1 Returns basically the dog%%%%%%%%%%%%%%%%5
project = (dot(img2,img1)*img2)/(norm(img2)^2);         %projection formula 
project = mat2gray(reshape(project, size(temp)));       %reshapes the project function into a matrix
figure;
imshow(project);                                        %outputs the result of projection
title('Question 4.1');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%4.2 Tests if images are orthogonal %%%%%%%%%%%%%
fprintf('#######################################################################\n');
fprintf("Question 4\n");
if dot(img1,img2) ==0                           %Tests if the two images are orthogonal by using the dot product (if it equals zero, it is orthogonal)
    fprintf('Images are orthogonal\n')
else
    fprintf('Images are not orthogonal\n');
end
fprintf('#######################################################################\n\n\n');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%4.3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c1 = img1;
c2 = img2;
A = [c1 c2]; 
b = img3;               
%4.4, y holds alpha and beta%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y = mldivide(A,b);                          %finding the x column, which holds alpha and beta for building new I image with two basis images

%4.5 Reconstructs the image%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
result = y(1)*c1 + y(2)*c2;                 %This is I
result = reshape(result, size(temp));       %reshapes column vector into specified size

figure;
subplot(1,2,1)                              %allows multiple figures on one plot
imshow(reshape(img3,size(temp)));           %outputs new image as new "smile" picture
title('Question 4.5 Original');
subplot(1,2,2)                              %outputs result of linear combination of dog image and mugshot
imshow(result)
xlabel(sprintf('%s value is %f,\n %s value is %f', char(945), y(1), char(946), y(2)));  %prints alpha and beta values
title('Reconstructed');

% Part 4.6%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = img4;
y = A\b;                                %finding the x column, which holds alpha and beta
result1 = y(1)*c1 + y(2)*c2;            %reconstruct vector 
result1 = reshape(result1, size(temp)); %turns return1 back to matrix from a column vector


figure;
subplot(1,2,1)
imshow(reshape(img4,size(temp)));       %turns img4 back into a matrix from a column vector
title('Question 4.6\_1 Original');
subplot(1,2,2)
imshow(result1)                         %plots result of linear combination of dog and me to make new I
xlabel(sprintf('alpha value is %f,\n beta value is %f', y(1), y(2)));
title('Question 4.6\_1 Reconstructed');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Part 4.6_1%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = img5;
y = A\b;                                        %finding the x column, which holds alpha and beta
result2 = y(1)*c1 + y(2)*c2;                    %reconstruct vector 
result2 = reshape(result2, size(temp));         %turn result2 as matrix again


figure;
subplot(1,2,1)
imshow(reshape(img5,size(temp)));               %turn img5 back into matrix
title('Question 4.6\_2 Original');
subplot(1,2,2)
imshow(result2)                                 %outputs new linear combination
xlabel(sprintf('alpha value is %f,\n beta value is %f', y(1), y(2)));
title('Question 4.6\_2 Reconstructed');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Part 4.6_3%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b = img6;
y = A\b;                                    %finding the x column, which holds alpha and beta
result3 = y(1)*c1 + y(2)*c2;                %reconstruct vector 
result3 = reshape(result3, size(temp));     %make result 3 a matrix again


figure;
subplot(1,2,1)
imshow(reshape(img6,size(temp)));           %output image 6, a new image(of myself smiling)
title('Question 4.6\_3 Original ');
subplot(1,2,2)
imshow(result3)                             %output the closest combination of myself and dog to represent new myself
xlabel(sprintf('alpha value is %f,\n beta value is %f', y(1), y(2)));
title('Question 4.6\_3 Reconstructed');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%