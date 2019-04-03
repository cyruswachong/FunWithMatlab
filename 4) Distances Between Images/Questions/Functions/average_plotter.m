function [] = average_plotter()

load('variables.mat')
% load('variables.mat')
%Allows me to set size of "Final" matrix
temp = getpgmraw('./Questions/Pictures/CroppedYale/yaleB01/yaleB01_P00_Ambient.pgm'); 

%Holds all mean images in columns
% All_averages = zeros(size(temp,1)*size(temp,2),38);
% % variance = zeros(size(temp,1)*size(temp,2),64,38);
% 
% %Holds all images, in columns, and each third dimension is a different
% %subject
% All_pictures = zeros(size(temp,1)*size(temp,2),64,38);
k=0;
%% Displays mean of each of the 28 participants
%Location of folder holding Subjects' folders
%CHANGE THIS TO NEW LOCATION HOLDING THE "yaleB.." FOLDERS
Location = sprintf('./Questions/Pictures/CroppedYale/');

%skips first ten folders, and skips #14 since there is no 14th folder
for i = setdiff(1:39, 14)  
    %Person number
    k = k+1;    
    %loads folder name for each individual
    %File name is different for below 10
%         if(i<10)
%         MyFolderInfo = dir(sprintf('%syaleB0%i/*.pgm', Location, i)); 
%         else
        MyFolderInfo = dir(sprintf('%syaleB%i/*.pgm', Location,  i));    
%         end 
    %Loop to average out every person
%     for n = 1:(length(MyFolderInfo)-1) 
%         file_name = MyFolderInfo(n).name;
        %File name is different for below 10
%             if(i<10)
%             file_name = sprintf('%syaleB0%i/%s', Location, i, file_name);
%             else
%             file_name = sprintf('%syaleB%i/%s', Location, i, file_name);
%             end
%         Grayscaled = getpgmraw(file_name);
%         %loads all images into this matrix
%         All_pictures(:,n,k) =Grayscaled(:);
%     end
    %Final contains 64 columns, each column is one of the 64 images
%     Mean_Image = mean(All_pictures(:,:,k), 2);
    %By the end of this, all average images will be held in here
%     All_averages(:,k) = Mean_Image(:); 
    subplot(4, 10, k);
    set(gcf, 'Position', get(0, 'Screensize'));
    imshow(uint8(reshape(All_averages(:,k), [size(temp,1),size(temp,2)])));
    title(sprintf('Subject #%i', k)); 
end

% save('variables.mat')
