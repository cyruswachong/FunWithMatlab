function r = rect_graph(M,N,A)
%one_mat creates the 2D rect function
one_mat = A*ones(floor(M/2),floor(N/2));
%r pads the matrix with zeroes for the rest of the output
r = pad_mat(one_mat,round(M/4),round(N/4));
end

