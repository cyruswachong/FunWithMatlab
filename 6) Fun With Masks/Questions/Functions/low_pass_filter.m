function LPF = low_pass_filter(rect_rows,rect_cols,Total_rows, Total_cols, A)
%one_mat creates the 2D rect function
one_mat = A*ones(rect_rows,rect_cols);
%r pads the matrix with zeroes for the rest of the output
LPF = pad_mat(one_mat,((Total_rows-(rect_rows))/2),((Total_cols-(rect_cols))/2));
end
