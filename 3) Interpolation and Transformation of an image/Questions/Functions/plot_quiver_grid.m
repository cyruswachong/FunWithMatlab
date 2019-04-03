function output = plot_quiver_grid(theta, sizeImg)
%parametrized functions for transforming
%@ passes the x, y, t to be able to evaluate in polar coordinates
%Learned this in 316 >:)
azimuthalX = @(x,y,t) x.*cosd(t) - y.*sind(t);
azimuthalY = @(x,y,t) x.*sind(t) + y.*cosd(t);
delta_X = @(x,y,t) azimuthalX(x,y,t)-x;
delta_Y = @(x,y,t) azimuthalY(x,y,t)-y;
[X,Y] = meshgrid(0:sizeImg(1)-50,0:sizeImg(2)-50);
linear_index=sub2ind(size(X),Y+1,X+1);

%Plot original image
figure
subplot(1,3,1);
pcolor(Y,X,linear_index);
title('Original Grid');
pbaspect([1,1,1]);

%Plot grid rotated with phi
subplot(1,3,2);
pcolor(azimuthalY(X,Y,theta), azimuthalX(X,Y,theta), linear_index);
title('\phi');
pbaspect([1,1,1]);

%plot grid rotated with inverse phi
subplot(1,3,3);
pcolor(azimuthalY(X,Y,-theta), azimuthalX(X,Y,-theta), linear_index);
title('\phi^{-1}');
pbaspect([1,1,1]);
colormap('white');

%Quiver plot (distance between phi(x) and x)
size_of = size(X);
figure
subplot(1,2,1);
quiver(Y,X,delta_Y(X,Y,theta),delta_X(X,Y,theta));
xlim([0,size_of(1)-1]);
ylim([0,size_of(2)-1]);
title('d(x)');
pbaspect([1,1,1]);

%Quiver plot (distance between phi^-1(x) and x)
subplot(1,2,2);
quiver(Y,X,delta_Y(X,Y,-theta),delta_X(X,Y,-theta));
xlim([0,size_of(1)-1]);
ylim([0,size_of(2)-1]);
title('d^{-1}(x)');
pbaspect([1,1,1]);