function n = cos_graph_shifted(u0,v0,M,N,A,shift)
%Creates values for x and y to run through
[x,y] = meshgrid(0:N-1,0:M-1);
%n is the values of the cosine output
n =A*cos(2*pi*(((u0*x)/M) + ((v0*y)/N)))+shift;
end