%% Initialization 
clear all;close all;clc;
addpath('./Questions/Pictures/');
addpath('./Questions/Functions/');
addpath('./Questions/Files/');
load('cpstruct');
load('frown');
no_smile = grayit('no_smile.jpg');
smile = grayit('smile.jpg');
%% Part 1.1
% r = cpselect(no_smile, smile);

%Loading landmark positions for 
smile_pts = cpstruct.basePoints;
non_smile_pts = cpstruct.inputPoints;
frown_pts = cpstruct1.inputPoints;
num_landmarks = 7;

% Calling of functions
variance = 5;
variance1 = 1;
variance2 = 15;
u = quiver_maker(smile, num_landmarks, smile_pts, non_smile_pts, variance);
v = quiver_maker(smile, num_landmarks, smile_pts, non_smile_pts, variance1);
z = quiver_maker(smile, num_landmarks, smile_pts, non_smile_pts, variance2);

%Output
subplot(1,3,2);set(gcf, 'Position', get(0, 'Screensize'));quiver(u(:,:,1), u(:,:,2));set(gca,'ydir','reverse');
xlim([100,250]);ylim([350,400]);title(sprintf('Quiver plot with variance = %i', variance));xlabel('X');ylabel('Y');
subplot(1,3,1);set(gcf, 'Position', get(0, 'Screensize'));quiver(v(:,:,1), v(:,:,2));set(gca,'ydir','reverse');
xlim([100,250]);ylim([350,380]);title(sprintf('Quiver plot with variance = %i', variance1));xlabel('X');ylabel('Y');
subplot(1,3,3);set(gcf, 'Position', get(0, 'Screensize'));quiver(z(:,:,1), z(:,:,2));set(gca,'ydir','reverse');
xlim([100,250]);ylim([325,410]);title(sprintf('Quiver plot with variance = %i', variance2));xlabel('X');ylabel('Y');

%%%%%%%%%%%%%%%%%%%%%%%CALCULATING phi(x)%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X,Y] = meshgrid(1:size(smile,2), 1:size(smile,1));

%calculating the phi function values in x and y direction
x = 1:size(smile,2);
y = 1:size(smile,1);
phi_x = X + z(:,:,1);
phi_y = Y + z(:,:,2);
inv_phi_x = X - z(:,:,1);
inv_phi_y = Y - z(:,:,2);

cols = size(smile,2);rows = size(smile,1);

figure;subplot(1,2,1);set(gcf, 'Position', get(0, 'Screensize'));plot(phi_x,phi_y);
xlim([1,cols]);ylim([1,rows]);title('\bf\phi\it(x) transform');
xlabel('X');ylabel('Y');set(gca,'ydir','reverse');

subplot(1,2,2);plot(inv_phi_x,inv_phi_y);xlim([1,cols]);ylim([1,rows]);
title('\bf\phi^{-1}\it(x), inverse transformation');xlabel('X')
ylabel('Y');set(gca,'ydir','reverse');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 1.2

template_to_target = transform_img(no_smile, z(:,:,1), z(:,:,2));
target_to_template = transform_img(smile, -1*z(:,:,1), -1*z(:,:,2));

figure;subplot (1,2,1);set(gcf, 'Position', get(0, 'Screensize'));
imshow(no_smile);title('No smile image')
subplot (1,2,2);set(gcf, 'Position', get(0, 'Screensize'));
imshow(template_to_target);title('No smile to smile image')

figure;subplot (1,2,1);set(gcf, 'Position', get(0, 'Screensize'));
imshow(smile);title('Smile Image')
subplot (1,2,2);set(gcf, 'Position', get(0, 'Screensize'));
imshow(target_to_template);title('Smile image to no smile image')

%% 2.1 

d1 = quiver_maker(smile, num_landmarks, non_smile_pts, frown_pts, variance);
d2 = quiver_maker(smile, num_landmarks, non_smile_pts, frown_pts, variance1);
d3 = quiver_maker(smile, num_landmarks, non_smile_pts, frown_pts, variance2);

figure;
subplot (1,3,2);quiver(d1(:,:,1),d1(:,:,2));set(gca,'ydir','reverse');
set(gcf, 'Position', get(0, 'Screensize'));title('u(x) sigma = 5');xlabel('X');ylabel('Y')
xlim([110,260]);ylim([355,400]);

subplot (1,3,1);set(gcf, 'Position', get(0, 'Screensize'));
quiver(d2(:,:,1),d2(:,:,2));set(gca,'ydir','reverse');
title('u(x) sigma = 1');xlabel('X');ylabel('Y')
xlim([130,260]);ylim([355,400]);

subplot (1,3,3);set(gcf, 'Position', get(0, 'Screensize'));
quiver(d3(:,:,1),d3(:,:,2));set(gca,'ydir','reverse');
title('u(x) sigma = 15');xlabel('X');ylabel('Y')
xlim([100,300]);ylim([340,410]);

phi_x = X + d3(:,:,1);
phi_y = Y + d3(:,:,2);
inv_phi_x = X - d3(:,:,1);
inv_phi_y = Y - d3(:,:,2);

figure;subplot(1,2,1);plot(phi_x,phi_y);xlim([1,cols]);ylim([1,rows]);
title('\bf\phi\it(x) Transform');xlabel('X');ylabel('Y')
set(gca,'ydir','reverse');

subplot(1,2,2);plot(inv_phi_x,inv_phi_y);xlim([1,cols]);ylim([1,rows]);
title('\bf\phi^{-1}\it(x) Inverse transform');xlabel('X');ylabel('Y')
set(gca,'ydir','reverse');

%% 2.2
template_to_frown = transform_img(no_smile, -1*d3(:,:,1), -1*d3(:,:,2));

figure;subplot (1,2,1);set(gcf, 'Position', get(0, 'Screensize'));
imshow(no_smile);title('No smile image')

subplot (1,2,2);set(gcf, 'Position', get(0, 'Screensize'));
imshow(template_to_frown);title('No smile image to frown image');

%% 3) Animation of question 2 with Gif 

figure;
filename = 'frown.gif'; % output file name

for i = 0:0.05:1
    template_to_frown = transform_img(no_smile, -i*d3(:,:,1), -i*d3(:,:,2));
    imshow(template_to_frown);
    f = getframe();
    [A,map] = rgb2ind(f.cdata,256,'nodither');
    if i == 0
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.001);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.001);
    end    
end


figure;subplot (2,3,1);set(gcf, 'Position', get(0, 'Screensize'));
imshow(no_smile);xlabel('frame 1')

subplot (2,3,2);set(gcf, 'Position', get(0, 'Screensize'));
imshow(transform_img(no_smile, -0.2*d3(:,:,1), -0.2*d3(:,:,2)))
title('No smile to frown')
xlabel('frame 4')

subplot (2,3,3);set(gcf, 'Position', get(0, 'Screensize'));
imshow(transform_img(no_smile, -0.4*d3(:,:,1), -0.4*d3(:,:,2)))
xlabel('frame 8')

subplot (2,3,4);set(gcf, 'Position', get(0, 'Screensize'));
imshow(transform_img(no_smile, -0.6*d3(:,:,1), -0.6*d3(:,:,2)))
xlabel('frame 12')

subplot (2,3,5);set(gcf, 'Position', get(0, 'Screensize'));
imshow(transform_img(no_smile, -0.8*d3(:,:,1), -0.8*d3(:,:,2)))
xlabel('frame 16')

subplot (2,3,6)
set(gcf, 'Position', get(0, 'Screensize'));
imshow(transform_img(no_smile, -d3(:,:,1), -d3(:,:,2)))
xlabel('frame 20')

