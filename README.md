# FunWithMatlab
MATLAB Projects written to understand and use tools of image processing

The reports in each folder discuss outputs, and outputted images are held in the "Output Images" folder of each assignment, just so no downloading/running of code is necessary

Basic description of assignments:


Assignment 1: Introduction:
Read in an image into MATLAB, and read basic properties of the image. Build a Grayscale function.

Assignment 2 - Reconstruction in a basis:
1) Test linearity of a the system.
2&3) Reconstruct vectors with basis vectors
4) Reconstruct image with 2 basis images

Assignment 3: Interpolation and Transformation of an image:
1) Write an interpolation function for an image, allowing you to conduct non interger integer transformations of an image.
2) Write a function to rotate an image by a specified angle, and call the interpolation function where necessary

Assignment 4: Distances Between Images:
To run this code, download the cropped images from the following link:
http://vision.ucsd.edu/~iskwak/ExtYaleDatabase/ExtYaleB.html
Insert the images into the empty "CroppedYale" Folder
1) Compute the mean image for each subject from each subjects' 64 illumination images.
2) Reconstruct the frontal image from anyone of the subjects using all the poses of a different subject

Assignment 5: Mask-based image processing:
1) Develop a function to find the edges of an image
2) Enhance the original image with the image holding the edges detected.

Assignment 6: Fun With Masks:
1) Add gaussian and SnP noise to your image, create a median and constant filter, and test them with these noises.
2) Create a cos(u(x/n)+v(y/N)) and rect function in the spatial domain, and analyze the fourier transform.
3) Apply the Fourier transform to your original image, and apply HPF and LPF to it, analyze results.

Assignment 7: Random and Periodic Noise Removal:
1) Remove the noises present in the given image. Discuss your findings.

Assignment 8: Non-rigid Registration:
Use landmarks to edit your mugshot image (smiling, frowning, etc)
