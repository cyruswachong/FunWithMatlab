function Output = Question_3
%blank grid 
syms x;
make_grid(1000, 10);
xlim([200 455])
ylim([50 305])
title('Figure\_Question3\_1(Blank Grid)')
xlabel('X')
ylabel('Y')

%grid for background of sinc
make_grid(1000, 10);
%sinc function that isnt centered, but in the specified frame
y = 200*sinc(x-300)+200;
fplot(y, 'k');
%limits that were asked for in the question
xlim([200 455])
ylim([50 305])
title('Figure\_Question3\_2(Off Center 2D sinc)')
xlabel('X')
ylabel('Y')
hold off;

%calculating and graphing the 3D sinc function
make_grid(1000, 10);
[X,Y] = meshgrid(-25:.5:25);
R = sqrt(X.^2 + Y.^2);
Z = sin(R)./R;
mesh(X+300,Y+200,Z)
xlabel('X')
ylabel('Y')
zlabel('Z')
xlim([200 455])
ylim([50 305])
title('Figure\_Question3\_3(3D sinc)')
%keeping grid for 3D
grid on;