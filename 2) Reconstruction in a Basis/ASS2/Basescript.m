addpath('./Questions/Question1/')
addpath('./Questions/Question2/')
addpath('./Questions/Question3/')
addpath('./Questions/Question4/')
addpath('./Questions/Images/')
addpath('./Questions/Functions/')
syms w t
Q1(exp(1j*w*t));
Q2([ 1 1 1 1 1]', [ 1 2 3 4 5]', [1 0 1 0 1]');
Q3([ 1 1 1 1 1]', [ 1 2 3 4 5]', [ 4 4 7 4 15]', [1 0 1 0 1]');
Q4('./Questions/Images/myimage.jpg', './Questions/Images/dog.jpg', './Questions/Images/mysmile.jpg', './Questions/Images/headphones.jpg', './Questions/Images/waterbottle.jpg', './Questions/Images/selfie1.jpg');
