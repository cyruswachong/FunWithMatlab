%% Initialization 
% clear all;
close all;clc;
addpath('./Questions/Images/');
addpath('./Questions/Functions/');  
addpath('./Questions/Files/');
load('Landmarks');load('Landmarks2');load('Landmarks3');load('Threshold_vals');

%% Calculating Landmarks/Loading Images
%Loop to load images of brain scans
for i=1:10
    BL_CN(:,:,i) = imread(sprintf('CN_%i_BL.jpeg',i));
    M24_CN(:,:,i) = imread(sprintf('CN_%i_M24.jpeg',i));
    BL_AD(:,:,i) = imread(sprintf('AD_%i_BL.jpeg',i));
    M24_AD(:,:,i) = imread(sprintf('AD_%i_M24.jpeg',i));
end

for i=1:10
%Average X and Y values of landmarks for each baseline image
Avg_BL_AD(i,1) = sum(BL_AD_PTS(:,1,i))/6;
Avg_BL_AD(i,2) = sum(BL_AD_PTS(:,2,i))/6;

%Avg of followup of people with alzheimers 
Avg_M24_AD(i,1) = sum(M24_AD_PTS(:,1,i))/6;
Avg_M24_AD(i,2) = sum(M24_AD_PTS(:,2,i))/6;

%Avg of BL of healthy patients
Avg_BL_CN(i,1) = sum(BL_CN_PTS(:,1,i))/6;
Avg_BL_CN(i,2) = sum(BL_CN_PTS(:,2,i))/6;

%Avg of followup of healthy patients
Avg_M24_CN(i,1) = sum(M24_CN_PTS(:,1,i))/6;
Avg_M24_CN(i,2) = sum(M24_CN_PTS(:,2,i))/6;
end

%% Calculations for Rigid Transformation
% Calculations covered in Lecture 19 to find rigid transformation 
% necessary to overlap images

for j = 1:10
    %Calculating covariance of each patients landmarks
    cov_AD(:,:,j)=cov(BL_AD_PTS(:,:,j),M24_AD_PTS(:,:,j));
    cov_CN(:,:,j)=cov(BL_CN_PTS(:,:,j),M24_CN_PTS(:,:,j));
end

for k = 1:10
    [u,D,V] = svd(cov_AD(k));
    if det(D)>= 1
        s = [1 0 ; 0 1];
    else 
        s = [1 0 ; 0 -1];
    end 
    R(:,:,k) = u*s*V';
    T(k,:) = (R(:,:,k)*Avg_BL_AD(k,:)')'-Avg_M24_AD(k,:);
end
    R = acos(R);

for k = 1:10
    [u,D,V] = svd(cov_CN(k));
    if det(D)>= 1
        s = [1 0 ; 0 1];
    else 
        s = [1 0 ; 0 -1];
    end 
    R1(:,:,k) = u*s*V';
    T1(k,:) = (R1(:,:,k)*Avg_BL_CN(k,:)')'-Avg_M24_CN(k,:);
end
R1 = acos(R1);

%% Plotting imshowpair Images
%This part is to compare the baseline image to the rigidly registered 
%image to find lost gray matter volume.

%AD Patient imshowpair
figure
for i=1:10
    subplot(2,5,i);set(gcf, 'Position', get(0, 'Screensize'));
    imshowpair(BL_AD(:,:,i), imrotate(imtranslate(M24_AD(:,:,i),T(i,:)),uint8(R(1,1,1))));
    title(sprintf('Patient %i with Alzheimers',i));
    Reg_img_AD(:,:,i)=imrotate(imtranslate(M24_AD(:,:,i),T(i,:)),uint8(R(1,1,1)));
end

%CN Patient imshowpair
figure 
for i=1:10
    subplot(2,5,i);set(gcf, 'Position', get(0, 'Screensize'));
    imshowpair(BL_CN(:,:,i), imrotate(imtranslate(M24_CN(:,:,i),T1(i,:)),uint8(R1(1,1,1))));
    title(sprintf('Patient %i that is CN',i));
    Reg_img_CN(:,:,i)=imrotate(imtranslate(M24_CN(:,:,i),T1(i,:)),uint8(R1(1,1,1)));
end

%% 1) Difference Image plotting
%Outputting Volume lost of AD patients
figure
for i=1:10
    difference = BL_AD(:,:,i)-Reg_img_AD(:,:,i);
    subplot(2,5,i);set(gcf, 'Position', get(0, 'Screensize'));
    imshow(difference)
    title(sprintf('Loss of Tissue of AD Patient %i',i));
end

%Outputting Volume lost of CN patients
figure
for i=1:10
    difference = BL_CN(:,:,i)-Reg_img_CN(:,:,i);
    subplot(2,5,i);set(gcf, 'Position', get(0, 'Screensize'));
    imshow(difference)
    title(sprintf('Loss of Tissue of CN Patient %i',i));
end

%% 2) Non-Rigid registration of registered images
u=zeros(256,256,2);

