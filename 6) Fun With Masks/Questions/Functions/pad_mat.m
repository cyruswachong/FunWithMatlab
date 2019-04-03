function padded_mat = pad_mat(mat,rows_padded, cols_padded)
%Pads inputted matrix with 0's around it. 
padded_mat = padarray(mat,[rows_padded cols_padded],0);
end
