function result = Q1(x)
syms t w
syms y(t)
given_equation = 2*diff(y,t)+3*y == 4*x; %plugs in input into given equation

fprintf('#######################################################################\n');
fprintf("Question 1\n");
result = dsolve(given_equation);         %solves the differential of the given equation
fprintf("solution to differential equation is y(t)=%s\n", result); 
fprintf('#######################################################################\n\n');
end