%Displaying quiver and grid for AD patients for non-rigid registration
figure
for i=1:3
u=quiver_maker(BL_CN(:,:,1), 69, REG_AD_LM(:,:,i), BL_AD_LM(:,:,i), 5);

subplot(2,3,i);quiver(u(:,:,1),u(:,:,2));xlim([1,256]);ylim([1,256]);
title(sprintf('Quiver of gray matter loss of AD Patient %i',i));

[X,Y] = meshgrid(1:256, 1:256);
%Calculates transform to go from baseline to rigidly registered image found
%in part 1
phi_x = X + u(:,:,1);
phi_y = Y + u(:,:,2);

subplot(2,3,i+3);set(gcf, 'Position', get(0, 'Screensize'));plot(phi_x,phi_y);
xlim([1,256]);ylim([1,256]);title(sprintf('Gray Matter Loss of AD Patient %i',i));
xlabel('X');ylabel('Y');set(gca,'ydir','reverse');
end


%Displaying quiver and grid for CN patients for non-rigid registration
figure
for i=1:3
u=quiver_maker(BL_CN(:,:,1), 69, REG_CN_LM(:,:,i), BL_CN_LM(:,:,i), 5);

subplot(2,3,i);quiver(u(:,:,1),u(:,:,2));xlim([1,256]);ylim([1,256]);
title(sprintf('Quiver of gray matter loss of CN Patient %i',i));

%Calculates transform to go from baseline to rigidly registered image found
%in part 1
[X,Y] = meshgrid(1:256, 1:256);
phi_x = X + u(:,:,1);
phi_y = Y + u(:,:,2);

subplot(2,3,i+3);set(gcf, 'Position', get(0, 'Screensize'));plot(phi_x,phi_y);
xlim([1,256]);ylim([1,256]);title(sprintf('Gray Matter Loss of CN Patient %i',i));
xlabel('X');ylabel('Y');set(gca,'ydir','reverse');
end

%% 3) Segmentation of different brain matters
%The commented out code below calculates the two thresholds using otsu's
%method, which was commented out since it takes too long, the values
%calculated were saved and loaded.

