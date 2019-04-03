function Output = bi_lin_interpolate(I_final, x, y)



iwant = zeros(287,351);
iwant(1:227,1:291) = I_final;         %Pads image on the right and bottom
[rows, cols] = size(iwant);         %Size of Image

x1 = fix(x);                    %truncates x, showing integers portion
y1 = fix(y);                    %truncates x, showing integers portion

if(x1 > cols || y1 > rows)      %makes sure we do not surpass x or y bounds, making image same size as original
    error('The inputted values do not exist in the image')
elseif(x1 < 0 || y1 < 0)        %makes sure we do not go into negative bounds
    error('The inputted values are negative, which is not possible')
else   
    
x2 = x1 +1;                     %rightmost value of x
y2 = y1 +1;                     %bottomost value of y
alpha = x-x1;
beta = y2-y;

%bilinear interpolation formula from lecture
Output = alpha.*beta.*iwant(y1,x2) + beta.*(1-alpha).*iwant(y1,x1) + alpha.*(1-beta).*iwant(y2,x2) + (1-alpha).*(1-beta).*iwant(y2,x1); 
end
end

