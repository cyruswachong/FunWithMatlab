function Q2(input_one, input_two, answer)

A = [input_one, input_two];                %turning to form Ax=b
y = mldivide(A,answer);          %finding the x column, which holds alpha and beta
result = y(1)*input_one + y(2)*input_two; %reconstruct vector 
distance = norm(result-answer);  %finds distance between the points

fprintf('#######################################################################\n');
fprintf("Question 2\n");
fprintf("value of alpha is %f \n", y(1));
fprintf("value of beta is %f \n", abs(y(2)));       %abs just so -0 is not returned
disp(['result = ', mat2str(result',2)]);            %returns result as a row vector
fprintf("distance between actual b value and reconstructed is %f \n", distance);
fprintf('#######################################################################\n\n');
end