% sigma_b_squared=zeros(256,1);
% for Thres1 = 1:255
% for Thres2 = Thres1:255
% mu_global=0;
% num_pixels_c1 = 0;
% num_pixels_c2 = 0;
% num_pixels_c3 = 0;
% m1=0;m2=0;m3=0;
%     for i = 0:Thres1
%         %counts number of pixels in C1 for P(C1)
%         num_pixels_c1 = num_pixels_c1 + nnz(BL_CN(:,:,4) == i);
%         %m1 is SIGMA(iP(i)) as i<=T1
%         m1 = m1 + i*(nnz(BL_CN(:,:,4) == i)/(256^2));
%         mu_global = mu_global + i*(nnz(BL_CN(:,:,4) == i)/(256^2));
%     end
%     for j = Thres1+1:Thres2
%         %counts number of pixels in C2 for P(C2)
%         num_pixels_c2 = num_pixels_c2 + nnz(BL_CN(:,:,4) == j);
%         %m2 is SIGMA(jP(j)) as T2>j>T1
%         m2 = m2 + j*nnz(BL_CN(:,:,4) == j)/(256^2);
%         mu_global = mu_global + j*nnz(BL_CN(:,:,4) == j)/(256^2);
%     end
%     for k = Thres2+1:255
%         %counts number of pixels in C3 for P(C2)
%         num_pixels_c3 = num_pixels_c3 + nnz(BL_CN(:,:,4) == k);
%         %m3 is SIGMA(kP(k)) as k>T2
%         m3 = m3 + k*nnz(BL_CN(:,:,4) == k)/(256^2);
%         mu_global = mu_global + k*nnz(BL_CN(:,:,4) == k)/(256^2);
%     end
%     
%     Pc1 = num_pixels_c1/(256^2); 
%     Pc2 = num_pixels_c2/(256^2); 
%     Pc3 = num_pixels_c3/(256^2);
%     sigma_b_squared(Thres1,Thres2) = Pc1*(m1-mu_global)^2 + Pc2*(m2-mu_global)^2 + ...
%         Pc3*(m3-mu_global)^2;
% end
% end
% [M,Threshold2] = max(max(sigma_b_squared));
% [Q,Threshold1] = max(sigma_b_squared(:,Threshold2));

%Loop for segmented BL image of CN patients
figure
for k = 1:10
for x = 1:size(BL_CN(:,:,1),1)
    for y = 1: size(BL_CN(:,:,1),2)
        
        if BL_CN(x,y,k)<=Threshold1
            test(x,y,k) = 0;
        elseif (Threshold1 < BL_CN(x,y,k)) && (BL_CN(x,y,k) <= Threshold2)
            test(x,y,k) = 128;
        else 
            test(x,y,k) = 255;
        end
        
    end
