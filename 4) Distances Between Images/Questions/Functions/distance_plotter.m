function [] = distance_plotter(num_subjects, All_averages, All_pictures, MyFolderInfo )

load('variables1.mat')
figure
counter =0;
% All_averages = All_averages/255;
% All_pictures = All_pictures/255;
% temp = getpgmraw('./Questions/Pictures/CroppedYale/yaleB01/yaleB01_P00_Ambient.pgm'); 
% variance = zeros(size(temp,1)*size(temp,2),64,38);
% penrose_dist = zeros(64,38);
% euclidian_dist = zeros(64,38);

for j = 1:num_subjects
    counter = counter +1;
    subplot(4, 10, counter);
       set(gcf, 'Position', get(0, 'Screensize'));
       plot(euclidian_dist(:,j),log(penrose_dist(:,j)), 'rx');
       title(sprintf('Distance subject #%i', counter));
       xlabel('Euclidian distance');
       ylabel('Penrose Distance');
       hold on
%     for r = 1:(length(MyFolderInfo)-1) 
        %sum takes the sum of the entire column. This returns the euclidian
        %distance
%        euclidian_dist(r,j) = sqrt(sum((All_averages(:,j) - All_pictures(:,r,j)).^2));
       
%        variance(:,r,j) = ((All_pictures(:,r,j) - All_averages(:,j)).^2)/64; 
%        variance(variance == 0) = 0.1;
%        penrose_dist(r,j) = sum(((All_pictures(:,r,j) - All_averages(:,j)).^2)./variance(:,r,j));
       
%     end
end

% 
% save ('variables1.mat')