end
    subplot(4,5,k);imshow(test(:,:,k),[]);title(sprintf('BL Segmented CN patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
    subplot(4,5,k+10);histogram(test(:,:,k));title(sprintf('Hist of BL CN patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
end

%Loop for segmented BL image of AD patients
figure
for k = 1:10
for x = 1:size(BL_CN(:,:,1),1)
    for y = 1: size(BL_CN(:,:,1),2)
        
        if BL_AD(x,y,k)<=Threshold1
            test(x,y,k) = 0;
        elseif (Threshold1 < BL_AD(x,y,k)) && (BL_AD(x,y,k) <= Threshold2)
            test(x,y,k) = 128;
        else 
            test(x,y,k) = 255;
        end
        
    end
end
    subplot(4,5,k);imshow(test(:,:,k),[]);title(sprintf('BL Segmented AD patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
    subplot(4,5,k+10);histogram(test(:,:,k));title(sprintf('Hist BL AD patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
end

%Loop for segmented M24 image of CN patients
figure
for k = 1:10
for x = 1:size(BL_CN(:,:,1),1)
    for y = 1: size(BL_CN(:,:,1),2)
        
        if M24_CN(x,y,k)<=Threshold1
            test(x,y,k) = 0;
        elseif (Threshold1 < M24_CN(x,y,k)) && (M24_CN(x,y,k) <= Threshold2)
            test(x,y,k) = 128;
        else 
            test(x,y,k) = 255;
        end
        
    end
end
    subplot(4,5,k);imshow(test(:,:,k),[]);title(sprintf('M24 Segmented CN patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
    subplot(4,5,k+10);histogram(test(:,:,k));title(sprintf('M24 CN patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
end

%Loop for segmented M24 image of AD patients
figure
for k = 1:10
for x = 1:size(BL_CN(:,:,1),1)
    for y = 1: size(BL_CN(:,:,1),2)
        
        if M24_AD(x,y,k)<=Threshold1
            test(x,y,k) = 0;
        elseif (Threshold1 < M24_AD(x,y,k)) && (M24_AD(x,y,k) <= Threshold2)
            test(x,y,k) = 128;
        else 
            test(x,y,k) = 255;
        end
        
    end
end
    subplot(4,5,k);imshow(test(:,:,k),[]);title(sprintf('M24 Segmented AD patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
    subplot(4,5,k+10);histogram(test(:,:,k));title(sprintf('Hist M24 AD patient %i',k));
    set(gcf, 'Position', get(0, 'Screensize'));
end

%% 4) Analysis of matter change over time

%Loop to segment all 40 images using builtin "multithresh" function
for k = 1:10
    %Segments the BL images of CN patients
    level = multithresh(BL_CN(:,:,k),2);
    Otsus(:,:,k) = imquantize(BL_CN(:,:,k),level);
    
    %Segments the BL images of AD patients
    level = multithresh(BL_AD(:,:,k),2);
    Otsus(:,:,k+10) = imquantize(BL_AD(:,:,k),level);
    
    %Segments the M24 images of CN patients
    level = multithresh(M24_CN(:,:,k),2);
    Otsus(:,:,k+20) = imquantize(M24_CN(:,:,k),level);
    
    %Segments the M24 images of AD patients
    level = multithresh(M24_AD(:,:,k),2);
    Otsus(:,:,k+30) = imquantize(M24_AD(:,:,k),level);
end

%Two images were issues, so reset so error is neutralized
Otsus(:,:,2) = Otsus(:,:,22);
Otsus(:,:,34) = Otsus(:,:,14);

for k = 1:10 
    %Calculates how many pixels are CSF
    BL_CN_CSF(k) = nnz(Otsus(:,:,k) == 1);
    %Calculates how many pixels are GM
    BL_CN_GM(k) = nnz(Otsus(:,:,k) == 2);
    %Calculates how many pixels are WM
    BL_CN_WM(k) = nnz(Otsus(:,:,k) == 3);
    
    %Calculates how many pixels are CSF
    BL_AD_CSF(k) = nnz(Otsus(:,:,k+10) == 1);
    %Calculates how many pixels are GM
    BL_AD_GM(k) = nnz(Otsus(:,:,k+10) == 2);
    %Calculates how many pixels are WM
    BL_AD_WM(k) = nnz(Otsus(:,:,k+10) == 3);
    
    %Calculates how many pixels are CSF
    M24_CN_CSF(k) = nnz(Otsus(:,:,k+20) == 1);
    %Calculates how many pixels are GM
    M24_CN_GM(k) = nnz(Otsus(:,:,k+20) == 2);
    %Calculates how many pixels are WM
    M24_CN_WM(k) = nnz(Otsus(:,:,k+20) == 3);
    
    %Calculates how many pixels are CSF
    M24_AD_CSF(k) = nnz(Otsus(:,:,k+30) == 1);
    %Calculates how many pixels are GM
    M24_AD_GM(k) = nnz(Otsus(:,:,k+30) == 2);
    %Calculates how many pixels are WM
    M24_AD_WM(k) = nnz(Otsus(:,:,k+30) == 3); 
end

figure
for k = 1:10
    %Plotting of the CN patients
    subplot(1,3,1);
    plot([0 2],[BL_CN_CSF(k) M24_CN_CSF(k)], 'b'); 
    xlabel('Years after first checkup'); ylabel('Volume of CSF (pixels)'); 
    title('CSF plot of patients');
    hold on;
    %Plotting of the AD patients
    plot([0 2],[BL_AD_CSF(k) M24_AD_CSF(k)], 'r');
    set(gcf, 'Position', get(0, 'Screensize'));
    hold on;
end


for k = 1:10
    %Plotting of the CN patients
    subplot(1,3,2);
    plot([0 2],[BL_CN_GM(k) M24_CN_GM(k)], 'b'); 
    xlabel('Years after first checkup'); ylabel('Volume of gray matter (pixels)'); 
    title('GM plot of patients');
    hold on;
    %Plotting of the AD patients
    plot([0 2],[BL_AD_GM(k) M24_AD_GM(k)], 'r');
    set(gcf, 'Position', get(0, 'Screensize'));
    hold on;
end


for k = 1:10
    %Plotting of the CN patients
    subplot(1,3,3);
    plot([0 2],[BL_CN_WM(k) M24_CN_WM(k)], 'b'); 
    xlabel('Years after first checkup'); ylabel('Volume of White matter (pixels)'); 
    title('WM plot of patients');
    hold on;
    %Plotting of the AD patients
    plot([0 2],[BL_AD_WM(k) M24_AD_WM(k)], 'r');
    set(gcf, 'Position', get(0, 'Screensize'));
    hold on;
end

%Calculates loss percentage of each tissue type for AD and CN patients
for k = 1:10
    
    Vol_CSF_loss_AD(k) = 100*((BL_AD_CSF(k) - M24_AD_CSF(k))/BL_AD_CSF(k));
    Vol_GM_loss_AD(k) = 100*((BL_AD_GM(k) - M24_AD_GM(k))/BL_AD_GM(k));
    Vol_WM_loss_AD(k) = 100*((BL_AD_WM(k) - M24_AD_WM(k))/BL_AD_WM(k));
    
    Vol_CSF_loss_CN(k) = 100*((BL_CN_CSF(k) - M24_CN_CSF(k))/BL_CN_CSF(k));
    Vol_GM_loss_CN(k) = 100*((BL_CN_GM(k) - M24_CN_GM(k))/BL_CN_GM(k));
    Vol_WM_loss_CN(k) = 100*((BL_CN_WM(k) - M24_CN_WM(k))/BL_CN_WM(k));
end

%Plotting of tissue loss
figure;subplot(2,3,1);bar(Vol_CSF_loss_AD);xlabel('Patient #');ylabel('Volume lost(pixels)');
title('Lost Volume of CSF in AD Patients');set(gcf, 'Position', get(0, 'Screensize'));

subplot(2,3,4);bar(Vol_CSF_loss_CN);xlabel('Patient #');ylabel('Volume lost(pixels)');
title('Lost Volume of CSF in CN Patients');set(gcf, 'Position', get(0, 'Screensize'));

subplot(2,3,5);bar(Vol_GM_loss_CN);xlabel('Patient #');ylabel('Volume lost(pixels)');
title('Lost Volume of GM in CN Patients');set(gcf, 'Position', get(0, 'Screensize'));

subplot(2,3,2);bar(Vol_GM_loss_AD);xlabel('Patient #');ylabel('Volume lost(pixels)');
title('Lost Volume of GM in AD Patients');set(gcf, 'Position', get(0, 'Screensize'));

subplot(2,3,6);bar(Vol_WM_loss_CN);xlabel('Patient #');ylabel('Volume lost(pixels)');
title('Lost Volume of WM in CN Patients');set(gcf, 'Position', get(0, 'Screensize'));

subplot(2,3,3);bar(Vol_WM_loss_AD);xlabel('Patient #');ylabel('Volume lost(pixels)');
title('Lost Volume of WM in AD Patients');set(gcf, 'Position', get(0, 'Screensize'));

%% Average change of tissue of CN and AD patients
avg_CN_CSF_change = sum(Vol_CSF_loss_CN)/10;    %decrease of ~0.23%
avg_CN_GM_change = sum(Vol_GM_loss_CN)/10;      %increase of ~0.62%
avg_CN_WM_change = sum(Vol_WM_loss_CN)/10;      %increase of ~0.75%

avg_AD_CSF_change = sum(Vol_CSF_loss_AD)/10;    %increase of ~0.03%
avg_AD_GM_change = sum(Vol_GM_loss_AD)/10;      %increase of ~1.93%
avg_AD_WM_change = sum(Vol_WM_loss_AD)/10;      %decrease of ~1.71%

%Output for average loss of tissues (percentage wise)
fprintf('For the CN Patients:\nThe average CSF volume decreased by %4.2f percent',avg_CN_CSF_change);
fprintf('\nThe average GM volume increased by %4.2f percent',abs(avg_CN_GM_change));
fprintf('\nThe average WM volume increased by %4.2f percent',abs(avg_CN_WM_change));

fprintf('\n\nFor the AD Patients:\nThe average CSF volume increased by %4.2f percent',abs(avg_AD_CSF_change));
fprintf('\nThe average GM volume increased by %4.2f percent',abs(avg_AD_GM_change));
fprintf('\nThe average WM volume decreased by %4.2f percent',abs(avg_AD_WM_change));